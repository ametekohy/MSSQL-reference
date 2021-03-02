/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     23-12-2015		                            */
/* INSERT SCRIPT MuziekdatabaseUitgebreid						*/
/*==============================================================*/

use MuziekdatabaseUitgebreid
go

DELETE FROM StudentInstrumentUitvoeringStuk
DELETE FROM uitvoeringstuk
DELETE FROM studentinstrument
DELETE FROM student
DELETE FROM bezettingsregel;
DELETE FROM instrument;
UPDATE stuk SET stuknrOrigineel = NULL;
DELETE FROM stuk;
DELETE FROM genre;
DELETE FROM niveau;
DELETE FROM Componist;
DELETE FROM Muziekschool;

INSERT INTO Muziekschool VALUES (1, 'Muziekschool Amsterdam',   'Amsterdam');
INSERT INTO Muziekschool VALUES (2, 'Reijnders'' Muziekschool', 'Nijmegen');
INSERT INTO Muziekschool VALUES (3, 'Het Muziekpakhuis',        'Amsterdam');

INSERT INTO Componist VALUES ( 1, 'Charlie Parker', '12-dec-1904', NULL);
INSERT INTO Componist VALUES ( 2, 'Thom Guidi',     '05-jan-1946', 1);
INSERT INTO Componist VALUES ( 4, 'Rudolf Escher',  '08-jan-1912', NULL);
INSERT INTO Componist VALUES ( 5, 'Sofie Bergeijk', '12-jul-1960', 2);
INSERT INTO Componist VALUES ( 8, 'W.A. Mozart',    '27-jan-1756', NULL);
INSERT INTO Componist VALUES ( 9, 'Karl Schumann',  '10-oct-1935', 2);
INSERT INTO Componist VALUES (10, 'Jan van Maanen', '08-sep-1965', 1);

INSERT INTO genre VALUES ('klassiek');
INSERT INTO genre VALUES ('jazz');
INSERT INTO genre VALUES ('pop');
INSERT INTO genre VALUES ('techno');

INSERT INTO niveau VALUES ('A', 'beginners');
INSERT INTO niveau VALUES ('B', 'gevorderden');
INSERT INTO niveau VALUES ('C', 'vergevorderden');

INSERT INTO stuk VALUES ( 1,  1, 'Blue bird',       NULL, 'jazz',     NULL, 4.5,  1954);
INSERT INTO stuk VALUES ( 2,  2, 'Blue bird',       1,    'jazz',     'B',  4,    1988);
INSERT INTO stuk VALUES ( 3,  4, 'Air pur charmer', NULL, 'klassiek', 'B',  4.5,  1953);
INSERT INTO stuk VALUES ( 5,  5, 'Lina',            NULL, 'klassiek', 'B',  5,    1979);
INSERT INTO stuk VALUES ( 8,  8, 'Berceuse',        NULL, 'klassiek', NULL, 4,    1786);
INSERT INTO stuk VALUES ( 9,  2, 'Cradle song',     8,    'klassiek', 'B',  3.5,  1990);
INSERT INTO stuk VALUES (10,  8, 'Non piu andrai',  NULL, 'klassiek', NULL, NULL, 1791);
INSERT INTO stuk VALUES (12,  9, 'I''ll never go',  10,   'pop',      'A',  6,    1996);
INSERT INTO stuk VALUES (13, 10, 'Swinging Lina',   5,    'jazz',     'B',  8,    1997);
INSERT INTO stuk VALUES (14,  5, 'Little Lina',     5,    'klassiek', 'A',  4.3,  1998);
INSERT INTO stuk VALUES (15, 10, 'Blue sky',        1,    'jazz',     'A',  4,    1998);

/* Opmerking:
   Een enkel aanhalingsteken binnen string (zoals in muziekschool 2 en stuk 12) moet
   twee keer worden genoteerd; anders wordt het opgevat als einde-string teken.
*/

INSERT INTO instrument VALUES ('piano',    ''       );
INSERT INTO instrument VALUES ('fluit',    ''       );
INSERT INTO instrument VALUES ('fluit',    'alt'    );
INSERT INTO instrument VALUES ('saxofoon', 'alt'    );
INSERT INTO instrument VALUES ('saxofoon', 'tenor'  );
INSERT INTO instrument VALUES ('saxofoon', 'sopraan');
INSERT INTO instrument VALUES ('gitaar',   ''       );
INSERT INTO instrument VALUES ('viool',    ''       );
INSERT INTO instrument VALUES ('viool',    'alt'    );
INSERT INTO instrument VALUES ('drums',    ''       );

