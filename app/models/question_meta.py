# 📁 app/models/question_meta.py

from sqlalchemy import Column, Integer, String, Boolean, DateTime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class QuestionMeta(Base):
    __tablename__ = "QuestionMeta"

    id = Column(Integer, primary_key=True, index=True)
    question_type = Column(String)
    difficulty_level = Column(Integer)
    source = Column(String)
    source_url = Column(String)
    certification_id = Column(Integer)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime)
    updated_at = Column(DateTime)
