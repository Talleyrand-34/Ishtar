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