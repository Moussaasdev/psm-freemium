# 📁 app/models/certification.py
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from app.database import Base

class Certification(Base):
    __tablename__ = "Certifications"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(50), unique=True, nullable=False)
    name = Column(String(255), nullable=False)
    created_at = Column(DateTime, default=func.now())
