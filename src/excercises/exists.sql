/*
    Een niet-gecorrelleerde subquery:

    SELECT stuknr, instrumentnaam, toonhoogte
    FROM bezettingsregel
    WHERE aantal = (SELECT MAX(aantal)          <-- zelfstandig executeerbaar
                    FROM bezettingsregel)

    Gecorreleerde subquery:

    SELECT stuknr, instrumentnaam, toonhoogte, aantal
    FROM bezettingsregel b
    WHERE aantal = (SELECT MAX(aantal)          <-- niet zelfstandig executeerbaar
                    FROM bezettingsregel            b in subquery verwijst buiten subquery
                    WHERE stuknr = b.stuknr)

    Exists (er bestaat)

    SELECT stuknr, title
    FROM stuk s
    WHERE EXISTS = (SELECT 1
                    FROM bezettingsregel
                    WHERE stuknr = s.stuknr
                    AND instrumentnaam = 'saxofoon')
    bestaat voor elk stuknr

    NOT EXISTS

    SELECT instrumentnaam, toonhoogte
    FROM instrument i
    WHERE NOT EXISTS    (SELECT 1
                        FROM bezettingsregel
                        WHERE i.instrumentnaam = instrumentnaam
                        AND i.toonhoogte = toonhoogte)

*/

-- 1.	Geef stuknr en titel van elk stuk waar een piano in meespeelt.
SELECT s.stuknr, s.titel
FROM Stuk s
WHERE EXISTS (SELECT 1 FROM Bezettingsregel b
              WHERE b.stuknr = s.stuknr
                AND b.instrumentnaam = 'piano')

-- 2.	Geef stuknr en titel voor elk stuk waar géén piano in meespeelt.
SELECT s.stuknr, s.titel
FROM Stuk s
WHERE NOT EXISTS (SELECT 1 FROM Bezettingsregel b
                  WHERE b.stuknr = s.stuknr
                    AND b.instrumentnaam = 'piano')

-- 3.	Geef instrumenten (instrumentnaam + toonhoogte) die niet worden gebruikt.
SELECT instrumentnaam, toonhoogte
FROM Instrument i
WHERE NOT EXISTS (SELECT 1 FROM Bezettingsregel b
                  WHERE b.instrumentnaam = i.instrumentnaam)

-- 4.	Geef componistId en naam van iedere componist die meer dan 1 stuk heeft gecomponeerd.
SELECT componistId, naam
FROM Componist
WHERE EXISTS(SELECT stuknr FROM Stuk
             WHERE Stuk.componistId = Componist.componistId
             GROUP BY stuknr
             HAVING COUNT(*) >1)

-- 5.	Geef alle originele stukken waar geen bewerkingen van zijn.
SELECT stuknr, titel
FROM Stuk s
WHERE s.stuknrOrigineel is null
  AND NOT EXISTS(SELECT 1 FROM Stuk s2
                 WHERE s.stuknrOrigineel = s2.stuknr)

SELECT stuknr, titel
FROM Stuk s
WHERE stuknrOrigineel is null
  AND stuknr NOT IN(SELECT s2.stuknr FROM Stuk s2
                    WHERE s.stuknrOrigineel IS NOT NULL)

-- 6.	Geef de drie oudste stukken (zonder top te gebruiken).
SELECT stuknr, titel
FROM Stuk s
WHERE (
          SELECT COUNT(*)
          FROM Stuk s2
          WHERE s2.jaartal < s.jaartal) < 3

-- 7.	Is er een stuk waarin alle instrumenten meespelen?
SELECT stuknr, titel
FROM Stuk
WHERE EXISTS(
              SELECT stuknr
              FROM Bezettingsregel
              WHERE Stuk.stuknr = Bezettingsregel.stuknr
              GROUP BY Bezettingsregel.stuknr
              HAVING COUNT(*) = (SELECT COUNT(*) FROM Instrument)
          )