INSERT INTO bezettingsregel VALUES ( 2, 'drums',    '',      1);
INSERT INTO bezettingsregel VALUES ( 2, 'saxofoon', 'alt',   2);
INSERT INTO bezettingsregel VALUES ( 2, 'saxofoon', 'tenor', 1);
INSERT INTO bezettingsregel VALUES ( 2, 'piano',    '',      1);
INSERT INTO bezettingsregel VALUES ( 3, 'fluit',    '',      1);
INSERT INTO bezettingsregel VALUES ( 5, 'fluit',    '',      3);
INSERT INTO bezettingsregel VALUES ( 9, 'fluit',    '',      1);
INSERT INTO bezettingsregel VALUES ( 9, 'fluit',    'alt',   1);
INSERT INTO bezettingsregel VALUES ( 9, 'piano',    '',      1);
INSERT INTO bezettingsregel VALUES (12, 'piano',    '',      1);
INSERT INTO bezettingsregel VALUES (12, 'fluit',    '',      2);
INSERT INTO bezettingsregel VALUES (13, 'drums',    '',      1);
INSERT INTO bezettingsregel VALUES (13, 'saxofoon', 'alt',   1);
INSERT INTO bezettingsregel VALUES (13, 'saxofoon', 'tenor', 1);
INSERT INTO bezettingsregel VALUES (13, 'fluit',    '',      2);
INSERT INTO bezettingsregel VALUES (14, 'piano',    '',      1);
INSERT INTO bezettingsregel VALUES (14, 'fluit',    '',      1);
INSERT INTO bezettingsregel VALUES (15, 'saxofoon', 'alt',   2);
INSERT INTO bezettingsregel VALUES (15, 'fluit',    'alt',   2);
INSERT INTO bezettingsregel VALUES (15, 'piano',    '',      1);

INSERT INTO student (studentid, schoolid, voornaam, achternaam, inschrijfdatum)
VALUES(1, 1, 'Emmy', 'Verhey', '2000-09-01'),
      (2,2, 'Candy', 'Dulfer', '2000-09-01'),
      (3,3, 'Thijs', 'van Leer', '2000-09-01'),
      (4,1, 'Ome', 'Willem', '2000-09-01'),
      (5,2, 'Wibi', 'Soerjadi', '2000-09-01'),
      (7,3, 'Misja', 'Nabben', '2000-09-01'),
      (8,2, 'Harrie', 'van Seters', '2000-09-01'),
      (9,1, 'Jan', 'Akkerman', '2000-09-01'),
      (10,2, 'Hans', 'Dulfer', '2000-09-01')

INSERT INTO studentinstrument (instrumentnaam, toonhoogte, studentid, niveaucode)
VALUES ('viool', 'alt', 1, 'C'),
       ('saxofoon', 'alt', 2, 'C'),
       ('fluit', '', 3, 'C'),
       ('drums', '', 4, 'B'),
       ('piano', '', 5, 'C'),
       ('saxofoon', 'alt', 7, 'B'),
       ('fluit', 'alt', 8, 'A'),
       ('saxofoon', 'tenor', 2, 'B'),
       ('fluit', 'alt', 3, 'B'),
       ('gitaar', '', 9, 'C'),
       ('saxofoon', 'tenor', 10, 'C')

INSERT INTO uitvoeringstuk (stuknr, datumtijduitvoering)
VALUES (2, '20141224'),
       (3, '20150101'),
       (9, '20151231'),
       (12, '20151206'),
       (15, '20160101')

INSERT INTO StudentInstrumentUitvoeringStuk(instrumentnaam, toonhoogte, studentId, stuknr, datumtijduitvoering)
VALUES ('drums', '', 4, 2, '20141224'),
       ('saxofoon', 'alt', 2, 2, '20141224'),
       ('saxofoon', 'alt', 7, 2, '20141224'),
       ('saxofoon', 'tenor', 10, 2, '20141224'),
       ('piano', '', 5, 2, '20141224'),
       ('fluit', '', 3, 3, '20150101'),
       ('piano', '', 5, 12, '20151206'),
       ('fluit', '', 3, 12, '20151206')