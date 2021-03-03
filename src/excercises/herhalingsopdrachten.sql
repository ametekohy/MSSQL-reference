/* Herhalingsopdrachten SQL */

-- 1.	Geef voor elk klassiek stuk het stuknr, de titel en de naam van de componist.
SELECT s.stuknr , s.titel, c.naam
FROM Stuk s
         INNER JOIN Componist C on C.componistId = s.componistId

GO

-- 2.	Welke stukken zijn gecomponeerd door een muziekschooldocent?
-- Geef van de betreffende stukken het stuknr, de titel, de naam van de componist en de naam van de muziekschool.
SELECT s.stuknr, s.titel, c.naam, m.naam
FROM Stuk s
         INNER JOIN Componist C on C.componistId = s.componistId
         INNER JOIN Muziekschool M on M.schoolId = C.schoolId

-- 3.	Bij welke stukken (geef stuknr en titel) bestaat de bezetting uit ondermeer een saxofoon?
-- Opmerking: Gebruik een subquery.

SELECT s.stuknr, s.titel
FROM Stuk s
WHERE s.stuknr IN ( SELECT stuknr
                    FROM Bezettingsregel
                    WHERE instrumentnaam = 'saxofoon')

-- 4.	Bij welke stukken wordt de saxofoon niet gebruikt?
SELECT *
FROM Stuk s
WHERE s.stuknr NOT IN ( SELECT stuknr
                        FROM Bezettingsregel
                        WHERE instrumentnaam = 'saxofoon')

-- 5.	Bij welke jazzstukken worden twee of meer verschillende instrumenten gebruikt?
SELECT s.stuknr, s.titel
FROM Stuk s
         INNER JOIN Bezettingsregel B on s.stuknr = B.stuknr
WHERE s.genrenaam = 'jazz'
GROUP BY s.stuknr, s.titel
having count(*) >= 2

-- 6.	Geef het aantal originele muziekstukken per componist. Ook componisten met nul originele stukken dienen te worden getoond.
SELECT c.naam, count(stuknr)
FROM Stuk s
         RIGHT JOIN Componist C on C.componistId = s.componistId
    AND s.stuknrOrigineel is null
GROUP BY c.naam

-- 7.	Geef voor elk niveau de niveaucode, de omschrijving en het aantal klassieke speelstukken.
-- Opmerking: Dus ook als er voor een niveau geen klassieke speelstukken zijn.
SELECT s.niveaucode, n.niveaucode, COUNT(s.stuknr)
FROM Stuk s
         INNER JOIN Niveau N on N.niveaucode = s.niveaucode
WHERE s.genrenaam = 'klassiek' OR s.genrenaam is null
GROUP BY s.niveaucode, n.niveaucode

-- 8.	Geef het nummer en de naam van de muziekscholen waarvoor meer dan drie speelstukken bestaan die gecomponeerd zijn door docenten van de betreffende school.
SELECT m.schoolId, m.naam
FROM Stuk s
         INNER JOIN Componist C on C.componistId = s.componistId
         INNER JOIN Muziekschool M on M.schoolId = C.schoolId
GROUP BY m.schoolId, m.naam
HAVING COUNT(*) > 3

-- 9.	Voorspel uit hoeveel rijen het resultaat van de volgende query bestaat:
-- 	SELECT	*
-- 	FROM 	Componist, Muziekschool;
-- 	Ga vervolgens na of je voorspelling correct is.
-- 	Opmerking: Deze query heeft hetzelfde effect als
SELECT	*
FROM 	Componist CROSS JOIN Muziekschool;

-- 10.	Stel de tabel Componist is gedefinieerd zonder een UNIQUE-constraint op de kolom naam. Als je deze constraint toevoegt m.b.v. een ALTER TABLE statement, dan lukt dat niet als er dubbele waarden voorkomen in de kolom naam.
-- Geef een SELECT-statement waarmee je de rijen met een niet-unieke componistnaam kunt opsporen.
SELECT *
FROM Componist c
WHERE naam in ( SELECT naam
                FROM Componist
                GROUP BY naam
                HAVING COUNT(*) > 1)

-- 11.	Geef twee UPDATE-statements waarmee alle stukken van docenten van Muziekschool Sonsbeek op niveaucode C gezet worden, als de niveaucode not null was: gebruik Ms SQL Server’s multiple tables UPDATE optie beschreven in the SQL Bible op pagina’s 302 tm 305 en scrhijf een ANSI SQL subquery variant.
--
-- Plaats je statements tussen een BEGIN TRANSACTION - ROLLBACK TRANSACTION statement combinatie. Daarmee worden wijzigingen aan de data uiteindelijk weer ongedaan gemaakt terwijl resultaten tijdelijk wel beschikbaar zijn voor controle op correctheid.
--
-- BEGIN TRANSACTION
-- 		<jouw UPDATE/DELETE statement>
-- 		<jouw SQL SELECT controle statement>
-- 	          ROLLBACK TRANSACTION
UPDATE Stuk
set niveaucode = 'C'
from Stuk s
         inner join Componist C on C.componistId = s.componistId
         inner join Muziekschool M on M.schoolId = C.schoolId
where m.naam = 'Muziekschool Sonsbeek'
  and s.niveaucode is not null

SELECT *
from Stuk s
         inner join Componist C on C.componistId = s.componistId
         inner join Muziekschool M on M.schoolId = C.schoolId
where m.naam = 'Muziekschool Sonsbeek'
  and s.niveaucode is not null

-- 12.	Geef twee DELETE-statements waarmee alle bezettingsregels van stukken van docenten van Muziekschool Sonsbeek verwijderd worden: gebruik Ms SQL Server’s multiple tables DELETE optie beschreven in the SQL Bible op pagina’s 310 tm 312 en scrhijf een ANSI SQL subquery variant.
--
-- Gebruik weer onderstaande transactie statements.
--
-- BEGIN TRANSACTION
-- 		<jouw UPDATE/DELETE statement>
-- 		<jouw SQL SELECT controle statement>
-- ROLLBACK TRANSACTION

DELETE FROM Bezettingsregel
from Bezettingsregel b
         INNER JOIN Stuk S on S.stuknr = b.stuknr
         INNER JOIN Componist C on C.componistId = S.componistId
         INNER JOIN Muziekschool M on M.schoolId = C.schoolId
WHERE m.naam = 'Muziekschool Sonsbeek'

SELECT * FROM Bezettingsregel
                  inner join Stuk S on S.stuknr = Bezettingsregel.stuknr
                  inner join Componist C on C.componistId = S.componistId
                  inner join Muziekschool M on M.schoolId = C.schoolId
where m.naam = 'Muziekschool Sonsbeek'