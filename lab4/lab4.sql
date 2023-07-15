USE Variant9

/* INSERT ��� �������� ������ ����� */
INSERT INTO book 
VALUES 
	('���� � ����', '1862' , 288),
	('����� � ���', '1867', 960),
	('����', '1856', 224);

/* INSERT c �������� ������ ����� */
INSERT INTO author 
	(first_name, last_name, date_of_birth)
VALUES 
	('����', '��������', '1818-11-09'),
	('���', '�������','1828-09-09');

INSERT INTO publisher
	(adress, name, founding_date)
VALUES
	('A', 'A', '1900'),
	('B', 'B', '2000')

SELECT * FROM book
SELECT * FROM author
SELECT * FROM publisher

INSERT INTO copy
	(id_book, id_publisher, release_date)
VALUES
	(4, 2, '2009'),
	(4, 1, '1901'),
	(5, 1, '1911'),
	(6, 2, '2005')

/* INSERT � ������� �������� �� ������ ������� */
INSERT INTO copy 
	(release_date) 
SELECT release_date FROM book;

/* DELETE ���� ������� */
DELETE book;

/* DELETE �� ������� */
DELETE FROM book WHERE name = '����� � ���';

/* UPDATE ���� ������� */
UPDATE author
SET first_name = '�����'

/* UPDATE �� ������� �������� ���� ������� */
UPDATE author
SET first_name = '���' WHERE id_author = 2

/* UPDATE �� ������� �������� ��������� ��������� */
UPDATE author
SET first_name = '���������', last_name = '������', date_of_birth = '1799-06-06'  WHERE id_author = 1

/* SELECT c ������� ����������� ��������� */
SELECT first_name FROM author

/* SELECT co ����� ���������� */
SELECT * FROM author

/* SELECT c �������� �� ��������*/
SELECT * FROM author WHERE first_name = '���'

/* SELECT ORDER BY + TOP (LIMIT) c ����������� �� ����������� ASC + ����������� ������ ���������� ������� */
SELECT TOP(2) * FROM author ORDER BY first_name ASC

/* SELECT ORDER BY + TOP (LIMIT) c ����������� �� �������� DESC */
SELECT * FROM author ORDER BY first_name DESC

/* SELECT ORDER BY + TOP (LIMIT) c ����������� �� ���� ��������� + ����������� ������ ���������� ������� */
SELECT TOP(2) * FROM author ORDER BY last_name, date_of_birth ASC

/* SELECT ORDER BY + TOP (LIMIT) c ����������� �� ������� ��������, �� ������ ����������� */
SELECT * FROM author ORDER BY 1 ASC

/* WHERE �� ���� */
SELECT * FROM author WHERE date_of_birth = '1799-06-06'

/* WHERE ���� � ��������� */
SELECT * FROM author WHERE date_of_birth BETWEEN '1818' AND '1829'

/* ������� �� ������� �� ��� ����, � ������ ��� */
SELECT YEAR(date_of_birth) FROM author

/* ��������� ���������� ������� � ������� */
SELECT COUNT(*) FROM author

/* ��������� ���������� ���������� ������� � ������� */
INSERT INTO author 
	(first_name, last_name, date_of_birth)
VALUES 
	('����', '��������', '1818-11-09')

SELECT COUNT(DISTINCT first_name) FROM author

/* ������� ���������� �������� ������� */
SELECT DISTINCT first_name FROM author

/* ����� ������������ �������� ������� */
SELECT MAX(date_of_birth) FROM author

/* ����� ����������� �������� ������� */
SELECT MIN(date_of_birth) FROM author

/* �������� ������ COUNT() + GROUP BY */
SELECT first_name, COUNT(first_name) FROM author
GROUP BY first_name

/* GROUP BY + HAVING */
--�� ����� �������
/* ���� �� � 1862 ��� 1867 ���� ����� 800 ������� � ����� */
SELECT YEAR(release_date) AS year_release, SUM(page_num) AS page_num FROM book
WHERE release_date IN ('1862', '1867')
GROUP BY release_date
HAVING SUM(page_num) > 800

/* ������ ����������� ������� �� ����� ��������, ������� �������� ����� 1800 ���� */
SELECT YEAR(date_of_birth) AS year_birth, COUNT(YEAR(date_of_birth)) AS count_author FROM author
GROUP BY date_of_birth
HAVING YEAR(date_of_birth) > '1800'

/* ������ ����������� ����� ���� ����� 1962 ���� */
SELECT release_date, COUNT(id_copy) FROM copy
GROUP BY release_date
HAVING YEAR(release_date) > '1962'

/* LEFT JOIN ���� ������ � WHERE �� ������ �� ��������� */
SELECT first_name, last_name, id_book FROM author
LEFT JOIN author_has_book ON author.id_author = author_has_book.id_author
WHERE first_name = '����'

/* RIGHT JOIN */
SELECT first_name, last_name, id_book FROM author
RIGHT JOIN author_has_book ON author.id_author = author_has_book.id_author
WHERE first_name = '����'

/* LEFT JOIN ���� ������ + WHERE �� �������� �� ������ ������� */
SELECT book.name AS book_name, publisher.name AS publisher_name, copy.release_date FROM book
LEFT JOIN copy ON copy.id_book = book.id_book
LEFT JOIN publisher ON copy.id_publisher = publisher.id_publisher
WHERE publisher.name = 'A' AND  book.name = '����' AND YEAR(copy.release_date) = '1901' 

/* INNER JOIN ���� ������ */
SELECT * FROM book
INNER JOIN author_has_book ON author_has_book.id_book = book.id_book

/* �������� ������ � �������� WHERE IN (���������) */ 
SELECT * FROM author
WHERE id_author IN (
	SELECT id_author FROM author_has_book
)

/* �������� ������ SELECT atr1, atr2, (���������) FROM .. */
SELECT name, YEAR(book.release_date) AS release_book, 
	(SELECT TOP(1) YEAR(release_date) FROM copy WHERE book.id_book = copy.id_book) AS release_copy
FROM book

/* �������� ������ ���� SELECT * FROM (���������) */
SELECT * FROM (SELECT * FROM copy) AS book

/* �������� ������ ���� SELECT * FROM table JOIN (���������) ON */
SELECT * FROM author
JOIN (SELECT id_author FROM author_has_book) AS book ON book.id_author = author.id_author
