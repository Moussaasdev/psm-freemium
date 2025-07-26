# ================================================================ 
# 📁 app/api/web_routes.py
# 🌟 Routes HTML de l'application (Jinja2)
# - Mode entraînement intelligent via sessions
# - Affichage conditionnel selon qu’une session est en pause
# ================================================================

from fastapi import APIRouter, Request, Form, Depends, Query
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session
from typing import List, Optional 
from datetime import datetime
from sqlalchemy import text

# 🔌 Connexion à la base
from app.database import get_db

# 📦 Schémas et modèles
from app.schemas.quiz_session import QuizSessionCreate, UserAnswerCreate
from app.models.quiz_session import QuizSession, UserAnswer

# 🧠 Logique métier
from app.services.quiz_session import (
    start_quiz_session,
    get_next_question,
    submit_user_answer,
    pause_quiz_session,
    resume_quiz_session,
    get_paused_session,
    end_quiz_session,
    start_exam_session
)
from app.services.question_service import get_question_by_id

# 🖼️ Système de templates Jinja2
templates = Jinja2Templates(directory="templates")
router = APIRouter()


# -- Fonction pour l'affichage des 10 denieres reponses dans le module score de quiz.html -- 
def get_last_answers(db: Session, session_id: int, limit: int = 7) -> list:
    rows = db.execute(text("""
        SELECT question_id, selected_choice_ids FROM UserAnswers
        WHERE session_id = :sid ORDER BY answered_at DESC LIMIT :lim
    """), {"sid": session_id, "lim": limit}).fetchall()

    results = []
    for row in rows:
        selected = [int(x) for x in row.selected_choice_ids.split(",") if x.strip()]
        if not selected:
            results.append("wrong")
            continue
        correct_rows = db.execute(text("""
            SELECT id FROM AnswerChoices
            WHERE question_id = :qid AND is_correct = 1 AND language_code = 'fr'
        """), {"qid": row.question_id}).fetchall()
        correct_ids = sorted(r.id for r in correct_rows)
        if sorted(selected) == correct_ids:
            results.append("correct")
        else:
            results.append("wrong")
    while len(results) < limit:
        results.append("pending")
    return list(reversed(results))




# ------------------------------------------------------------
# 🏠 Page d’accueil : Choix du mode
# ------------------------------------------------------------
@router.get("/", response_class=HTMLResponse)
async def homepage(request: Request, db: Session = Depends(get_db)):
    paused_session = get_paused_session(db, user_id=1)
    return templates.TemplateResponse("index.html", {
        "request": request,
        "paused_session": paused_session
    })


# ------------------------------------------------------------
# 🎚️ Page de sélection du niveau (mode entraînement)
# ------------------------------------------------------------
@router.get("/quiz", response_class=HTMLResponse)
async def show_level_selector(request: Request, db: Session = Depends(get_db)):
    paused_session = get_paused_session(db, user_id=1)
    last_answers = None
    score_percent = 0
    score_correct = 0
    score_wrong = 0
    if paused_session:
        last_answers = get_last_answers(db, paused_session.id)
        correct = paused_session.correct_answers or 0
        total = paused_session.total_answered or 0
        score_correct = correct
        score_wrong = total - correct
        score_percent = int((correct / total) * 100) if total > 0 else 0    
    return templates.TemplateResponse("quiz_start.html", {
        "request": request,
        "paused_session": paused_session,
        "last_answers": last_answers,
        "score_percent": score_percent,
        "score_correct": score_correct,
        "score_wrong": score_wrong
    })



# ------------------------------------------------------------
# 🚀 Démarre une nouvelle session d’entraînement
# ------------------------------------------------------------
@router.get("/quiz/start")
async def start_training_session(
    request: Request,
    level: int = Query(0),
    db: Session = Depends(get_db)
):
    session_data = QuizSessionCreate(
        user_id=1,
        mode="training",
        difficulty_level=level
    )
    session = start_quiz_session(db, session_data)
    return RedirectResponse(f"/quiz/session/{session.id}", status_code=303)


