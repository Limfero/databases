CREATE DATABASE Variant6
USE Variant6

CREATE TABLE restaurant(
	id_restaurant INT IDENTITY(1, 1) CONSTRAINT PK_restaurant PRIMARY KEY, 
	adress NVARCHAR(100) NOT NULL,
	phone_number NVARCHAR(10) NOT NULL,
	name NVARCHAR(100) NOT NULL 
)

CREATE TABLE recipe(
	id_recipe INT IDENTITY(1, 1) CONSTRAINT PK_recipe PRIMARY KEY, 
	name NVARCHAR(100) NOT NULL,
	cooking_time TIME NOT NULL,
	calories SMALLINT NOT NULL
)

CREATE TABLE menu(
	id_menu INT IDENTITY(1, 1) CONSTRAINT PK_menu PRIMARY KEY, 
	name NVARCHAR(100) NOT NULL,
	approval_date DATE NOT NULL,
	id_restaurant INT CONSTRAINT FK_restaurant_menu REFERENCES restaurant(id_restaurant)
)

CREATE TABLE product(
	id_product INT IDENTITY(1, 1) CONSTRAINT PK_product PRIMARY KEY, 
	name NVARCHAR(100) NOT NULL,
	packing_date DATETIME NOT NULL,
	shelf_life DATETIME NOT NULL
)

CREATE TABLE product_in_recipe(
	id_product INT CONSTRAINT FK_product REFERENCES product(id_product),
	id_recipe INT CONSTRAINT FK_recipe REFERENCES recipe(id_recipe) 
	PRIMARY KEY(id_product, id_recipe)
)

CREATE TABLE dish(
	id_dish INT IDENTITY(1, 1) CONSTRAINT PK_dish PRIMARY KEY, 
	cost DECIMAL NOT NULL,
	weight INT NOT NULL,
	id_recipe INT CONSTRAINT FK_recipe_for_dish REFERENCES recipe(id_recipe)
)

CREATE TABLE dish_in_menu(
	id_dish INT CONSTRAINT FK_dish REFERENCES dish(id_dish),
	id_menu INT CONSTRAINT FK_menu REFERENCES menu(id_menu) 
	PRIMARY KEY(id_dish, id_menu)
)
