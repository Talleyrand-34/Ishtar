-- Crear tabla pedido

CREATE TABLE products (
    id INTEGER,
    name VARCHAR(255),
    ean VARCHAR(13),
    Constraint "products_pkey" Primary Key ("id")
);

COPY products FROM '/data/products.csv' DELIMITER ';' CSV HEADER;

-- Crear tabla usuario
CREATE TABLE usuario (
    user_id SERIAL PRIMARY KEY,
    username_name VARCHAR(255)
);
CREATE TABLE pedido (
    pedido_id SERIAL PRIMARY KEY,
    pedido_finalizado BOOLEAN,
    pedido_user INT REFERENCES usuario(user_id)
);

-----------------------------------------------------------------------
-- Crear tabla inventario
CREATE TABLE inventario (
    inventario_id SERIAL PRIMARY KEY,
    inventario_name VARCHAR(255),
    inventario_ean VARCHAR(13),
    inventario_quantity INTEGER,
    inventario_localization VARCHAR(50)
);
-- Crear tabla componentes
CREATE TABLE componentes (
    componentes_id SERIAL PRIMARY KEY,
    componentes_pedido_id INT REFERENCES pedido(pedido_id),
    componentes_producto_id INT REFERENCES products(id),
    componentes_quantity INT
);

-- Create 20 users and insert them into the usuario table
INSERT INTO usuario (username_name) VALUES
('user1'),
('user2'),
('user3'),
('user4'),
('user5'),
('user6'),
('user7'),
('user8'),
('user9'),
('user10'),
('user11'),
('user12'),
('user13'),
('user14'),
('user15'),
('user16'),
('user17'),
('user18'),
('user19'),
('user20');