# ------------------------------------------------------------
# 🔄 Reprend une session en pause
# ------------------------------------------------------------
@router.get("/quiz/session/{session_id}/resume")
async def resume_session(session_id: int, db: Session = Depends(get_db)):
    session = resume_quiz_session(db, session_id)
    if session:
        return RedirectResponse(f"/quiz/session/{session.id}", status_code=303)
    return HTMLResponse("Erreur : impossible de reprendre cette session.", status_code=400)


# ------------------------------------------------------------
# ❓ Affiche une question d’une session en cours ou en pause
# ------------------------------------------------------------
@router.get("/quiz/session/{session_id}", response_class=HTMLResponse)
async def show_question_for_session(request: Request, session_id: int, db: Session = Depends(get_db)):
    session = db.query(QuizSession).filter(QuizSession.id == session_id).first()

    if not session or session.status == "finished":
        score_correct = session.correct_answers if session else 0
        score_total = session.total_answered if session else 0
        score_percent = int((score_correct / score_total) * 100) if score_total > 0 else 0

        return templates.TemplateResponse("quiz.html", {
            "request": request,
            "question": None,
            "end_of_quiz": True,
            "score_correct": score_correct,
            "score_total": score_total,
            "score_percent": score_percent,
            "score_wrong": score_total - score_correct,
            "last_answers": get_last_answers(db, session_id),
            "session_active": False
        })

    if session.status == "paused":
        session.status = "in_progress"
        session.last_interaction_at = datetime.utcnow()
        db.commit()
        db.refresh(session)

    answered = db.query(UserAnswer.question_id).filter(
        UserAnswer.session_id == session_id
    ).all()
    seen_ids = [row[0] for row in answered]
    question = get_next_question(db, session, seen_ids)

    if not question:
        score_correct = session.correct_answers
        score_total = session.total_answered
        score_percent = int((score_correct / score_total) * 100) if score_total > 0 else 0

        return templates.TemplateResponse("quiz.html", {
            "request": request,
            "question": None,
            "end_of_quiz": True,
            "score_correct": score_correct,
            "score_total": score_total,
            "score_percent": score_percent,
            "score_wrong": score_total - score_correct,
            "last_answers": get_last_answers(db, session_id),
            "session_active": False
        })

    expected_answers = sum(1 for a in question.answers if a.is_correct)
    score_correct = session.correct_answers
    score_total = session.total_answered
    score_percent = int((score_correct / score_total) * 100) if score_total > 0 else 0

    return templates.TemplateResponse("quiz.html", {
        "request": request,
        "question": question,
        "selected_id": None,
        "show_feedback": False,
        "session_id": session_id,
        "expected_answers": expected_answers,
        "score_correct": score_correct,
        "score_total": score_total,
        "score_percent": score_percent,
        "score_wrong": score_total - score_correct,
        "last_answers": get_last_answers(db, session_id),
        "difficulty_level": session.difficulty_level,
        "end_of_quiz": False,
        "session_active": True
    })


# ------------------------------------------------------------
# ✅ Enregistre la réponse de l’utilisateur
# ------------------------------------------------------------
@router.post("/quiz/session/{session_id}/answer", response_class=HTMLResponse)
async def submit_session_answer(
    request: Request,
    session_id: int,
    question_id: int = Form(...),
    selected_id: Optional[int] = Form(None),
    selected_ids: Optional[List[int]] = Form(None),
    db: Session = Depends(get_db)
):
    session = db.query(QuizSession).filter(QuizSession.id == session_id).first()

    if not session:
        return HTMLResponse("Session introuvable.", status_code=404)

    selected = selected_ids or ([selected_id] if selected_id is not None else [])
    answer_data = UserAnswerCreate(
        session_id=session_id,
        question_id=question_id,
        selected_choice_ids=selected,
        user_id=session.user_id
    )
    answer = submit_user_answer(db, answer_data)

    full_question = get_question_by_id(db, "fr", question_id)
    for ans in full_question.answers:
        ans.is_selected = ans.id in selected
        ans.feedback = ("✅ Vrai : " if ans.is_correct else "❌ Faux : ") + (ans.explanation or "")

    expected_answers = sum(1 for a in full_question.answers if a.is_correct)

    score_correct = answer.session.correct_answers or 0
    score_total = answer.session.total_answered or 0
    score_percent = int((score_correct / score_total) * 100) if score_total else 0


    return templates.TemplateResponse("quiz.html", {
            "request": request,
            "question": full_question,
            "selected_id": selected,
            "show_feedback": True,              # ← Active les explications
            "session_id": session_id,
            "expected_answers": expected_answers,
            "score_correct": answer.session.correct_answers,
            "score_total": answer.session.total_answered,
            "score_percent": score_percent,
            "score_wrong": answer.session.total_answered - answer.session.correct_answers,
            "last_answers": get_last_answers(db, session_id),   # ← Affiche les 7 dernières réponses
            "difficulty_level": answer.session.difficulty_level,
            "end_of_quiz": False,
            "session_active": True
        })



