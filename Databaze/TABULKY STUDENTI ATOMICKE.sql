/*  TABULKY STUDENTI NEATOMICKE*/

/* Vytvorte tyto tabulky. */
create table student (ID INTEGER, jmeno VARCHAR(45));
create table ucitel (ID INTEGER, jmeno VARCHAR(45));
create table uci (ID_studenta INTEGER, ID_ucitele INTEGER, predmet VARCHAR(45));
create table knihy (ID INTEGER, ID_studenta INTEGER, nazev VARCHAR(100));

/* Vlozte do kazde tabulky 2-4 radky. */
INSERT INTO student (ID, jmeno) VALUES (1, 'Petr Blazek');
INSERT INTO student (ID, jmeno) VALUES (2, 'Petr Moravec');
INSERT INTO student (ID, jmeno) VALUES (3, 'Martin Rychly');
INSERT INTO student (ID, jmeno) VALUES (4, 'Pavel Stanek');

INSERT INTO ucitel (ID, jmeno) VALUES (1, 'Simeon Karamazov');
INSERT INTO ucitel (ID, jmeno) VALUES (2, 'Martin Zeman');
INSERT INTO ucitel (ID, jmeno) VALUES (3, 'Kamil Pulpan');
INSERT INTO ucitel (ID, jmeno) VALUES (4, 'David Zak');

INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (1, 2, 'IZITE');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (2, 1, 'C++');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (3, 2, 'AJ');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (4, 1, 'DS1');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (2, 2, 'IZITE');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (1, 3, 'C++');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (3, 1, 'DS1');
INSERT INTO uci (ID_studenta,ID_ucitele, predmet) VALUES (2, 1, 'DS1');

INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3001, 3, 'Databazove systemy');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3002, 3, 'MySQL snadno a rychle');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3003, 3, 'Anglictina');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3004, 1, 'Nemcina');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3005, 1, 'SQL za 21 dni');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3006, 3, 'Relacni databaze');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3007, 3, 'Mistrovstvi v SQL');
INSERT INTO knihy (ID,ID_studenta,nazev) VALUES (3008, 1, 'MySQL Programming');
/*  TABULKY STUDENTI ATOMICKE*/
/* Upravte tabulky student a ucitel tak, aby příjmení a jméno bylo samostatném sloupečku  */
ALTER TABLE student ADD (prijmeni VARCHAR(25));
UPDATE student SET prijmeni='Blazek' WHERE jmeno='Petr Blazek';
UPDATE student SET jmeno='Petr' WHERE prijmeni='Blazek';
UPDATE student SET prijmeni='Moravec' WHERE jmeno='Petr Moravec';
UPDATE student SET jmeno='Petr' WHERE prijmeni='Moravec';
UPDATE student SET prijmeni='Rychly' WHERE jmeno='Martin Rychly';
UPDATE student SET jmeno='Martin' WHERE prijmeni='Rychly';
UPDATE student SET prijmeni='Stanek' WHERE jmeno='Pavel Stanek';
UPDATE student SET jmeno='Pavel' WHERE prijmeni='Stanek';

ALTER TABLE ucitel ADD (prijmeni VARCHAR(25));
UPDATE ucitel SET prijmeni='Karamazov' WHERE jmeno='Simeon Karamazov';
UPDATE ucitel SET jmeno='Simeon' WHERE prijmeni='Karamazov';
UPDATE ucitel SET prijmeni='Zeman' WHERE jmeno='Martin Zeman';
UPDATE ucitel SET jmeno='Martin' WHERE prijmeni='Zeman';
UPDATE ucitel SET prijmeni='Pulpan' WHERE jmeno='Kamil Pulpan';
UPDATE ucitel SET jmeno='Kamil' WHERE prijmeni='Pulpan';
UPDATE ucitel SET prijmeni='Zak' WHERE jmeno='David Zak';
UPDATE ucitel SET jmeno='David' WHERE prijmeni='Zak';

SELECT prijmeni AS "Příjmení studentů" FROM student;

SELECT jmeno AS "Jméno studenta" FROM student ORDER BY jmeno;

SELECT jmeno as "Jméno studenta" FROM student ORDER BY jmeno DESC;

