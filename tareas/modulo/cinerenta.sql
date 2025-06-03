CREATE DATABASE IF NOT EXISTS cinerenta;
USE cinerenta;

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    correo VARCHAR(100),
    telefono VARCHAR(15)
);

CREATE TABLE Peliculas (
    id_pelicula INT PRIMARY KEY,
    titulo VARCHAR(100),
    genero VARCHAR(50),
    anio INT,
    disponibilidad BOOLEAN
);

CREATE TABLE Rentas (
    id_renta INT PRIMARY KEY,
    id_cliente INT,
    id_pelicula INT,
    fecha_renta DATE,
    fecha_devolucion DATE,
    estado VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_pelicula) REFERENCES Peliculas(id_pelicula)
);


INSERT INTO Clientes VALUES
(1, 'Carlos', 'Ramírez', 'carlosr@gmail.com', '70123456'),
(2, 'Ana', 'López', 'ana.lopez@yahoo.com', '71234567'),
(3, 'Luis', 'Martínez', 'lmartinez@hotmail.com', '72345678'),
(4, 'Sofía', 'González', 'sofiagz@gmail.com', '73456789'),
(5, 'Javier', 'Hernández', 'javier.hz@outlook.com', '74567890'),
(6, 'Lucía', 'Morales', 'lucia.mr@gmail.com', '75678901'),
(7, 'Diego', 'Castro', 'dcastro@gmail.com', '76789012'),
(8, 'Valeria', 'Pérez', 'valepz@yahoo.com', '77890123'),
(9, 'Ricardo', 'Mejía', 'rmejia@hotmail.com', '78901234'),
(10, 'Carmen', 'Flores', 'carmenfl@gmail.com', '79012345');

INSERT INTO Peliculas VALUES
(1, 'Matrix', 'Ciencia Ficción', 1999, true),
(2, 'Titanic', 'Romance', 1997, true),
(3, 'El Padrino', 'Drama', 1972, true),
(4, 'Avengers: Endgame', 'Acción', 2019, true),
(5, 'Coco', 'Animación', 2017, true),
(6, 'Parásito', 'Thriller', 2019, true),
(7, 'Joker', 'Drama', 2019, true),
(8, 'Toy Story', 'Animación', 1995, true),
(9, 'Gladiador', 'Acción', 2000, true),
(10, 'Interestelar', 'Ciencia Ficción', 2014, true),
(11, 'Frozen', 'Animación', 2013, true),
(12, 'Whiplash', 'Drama', 2014, true),
(13, 'John Wick', 'Acción', 2014, true),
(14, 'La La Land', 'Musical', 2016, true),
(15, 'Soul', 'Animación', 2020, true);

INSERT INTO Rentas VALUES
(1, 1, 1, '2025-05-01', '2025-05-03', 'Devuelto'),
(2, 2, 2, '2025-05-01', '2025-05-05', 'Devuelto'),
(3, 3, 3, '2025-05-02', '2025-05-04', 'Devuelto'),
(4, 4, 4, '2025-05-03', NULL, 'Pendiente'),
(5, 5, 5, '2025-05-03', NULL, 'Pendiente'),
(6, 6, 6, '2025-05-04', '2025-05-06', 'Devuelto'),
(7, 7, 7, '2025-05-05', '2025-05-07', 'Devuelto'),
(8, 8, 8, '2025-05-05', NULL, 'Pendiente'),
(9, 9, 9, '2025-05-06', '2025-05-07', 'Devuelto'),
(10, 10, 10, '2025-05-07', '2025-05-09', 'Devuelto'),
(11, 1, 11, '2025-05-08', '2025-05-10', 'Devuelto'),
(12, 2, 12, '2025-05-08', '2025-05-09', 'Devuelto'),
(13, 3, 13, '2025-05-09', NULL, 'Pendiente'),
(14, 4, 14, '2025-05-10', NULL, 'Pendiente'),
(15, 5, 15, '2025-05-10', NULL, 'Pendiente'),
(16, 6, 1, '2025-05-11', NULL, 'Pendiente'),
(17, 7, 2, '2025-05-11', NULL, 'Pendiente'),
(18, 8, 3, '2025-05-12', '2025-05-13', 'Devuelto'),
(19, 9, 4, '2025-05-12', '2025-05-14', 'Devuelto'),
(20, 10, 5, '2025-05-12', NULL, 'Pendiente'),
(21, 1, 6, '2025-05-13', NULL, 'Pendiente'),
(22, 2, 7, '2025-05-13', NULL, 'Pendiente'),
(23, 3, 8, '2025-05-14', NULL, 'Pendiente'),
(24, 4, 9, '2025-05-14', NULL, 'Pendiente'),
(25, 5, 10, '2025-05-15', NULL, 'Pendiente');


UPDATE Clientes SET telefono = '70111111' WHERE id_cliente = 1;
UPDATE Clientes SET correo = 'ana.new@gmail.com' WHERE id_cliente = 2;
UPDATE Clientes SET telefono = '72333333' WHERE id_cliente = 3;
UPDATE Clientes SET correo = 'sofiag.new@gmail.com' WHERE id_cliente = 4;
UPDATE Clientes SET telefono = '74500000' WHERE id_cliente = 5;

UPDATE Peliculas SET disponibilidad = false WHERE id_pelicula IN (4, 5, 10);

UPDATE Rentas SET estado = 'Devuelto', fecha_devolucion = '2025-05-16' WHERE id_renta IN (4, 5, 8, 13, 14, 15, 16, 17, 20, 21);


SELECT P.titulo
FROM Rentas R
JOIN Peliculas P ON R.id_pelicula = P.id_pelicula
WHERE R.id_cliente = 1;

SELECT titulo
FROM Peliculas
WHERE genero = 'Animación' AND disponibilidad = true;

SELECT C.nombre, C.apellido, COUNT(R.id_renta) AS total_rentas
FROM Clientes C
JOIN Rentas R ON C.id_cliente = R.id_cliente
GROUP BY C.id_cliente;

SELECT DISTINCT C.nombre, C.apellido
FROM Rentas R
JOIN Clientes C ON R.id_cliente = C.id_cliente
WHERE R.id_pelicula = 1;

