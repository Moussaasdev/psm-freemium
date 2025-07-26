import sqlite3
import os

# Chemin du fichier DB local
DB_PATH = os.path.join(os.path.dirname(__file__), "localdev.db")

# Liste de fichiers SQL à exécuter (adapte les chemins si besoin)
sql_files = [
    "schema/reset_database.sql",
    "schema/create_tables.sql",
    "data/reference_data/insert_languages.sql",
    "data/reference_data/insert_certifications.sql",
    "data/reference_data/insert_tags.sql",
    "data/reference_data/inert_initial_user.sql",
    "data/seed_data/insert_generated_fake_questions.sql",
    "schema/create_views.sql",
]

def execute_sql_file(cursor, path):
    print(f"📄 Exécution du fichier : {os.path.basename(path)}")
    with open(path, "r", encoding="utf-8-sig") as file:
        sql_script = file.read()
    # Pas de 'GO' dans SQLite, donc on exécute tout d'un coup
    cursor.executescript(sql_script)

def main():
    conn = None
    try:
        # Connexion à SQLite (créera le fichier si absent)
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        for path in sql_files:
            execute_sql_file(cursor, path)
        conn.commit()
        print("\n✅ Base de données SQLite réinitialisée et rechargée avec succès !")
    except Exception as e:
        print("\n❌ Une erreur est survenue lors de l'exécution :")
        print(e)
    finally:
        if conn:
            conn.close()
        print("🔒 Connexion fermée.")

if __name__ == '__main__':
    main()
