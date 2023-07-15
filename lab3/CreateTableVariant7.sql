CREATE DATABASE Variant7
USE Variant7

CREATE TABLE company(
	id_company INT IDENTITY(1, 1) CONSTRAINT PK_company PRIMARY KEY, 
	adress NVARCHAR(100) NOT NULL,
	phone_number NVARCHAR(10) NOT NULL,
	name NVARCHAR(100) NOT NULL 
)

CREATE TABLE type(
	id_type INT IDENTITY(1, 1) CONSTRAINT PK_type PRIMARY KEY, 
	name NVARCHAR(100) NOT NULL,
	description NVARCHAR(256) NOT NULL,
	type_electronics NVARCHAR(100) NOT NULL
)

CREATE TABLE phone(
	id_phone INT IDENTITY(1, 1) CONSTRAINT PK_phone PRIMARY KEY, 
	model NVARCHAR(100) NOT NULL,
	manufacturer NVARCHAR(100) NOT NULL,
	date_purchase DATE NOT NULL
)

CREATE TABLE service(
	id_service INT IDENTITY(1, 1) CONSTRAINT PK_service PRIMARY KEY, 
	cost INT NOT NULL,
	name NVARCHAR(100) NOT NULL,
	id_phone int constraint FK_repair_phone references phone(id_phone),
	id_type int constraint FK_repair_type references type(id_type)
)


CREATE TABLE company_has_service(
	id_service INT CONSTRAINT FK_product REFERENCES service(id_service),
	id_company INT CONSTRAINT FK_company REFERENCES company(id_company) 
	PRIMARY KEY(id_service, id_company)
)

CREATE TABLE buyer(
	id_buyer INT IDENTITY(1, 1) CONSTRAINT PK_buyer PRIMARY KEY,
	adress NVARCHAR(100) NOT NULL,
	first_name NVARCHAR(100) NOT NULL,
	last_name NVARCHAR(256) NOT NULL
)

CREATE TABLE payment(
	id_payment INT IDENTITY(1, 1) CONSTRAINT PK_payment PRIMARY KEY,
	data_paiment DATETIME NOT NULL,
	id_service INT CONSTRAINT FK_payment_service REFERENCES service(id_service),
	id_phone INT CONSTRAINT FK_payment_phone REFERENCES phone(id_phone),
	id_buyer INT CONSTRAINT FK_buyer_phone REFERENCES buyer(id_buyer)
)

