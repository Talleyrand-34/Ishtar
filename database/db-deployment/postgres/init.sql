-------------------------------------- Crear tablas -----------------------------
CREATE TABLE products (
    id INTEGER,
    name VARCHAR(255),
    ean VARCHAR(13),
    Constraint "products_pkey" Primary Key ("id")
);

CREATE TABLE usuario (
    user_id SERIAL PRIMARY KEY,
    username_name VARCHAR(255)
);

CREATE TABLE pedido (
    pedido_id SERIAL PRIMARY KEY,
    pedido_finalizado BOOLEAN,
    pedido_user INT REFERENCES usuario(user_id)
);

CREATE TABLE inventario (
    inventario_id SERIAL PRIMARY KEY,
    inventario_name VARCHAR(255),
    inventario_ean VARCHAR(13),
    inventario_quantity INTEGER,
    inventario_localization VARCHAR(50)
);

CREATE TABLE componentes (
    componentes_id SERIAL PRIMARY KEY,
    componentes_pedido_id INT REFERENCES pedido(pedido_id),
    componentes_producto_id INT REFERENCES products(id),
    componentes_quantity INT
);



-------------------------------- insertar contenidos en las tablas --------------------------------------

INSERT INTO products (id, name, ean) VALUES
(1, 'Producto 1', '0123456789012'),
(2, 'Producto 2', '1234567890123'),
(3, 'Producto 3', '2345678901234'),
(4, 'Producto 4', '3456789012345'),
(5, 'Producto 5', '4567890123456'),
(6, 'Producto 6', '5678901234567'),
(7, 'Producto 7', '6789012345678'),
(8, 'Producto 8', '7890123456789'),
(9, 'Producto 9', '8901234567890'),
(10, 'Producto 10', '9012345678901'),
(11, 'Producto 11', '0123456789012'),
(12, 'Producto 12', '1234567890123'),
(13, 'Producto 13', '2345678901234'),
(14, 'Producto 14', '3456789012345'),
(15, 'Producto 15', '4567890123456'),
(16, 'Producto 16', '5678901234567'),
(17, 'Producto 17', '6789012345678'),
(18, 'Producto 18', '7890123456789'),
(19, 'Producto 19', '8901234567890'),
(20, 'Producto 20', '9012345678901'),
(21, 'Producto 21', '0123456789012'),
(22, 'Producto 22', '1234567890123'),
(23, 'Producto 23', '2345678901234'),
(24, 'Producto 24', '3456789012345'),
(25, 'Producto 25', '4567890123456'),
(26, 'Producto 26', '5678901234567'),
(27, 'Producto 27', '6789012345678'),
(28, 'Producto 28', '7890123456789'),
(29, 'Producto 29', '8901234567890'),
(30, 'Producto 30', '9012345678901'),
(31, 'Producto 31', '0123456789012'),
(32, 'Producto 32', '1234567890123'),
(33, 'Producto 33', '2345678901234'),
(34, 'Producto 34', '3456789012345'),
(35, 'Producto 35', '4567890123456');


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


INSERT INTO pedido (pedido_finalizado, pedido_user) VALUES
(TRUE, 101),
(FALSE, 102),
(TRUE, 103),
(FALSE, 104),
(TRUE, 105),
(FALSE, 106),
(TRUE, 107),
(FALSE, 108),
(TRUE, 109),
(FALSE, 110),
(TRUE, 111),
(FALSE, 112),
(TRUE, 113),
(FALSE, 114),
(TRUE, 115),
(FALSE, 116),
(TRUE, 117),
(FALSE, 118),
(TRUE, 119),
(FALSE, 120),
(TRUE, 121),
(FALSE, 122),
(TRUE, 123),
(FALSE, 124),
(TRUE, 125),
(FALSE, 126),
(TRUE, 127),
(FALSE, 128),
(TRUE, 129),
(FALSE, 130),
(TRUE, 131),
(FALSE, 132),
(TRUE, 133),
(FALSE, 134),
(TRUE, 135);


INSERT INTO inventario (inventario_name, inventario_ean, inventario_quantity, inventario_localization) VALUES
('Producto 1', '1234567890123', 10, 'Estante A1'),
('Producto 2', '2345678901234', 15, 'Estante B2'),
('Producto 3', '3456789012345', 20, 'Estante C3'),
('Producto 4', '4567890123456', 12, 'Estante D4'),
('Producto 5', '5678901234567', 8, 'Estante E5'),
('Producto 6', '6789012345678', 25, 'Estante F6'),
('Producto 7', '7890123456789', 18, 'Estante G7'),
('Producto 8', '8901234567890', 30, 'Estante H8'),
('Producto 9', '9012345678901', 22, 'Estante I9'),
('Producto 10', '0123456789012', 17, 'Estante J10'),
('Producto 11', '1234567890123', 14, 'Estante A11'),
('Producto 12', '2345678901234', 9, 'Estante B12'),
('Producto 13', '3456789012345', 28, 'Estante C13'),
('Producto 14', '4567890123456', 19, 'Estante D14'),
('Producto 15', '5678901234567', 13, 'Estante E15'),
('Producto 16', '6789012345678', 16, 'Estante F16'),
('Producto 17', '7890123456789', 21, 'Estante G17'),
('Producto 18', '8901234567890', 11, 'Estante H18'),
('Producto 19', '9012345678901', 7, 'Estante I19'),
('Producto 20', '0123456789012', 23, 'Estante J20'),
('Producto 21', '1234567890123', 29, 'Estante A21'),
('Producto 22', '2345678901234', 26, 'Estante B22'),
('Producto 23', '3456789012345', 24, 'Estante C23'),
('Producto 24', '4567890123456', 6, 'Estante D24'),
('Producto 25', '5678901234567', 31, 'Estante E25'),
('Producto 26', '6789012345678', 27, 'Estante F26'),
('Producto 27', '7890123456789', 5, 'Estante G27'),
('Producto 28', '8901234567890', 32, 'Estante H28'),
('Producto 29', '9012345678901', 4, 'Estante I29'),
('Producto 30', '0123456789012', 33, 'Estante J30'),
('Producto 31', '1234567890123', 3, 'Estante A31'),
('Producto 32', '2345678901234', 34, 'Estante B32'),
('Producto 33', '3456789012345', 2, 'Estante C33'),
('Producto 34', '4567890123456', 35, 'Estante D34'),
('Producto 35', '5678901234567', 1, 'Estante E35');


INSERT INTO componentes (componentes_pedido_id, componentes_producto_id, componentes_quantity) VALUES
(1, 101, 5),
(1, 102, 3),
(1, 103, 2),
(2, 104, 7),
(2, 105, 4),
(3, 106, 6),
(3, 107, 1),
(4, 108, 3),
(5, 109, 2),
(5, 110, 5),
(6, 111, 8),
(6, 112, 2),
(7, 113, 4),
(7, 114, 6),
(8, 115, 3),
(9, 116, 7),
(9, 117, 1),
(10, 118, 5),
(11, 119, 2),
(11, 120, 3),
(11, 121, 4),
(12, 122, 6),
(12, 123, 2),
(12, 124, 1),
(13, 125, 3),
(14, 126, 2),
(14, 127, 5),
(15, 128, 4),
(15, 129, 3),
(16, 130, 6),
(17, 131, 2),
(17, 132, 7),
(18, 133, 4),
(19, 134, 3),
(19, 135, 5);


