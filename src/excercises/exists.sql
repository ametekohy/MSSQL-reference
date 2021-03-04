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
