-- 🟩 Question 1
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Étouffer avancer décider partir franc ?', 
  'Vaincre dangereux grave respirer causer. Haine haïr douze.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Enfant bien jeu vieillard ombre fort vers.', 0, 'Avouer peau ouvert général protéger violent chambre habitude oreille tandis que mener vaste.'),
(@question_id, 'fr', 'Général désormais dans santé.', 0, 'Facile avoir pourquoi nouveau réveiller couche certain.'),
(@question_id, 'fr', 'Naturellement mort annoncer oh.', 1, 'Mériter importer victime loup parler peine lieu oui paysage franchir.'),
(@question_id, 'fr', 'Défendre printemps étouffer odeur neuf.', 0, 'Caresser transformer poche le argent appartement chien établir calmer enfin lutte après chat.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 7),
(@question_id, 1),
(@question_id, 9);

GO

-- 🟩 Question 2
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Contenter père raison journée espace tellement lisser alors poésie ?', 
  'Masse horizon davantage chercher achever bientôt. Plein poche chaise travers. Arrière rose habitant
arrière.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Vin sur fil claire.', 1, 'Blanc face amuser poésie homme caractère douze jouer certain.'),
(@question_id, 'fr', 'Échapper cacher temps mariage chose nuage déclarer.', 0, 'Sentir satisfaire tromper montrer présent dont beau casser parcourir douze silence penser.'),
(@question_id, 'fr', 'Verser contre personne dieu pendre.', 0, 'Masse monde partie chaîne si nombreux abattre sentir joue avant charger intelligence.'),
(@question_id, 'fr', 'Avancer remettre visite nu.', 0, 'Vieil fenêtre crier environ jouer jouer venir droit le nature ne escalier billet.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 7),
(@question_id, 4);

GO

-- 🟩 Question 3
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Bord étudier corde où odeur pointe muet ?', 
  'Riche problème loi signifier décider remonter. Pencher retenir ventre détruire million mémoire
champ. Commander tombe tout combat ton réflexion. Tellement gauche vague vieil delà puis esprit. Cour anglais pauvre arrière un année. Rejeter moment condamner genou monter mari île. Profiter rose
inutile visible grand ombre. Soldat à mensonge au dans ouvrir agiter.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Apporter décider selon mourir porte arracher colline.', 0, 'Partir fatiguer billet peau échapper large.'),
(@question_id, 'fr', 'Plus tout inquiéter clef image devant yeux seul.', 1, 'Tourner proposer fleur couper repousser dieu durant interroger âgé mer.'),
(@question_id, 'fr', 'Malheur enfance rare ceci appeler rapidement.', 0, 'Neuf causer beaucoup pleurer tel famille français dominer personne argent petit.'),
(@question_id, 'fr', 'Fenêtre discussion perdu terme semaine.', 0, 'Sourire jeunesse bonheur étouffer absolument chair étranger tellement mois.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 8),
(@question_id, 4);

GO

-- 🟩 Question 4
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Absolu trop calmer chien saint exécuter reculer sonner hauteur ?', 
  'Cour anglais pauvre arrière un année. Rejeter moment condamner genou monter mari île. Profiter rose
inutile visible grand ombre. Soldat à mensonge au dans ouvrir agiter. Cour anglais pauvre arrière un année. Rejeter moment condamner genou monter mari île. Profiter rose
inutile visible grand ombre. Soldat à mensonge au dans ouvrir agiter. Cour anglais pauvre arrière un année. Rejeter moment condamner genou monter mari île. Profiter rose
inutile visible grand ombre. Soldat à mensonge au dans ouvrir agiter.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Voilà plusieurs recueillir abandonner désigner.', 1, 'Jeu nation prouver heure sourire poussière flamme sauvage signifier.'),
(@question_id, 'fr', 'Promettre chef jusque veiller surprendre émotion paysage certes.', 0, 'Approcher dire devoir hasard écarter apporter casser preuve avec émotion toile.'),
(@question_id, 'fr', 'Point glace vide.', 0, 'Autorité fusil pain pensée silence action autre remplacer animal habitant.'),
(@question_id, 'fr', 'Réussir arracher quitter plaine monter.', 0, 'Moins fine franc femme rapide lune passage page obliger pourtant regard son.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 5);

GO

-- 🟩 Question 5
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Amuser jouer froid car manger expérience nouveau ?', 
  'Exister peine étudier séparer âme bout croire. Presque d''abord arracher enfin loup remettre. Jeune
que armer tromper croix ton. Titre cesse respect admettre juger sourire inventer.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Gros sauver trente recommencer ce un.', 1, 'Second inutile beaux musique succès goutte oeuvre carte vaste.'),
(@question_id, 'fr', 'Groupe par eaux lors mort.', 0, 'Terreur devenir endormir avec valoir intention obéir mari résultat protéger ensemble.'),
(@question_id, 'fr', 'Trente temps cou nombreux bien déclarer.', 0, 'Penser relever assez résistance vent entier vague inspirer intérêt apprendre croix apprendre ah.'),
(@question_id, 'fr', 'Cinq cinquante forme ciel lutte.', 0, 'Visible pourquoi répandre signifier île compagnie.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 2);

GO

-- 🟩 Question 6
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Découvrir prendre même juge droite pousser sens ?', 
  'Certain affaire occasion abattre ce triste. Petit véritable présenter mon. Émotion preuve
intelligence.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Examiner amener muet troisième si décider employer.', 1, 'Avant suivant calme poids suivant désirer en gros rôle vraiment tapis tapis former.'),
(@question_id, 'fr', 'En essuyer cinquante blanc que soleil choisir sauter.', 0, 'Hôtel croix petit juger serrer sang prétendre douceur repousser brusquement achever voiture ici.'),
(@question_id, 'fr', 'Nombreux arrière obtenir parfois occuper importance beauté.', 0, 'Départ aile billet marcher semblable fait d''autres.'),
(@question_id, 'fr', 'Chaîne queue souffrance emporter habitude peau.', 0, 'Supérieur revoir près durer cependant fumée convenir voici quelqu''un forêt renverser exemple.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 10),
(@question_id, 6),
(@question_id, 4);

GO

-- 🟩 Question 7
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Odeur etc parler taille matin absolument ordre beaux ?', 
  'Disposer pur traiter dessiner repas vieillard. Image écraser vieux. Yeux siège aussi plante âme afin
de. Tout attitude roi interrompre chemin valoir.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Route cesse figure ensuite avouer facile quinze.', 0, 'Couleur plante crier beau égal sauter malgré beaucoup lequel commencement différent tenter.'),
(@question_id, 'fr', 'Un dent parmi course.', 0, 'Souvenir verser oncle unique étonner douceur combat rare.'),
(@question_id, 'fr', 'Fond sueur dieu sommet commun naissance.', 0, 'Anglais taille français lever yeux billet choisir.'),
(@question_id, 'fr', 'Manquer résultat plan contenter gagner absolument mal.', 1, 'Plaisir tenir boire mentir aide sorte toile queue vague état cabinet.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),
(@question_id, 7),
(@question_id, 9);

GO

-- 🟩 Question 8
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Magnifique pendre couper animal plonger qui effet loi soleil ?', 
  'Entrée famille rapidement étendue aussi simplement. Revenir intéresser fond consulter ni mari
souhaiter. Véritable prononcer besoin sembler fier remonter véritable. Âge toit interrompre. Moment
million haine passé exprimer court visite.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Étude éviter conseil chasse mener.', 1, 'Yeux discuter pareil réunir confier planche écouter rôle honte.'),
(@question_id, 'fr', 'Peine répondre imaginer haut.', 0, 'Froid foule connaissance toute trouver propre veille considérer main détruire hier.'),
(@question_id, 'fr', 'Saluer peau liberté sous sou votre.', 0, 'Bientôt me terreur confier sujet habitude magnifique pauvre ignorer cela.'),
(@question_id, 'fr', 'Pencher cuisine gauche comprendre posséder erreur.', 0, 'D''Autres côté sec essayer détail mettre pousser nerveux.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),
(@question_id, 4),
(@question_id, 7);

GO

-- 🟩 Question 9
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'École calme ventre rouler tôt ?', 
  'Long noir notre carte accompagner naître. Haut tout voix étrange doucement vingt. Etc dresser
consentir armer fixe siècle obliger roman.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Pendant hôtel secrétaire réel jeter malade falloir.', 1, 'Verser planche repas ancien rang te asseoir calmer âgé etc tempête obliger rose mener.'),
(@question_id, 'fr', 'Ça vieil dormir nation partie déposer solitude.', 0, 'Chat mais vivant examiner avec entourer seulement assister premier cinq étranger type.'),
(@question_id, 'fr', 'Décrire morceau bataille trop importance plaire.', 0, 'Fumer chiffre compagnon trente étrange sûr absolument supposer amener avenir malheur public.'),
(@question_id, 'fr', 'Rue parti premier essayer.', 0, 'Établir tant erreur papier ici rose.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 7),
(@question_id, 8);

GO

-- 🟩 Question 10
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Te accorder combien précéder hiver plusieurs pourquoi de ?', 
  'Instinct haut avenir. Libre enfoncer note problème éteindre bataille ton. Réunir triste que unique
six. Poète sou grain table. Dormir lendemain robe combien exécuter.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Plaine intention esprit hôtel existence spectacle.', 0, 'Lentement briller quant à inventer désigner vaste.'),
(@question_id, 'fr', 'Sonner fonder mourir chat mariage semaine regard.', 1, 'Bon unique hésiter plein disparaître jeune terre souhaiter vrai ferme besoin vif franc.'),
(@question_id, 'fr', 'Journée désespoir dent.', 0, 'Sonner parler mensonge vivre arme achever agir liberté.'),
(@question_id, 'fr', 'Distinguer père parent ah.', 0, 'Fusil vivre fatiguer poser puissance matière.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 6),
(@question_id, 8),
(@question_id, 1);

GO

-- 🟩 Question 11
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Saint vision colère étaler tracer large ?', 
  'Facile phrase oeuvre français faim. Est décrire fatigue charger. Dangereux français sommeil sûr
auprès te effacer fatiguer. Aujourd''Hui distance colline.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Seigneur nul nouveau intérieur penser part.', 0, 'Coeur douter confondre enfance pied toucher révolution paquet.'),
(@question_id, 'fr', 'Terrain résistance valeur souhaiter.', 0, 'Pouvoir peine doucement non longtemps sourire aussi distinguer.'),
(@question_id, 'fr', 'Cri beauté profiter haut effort vrai.', 1, 'Juge rapidement cri pénétrer source médecin.'),
(@question_id, 'fr', 'Envie jeunesse honneur cinq vingt.', 0, 'Trésor dangereux colline herbe parvenir herbe extraordinaire oser maison fonder.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 3),
(@question_id, 5);

GO

-- 🟩 Question 12
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Parler oeil six blond couleur faim faim ?', 
  'Réduire cinq spectacle empire jambe oeil planche chien. Eh cent peau fleur. Espoir course triste
reculer expression.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Être séparer certainement gros.', 0, 'Victime donc odeur ton cour conclure un tempête.'),
(@question_id, 'fr', 'Deviner madame passage construire.', 1, 'Président machine fidèle juge consulter grain celui.'),
(@question_id, 'fr', 'Rapidement riche noire nombreux assister écrire.', 0, 'Réussir bande fortune tapis recommencer anglais remplir tout lueur partager.'),
(@question_id, 'fr', 'Vers qualité révéler supposer accent circonstance.', 0, 'Nul prix envie vous jeter être.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 3),
(@question_id, 4),
(@question_id, 2);

GO

-- 🟩 Question 13
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Aucun fil bataille double dernier paupière ?', 
  'Sauvage contraire achever cher. Devant peau animal chaque connaissance en fort nombreux. Passer
salle charge ligne pièce.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Intelligence près magnifique secret promettre.', 0, 'Jeune recherche professeur dessiner roman accomplir poursuivre fruit tu.'),
(@question_id, 'fr', 'Présenter ensemble respecter reculer.', 0, 'Colline habiter approcher noir souffrir autour abattre président ensuite odeur éclairer.'),
(@question_id, 'fr', 'Réclamer monde intérêt soudain chez.', 0, 'Dépasser pendant trou voisin rire souvenir condamner distance éclairer.'),
(@question_id, 'fr', 'Homme sauter avec été cacher lever.', 1, 'Campagne colon autre guère port taille.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 6),
(@question_id, 3),
(@question_id, 5);

GO

-- 🟩 Question 14
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Dépasser pointe vrai puisque soulever ?', 
  'Solitude un noir nouveau. Recueillir rond vieil armer ni couleur soin. Cuisine loup paupière lueur
renverser vingt beauté.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Situation bleu étaler.', 1, 'Remarquer en protéger chant marcher ministre installer souvent personnage chemin époque.'),
(@question_id, 'fr', 'Art plaisir davantage froid.', 0, 'Billet ancien aller soirée président clair fleur puisque pain fixer.'),
(@question_id, 'fr', 'Jaune colon sauver réfléchir.', 0, 'Distance dans peur surveiller choix reprendre.'),
(@question_id, 'fr', 'Un entourer écraser lieu bon possible que.', 0, 'Briller bord art loup ne épaule autrefois trois.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),
(@question_id, 4),
(@question_id, 5);

GO

-- 🟩 Question 15
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Nombre réclamer exprimer campagne mer tourner en ?', 
  'Représenter croiser ramasser. Tombe somme quart mer exiger exposer ignorer payer. Sentiment type
chaque colon armer arrière.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Sonner solitude admettre nouveau quatre déchirer pointe.', 0, 'Lendemain admettre choisir contre rejoindre danger marche abandonner vêtir oh dieu durer partager.'),
(@question_id, 'fr', 'Frère tracer rond tel combat docteur.', 0, 'Un aussi flot essuyer fête vaste.'),
(@question_id, 'fr', 'Davantage choisir marquer sonner décider réflexion ombre.', 1, 'Ouvrir mener chute empire espèce signifier chemin.'),
(@question_id, 'fr', 'Général là vieil enfermer paquet.', 0, 'Créer violent nouveau ton ferme asseoir autorité droit paysan flamme rapide.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1);

GO

-- 🟩 Question 16
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Retour impression on jeune classe centre plaine soleil lieu compte maladie ?', 
  'Perte noir votre accepter certes. Pencher sourire toujours pauvre membre diriger nation. Rayon
atteindre mesure rapport. Ainsi triste sommet île.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Plusieurs reste curieux accord.', 1, 'Joindre nu retour supporter dans vérité.'),
(@question_id, 'fr', 'Soudain tête époque retirer songer entier.', 0, 'Maître ramasser revenir expression bout air entretenir.'),
(@question_id, 'fr', 'Profond abattre vrai cependant.', 0, 'Appartement réduire étage sauver expression fonction as rêve armer.'),
(@question_id, 'fr', 'Souvenir peser longtemps enfermer idée souhaiter l''une croiser.', 0, 'Mot ainsi plutôt besoin ouvrir inviter propre lentement souvent former ouvert.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 5),
(@question_id, 1);

GO

-- 🟩 Question 17
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Solitude votre réfléchir ressembler elle rocher quinze eaux livre ?', 
  'Faute demeurer voyager. Me cela si machine. Présenter passé rappeler soudain paquet expliquer.
Parvenir immense couleur auquel volonté point endormir. Moindre connaissance condamner cher gloire
soi.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Sujet mener force verre maison franchir million monsieur.', 0, 'Plan hésiter vieillard droite veiller paysage rouge afin de soleil égal.'),
(@question_id, 'fr', 'Porte eau semblable.', 0, 'Souffrance révéler parole changer tranquille commun puisque serrer as important moyen plan réduire.'),
(@question_id, 'fr', 'Odeur compagnon service musique facile.', 0, 'Quartier honte garde attitude note naître.'),
(@question_id, 'fr', 'Tout préférer quatre presque.', 1, 'Veille avant permettre un lisser éclater remercier.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 4),
(@question_id, 2),
(@question_id, 10);

GO

-- 🟩 Question 18
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Derrière paysage saluer remplacer conduire quelque cri reste ?', 
  'Demande effet souvenir nord mieux serrer. Animer soi partir marchand désigner ensemble montrer.
Ruine joue tout maintenant en moyen. Quartier billet causer précéder centre livrer ou.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Interrompre hier rencontrer fille souffler essuyer autre.', 0, 'Lieu vague expliquer désigner envoyer inconnu milieu mince propre.'),
(@question_id, 'fr', 'Conduire si chat oiseau soit.', 1, 'Cent seulement profondément noir user flamme.'),
(@question_id, 'fr', 'Saint surprendre du pauvre.', 0, 'Plan guère envelopper jamais tour aussitôt.'),
(@question_id, 'fr', 'Dépasser juge lier retomber glace recevoir allumer abattre.', 0, 'Rare charge résistance dehors séparer inutile casser.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 9);

GO

-- 🟩 Question 19
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Créer difficile éclat calmer espérer ?', 
  'Objet tout naturel peau signer. Abri aussi point deux préparer éclairer. Peuple finir répandre guère
robe content. Âge défendre entrer nation tête fin cependant.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Toit détacher goutte accrocher.', 0, 'Intérieur pensée partout craindre enfin voiture.'),
(@question_id, 'fr', 'Guerre agent fier jouer.', 0, 'Droit partir mode espérer mort courage dès.'),
(@question_id, 'fr', 'Rose précieux joue sauver règle autorité.', 0, 'Respecter séparer table gouvernement demande devant fixe plaire recherche.'),
(@question_id, 'fr', 'Partie depuis haïr fer.', 1, 'Désormais enfance remercier route détacher oeil songer garder fait résultat dans important chiffre.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 2);

GO

-- 🟩 Question 20
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('single_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Mal préférer contenter autour frapper abattre bas habiller ?', 
  'Fier lors étendue. Système sourd déchirer lutter. Depuis champ existence lire fixer. Doucement par
foule profondément bande arracher tour.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Espérer traîner son cas contre.', 0, 'Il verser étage considérer confier etc tantôt poussière plante foi militaire en cent conclure.'),
(@question_id, 'fr', 'Douter davantage règle.', 1, 'Mesure étranger regretter souffler observer noir tête éclairer voyage pointe pied rocher.'),
(@question_id, 'fr', 'Appel d''abord désir repas mouvement.', 0, 'Chez leur loup science grain commencement peur silencieux en tirer pitié moins maintenant.'),
(@question_id, 'fr', 'Course fusil près accent fine.', 0, 'Fine souhaiter derrière soit horizon pointe semaine trouver pendre comme.');
INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 6),
(@question_id, 2),
(@question_id, 1);

GO

-- ✅ Question 21
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quelles affirmations sont vraies à propos du Sprint Review ?', 
  'Le Sprint Review est une opportunité d''inspecter l''incrément et d''adapter le Product Backlog si nécessaire. C''est un événement empirique majeur dans Scrum.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Elle permet de montrer le travail réalisé durant le Sprint.', 1, 'C''est le but principal du Sprint Review.'),
(@question_id, 'fr', 'Elle sert uniquement à valider l''incrément par le Product Owner.', 0, 'Tous les participants inspectent ensemble l''incrément.'),
(@question_id, 'fr', 'Elle permet d''adapter le Product Backlog en fonction des retours.', 1, 'Elle influence les futurs objectifs et le contenu du backlog.'),
(@question_id, 'fr', 'C''est une réunion de planification des Sprints à venir.', 0, 'C''est le Sprint Planning qui sert à planifier.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),  -- Sprint
(@question_id, 4);  -- Sprint Review

GO

-- ✅ Question 22
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 3, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quelles sont les responsabilités du Scrum Master ?', 
  'Le Scrum Master est un leader serviteur pour l''équipe Scrum, chargé de promouvoir et de soutenir Scrum tel que défini dans le Scrum Guide.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'S''assurer que Scrum est compris et bien appliqué.', 1, 'C''est l''une des missions principales du Scrum Master.'),
(@question_id, 'fr', 'Attribuer les tâches aux membres de l''équipe.', 0, 'C''est l''équipe de développement qui s''auto-organise.'),
(@question_id, 'fr', 'Faciliter les événements Scrum au besoin.', 1, 'Le Scrum Master facilite si nécessaire.'),
(@question_id, 'fr', 'Décider du contenu du Sprint Backlog.', 0, 'Le Sprint Backlog est géré par les développeurs.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 2),  -- Scrum Master
(@question_id, 6);  -- Rôles Scrum

GO

-- ✅ Question 23
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quelles sont les caractéristiques d''un bon Product Backlog ?', 
  'Le Product Backlog est un artefact Scrum vivant qui doit être clair, ordonné, et refléter les priorités du produit à tout moment.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Il est figé à chaque début de Sprint.', 0, 'Il peut évoluer même pendant le Sprint.'),
(@question_id, 'fr', 'Il reflète les besoins et les priorités actuelles.', 1, 'Il est dynamique et à jour.'),
(@question_id, 'fr', 'Il est ordonné par priorité business.', 1, 'L''ordre est déterminé par le Product Owner selon la valeur.'),
(@question_id, 'fr', 'Il est créé uniquement par les développeurs.', 0, 'Le Product Owner est responsable de son contenu.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 3),  -- Product Backlog
(@question_id, 6);  -- Rôles Scrum

GO

-- ✅ Question 24
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quels sont les artefacts définis par le Scrum Guide ?', 
  'Scrum repose sur trois artefacts : le Product Backlog, le Sprint Backlog et l''Incrément. Ils sont essentiels pour la transparence et l''inspection.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Product Backlog', 1, 'C''est l''artefact qui décrit tout le travail à faire.'),
(@question_id, 'fr', 'Sprint Backlog', 1, 'Il contient les éléments sélectionnés pour le Sprint et le plan pour les livrer.'),
(@question_id, 'fr', 'Sprint Goal', 0, 'C''est un objectif, pas un artefact.'),
(@question_id, 'fr', 'Incrément', 1, 'Représente la somme de tous les éléments complétés.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 5),  -- Artefacts Scrum
(@question_id, 6);  -- Rôles Scrum

GO

-- ✅ Question 25
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 3, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quelles options sont des bénéfices de l''auto-organisation dans une équipe Scrum ?', 
  'L''auto-organisation permet une plus grande responsabilisation, créativité et meilleure qualité des livrables.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Augmentation de la productivité.', 1, 'Les équipes auto-organisées sont généralement plus efficaces.'),
(@question_id, 'fr', 'Réduction de la responsabilité individuelle.', 0, 'Au contraire, elle augmente la responsabilité de chacun.'),
(@question_id, 'fr', 'Meilleure réactivité face aux changements.', 1, 'Elles s''adaptent plus facilement aux imprévus.'),
(@question_id, 'fr', 'Décision centralisée par le manager.', 0, 'Scrum favorise la décentralisation des décisions.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 2),  -- Scrum Master
(@question_id, 6);  -- Rôles Scrum

GO

-- ✅ Question 26
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quelles sont les valeurs fondamentales de Scrum ?', 
  'Les cinq valeurs Scrum sont : engagement, courage, focus, ouverture, et respect.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Transparence', 0, 'La transparence est un pilier de Scrum, mais pas une valeur.'),
(@question_id, 'fr', 'Engagement', 1, 'C''est bien l''une des cinq valeurs Scrum.'),
(@question_id, 'fr', 'Focus', 1, 'C''est une valeur officielle du Scrum Guide.'),
(@question_id, 'fr', 'Planification', 0, 'C''est une activité, pas une valeur.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 6);  -- Rôles Scrum

GO

-- ✅ Question 27
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quelles sont les responsabilités du Product Owner dans Scrum ?', 
  'Le Product Owner maximise la valeur du produit, gère le Product Backlog, et veille à sa clarté et transparence.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Gérer le contenu du Product Backlog.', 1, 'C''est l''une de ses responsabilités principales.'),
(@question_id, 'fr', 'Décider du Sprint Goal sans consulter les développeurs.', 0, 'Le Sprint Goal est défini ensemble.'),
(@question_id, 'fr', 'Maximiser la valeur produite par l''équipe Scrum.', 1, 'C''est sa mission principale.'),
(@question_id, 'fr', 'Assurer la clarté et la transparence du Product Backlog.', 1, 'C''est essentiel pour le bon déroulement de Scrum.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 3),  -- Product Backlog
(@question_id, 6);  -- Rôles Scrum

GO

-- ✅ Question 28
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quels sont les objectifs du Daily Scrum ?', 
  'Le Daily Scrum permet à l''équipe de planifier le travail des prochaines 24h et de synchroniser ses activités.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Partager l''état d''avancement des tâches.', 1, 'Cela aide à la coordination de l''équipe.'),
(@question_id, 'fr', 'Identifier les obstacles potentiels.', 1, 'C''est un moment pour faire remonter les blocages.'),
(@question_id, 'fr', 'Modifier le Product Backlog.', 0, 'Ce n''est pas le moment prévu pour cela.'),
(@question_id, 'fr', 'Recevoir les ordres du Scrum Master.', 0, 'L''équipe est auto-organisée.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),  -- Sprint
(@question_id, 4);  -- Sprint Review

GO

-- ✅ Question 29
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 2, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quels éléments peuvent changer pendant un Sprint ?', 
  'Pendant un Sprint, le scope peut être clarifié et ajusté en collaboration avec le Product Owner.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Le Sprint Goal.', 0, 'Le Sprint Goal reste fixe pendant tout le Sprint.'),
(@question_id, 'fr', 'Le contenu du Sprint Backlog.', 1, 'Il peut être ajusté par les développeurs.'),
(@question_id, 'fr', 'Les tâches pour atteindre le Sprint Goal.', 1, 'Elles sont souvent affinées en cours de Sprint.'),
(@question_id, 'fr', 'La durée du Sprint.', 0, 'Elle est fixe et ne doit pas être modifiée.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),  -- Sprint
(@question_id, 5);  -- Artefacts Scrum

GO

-- ✅ Question 30
DECLARE @question_id INT;

INSERT INTO QuestionMeta (question_type, difficulty_level, source, source_url, certification_id)
VALUES ('multiple_choice', 3, 'ChatGPT', NULL, 1);
SET @question_id = SCOPE_IDENTITY();

INSERT INTO QuestionTranslations (question_id, language_code, question_text, explanation_detailed)
VALUES (
  @question_id, 'fr', 
  'Quels facteurs influencent la vélocité d''une équipe Scrum ?', 
  'La vélocité peut être affectée par de nombreux éléments : expérience, interruptions, stabilité, etc.'
);

INSERT INTO AnswerChoices (question_id, language_code, answer_text, is_correct, explanation)
VALUES
(@question_id, 'fr', 'Les congés des membres de l''équipe.', 1, 'Cela diminue la capacité du Sprint.'),
(@question_id, 'fr', 'La stabilité de l''équipe au fil des Sprints.', 1, 'Une équipe stable a une vélocité plus prévisible.'),
(@question_id, 'fr', 'Le nombre de clients potentiels du produit.', 0, 'Cela n''influence pas directement la vélocité.'),
(@question_id, 'fr', 'Les interruptions extérieures.', 1, 'Elles réduisent le temps consacré aux tâches du Sprint.');

INSERT INTO QuestionTags (question_id, tag_id)
VALUES
(@question_id, 1),  -- Sprint
(@question_id, 6);  -- Rôles Scrum
