# ================================================================
# 📁 app/services/answer_service.py
# 🎯 Gère les opérations liées aux réponses utilisateur :
# - Enregistrer une réponse (UserAnswers)
# - Supprimer les réponses d’un utilisateur
# - Calculer le score total (nombre de bonnes réponses vs total)
# - Récupérer les bonnes réponses attendues pour une question
# ================================================================

from sqlalchemy.orm import Session
from sqlalchemy import func, and_

from app.models.quiz_session import UserAnswer
from app.models.question import AnswerChoices


# 💾 Enregistre une réponse sélectionnée par l’utilisateur (version simple pour tests)
def save_user_answer(db: Session, user_id: int, answer_choice_id: int, question_id: int):
    answer = UserAnswer(
        user_id=user_id,
        question_id=question_id,
        selected_choice_ids=str(answer_choice_id),
        is_correct=False  # pour cette fonction simple, on ne calcule pas
    )
    db.add(answer)
    db.commit()
    db.refresh(answer)
    return answer


# 🔁 Supprime toutes les réponses précédentes d’un utilisateur (utile pour réinitialiser une session)
def delete_previous_user_answers(db: Session, user_id: int):
    db.query(UserAnswer).filter(UserAnswer.user_id == user_id).delete()
    db.commit()


# 📊 Calcule le score d’un utilisateur (nb de bonnes réponses vs total répondu)
def get_user_score(db: Session, user_id: int) -> tuple[int, int]:
    subquery = (
        db.query(
            func.max(UserAnswer.answered_at).label("latest_time"),
            UserAnswer.question_id
        )
        .filter(UserAnswer.user_id == user_id)
        .group_by(UserAnswer.question_id)
        .subquery()
    )

    latest_answers = db.query(UserAnswer).join(
        subquery,
        (UserAnswer.question_id == subquery.c.question_id) &
        (UserAnswer.answered_at == subquery.c.latest_time)
    ).filter(UserAnswer.user_id == user_id).subquery()

    results = db.query(
        func.sum(func.case((AnswerChoices.is_correct == True, 1), else_=0)),
        func.count()
    ).join(AnswerChoices, latest_answers.c.answer_choice_id == AnswerChoices.id).one()

    correct = results[0] if results[0] is not None else 0
    total = results[1] if results[1] is not None else 0
    return correct, total


# ✅ Renvoie les IDs des bonnes réponses attendues pour une question
def get_selected_answer_ids(db: Session, user_id: int, question_id: int) -> set[int]:
    rows = db.query(AnswerChoices.id).filter(
        and_(
            AnswerChoices.question_id == question_id,
            AnswerChoices.is_correct == True
        )
    ).all()
    return {row[0] for row in rows}