# ------------------------------------------------------------
# ⏸️ Met en pause la session
# ------------------------------------------------------------
@router.post("/quiz/session/{session_id}/pause")
async def pause_session(session_id: int, db: Session = Depends(get_db)):
    session = pause_quiz_session(db, session_id)
    if session:
        return RedirectResponse("/", status_code=303)
    return HTMLResponse("Erreur : impossible de mettre la session en pause.", status_code=400)


# ------------------------------------------------------------
# 🛑 Termine une session manuellement
# ------------------------------------------------------------
@router.post("/quiz/session/{session_id}/end")
async def end_session(session_id: int, db: Session = Depends(get_db)):
    session = end_quiz_session(db, session_id)
    if session:
        return RedirectResponse("/", status_code=303)
    return HTMLResponse("Erreur : impossible de terminer la session.", status_code=400)


# ------------------------------------------------------------
# 📄 Examen blanc : démarrage
# ------------------------------------------------------------
@router.get("/exam")
async def start_exam_route(request: Request, db: Session = Depends(get_db)):
    user_id = 1
    paused = db.query(QuizSession).filter(
        QuizSession.user_id == user_id,
        QuizSession.mode == "exam",
        QuizSession.status == "paused"
    ).first()
    if paused:
        return RedirectResponse(url=f"/exam/resume/{paused.id}")
    session, questions = start_exam_session(db, user_id=user_id)
    request.session["exam_question_ids"] = [q.id for q in questions]
    request.session["exam_session_id"] = session.id
    request.session["exam_start_time"] = session.started_at.isoformat()
    request.session["exam_saved_answers"] = {}
    return RedirectResponse(url=f"/exam/question/1")


# ------------------------------------------------------------
# 📄 Affiche une question de l'examen (avec navigation)
# ------------------------------------------------------------
@router.get("/exam/question/{index}", response_class=HTMLResponse)
async def show_exam_question(index: int, request: Request, db: Session = Depends(get_db)):
    question_ids = request.session.get("exam_question_ids")
    session_id = request.session.get("exam_session_id")
    saved_answers = request.session.get("exam_saved_answers", {})

    if not question_ids or not session_id:
        return HTMLResponse("Erreur : session d’examen introuvable.", status_code=400)

    if index < 1 or index > len(question_ids):
        return HTMLResponse("Erreur : index de question invalide.", status_code=404)

    question_id = question_ids[index - 1]
    question = get_question_by_id(db, "fr", question_id)

    if not question:
        return HTMLResponse("Erreur : question introuvable.", status_code=404)

    expected_answers = sum(1 for a in question.answers if a.is_correct)
    selected_ids = [int(i) for i in saved_answers.get(str(question_id), [])]

    # 🕒 On récupère la session pour obtenir le temps restant
    session = db.query(QuizSession).filter(QuizSession.id == session_id).first()
    time_left = 3600  # par défaut 60mn si jamais rien n'est trouvé
    if session and session.duration_sec:
        time_left = session.duration_sec

    return templates.TemplateResponse("exam.html", {
        "request": request,
        "question": question,
        "index": index,
        "total": len(question_ids),
        "session_id": session_id,
        "expected_answers": expected_answers,
        "selected_ids": selected_ids,
        "time_left": time_left   # <---- AJOUT INDISPENSABLE !!!
    })


