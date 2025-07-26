# ================================================================
# 📁 app/models/user.py
# 🎯 Modèle ORM SQLAlchemy pour les utilisateurs
# ================================================================

from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database import Base

# 📦 Table Users : représente un utilisateur
class User(Base):
    __tablename__ = "Users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)

    # 🔄 Relations ORM : un utilisateur peut avoir plusieurs sessions
    sessions = relationship("QuizSession", back_populates="user")
