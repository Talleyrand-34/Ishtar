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
