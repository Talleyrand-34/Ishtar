CREATE DATABASE Seidor
  WITH
  OWNER = anonymous_not_seidor_user
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

