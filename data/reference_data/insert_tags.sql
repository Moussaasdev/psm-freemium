-- =============================
-- 📁 insert_tags.sql — Tags multilingues pour PSM I
-- =============================

-- 🏷 Insertion de tags de base avec libellés FR / EN / ES
INSERT INTO Tags (code, name_fr, name_en, name_es) VALUES
  ('scrum_values', 'Valeurs Scrum', 'Scrum Values', 'Valores de Scrum'),
  ('sprint_goal', 'Objectif du Sprint', 'Sprint Goal', 'Objetivo del Sprint'),
  ('daily_scrum', 'Daily Scrum', 'Daily Scrum', 'Daily Scrum'),
  ('definition_of_done', 'Definition of Done', 'Definition of Done', 'Definición de Terminado'),
  ('empiricism', 'Empirisme', 'Empiricism', 'Empirismo'),
  ('sprint_review', 'Sprint Review', 'Sprint Review', 'Revisión del Sprint'),
  ('sprint_retrospective', 'Sprint Rétrospective', 'Sprint Retrospective', 'Retrospectiva del Sprint'),
  ('product_backlog', 'Product Backlog', 'Product Backlog', 'Product Backlog'),
  ('product_goal', 'Objectif Produit', 'Product Goal', 'Objetivo del Producto'),
  ('scrum_team', 'Équipe Scrum', 'Scrum Team', 'Equipo Scrum');

-- 📘 Association des tags à la certification PSM I (id = 1)
INSERT INTO TagCertifications (tag_id, certification_id)
SELECT id, 1 FROM Tags WHERE code IN (
  'scrum_values', 'sprint_goal', 'daily_scrum', 'definition_of_done',
  'empiricism', 'sprint_review', 'sprint_retrospective',
  'product_backlog', 'product_goal', 'scrum_team'
);

-- ✅ Tous les tags sont maintenant prêts à être associés aux questions
