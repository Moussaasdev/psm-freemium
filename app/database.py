# ================================================================
# 📁 app/database.py
# 🔌 Configuration de la base de données avec SQLAlchemy (SQLite LOCAL)
# ================================================================

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# ================================================================
# 🌱 Chemin du fichier SQLite (modifie ./localdev.db si tu veux changer)
# ================================================================
DATABASE_URL = "sqlite:///./data/localdev.db"

# ================================================================
# ⚙️ Création du moteur SQLAlchemy pour SQLite
# - connect_args={"check_same_thread": False} : OBLIGATOIRE pour SQLite en mode multi-thread (FastAPI)
# ================================================================
engine = create_engine(
    DATABASE_URL,
    connect_args={"check_same_thread": False}
)

# ================================================================
# 🧵 Session locale : utilisée pour interagir avec la base via ORM
# Injectée dans FastAPI avec Depends(get_db)
# ================================================================
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# ================================================================
# 📦 Base ORM : classe de base pour tous les modèles (via declarative_base)
# Exemple : class User(Base): ...
# ================================================================
Base = declarative_base()

# ================================================================
# 🔁 Fonction utilitaire pour FastAPI : ouvre une session DB temporaire
# À utiliser dans les routes/services : db: Session = Depends(get_db)
# Elle gère automatiquement l’ouverture/fermeture
# ================================================================
def get_db():
    """
    Fournit une session SQLAlchemy pour une requête FastAPI.
    Usage :
        from fastapi import Depends
        from app.database import get_db
        def route(db: Session = Depends(get_db)):
            ...
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
