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