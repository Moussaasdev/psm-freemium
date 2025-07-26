# 📄 main.py
# Point d’entrée principal de l’application FastAPI.
# Il crée l’instance `app`, configure les middlewares, et enregistre les routes (API REST, interface HTML, etc.)

from fastapi import FastAPI
from starlette.middleware.sessions import SessionMiddleware  # 🔐 Pour la gestion des sessions utilisateur
from fastapi.staticfiles import StaticFiles

# ✳️ Import des modules de routes
from app.api import questions         # API REST : récupération d’une question spécifique (JSON)
from app.api import web_routes        # Routes HTML (Jinja2) : interface utilisateur web (quiz, exam, accueil)
from app.api import quiz              # API REST : gestion des sessions d’entraînement (JSON, prefix=/api)

# 🚀 Création de l’application FastAPI
app = FastAPI()

# 🔐 Middleware de session (obligatoire pour utiliser `request.session[...]`)
# La clé secrète peut être plus longue pour plus de sécurité (ex : avec un générateur de tokens)
app.add_middleware(SessionMiddleware, secret_key="une_clé_ultra_secrète_psm123")

# 🔌 Inclusion des routes API REST (JSON)
app.include_router(questions.router)   # /questions/{language_code}/{question_id}

# 🗼 Inclusion des routes Web (interface utilisateur HTML avec Jinja2)
app.include_router(web_routes.router)  # /quiz, /exam, / (accueil), etc.

# 🧠 Inclusion des routes API JSON d’entraînement, préfixées par /api
# Exemple : /api/session/start, /api/session/{id}/next
app.include_router(quiz.router, prefix="/api")

# Cette ligne permet de servir /static (CSS, images…)
app.mount("/static", StaticFiles(directory="static"), name="static")

