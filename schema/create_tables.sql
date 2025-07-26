-- =============================
-- 📁 1 - create_tables.sql (SQLite version, with FOREIGN KEY)
-- =============================

-- Active la gestion des clés étrangères (important pour SQLite !)
PRAGMA foreign_keys = ON;

-- Suppression préalable de toutes les tables (ordre inversé des dépendances)
DROP TABLE IF EXISTS ExamSessionQuestions;
DROP TABLE IF EXISTS UserAnswers;
DROP TABLE IF EXISTS UserQuestionStats;
DROP TABLE IF EXISTS QuestionStats;
DROP TABLE IF EXISTS QuizSessions;
DROP TABLE IF EXISTS QuestionTags;
DROP TABLE IF EXISTS TagCertifications;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS AnswerChoices;
DROP TABLE IF EXISTS QuestionTranslations;
DROP TABLE IF EXISTS QuestionMeta;
DROP TABLE IF EXISTS Languages;
DROP TABLE IF EXISTS Certifications;
DROP TABLE IF EXISTS Users;

-- 🧱 Utilisateurs
CREATE TABLE Users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name TEXT,
    birth_date DATE,
    country_code TEXT,
    user_status TEXT,
    preferred_language TEXT DEFAULT 'fr',
    is_email_verified INTEGER DEFAULT 0,
    subscription_status TEXT DEFAULT 'free',
    referral_code TEXT,
    referred_by_code TEXT,
    is_admin INTEGER DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- 📘 Certifications
CREATE TABLE Certifications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- 📦 Questions (métadonnées)
CREATE TABLE QuestionMeta (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_type TEXT,
    difficulty_level INTEGER,
    source TEXT,
    source_url TEXT,
    certification_id INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    is_active INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (certification_id) REFERENCES Certifications(id)
);

-- 🌍 Traductions de questions
CREATE TABLE QuestionTranslations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_id INTEGER NOT NULL,
    language_code TEXT NOT NULL,
    question_text TEXT NOT NULL,
    explanation_detailed TEXT,
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE,
    FOREIGN KEY (language_code) REFERENCES Languages(code)
);

-- ✅ Choix de réponse proposés
CREATE TABLE AnswerChoices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_id INTEGER NOT NULL,
    language_code TEXT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct INTEGER DEFAULT 0,
    explanation TEXT,
    UNIQUE (question_id, language_code, answer_text),
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE,
    FOREIGN KEY (language_code) REFERENCES Languages(code)
);

-- 🏷 Tags
CREATE TABLE Tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL UNIQUE,
    name_fr TEXT NOT NULL,
    name_en TEXT NOT NULL,
    name_es TEXT NOT NULL
);

-- 🔗 Tags ↔ Certifications
CREATE TABLE TagCertifications (
    tag_id INTEGER NOT NULL,
    certification_id INTEGER NOT NULL,
    PRIMARY KEY (tag_id, certification_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(id) ON DELETE CASCADE,
    FOREIGN KEY (certification_id) REFERENCES Certifications(id) ON DELETE CASCADE
);

-- 🔗 Questions ↔ Tags
CREATE TABLE QuestionTags (
    question_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (question_id, tag_id),
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Tags(id) ON DELETE CASCADE
);

-- 🌐 Langues
CREATE TABLE Languages (
    code TEXT PRIMARY KEY,
    name TEXT NOT NULL
);

-- 📦 Sessions d'entraînement ou examen
CREATE TABLE QuizSessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    certification_id INTEGER NOT NULL,
    mode TEXT NOT NULL CHECK (mode IN ('exam', 'training')),
    status TEXT NOT NULL DEFAULT 'in_progress', -- in_progress, completed, abandoned
    difficulty_level INTEGER,
    started_at TEXT DEFAULT CURRENT_TIMESTAMP,
    ended_at TEXT,
    paused_at TEXT,
    last_interaction_at TEXT DEFAULT CURRENT_TIMESTAMP,
    score REAL,
    score_percent REAL,
    duration_sec INTEGER,
    is_active INTEGER DEFAULT 1,
    total_answered INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (certification_id) REFERENCES Certifications(id)
);

-- 🧾 Réponses séléctionnés par le User
CREATE TABLE UserAnswers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    session_id INTEGER,
    answer_choice_id INTEGER,
    question_id INTEGER NOT NULL,
    selected_choice_ids TEXT,  -- séparés par des virgules
    is_correct INTEGER DEFAULT 0,
    answered_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (session_id) REFERENCES QuizSessions(id) ON DELETE CASCADE,
    FOREIGN KEY (answer_choice_id) REFERENCES AnswerChoices(id),
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE
);

-- 📊 Statistiques utilisateur par question
CREATE TABLE UserQuestionStats (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    times_seen INTEGER DEFAULT 0,
    times_correct INTEGER DEFAULT 0,
    last_answered_at TEXT,
    PRIMARY KEY (user_id, question_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE
);

-- 📈 Statistiques globales par question
CREATE TABLE QuestionStats (
    question_id INTEGER PRIMARY KEY,
    total_attempts INTEGER DEFAULT 0,
    correct_attempts INTEGER DEFAULT 0,
    avg_duration_sec REAL,
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE
);

-- 📘 Questions associées à une session d'examen (ordre défini)
CREATE TABLE ExamSessionQuestions (
    session_id INTEGER NOT NULL,
    question_index INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    PRIMARY KEY (session_id, question_index),
    FOREIGN KEY (session_id) REFERENCES QuizSessions(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES QuestionMeta(id) ON DELETE CASCADE
);

-- =======================================
-- Ce script est maintenant auto-suffisant et prêt pour SQLite :
--   - Il crée toutes les tables AVEC les foreign keys
--   - Il n'y a plus besoin de add_constraints.sql
--   - Lance-le tel quel avec DB Browser SQLite ou Python sqlite3
-- =======================================