SELECT * FROM student WHERE jmeno="PETR";

SELECT COUNT(jmeno) AS "Počet studentů" FROM student;

SELECT LCASE(jmeno) AS jmeno, UCASE(prijmeni) AS "Příjmení" FROM student ORDER BY prijmeni;


SELECT prijmeni, CHAR_LENGTH(prijmeni) AS "Délka příjmení" FROM student
  WHERE ID < 2 AND (jmeno = 'Petr' OR jmeno = 'Karel');

SELECT DISTINCT student.jmeno, student.prijmeni FROM student JOIN uci ON student.ID = uci.ID_studenta
WHERE student.ID < 2 
AND student.jmeno = 'Petr';


SELECT 
    ucitel.jmeno AS "Jméno učitele", 
    ucitel.prijmeni AS "Příjmení učitele", 
    student.jmeno AS "Jméno studenta", 
    student.prijmeni AS "Příjmení studenta"
FROM uci, ucitel, student
WHERE uci.ID_ucitele = ucitel.ID 
  AND uci.ID_studenta = student.ID;

SELECT DISTINCT student.jmeno AS "Jméno studenta", student.prijmeni AS "Příjmení studenta", knihy.nazev AS "Název knihy"
FROM student, knihy
WHERE student.ID = knihy.ID_studenta 
  AND CHAR_LENGTH(knihy.nazev) > 10;


SELECT DISTINCT 
    student.jmeno AS "Jméno studenta", 
    student.prijmeni AS "Příjmení studenta", 
    knihy.nazev AS "Název knihy"
FROM student
JOIN knihy ON student.ID = knihy.ID_studenta
WHERE knihy.ID BETWEEN 3000 AND 3002;


SELECT DISTINCT 
    ucitel.jmeno AS "Jméno učitele", 
    ucitel.prijmeni AS "Příjmení učitele"
FROM ucitel
JOIN uci ON ucitel.ID = uci.ID_ucitele
JOIN knihy ON uci.ID_studenta = knihy.ID_studenta;

SELECT DISTINCT 
    ucitel.jmeno AS "Jméno učitele", 
    ucitel.prijmeni AS "Příjmení učitele",
    student.jmeno AS "Jméno studenta",
    student.prijmeni AS "Příjmení studenta"
FROM ucitel
JOIN uci ON ucitel.ID = uci.ID_ucitele
JOIN student ON uci.ID_studenta = student.ID
JOIN knihy ON student.ID = knihy.ID_studenta;


SELECT DISTINCT 
    ucitel.jmeno AS "Jméno učitele", 
    ucitel.prijmeni AS "Příjmení učitele",
    student.jmeno AS "Jméno studenta",
    student.prijmeni AS "Příjmení studenta"
FROM ucitel
JOIN uci ON ucitel.ID = uci.ID_ucitele
JOIN student ON uci.ID_studenta = student.ID
WHERE student.ID BETWEEN 2 AND 6
  AND (student.jmeno = 'Petr' OR student.jmeno = 'Karel')
  AND CHAR_LENGTH(student.prijmeni) > 6;



SELECT student.prijmeni AS "Příjmení studenta"
FROM student
JOIN uci ON student.ID = uci.ID_studenta
GROUP BY student.prijmeni;


SELECT 
    student.jmeno AS "Jméno studenta", 
    student.prijmeni AS "Příjmení studenta", 
    COUNT(uci.predmet) AS "Počet předmětů které studují"
FROM student
JOIN uci ON student.ID = uci.ID_studenta
GROUP BY student.ID, student.jmeno, student.prijmeni;

SELECT 
    ucitel.ID AS "ID učitele",
    ucitel.jmeno AS "Jméno učitele",
    ucitel.prijmeni AS "Příjmení učitele",
    uci.predmet AS "Předmět"
FROM ucitel, uci
WHERE ucitel.ID = uci.ID_ucitele;

--stejne
SELECT 
    ucitel.ID AS "ID učitele",
    ucitel.jmeno AS "Jméno učitele",
    ucitel.prijmeni AS "Příjmení učitele",
    uci.predmet AS "Předmět"
FROM ucitel
JOIN uci ON ucitel.ID = uci.ID_ucitele;