# ------------------------------------------------------------
# 📝 POST /exam/answer — Sauvegarde temporaire + navigation + timer
# ------------------------------------------------------------
@router.post("/exam/answer")
async def handle_exam_answer(
    request: Request,
    question_id: int = Form(...),
    index: int = Form(...),
    session_id: int = Form(...),
    selected_ids: Optional[List[int]] = Form(None),
    action: str = Form(...),
    time_left: Optional[int] = Form(None),   # ⬅️ Ajout du temps restant
    db: Session = Depends(get_db)
):
    
    # ⏺️ Sauvegarde temporaire de la réponse (robuste pour radio/checkbox/aucune réponse)
    saved_answers = request.session.get("exam_saved_answers", {})

    selected_ids_raw = selected_ids or []
    if isinstance(selected_ids_raw, str):
        # Cas radio bouton : une seule valeur, string
        selected_ids_list = [int(selected_ids_raw)]
    elif isinstance(selected_ids_raw, list):
        selected_ids_list = [int(i) for i in selected_ids_raw]
    else:
        selected_ids_list = []

    saved_answers[str(question_id)] = selected_ids_list
    request.session["exam_saved_answers"] = saved_answers

    # 🕒 Mise à jour du temps restant dans la session SQL
    if time_left is not None:
        session = db.query(QuizSession).filter(QuizSession.id == session_id).first()
        if session:
            session.duration_sec = time_left
            db.commit()

    # Navigation
    if action == "next":
        return RedirectResponse(url=f"/exam/question/{index + 1}", status_code=303)
    elif action == "prev":
        return RedirectResponse(url=f"/exam/question/{index - 1}", status_code=303)
    elif action == "submit":
        return RedirectResponse(url="/exam/submit", status_code=303)

    return HTMLResponse("Action inconnue.", status_code=400)


# ------------------------------------------------------------
# ✅ Soumission finale — Enregistre en base
# ------------------------------------------------------------
# ------------------------------------------------------------
# ✅ Soumission finale — Enregistre en base
# ------------------------------------------------------------
@router.get("/exam/submit")
async def submit_exam(request: Request, db: Session = Depends(get_db)):
    session_id = request.session.get("exam_session_id")
    question_ids = request.session.get("exam_question_ids")
    saved_answers = request.session.get("exam_saved_answers", {})

    if not session_id or not question_ids:
        return HTMLResponse("Erreur : données de session manquantes.", status_code=400)

    session = db.query(QuizSession).filter(QuizSession.id == session_id).first()
    if not session:
        return HTMLResponse("Erreur : session introuvable.", status_code=404)

    # ⏺️ Enregistre toutes les réponses, même vides
    for qid in question_ids:
        selected = saved_answers.get(str(qid), [])
        answer_data = UserAnswerCreate(
            session_id=session_id,
            question_id=qid,
            selected_choice_ids=selected,
            user_id=session.user_id
        )
        submit_user_answer(db, answer_data)

    # 🏁 Termine la session
    session.status = "finished"
    session.finished_at = datetime.utcnow()
    db.commit()

    # 🧮 Calcul du score correct/faux (rechargé depuis la base pour fiabilité)
    correct_count = db.query(UserAnswer).filter(
        UserAnswer.session_id == session_id,
        UserAnswer.is_correct == True
    ).count()

    wrong_count = db.query(UserAnswer).filter(
        UserAnswer.session_id == session_id,
        UserAnswer.is_correct == False
    ).count()

    # 🧹 Nettoyage de la session utilisateur
    request.session.pop("exam_session_id", None)
    request.session.pop("exam_question_ids", None)
    request.session.pop("exam_saved_answers", None)
    request.session.pop("exam_start_time", None)

    # ✅ Passage des bonnes variables au template
    return templates.TemplateResponse("exam_finished.html", {
        "request": request,
        "score_correct": correct_count,
        "score_wrong": wrong_count,
        "total": correct_count + wrong_count,
        "session_id": session_id
    })


