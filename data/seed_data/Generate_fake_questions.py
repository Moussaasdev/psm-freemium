import random
import os
from faker import Faker

# 📂 Chemin du script et du fichier généré
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__)) if '__file__' in globals() else os.getcwd()
OUTPUT_SQL_PATH = os.path.join(SCRIPT_DIR, "insert_generated_fake_questions.sql")

# 🧹 Supprimer le fichier précédent si besoin
if os.path.exists(OUTPUT_SQL_PATH):
    os.remove(OUTPUT_SQL_PATH)

fake = Faker('fr_FR')

# 🎯 Paramètres personnalisables
NB_QUESTIONS = 100  # Nombre de questions à générer
PERCENT_DIFFICULTY = {1: 30, 2: 40, 3: 30}
PERCENT_TYPES = {'boolean': 20, 'single_choice': 50, 'multiple_choice': 30}
TAG_POOL = {
    1: "scrum_values",
    2: "sprint_goal",
    3: "daily_scrum",
    4: "definition_of_done",
    5: "empiricism",
    6: "sprint_review",
    7: "sprint_retrospective",
    8: "product_backlog",
    9: "product_goal",
    10: "scrum_team"
}
CERTIFICATION_ID = 1
LANGUAGE_CODE = 'fr'

# --- Fonctions utilitaires ---
def generate_random_words(n_range):
    return ' '.join(fake.words(nb=random.randint(*n_range))).capitalize()

def escape_sql(text: str) -> str:
    return text.replace("'", "''")

def generate_short_explanation():
    return escape_sql(generate_random_words((20, 25))) + '.'

def generate_long_explanation():
    return escape_sql(u"\n\n".join([
        u"📌 " + generate_random_words((5, 10)) + ". " + generate_random_words((20, 30)) + ".",
        u"💡 " + generate_random_words((25, 35)) + ".",
        u"<i>« " + generate_random_words((10, 15)) + ". »</i> – Scrum Guide imaginaire"
    ]))

def choose_weighted(options):
    r = random.randint(1, 100)
    cumulative = 0
    for key, percent in options.items():
        cumulative += percent
        if r <= cumulative:
            return key
    return random.choice(list(options.keys()))

def generate_question_sql(index):
    """
    Génére le bloc SQL pour UNE question, version 100% compatible SQLite
    """
    question_id = index + 1   # 💡 On suppose que la base est vide (id auto-incrémenté)
    question_type = choose_weighted(PERCENT_TYPES)
    difficulty = choose_weighted(PERCENT_DIFFICULTY)
    tag_ids = random.sample(list(TAG_POOL.keys()), k=random.choice([1, 2, 3]))

    # Déterminer nombre de réponses et bonnes réponses
    if question_type == 'boolean':
        nb_answers = 2
        nb_correct = 1
    elif question_type == 'single_choice':
        nb_answers = 3
        nb_correct = 1
    else:
        nb_answers = random.randint(3, 5)
        nb_correct = random.randint(2, nb_answers - 1)

    correct_indices = set(random.sample(range(nb_answers), nb_correct))

    # --- Construction du SQL ---
    sql = f"\n-- 🟩 Question {question_id}\n"

    # QuestionMeta
    sql += (
        "INSERT INTO QuestionMeta (id, question_type, difficulty_level, source, source_url, certification_id)\n"
        f"VALUES ({question_id}, '{question_type}', {difficulty}, 'ScriptTest', NULL, {CERTIFICATION_ID});\n"
    )

    # QuestionTranslations
    tags_txt = ', '.join([TAG_POOL[i] for i in tag_ids])
    question_text = escape_sql(
        f"Tags : {tags_txt} / {question_type} / Difficulté {difficulty} / PSM I / "
        + generate_random_words((10, 15)) + " ?"
    )
    explanation = escape_sql(generate_long_explanation())
    sql += (
        "INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)\n"
        f"VALUES ({question_id}, '{LANGUAGE_CODE}', '{question_text}', '{explanation}');\n"
    )

    # AnswerChoices
    sql += "INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)\nVALUES\n"
    answer_lines = []
    for i in range(nb_answers):
        is_correct = 1 if i in correct_indices else 0
        prefix = "Vrai - " if is_correct else "Faux - "
        answer_text = escape_sql(prefix + generate_random_words((2, 5)))
        answer_explanation = generate_short_explanation()
        answer_lines.append(
            f"({question_id}, '{LANGUAGE_CODE}', '{answer_text}', {is_correct}, '{answer_explanation}')"
        )
    sql += ",\n".join(answer_lines) + ";\n"

    # QuestionTags (plusieurs par question possible)
    for tag_id in tag_ids:
        sql += f"INSERT INTO QuestionTags (question_id, tag_id) VALUES ({question_id}, {tag_id});\n"

    return sql

# --- Génération des questions ---
all_sql = "\n".join([generate_question_sql(i) for i in range(NB_QUESTIONS)])

# --- Écriture dans le fichier SQL ---
with open(OUTPUT_SQL_PATH, "w", encoding="utf-8-sig") as f:
    f.write(all_sql)

print(f"✅ Fichier SQL SQLite généré : {OUTPUT_SQL_PATH}")
