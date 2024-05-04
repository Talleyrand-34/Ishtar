CREATE TABLE products (
    id INTEGER,
    name VARCHAR(255),
    ean VARCHAR(13),
    Constraint "products_pkey" Primary Key ("id")
);

COPY products FROM '/data/products.csv' DELIMITER ';' CSV HEADER;