# ------------------------------------------------------------
# 🧐 Correction détaillée des questions échouées après examen
# ------------------------------------------------------------
@router.get("/exam/correction/{index}", response_class=HTMLResponse)
async def show_exam_correction(
    request: Request,
    index: int,
    session_id: int = Query(...),
    db: Session = Depends(get_db)
):
    user_id = 1  # TODO: remplacer par l'ID du user connecté si gestion d'authentification

    # 1. Vérifie que la session d'exam existe, appartient à l'utilisateur et est terminée
    session = db.query(QuizSession).filter(
        QuizSession.id == session_id,
        QuizSession.user_id == user_id,
        QuizSession.mode == "exam",
        QuizSession.status == "finished"
    ).first()
    if not session:
        return HTMLResponse("Session d’examen invalide ou incomplète.", status_code=404)

    # 2. Récupère toutes les réponses UserAnswers pour cette session d'examen
    user_answers = db.query(UserAnswer).filter(
        UserAnswer.session_id == session_id
    ).all()

    # 3. Construit la liste des questions échouées (réponse partielle, fausse ou non répondue)
    failed_questions = []
    for ua in user_answers:
        # IDs sélectionnés par l'utilisateur (sous forme de liste d'entiers)
        selected_ids = [int(x) for x in ua.selected_choice_ids.split(",") if x.strip()] if ua.selected_choice_ids else []

        # Récupère tous les bons IDs pour cette question
        answer_choices = db.execute(
            text("SELECT id, is_correct FROM AnswerChoices WHERE question_id = :qid AND language_code = :lang"),
            {"qid": ua.question_id, "lang": "fr"}
        ).fetchall()
        correct_ids = [row.id for row in answer_choices if row.is_correct]

        # Si la sélection utilisateur n'est pas strictement égale aux bonnes réponses attendues (ordre non important), c'est un échec
        if sorted(selected_ids) != sorted(correct_ids):
            failed_questions.append({
                "user_answer": ua,
                "selected_ids": selected_ids,
                "correct_ids": correct_ids
            })

    # 4. Navigation et vérification d'index
    total_failed = len(failed_questions)
    if total_failed == 0:
        # Cas où il n'y a aucune erreur à corriger
        return templates.TemplateResponse("exam_correction.html", {
            "request": request,
            "no_error": True,
            "total": 0
        })
    if index < 1 or index > total_failed:
        return HTMLResponse("Index de correction hors limite.", status_code=404)

    # 5. Récupère la question à afficher dans la correction
    fq = failed_questions[index - 1]
    ua = fq["user_answer"]
    selected_ids = fq["selected_ids"]
    correct_ids = fq["correct_ids"]

    # Texte de la question + explication longue
    q_row = db.execute(
        text("SELECT question_text, explanation_detailed FROM QuestionTranslations WHERE question_id = :qid AND language_code = :lang"),
        {"qid": ua.question_id, "lang": "fr"}
    ).first()
    # Réponses possibles (avec texte, validité, explication courte)
    answer_rows = db.execute(
        text("SELECT id, answer_text, is_correct, explanation FROM AnswerChoices WHERE question_id = :qid AND language_code = :lang"),
        {"qid": ua.question_id, "lang": "fr"}
    ).fetchall()

    # Structure pour affichage dans la template
    question_display = {
        "question_text": q_row.question_text if q_row else "",
        "explanation_detailed": q_row.explanation_detailed if q_row else "",
        "answers": [
            {
                "id": ans.id,
                "text": ans.answer_text,
                "is_correct": ans.is_correct,
                "explanation": ans.explanation,
                "is_selected": ans.id in selected_ids
            }
            for ans in answer_rows
        ]
    }

    # Correction du bug Jinja2 : on transmet directement la première explication courte trouvée
    first_correct_explanation = ""
    for ans in answer_rows:
        if ans.is_correct and ans.explanation:
            first_correct_explanation = ans.explanation
            break
            
        
        # Score total de la session
        score = session.correct_answers or 0
        total = db.query(UserAnswer).filter(UserAnswer.session_id == session_id).count()
        score_correct = session.correct_answers or 0
        score_total = total or 1  # éviter division par 0
        score_wrong = score_total - score_correct
        score_percent = int((score_correct / score_total) * 100)

        last_answers = get_last_answers(db, session_id)

    return templates.TemplateResponse("exam_correction.html", {
        "request": request,
        "question": question_display,
        "selected_ids": selected_ids,
        "correct_ids": correct_ids,
        "index": index,
        "total": total_failed,
        "session_id": session_id,
        "no_error": False,
        "first_correct_explanation": first_correct_explanation,
        "score_correct": score_correct,
        "score_wrong": score_wrong,
        "score_percent": score_percent,
        "last_answers": last_answers
    })

