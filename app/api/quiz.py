from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.quiz_session import QuizSessionCreate, QuizSessionOut, UserAnswerCreate, UserAnswerOut
from app.services.quiz_session import start_quiz_session, get_next_question, submit_user_answer
from app.models.quiz_session import QuizSession

router = APIRouter()

# ------------------------------------------------------------
# 🎯 POST /session/start : Crée une nouvelle session d'entraînement
# ------------------------------------------------------------
@router.post("/session/start", response_model=QuizSessionOut)
def start_session(session_data: QuizSessionCreate, db: Session = Depends(get_db)):
    return start_quiz_session(db, session_data)

# ------------------------------------------------------------
# ❓ GET /session/{session_id}/next : Récupère la prochaine question
# ------------------------------------------------------------
@router.get("/session/{session_id}/next")
def next_question(session_id: int, lang: str = "fr", db: Session = Depends(get_db)):
    session = db.query(QuizSession).filter(QuizSession.id == session_id).first()
    if not session or not session.is_active:
        raise HTTPException(status_code=404, detail="Session not found or inactive")

    # 🧠 Récupère toutes les réponses déjà données dans cette session
    seen_answers = db.query(UserAnswerCreate.question_id).filter_by(session_id=session_id).all()
    seen_ids = [row[0] for row in seen_answers]

    question = get_next_question(session, seen_ids, lang)
    if question is None:
        return {"message": "No more questions"}
    return question

# ------------------------------------------------------------
# 📝 POST /session/{session_id}/answer : Soumet une réponse
# ------------------------------------------------------------
@router.post("/session/{session_id}/answer", response_model=UserAnswerOut)
def answer_question(answer_data: UserAnswerCreate, db: Session = Depends(get_db)):
    return submit_user_answer(db, answer_data)
