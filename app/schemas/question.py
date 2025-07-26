from pydantic import BaseModel
from typing import List, Optional

# ✅ Schéma pour une réponse possible (une ligne dans AnswerChoices)
class AnswerChoiceSchema(BaseModel):
    id: int
    answer_text: str
    explanation: Optional[str]  # Explication spécifique à cette réponse
    is_correct: bool  # Nécessaire pour afficher la correction

    # Champs calculés dynamiquement (ex: en mode feedback)
    is_selected: Optional[bool] = False
    feedback: Optional[str] = None

    # ⚙️ Permet de créer un objet à partir d’un dictionnaire ou d’un ORM
    model_config = {
        "from_attributes": True
    }


# 🧠 Schéma pour une question complète (QuestionMeta + QuestionTranslations + AnswerChoices)
class QuestionSchema(BaseModel):
    id: int
    question_text: str
    question_type: str  # Ex: 'single', 'multiple', 'boolean'
    difficulty_level: Optional[int]  # Peut être utilisé plus tard pour filtrer
    explanation_detailed: Optional[str]  # Grande explication affichée sur demande
    answers: List[AnswerChoiceSchema]  # Liste des réponses liées à cette question

    model_config = {
        "from_attributes": True
    }
