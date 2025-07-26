# ================================================================
# 📁 app/services/question_service.py
# 🎯 Gère la récupération des questions depuis la base :
# - Question par ID (avec texte, réponses, feedback)
# - Tirage aléatoire (en excluant les questions déjà vues)
# - Comptage/statistiques
# ================================================================

import random
from typing import List, Optional
from sqlalchemy.orm import Session
from sqlalchemy.sql import and_
from sqlalchemy.sql import func
from sqlalchemy import select, func, not_

from app.models.question import QuestionMeta, QuestionTranslations, AnswerChoices
from app.schemas.question import QuestionSchema, AnswerChoiceSchema
from app.models.question_meta import QuestionMeta

# ------------------------------------------------------------
# 🔍 Récupère une question complète (texte, type, niveau, réponses) à partir de son ID
# ------------------------------------------------------------
def get_question_by_id(db: Session, language_code: str, question_id: int) -> QuestionSchema:
    """
    Récupère une question complète à partir de son ID :
    - Texte et explication via QuestionTranslations
    - Métadonnées via QuestionMeta
    - Réponses via AnswerChoices
    """

    # ✅ Requête corrigée avec jointure explicite
    row = db.query(QuestionMeta, QuestionTranslations).select_from(QuestionMeta).join(
        QuestionTranslations,
        QuestionMeta.id == QuestionTranslations.question_id
    ).filter(
        QuestionMeta.id == question_id,
        QuestionTranslations.language_code == language_code
    ).first()

    if not row:
        raise Exception("❌ Question introuvable ou non traduite.")

    qm, qt = row  # Déballage tuple : meta et traduction

    # 📦 Structure de la question
    question_data = {
        "id": qm.id,
        "question_text": qt.question_text,
        "question_type": qm.question_type,
        "difficulty_level": qm.difficulty_level,
        "explanation_detailed": qt.explanation_detailed,
        "answers": []
    }

    # 🔗 Récupération des réponses associées (filtrées par langue)
    answers = db.query(AnswerChoices).filter(
        AnswerChoices.question_id == question_id,
        AnswerChoices.language_code == language_code
    ).all()

    question_data["answers"] = [
        AnswerChoiceSchema(
            id=a.id,
            answer_text=a.answer_text,
            explanation=a.explanation,
            is_correct=a.is_correct
        ) for a in answers
    ]

    return QuestionSchema(**question_data)



# ------------------------------------------------------------
# 🔀 Tire une question aléatoire parmi les actives non encore vues
# ------------------------------------------------------------
def get_random_question_id(db: Session, exclude_ids: list[int], difficulty: int) -> Optional[int]:
    """
    🔁 Tire l’ID d’une question aléatoire en :
    - excluant celles déjà vues (exclude_ids)
    - filtrant par niveau de difficulté si précisé
    - s’assurant que la question est active et traduite en français
    """

    # 🔍 Sélection explicite du modèle principal + jointure propre
    query = db.query(QuestionMeta.id).select_from(QuestionMeta).join(
        QuestionTranslations,
        QuestionTranslations.question_id == QuestionMeta.id
    ).filter(
        QuestionTranslations.language_code == "fr",
        QuestionMeta.is_active == True
    )

    # ❌ Exclure les questions déjà vues si présent
    if exclude_ids:
        query = query.filter(~QuestionMeta.id.in_(exclude_ids))

    # 🎯 Filtrer par difficulté (sauf si niveau "0" = tout accepter)
    if difficulty != 0:
        query = query.filter(QuestionMeta.difficulty_level == difficulty)

    # 📦 Récupération des IDs candidats
    question_ids = [row[0] for row in query.all()]

    if not question_ids:
        return None  # Aucun ID dispo pour ces critères

    # 🎲 Tirage aléatoire
    return random.choice(question_ids)


# ------------------------------------------------------------
# 🧮 Compte toutes les questions actives dans une langue donnée
# ------------------------------------------------------------
def count_active_questions(db: Session, language_code: str = "fr") -> int:
    count = db.query(func.count()).select_from(QuestionMeta).join(QuestionTranslations).filter(
        QuestionMeta.is_active == True,
        QuestionTranslations.language_code == language_code
    ).scalar()
    return count


# ------------------------------------------------------------
# 🗂️ Récupère tous les IDs de questions actives pour une langue donnée
# ------------------------------------------------------------
def get_all_active_question_ids(db: Session, lang: str = "fr") -> List[int]:
    rows = db.query(QuestionMeta.id).join(QuestionTranslations).filter(
        QuestionMeta.is_active == True,
        QuestionTranslations.language_code == lang
    ).all()
    return [row[0] for row in rows]


# ------------------------------------------------------------
# 🗂️ 🎯 Tirage intelligent de N questions réparties par niveau de difficulté
# ------------------------------------------------------------
def get_random_exam_questions(
    db: Session,
    language_code: str = "fr",
    certification_id: int = 1,
    total: int = 80
) -> list[QuestionSchema]:
    """
    🔁 Tire un set de 80 questions équilibrées par niveau de difficulté
    pour une session d'examen. Langue et certification paramétrables.
    """

    # 🎯 Étape 1 : Récupérer toutes les questions actives liées à cette certification
    query = db.query(QuestionMeta).filter(
        QuestionMeta.is_active == True,
        QuestionMeta.certification_id == certification_id
    )

    all_questions = query.all()

    # 🧠 Étape 2 : Répartir les questions par difficulté (1, 2, 3)
    questions_by_level = {1: [], 2: [], 3: []}
    for q in all_questions:
        level = q.difficulty_level or 1
        if level in questions_by_level:
            questions_by_level[level].append(q)

    # 🧮 Étape 3 : Tirage équilibré (modifiable)
    distribution = {1: 15, 2: 30, 3: 35}  # Somme = 80
    selected_questions = []

    for level, count in distribution.items():
        pool = questions_by_level[level]
        random.shuffle(pool)
        selected_questions.extend(pool[:count])

    # 🧹 Étape 4 : Compléter si pas assez de questions (base incomplète)
    if len(selected_questions) < total:
        missing = total - len(selected_questions)
        others = list(set(all_questions) - set(selected_questions))
        random.shuffle(others)
        selected_questions.extend(others[:missing])

    # 📝 Étape 5 : Récupérer les traductions et réponses
    result = []
    for q in selected_questions:
        translation = db.query(QuestionTranslations).filter_by(
            question_id=q.id, language_code=language_code
        ).first()
        if not translation:
            continue  # 🔕 Ignore les questions non traduites

        raw_answers = db.query(AnswerChoices).filter_by(
            question_id=q.id, language_code=language_code
        ).all()

        answers = [
            AnswerChoiceSchema(
                id=a.id,
                answer_text=a.answer_text,
                explanation=a.explanation,
                is_correct=a.is_correct
            )
            for a in raw_answers
        ]

        schema = QuestionSchema(
            id=q.id,
            question_text=translation.question_text,
            explanation_detailed=translation.explanation_detailed,
            question_type=q.question_type,
            difficulty_level=q.difficulty_level,
            answers=answers
        )
        result.append(schema)

    # 🔀 Mélange final
    random.shuffle(result)
    return result
