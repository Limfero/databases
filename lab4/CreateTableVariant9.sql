USE Variant9

CREATE TABLE book(
	id_book INT IDENTITY(1, 1) CONSTRAINT PK_book PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	release_date DATE NOT NULL,
	page_num INT NOT NULL
)

CREATE TABLE author(
	id_author INT IDENTITY(1, 1) CONSTRAINT PK_autor PRIMARY KEY,
	first_name NVARCHAR(50) NOT NULL,
	last_name NVARCHAR(100) NOT NULL,
	date_of_birth DATE NOT NULL 
)

CREATE TABLE author_has_book(
	id_book INT CONSTRAINT FK_book_author REFERENCES book(id_book),
	id_author INT CONSTRAINT FK_author REFERENCES author(id_author) 
	PRIMARY KEY(id_book, id_author)
)

CREATE TABLE publisher(
	id_publisher INT IDENTITY(1, 1) CONSTRAINT PK_publisher PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	founding_date DATE NOT NULL,
	adress NVARCHAR(100) NOT NULL
)

CREATE TABLE publisher_has_book(
	id_book INT CONSTRAINT FK_book_publisher REFERENCES book(id_book),
	id_publisher INT CONSTRAINT FK_publisher_book REFERENCES publisher(id_publisher) 
	PRIMARY KEY(id_book, id_publisher)
)

CREATE TABLE copy(
	id_copy INT IDENTITY(1, 1) CONSTRAINT PK_copy PRIMARY KEY,
	id_book INT CONSTRAINT FK_book REFERENCES book(id_book),
	id_publisher INT CONSTRAINT FK_publisher_copy REFERENCES publisher(id_publisher),
	release_date DATE NOT NULL
)

CREATE TABLE shop(
	id_shop INT IDENTITY(1, 1) CONSTRAINT PK_shop PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	adress NVARCHAR(100) NOT NULL,
	phone_number NVARCHAR(10) NOT NULL
)

CREATE TABLE copy_in_shop(
	id_copy INT CONSTRAINT FK_copy_shop REFERENCES copy(id_copy),
	id_shop INT CONSTRAINT FK_shop REFERENCES shop(id_shop) 
	PRIMARY KEY(id_copy, id_shop)
)