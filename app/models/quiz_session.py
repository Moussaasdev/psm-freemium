# ================================================================
# 📁 app/models/quiz_session.py
# 🧠 Modèles ORM pour la gestion des sessions de quiz et réponses utilisateur
# ================================================================

from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, Float, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base

from app.models.user import User  # ✅ Requis pour la relation ORM avec User

# ----------------------------------------------------------------
# 📦 Modèle SQLAlchemy : QuizSession
# Représente une session d'entraînement ou d'examen
# ----------------------------------------------------------------
class QuizSession(Base):
    __tablename__ = "QuizSessions"

    id = Column(Integer, primary_key=True, index=True)

    # 🔗 Lien vers l'utilisateur propriétaire de la session
    user_id = Column(Integer, ForeignKey("Users.id"), nullable=False)

    # 🔗 Certification ciblée (ex: PSM I)
    certification_id = Column(Integer, ForeignKey("Certifications.id"), nullable=False)

    # 🧪 Mode : "training" ou "exam"
    mode = Column(String(50), nullable=False)

    # 🎚️ Niveau de difficulté (utilisé uniquement pour l'entraînement)
    difficulty_level = Column(Integer, nullable=True)  # Valeurs possibles : 1, 2, 3

    # 🧭 Statut de la session : in_progress, completed, abandoned
    status = Column(String(20), default="in_progress", nullable=False)

    # 🕐 Horodatages de suivi
    started_at = Column(DateTime(timezone=True), server_default=func.now())
    ended_at = Column(DateTime(timezone=True), nullable=True)
    paused_at = Column(DateTime(timezone=True), nullable=True)  # ✅ Pour la mise en pause
    last_interaction_at = Column(DateTime(timezone=True), server_default=func.now())

    # 📊 Score global de la session
    score_percent = Column(Float, nullable=True)       # Ex: 87.5%
    score = Column(Float, nullable=True)               # Score instantané si différent
    duration_sec = Column(Integer, nullable=True)      # Durée totale (secondes)

    # ✅ Suivi d'activité dans la session
    is_active = Column(Boolean, default=True)          # Session en cours ou non
    total_answered = Column(Integer, default=0)        # Nombre total de questions répondues
    correct_answers = Column(Integer, default=0)       # Nombre de bonnes réponses

    # 🔁 Relations ORM (accès aux réponses et à l'utilisateur)
    user = relationship("User", back_populates="sessions")         # Accès user.sessions
    answers = relationship("UserAnswer", back_populates="session") # Accès session.answers


# ----------------------------------------------------------------
# 📦 Modèle SQLAlchemy : UserAnswer
# Représente une réponse donnée à une question lors d’une session
# ----------------------------------------------------------------
class UserAnswer(Base):
    __tablename__ = "UserAnswers"

    id = Column(Integer, primary_key=True, index=True)

    # 🔗 Références obligatoires
    user_id = Column(Integer, ForeignKey("Users.id"), nullable=False)
    session_id = Column(Integer, ForeignKey("QuizSessions.id"), nullable=True)
    answer_choice_id = Column(Integer, ForeignKey("AnswerChoices.id"), nullable=False)
    question_id = Column(Integer, ForeignKey("QuestionMeta.id"), nullable=False)

    # 📊 Réponse multiple : liste d’IDs en texte si multiple_choice
    selected_choice_ids = Column(String, nullable=True)   # ex: "12,13"

    # ✅ Corrigé ou non
    is_correct = Column(Boolean, default=False)

    # 🕐 Date de réponse
    answered_at = Column(DateTime(timezone=True), server_default=func.now())

    # 🔁 Relations ORM
    session = relationship("QuizSession", back_populates="answers")
    question = relationship("QuestionMeta", back_populates="user_answers")
