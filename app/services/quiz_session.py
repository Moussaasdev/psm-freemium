# ================================================================
# 📁 app/services/quiz_session.py
# 🎯 Gère la logique d’une session de quiz :
# - Création de session
# - Sélection de question aléatoire
# - Soumission de réponse et calcul du score
# - Mise en pause, reprise et fin
# ================================================================

from sqlalchemy.orm import Session
from datetime import datetime
from typing import Optional

from app.schemas.question import QuestionSchema
from app.schemas.quiz_session import QuizSessionCreate, UserAnswerCreate
from app.models.quiz_session import QuizSession, UserAnswer
from app.schemas.question import QuestionSchema

from app.services.question_service import get_random_question_id, get_question_by_id, get_random_exam_questions
from app.services.answer_service import get_selected_answer_ids  # ✅ version SQLAlchemy


# 🚀 Crée une nouvelle session de quiz
def start_quiz_session(db: Session, session_data: QuizSessionCreate) -> QuizSession:
    # ❌ Termine toutes les anciennes sessions encore actives
    db.query(QuizSession).filter(
        QuizSession.user_id == session_data.user_id,
        QuizSession.status.in_(["in_progress", "paused"])
    ).update({
        QuizSession.status: "finished",
        QuizSession.ended_at: datetime.utcnow()
    }, synchronize_session=False)

    # ✅ Création de la nouvelle session
    session = QuizSession(
        user_id=session_data.user_id,
        certification_id=getattr(session_data, "certification_id", 1),
        mode=session_data.mode,
        difficulty_level=session_data.difficulty_level,
        status="in_progress",
        total_answered=0,
        correct_answers=0
    )
    db.add(session)
    db.commit()
    db.refresh(session)
    return session


# 🎯 Tire une question aléatoire non encore vue dans cette session
def get_next_question(db: Session, session: QuizSession, seen_ids: list[int]) -> Optional[QuestionSchema]:
    # 🔍 Tire une nouvelle question non vue avec le bon niveau de difficulté
    question_id = get_random_question_id(
        db=db,
        exclude_ids=seen_ids,
        difficulty=session.difficulty_level
    )

    if not question_id:
        return None

    # 🔁 Retourne la question complète (avec réponses, explications…)
    return get_question_by_id(db, "fr", question_id)


# 📝 Enregistre la réponse d’un utilisateur + met à jour la session
def submit_user_answer(db: Session, answer_data: UserAnswerCreate) -> UserAnswer:
    selected_ids = set(answer_data.selected_choice_ids)
    expected_ids = get_selected_answer_ids(db, user_id=answer_data.user_id, question_id=answer_data.question_id)

    is_correct = selected_ids == expected_ids

    # 💾 Insertion dans UserAnswers
    answer = UserAnswer(
        session_id=answer_data.session_id,
        user_id=answer_data.user_id,  # ✅ OBLIGATOIRE pour éviter le NULL
        question_id=answer_data.question_id,
        selected_choice_ids=",".join(map(str, selected_ids)),
        is_correct=is_correct,
        answered_at=datetime.utcnow()
    )

    # 🔄 Mise à jour de la session
    session = db.query(QuizSession).filter(QuizSession.id == answer_data.session_id).first()
    if session:
        session.total_answered += 1
        if is_correct:
            session.correct_answers += 1
        session.score_percent = round(100 * session.correct_answers / session.total_answered, 1)
        session.last_interaction_at = datetime.utcnow()

    db.add(answer)
    db.commit()
    db.refresh(answer)
    return answer


# 🛑 Met une session en pause (changement de statut + timestamp)
def pause_quiz_session(db: Session, session_id: int) -> Optional[QuizSession]:
    session = db.query(QuizSession).filter(
        QuizSession.id == session_id,
        QuizSession.status == "in_progress"
    ).first()
    if not session:
        return None

    session.status = "paused"
    session.paused_at = datetime.utcnow()
    session.last_interaction_at = datetime.utcnow()

    db.commit()
    db.refresh(session)
    return session


# 🔄 Reprend une session en pause (change le statut en in_progress)
def resume_quiz_session(db: Session, session_id: int) -> Optional[QuizSession]:
    session = db.query(QuizSession).filter(
        QuizSession.id == session_id,
        QuizSession.status == "paused"
    ).first()

    if not session:
        return None

    session.status = "in_progress"
    session.last_interaction_at = datetime.utcnow()

    db.commit()
    db.refresh(session)
    return session


# 🔍 Récupère la dernière session en pause pour un utilisateur
def get_paused_session(db: Session, user_id: int) -> Optional[QuizSession]:
    return db.query(QuizSession).filter(
        QuizSession.user_id == user_id,
        QuizSession.status == "paused",
        QuizSession.paused_at.isnot(None),
        QuizSession.ended_at.is_(None)
    ).order_by(QuizSession.paused_at.desc()).first()


# ⛔ Termine une session de quiz (changement de statut + fin horodatée)
def end_quiz_session(db: Session, session_id: int) -> Optional[QuizSession]:
    session = db.query(QuizSession).filter(
        QuizSession.id == session_id,
        QuizSession.status == "in_progress"
    ).first()

    if session:
        session.status = "finished"
        session.ended_at = datetime.utcnow()  # ✅ Pour exclure cette session dans get_paused_session
        db.commit()
        db.refresh(session)
        return session

    return None


# 🚀 Démarre une nouvelle session d’examen (80 questions équilibrées)
def start_exam_session(
    db: Session,
    user_id: int,
    certification_id: int = 1,
    language_code: str = "fr"
) -> tuple[QuizSession, list[QuestionSchema]]:
    """
    Crée une nouvelle session d'examen (mode = 'exam') et génère 80 questions aléatoires.
    Retourne la session + la liste des questions formatées.
    """

    # 🧾 Étape 1 : Créer la session en base
    session = QuizSession(  # ✅ correction ici (pas "QuizSessions")
        user_id=user_id,
        certification_id=certification_id,
        mode="exam",
        status="in_progress",
        started_at=datetime.utcnow(),
        last_interaction_at=datetime.utcnow()
    )
    db.add(session)
    db.commit()
    db.refresh(session)

    # 🧠 Étape 2 : Tirage intelligent des questions
    questions = get_random_exam_questions(
        db=db,
        language_code=language_code,
        certification_id=certification_id,
        total=80
    )

    return session, questions
