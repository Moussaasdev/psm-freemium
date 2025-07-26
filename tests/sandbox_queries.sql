-- Voir l'historique des réponses enregistrées
SELECT ua.id, ua.user_id, ua.answer_choice_id, ac.answer_text, ac.is_correct, ua.answered_at
FROM UserAnswers ua
JOIN AnswerChoices ac ON ua.answer_choice_id = ac.id
ORDER BY ua.answered_at DESC;

