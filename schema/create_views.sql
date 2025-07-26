-- =============================
-- 📁 create_views.sql (VUES TABLEAU DE BORD – VERSION SQLITE)
-- =============================

-- ===============================
-- 🧠 Vue 1 : Nombre de questions répondues et taux de réussite par jour (TOUS MODES CONFONDUS)
-- Suivi de la progression quotidienne de chaque utilisateur (exam + training)
-- ===============================
DROP VIEW IF EXISTS vw_DailyUserPerformance;
CREATE VIEW vw_DailyUserPerformance AS
SELECT
    ua.user_id,
    DATE(ua.answered_at) AS answer_date,
    COUNT(*) AS questions_answered,
    -- Taux de réussite = réponses correctes / total répondues (pour la journée)
    SUM(CASE WHEN ac.is_correct = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS success_rate
FROM UserAnswers ua
JOIN AnswerChoices ac ON ua.answer_choice_id = ac.id
JOIN QuizSessions qs ON ua.session_id = qs.id
GROUP BY ua.user_id, DATE(ua.answered_at);

-- ===============================
-- 📝 Vue 2 : Nombre d'examens blancs réalisés et taux de réussite MOYEN (MODE EXAM UNIQUEMENT)
-- Affiche le nombre d’examens blancs complétés et la moyenne des scores obtenus
-- ===============================
DROP VIEW IF EXISTS vw_ExamSessionStats;
CREATE VIEW vw_ExamSessionStats AS
SELECT
    user_id,
    COUNT(*) AS total_exams,
    AVG(score_percent) AS avg_exam_score
FROM QuizSessions
WHERE mode = 'exam' AND status = 'completed'
GROUP BY user_id;

-- ===============================
-- 🏷️ Vue 3 : Taux de réussite par TAG (TOUS MODES CONFONDUS)
-- Permet d’analyser les thématiques fortes/faibles par utilisateur
-- ===============================
DROP VIEW IF EXISTS vw_SuccessRateByTag;
CREATE VIEW vw_SuccessRateByTag AS
SELECT
    ua.user_id,
    t.code AS tag_code,
    t.name_fr,
    COUNT(*) AS total_attempts,
    SUM(CASE WHEN ac.is_correct = 1 THEN 1 ELSE 0 END) AS correct_answers,
    SUM(CASE WHEN ac.is_correct = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS success_rate
FROM UserAnswers ua
JOIN AnswerChoices ac ON ua.answer_choice_id = ac.id
JOIN QuizSessions qs ON ua.session_id = qs.id
JOIN QuestionTags qt ON ua.question_id = qt.question_id
JOIN Tags t ON qt.tag_id = t.id
GROUP BY ua.user_id, t.code, t.name_fr;

-- ===============================
-- 📈 Vue 4 : Taux de réussite par niveau de difficulté (TOUS MODES CONFONDUS)
-- Évalue la maîtrise de l’utilisateur selon la difficulté des questions
-- ===============================
DROP VIEW IF EXISTS vw_SuccessRateByDifficulty;
CREATE VIEW vw_SuccessRateByDifficulty AS
SELECT
    ua.user_id,
    qm.difficulty_level,
    COUNT(*) AS total_attempts,
    SUM(CASE WHEN ac.is_correct = 1 THEN 1 ELSE 0 END) AS correct_answers,
    SUM(CASE WHEN ac.is_correct = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS success_rate
FROM UserAnswers ua
JOIN AnswerChoices ac ON ua.answer_choice_id = ac.id
JOIN QuizSessions qs ON ua.session_id = qs.id
JOIN QuestionMeta qm ON ua.question_id = qm.id
GROUP BY ua.user_id, qm.difficulty_level;

-- ===============================
-- 📒 Toutes les vues sont 100% compatibles SQLite
-- - Utilise DROP VIEW IF EXISTS pour éviter les conflits au rechargement
-- - Les jointures, CASE, AVG, SUM, GROUP BY fonctionnent nativement
-- - Pas de syntaxe SQL Server, tout est natif SQLite
-- ===============================
