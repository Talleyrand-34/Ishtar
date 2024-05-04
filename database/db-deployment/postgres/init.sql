-- Crear tabla pedido

-- CREATE TABLE products (
--     id INTEGER,
--     name VARCHAR(255),
--     ean VARCHAR(13),
--     Constraint "products_pkey" Primary Key ("id")
-- );

-- COPY products FROM '/data/products.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE pedido (
    pedido_id SERIAL PRIMARY KEY,
    pedido_finalizado BOOLEAN,
    pedido_user INT REFERENCES usuario(user_id)
);

-- Generar datos aleatorios
INSERT INTO pedido (pedido_finalizado, pedido_user)
SELECT
    CASE WHEN random() > 0.5 THEN TRUE ELSE FALSE END AS pedido_finalizado,
    FLOOR(random() * 100) + 1 AS pedido_user
FROM
    generate_series(1, 35) AS nums(num);


-----------------------------------------------------------------------
-- Crear tabla inventario
CREATE TABLE inventario (
    inventario_id SERIAL PRIMARY KEY,
    inventario_name VARCHAR(255),
    inventario_ean VARCHAR(13),
    inventario_quantity INTEGER,
    inventario_localization VARCHAR(50)
);

-- Generar datos aleatorios
INSERT INTO inventario (inventario_name, inventario_ean, inventario_quantity, inventario_localization)
SELECT
    CONCAT('Producto', num) AS inventario_name,
    LPAD(FLOOR(RANDOM() * 999999999999)::VARCHAR, 13, '0') AS inventario_ean,
    FLOOR(RANDOM() * 1000)::INTEGER AS inventario_quantity,
    CONCAT('Localizacion', FLOOR(RANDOM() * 100)) AS inventario_localization
FROM
    generate_series(1, 35) AS nums(num);

-----------------------------------------------------------------------------------

-- Crear tabla componentes
CREATE TABLE componentes (
    componentes_id SERIAL PRIMARY KEY,
    componentes_pedido_id INT REFERENCES pedido(pedido_id),
    componentes_producto_id INT REFERENCES inventario(inventario_id),
    componentes_quantity INT
);

-- Generar datos aleatorios
INSERT INTO componentes (componentes_pedido_id, componentes_producto_id, componentes_quantity)
SELECT
    (SELECT pedido_id FROM pedido ORDER BY RANDOM() LIMIT 1) AS componentes_pedido_id,
    (SELECT inventario_id FROM inventario ORDER BY RANDOM() LIMIT 1) AS componentes_producto_id,
    FLOOR(RANDOM() * 100) AS componentes_quantity
FROM
    generate_series(1, 35) AS nums(num);

-----------------------------------------------------------------------------------
-- Crear tabla usuario
CREATE TABLE usuario (
    user_id SERIAL PRIMARY KEY,
    username_name VARCHAR(255)
);

-- Generar datos aleatorios
INSERT INTO usuario (username_name)
SELECT
    'Usuario' || num
FROM
    generate_series(1, 35) AS nums(num);

