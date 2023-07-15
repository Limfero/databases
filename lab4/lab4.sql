USE Variant9

/* INSERT без указания списка полей */
INSERT INTO book 
VALUES 
	('Отцы и дети', '1862' , 288),
	('Война и мир', '1867', 960),
	('Муму', '1856', 224);

/* INSERT c указания списка полей */
INSERT INTO author 
	(first_name, last_name, date_of_birth)
VALUES 
	('Иван', 'Тургенев', '1818-11-09'),
	('Лев', 'Толстой','1828-09-09');

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

/* INSERT с чтением значения из другой таблицы */
INSERT INTO copy 
	(release_date) 
SELECT release_date FROM book;

/* DELETE всех записей */
DELETE book;

/* DELETE по условию */
DELETE FROM book WHERE name = 'Война и мир';

/* UPDATE всех записей */
UPDATE author
SET first_name = 'Антон'

/* UPDATE по условию обновляя один атрибут */
UPDATE author
SET first_name = 'Лев' WHERE id_author = 2

/* UPDATE по условию обновляя несколько атрибутов */
UPDATE author
SET first_name = 'Александр', last_name = 'Пушкин', date_of_birth = '1799-06-06'  WHERE id_author = 1

/* SELECT c набором извлекаемых атрибутов */
SELECT first_name FROM author

/* SELECT co всему атрибутами */
SELECT * FROM author

/* SELECT c условием по атрибуту*/
SELECT * FROM author WHERE first_name = 'Лев'

/* SELECT ORDER BY + TOP (LIMIT) c сортировкой по возрастанию ASC + ограничение вывода количества записей */
SELECT TOP(2) * FROM author ORDER BY first_name ASC

/* SELECT ORDER BY + TOP (LIMIT) c сортировкой по убыванию DESC */
SELECT * FROM author ORDER BY first_name DESC

/* SELECT ORDER BY + TOP (LIMIT) c сортировкой по двум атрибутам + ограничение вывода количества записей */
SELECT TOP(2) * FROM author ORDER BY last_name, date_of_birth ASC

/* SELECT ORDER BY + TOP (LIMIT) c сортировкой по первому атрибуту, из списка извлекаемых */
SELECT * FROM author ORDER BY 1 ASC

/* WHERE по дате */
SELECT * FROM author WHERE date_of_birth = '1799-06-06'

/* WHERE дата в диапазоне */
SELECT * FROM author WHERE date_of_birth BETWEEN '1818' AND '1829'

/* Извлечь из таблицы не всю дату, а только год */
SELECT YEAR(date_of_birth) FROM author

/* Посчитать количество записей в таблице */
SELECT COUNT(*) FROM author

/* Посчитать количество уникальных записей в таблице */
INSERT INTO author 
	(first_name, last_name, date_of_birth)
VALUES 
	('Иван', 'Тургенев', '1818-11-09')

SELECT COUNT(DISTINCT first_name) FROM author

/* Вывести уникальные значения столбца */
SELECT DISTINCT first_name FROM author

/* Найти максимальное значение столбца */
SELECT MAX(date_of_birth) FROM author

/* Найти минимальное значение столбца */
SELECT MIN(date_of_birth) FROM author

/* Написать запрос COUNT() + GROUP BY */
SELECT first_name, COUNT(first_name) FROM author
GROUP BY first_name

/* GROUP BY + HAVING */
--не нужен групбай
/* Есть ли в 1862 или 1867 году более 800 страниц в сумме */
SELECT YEAR(release_date) AS year_release, SUM(page_num) AS page_num FROM book
WHERE release_date IN ('1862', '1867')
GROUP BY release_date
HAVING SUM(page_num) > 800

/* Запрос колличества авторов по годам рождения, которые родились после 1800 года */
SELECT YEAR(date_of_birth) AS year_birth, COUNT(YEAR(date_of_birth)) AS count_author FROM author
GROUP BY date_of_birth
HAVING YEAR(date_of_birth) > '1800'

/* Запрос колличества копий книг после 1962 года */
SELECT release_date, COUNT(id_copy) FROM copy
GROUP BY release_date
HAVING YEAR(release_date) > '1962'

/* LEFT JOIN двух таблиц и WHERE по одному из атрибутов */
SELECT first_name, last_name, id_book FROM author
LEFT JOIN author_has_book ON author.id_author = author_has_book.id_author
WHERE first_name = 'Иван'

/* RIGHT JOIN */
SELECT first_name, last_name, id_book FROM author
RIGHT JOIN author_has_book ON author.id_author = author_has_book.id_author
WHERE first_name = 'Иван'

/* LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы */
SELECT book.name AS book_name, publisher.name AS publisher_name, copy.release_date FROM book
LEFT JOIN copy ON copy.id_book = book.id_book
LEFT JOIN publisher ON copy.id_publisher = publisher.id_publisher
WHERE publisher.name = 'A' AND  book.name = 'Муму' AND YEAR(copy.release_date) = '1901' 

/* INNER JOIN двух таблиц */
SELECT * FROM book
INNER JOIN author_has_book ON author_has_book.id_book = book.id_book

/* Написать запрос с условием WHERE IN (подзапрос) */ 
SELECT * FROM author
WHERE id_author IN (
	SELECT id_author FROM author_has_book
)

/* Написать запрос SELECT atr1, atr2, (подзапрос) FROM .. */
SELECT name, YEAR(book.release_date) AS release_book, 
	(SELECT TOP(1) YEAR(release_date) FROM copy WHERE book.id_book = copy.id_book) AS release_copy
FROM book

/* Написать запрос вида SELECT * FROM (подзапрос) */
SELECT * FROM (SELECT * FROM copy) AS book

/* Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON */
SELECT * FROM author
JOIN (SELECT id_author FROM author_has_book) AS book ON book.id_author = author.id_author
