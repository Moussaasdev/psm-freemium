-- ===============================
-- reset_database.sql (version SQLite)
-- 🧹 Supprime toutes les tables de la base (brut)
-- ===============================

-- Reset complet de la base SQLite (supprime toutes les tables)
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
