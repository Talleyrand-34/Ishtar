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
