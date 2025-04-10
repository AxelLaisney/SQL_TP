-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT * FROM Article ORDER BY Ref ASC

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT * FROM Article ORDER BY Prix ASC

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM Article WHERE Designation = 'boulons' ORDER BY Prix ASC

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM Article WHERE Designation LIKE '%sachet%'

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * FROM Article WHERE LOWER(Designation) LIKE '%sachet%'

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT * FROM Article LEFT JOIN Fournisseur ON Article.Id_fou = Fournisseur.IDFournisseur ORDER BY Fournisseur.Nom,  Article.Prix DESC

-- g. Listez les articles de la société « Dubois & Fils »
SELECT * FROM Article WHERE Id_fou = 3

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT SUM(Prix) FROM Article WHERE Id_fou = 3

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT Fournisseur.Nom, AVG(Article.Prix) FROM Fournisseur LEFT JOIN Article ON Article.Id_fou = Fournisseur.IDFournisseur GROUP BY Fournisseur.Nom

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * FROM Bon WHERE Date_cmde BETWEEN '01/03/2019' AND '05/04/2019'

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT Bon.Numero
FROM Bon
LEFT JOIN compo ON compo.Id_bon = Bon.ID
LEFT JOIN Article ON Article.ID = compo.Id_art
WHERE Article.Designation LIKE '%boulons%'

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT Fournisseur.Nom, Bon.Numero
FROM Bon
LEFT JOIN Fournisseur ON Fournisseur.IDFournisseur = Bon.Id_fou
LEFT JOIN Article ON Article.ID = Fournisseur.IDFournisseur
WHERE Article.Designation LIKE '%boulons%'

-- m. Calculez le prix total de chaque bon de commande
SELECT Bon.Numero, SUM(Article.Prix * compo.QTE)
FROM Bon
LEFT JOIN compo ON compo.Id_bon = Bon.ID
LEFT JOIN Article ON Article.ID = compo.Id_art
GROUP BY Bon.Numero

-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT Bon.Numero, SUM(compo.QTE)
FROM Bon
LEFT JOIN compo ON compo.Id_bon = Bon.ID
GROUP BY Bon.ID

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT Bon.Numero, SUM(compo.QTE)
FROM Bon
LEFT JOIN compo ON compo.Id_bon = Bon.ID
GROUP BY Bon.ID
HAVING SUM(compo.QTE) > 25



-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT Bon.Numero, SUM(Article.Prix)
FROM Bon
LEFT JOIN compo ON compo.Id_bon = Bon.ID
LEFT JOIN Article ON Article.ID = compo.Id_art
WHERE MONTH(Bon.Date_cmde) = 4