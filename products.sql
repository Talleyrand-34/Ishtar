-- path para ejecutar en psql: \i 'your_path\\your_path\\document.sql'
--\i 'C:\\Users\\LittleDragon\\hackUPC2024\\PostgreSQLPortable-10.1.1\\products.sql'

CREATE DATABASE Seidor
  WITH 
  OWNER = Seidor
  ENCODING = 'UTF8'
  LC_COLLATE = 'es_ES.UTF-8'
  LC_CTYPE = 'es_ES.UTF-8'
  TEMPLATE = template0;


CREATE TABLE products (
    id INTEGER,
	name VARCHAR(255),
	ean VARCHAR(13),
	Constraint "products_pkey" Primary Key ("id")
);

COPY products FROM 'C:\Users\LittleDragon\hackUPC2024\PostgreSQLPortable-10.1.1\products.csv' DELIMITER ';' CSV HEADER;
--COPY products FROM 'your_path\yourpath' DELIMITER ';' CSV HEADER;