SELECT 
    student.ID AS "ID studenta",
    student.jmeno AS "Jméno studenta",
    student.prijmeni AS "Příjmení studenta",
    ucitel.ID AS "ID učitele",
    ucitel.jmeno AS "Jméno učitele",
    ucitel.prijmeni AS "Příjmení učitele",
    uci.predmet AS "Název předmětu"
FROM student
JOIN uci ON student.ID = uci.ID_studenta
JOIN ucitel ON uci.ID_ucitele = ucitel.ID
GROUP BY student.ID, student.jmeno, student.prijmeni, ucitel.ID, ucitel.jmeno, ucitel.prijmeni, uci.predmet;


SELECT 
    uci.predmet AS "Název předmětu",
    ucitel.prijmeni AS "Příjmení učitele",
    COUNT(uci.ID_studenta) AS "Počet studentů"
FROM uci
JOIN ucitel ON uci.ID_ucitele = ucitel.ID
GROUP BY uci.predmet, ucitel.prijmeni
HAVING COUNT(uci.ID_studenta) > 1;

SELECT 
    ucitel.ID AS "ID učitele",
    ucitel.jmeno AS "Jméno učitele",
    ucitel.prijmeni AS "Příjmení učitele",
    uci.predmet AS "Název předmětu",
    COUNT(*) AS "Počet studentů"
FROM ucitel
JOIN uci ON ucitel.ID = uci.ID_ucitele
GROUP BY ucitel.ID, ucitel.jmeno, ucitel.prijmeni, uci.predmet
HAVING COUNT(*) IN (2);


SELECT 
    student.jmeno AS "Jméno studenta",
    student.prijmeni AS "Příjmení studenta",
    knihy.nazev AS "Název knihy"
FROM student
LEFT JOIN knihy ON student.ID = knihy.ID_studenta;


SELECT 
    student.jmeno AS "Jméno studenta",
    student.prijmeni AS "Příjmení studenta",
    knihy.nazev AS "Název knihy"
FROM student
RIGHT JOIN knihy ON student.ID = knihy.ID_studenta;


SELECT 
    student.jmeno AS "Jméno studenta",
    student.prijmeni AS "Příjmení studenta"
FROM student
LEFT JOIN knihy ON student.ID = knihy.ID_studenta
WHERE knihy.ID IS NULL; 

SELECT DISTINCT ucitel.jmeno, ucitel.prijmeni
FROM ucitel
JOIN uci ON ucitel.id = uci.id_ucitele
JOIN student ON uci.id_studenta = student.id
LEFT JOIN knihy ON student.id = knihy.id_studenta
WHERE knihy.id_studenta IS NULL;


SELECT student.jmeno, student.prijmeni, uci.predmet
FROM student
LEFT JOIN uci ON student.id = uci.id_studenta
LEFT JOIN knihy ON student.id = knihy.id_studenta
WHERE knihy.id_studenta IS NULL;

SELECT DISTINCT ucitel.jmeno AS "Jméno učitele", ucitel.prijmeni AS "Příjmení učitele" FROM ucitel JOIN uci ON ucitel.ID = uci.ID_ucitele JOIN student ON uci.ID_studenta = student.ID LEFT JOIN knihy ON student.ID = knihy.ID_studenta WHERE knihy.ID IS NULL;

SELECT ucitel.ID AS "ID učitele", ucitel.jmeno AS "Jméno učitele", ucitel.prijmeni AS "Příjmení učitele", uci.predmet AS "Předmět", COUNT(uci.ID_studenta) AS "Počet studentů" FROM ucitel JOIN uci ON ucitel.ID = uci.ID_ucitele JOIN student ON uci.ID_studenta = student.ID WHERE student.jmeno != 'Petr' GROUP BY ucitel.ID, ucitel.jmeno, ucitel.prijmeni, uci.predmet HAVING COUNT(uci.ID_studenta) > 1;

Select ucitel.jmeno,ucitel.prijmeni, uci.id_studenta, count(*) as "Pocet vyucovanych predmetu"
From ucitel, uci
Left join knihy on uci.Id_studenta knihy.ID_studenta where ucitel.ID, and knihy.ID IS NULL
Group by ucitel.id, uci.id_studenta
