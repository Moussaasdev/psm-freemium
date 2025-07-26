# app/config.py

# Ce fichier contient la configuration de la base de données Azure SQL
# On la stocke sous forme de dictionnaire pour pouvoir l'utiliser ailleurs

DB_CONFIG = {
    # Adresse du serveur SQL Azure (nom complet du serveur)
    "server": "psm-server-france.database.windows.net",
    
    # Nom de ta base de données
    "database": "psmfreemiumdb",
    
    # Nom d'utilisateur SQL (celui que tu as défini lors de la création du serveur)
    "username": "CloudSAe1347dca",  # 👉 À modifier avec ton vrai login SQL
    
    # Mot de passe SQL (à ne jamais partager publiquement)
    "password": "PsmTest2025!",  # 👉 À modifier aussi
    
    # Nom du driver utilisé pour se connecter en ODBC
    # Ce driver doit être installé sur ton ordinateur (via ODBC Driver for SQL Server)
    "driver": "ODBC Driver 18 for SQL Server"
}
