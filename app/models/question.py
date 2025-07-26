# app/models/question.py

from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from app.database import Base

# 🎯 Table des questions principales
class QuestionMeta(Base):
    __tablename__ = "QuestionMeta"

    id = Column(Integer, primary_key=True, index=True)
    question_type = Column(String)
    difficulty_level = Column(Integer)
    is_active = Column(Boolean, default=True)

    # Relations
    translations = relationship("QuestionTranslations", back_populates="question")
    answers = relationship("AnswerChoices", back_populates="question")
    user_answers = relationship("UserAnswer", back_populates="question")  # ✅ Ajout nécessaire


# 🌍 Traductions des questions
class QuestionTranslations(Base):
    __tablename__ = "QuestionTranslations"

    id = Column(Integer, primary_key=True)
    question_id = Column(Integer, ForeignKey("QuestionMeta.id"))
    language_code = Column(String)
    question_text = Column(String)
    explanation_detailed = Column(String)

    # Relation inverse
    question = relationship("QuestionMeta", back_populates="translations")


# ✅ Réponses possibles
class AnswerChoices(Base):
    __tablename__ = "AnswerChoices"

    id = Column(Integer, primary_key=True)
    question_id = Column(Integer, ForeignKey("QuestionMeta.id"))
    language_code = Column(String)
    answer_text = Column(String)
    explanation = Column(String)
    is_correct = Column(Boolean)

    # Relation inverse
    question = relationship("QuestionMeta", back_populates="answers")
