
CREATE DATABASE IF NOT EXISTS la_nueva_lectura;
USE la_nueva_lectura;

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE editoriales (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE generos (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL UNIQUE,
    id_autor INT NOT NULL,
    id_genero INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_editorial INT NOT NULL,
    cantidad_stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
);

CREATE TABLE libro_categoria (
    id_libro INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_libro, id_categoria),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(50)
);

CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_compra (
    id_compra INT NOT NULL,
    id_libro INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_compra, id_libro),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra) ON DELETE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
);

-- Agregar tabla usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    edad INT,
    direccion VARCHAR(255),
    telefono VARCHAR(50)
);

-- Agregar tabla prestamos
CREATE TABLE prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Insertar datos desde la imagen
INSERT INTO autores (id_autor, nombre) VALUES
(3, 'Jane'),
(4, 'Haruki');

-- NOTA: autores con id 1 y 2 también son necesarios
INSERT INTO autores (id_autor, nombre) VALUES
(1, 'Gabriel'),
(2, 'Desconocido');

INSERT INTO generos (id_genero, nombre) VALUES
(1, 'Novela romántica'),
(2, 'Ficción'),
(3, 'Novela');

INSERT INTO editoriales (id_editorial, nombre) VALUES
(1, 'Planeta'),
(2, 'Alfaguara'),
(3, 'Tusquets');

-- Insertar libros
INSERT INTO libros (id_libro, titulo, id_autor, id_genero, precio, id_editorial, cantidad_stock)
VALUES
(3, 'Orgullo y prejuicio', 2, 1, 15.99, 1, 10),
(4, 'Kafka en la orilla', 3, 2, 18.50, 2, 5),
(5, 'Crónica de una muerte anunciada', 1, 3, 12.75, 3, 8);

-- Insertar usuarios (5 registros inventados)
INSERT INTO usuarios (nombre, apellido, edad, direccion, telefono) VALUES
('Ana', 'Martínez', 25, 'Calle Luna #45', '7000-1234'),
('Luis', 'Ramírez', 30, 'Av. Sol 202', '7000-5678'),
('Carlos', 'Pérez', 19, 'Pasaje Estrella 101', '7000-9999'),
('Lucía', 'Gómez', 27, 'Col. Jardines', '7000-8888'),
('María', 'López', 22, 'Res. Arcos', '7000-7777');

-- Insertar prestamos (5 registros)
INSERT INTO prestamos (id_libro, fecha_prestamo, fecha_devolucion, id_usuario) VALUES
(3, '2025-05-01', '2025-05-15', 1),
(4, '2025-05-02', NULL, 2),
(5, '2025-05-03', '2025-05-10', 3),
(3, '2025-05-05', NULL, 4),
(4, '2025-05-06', '2025-05-20', 5);

-- CONSULTAS
-- 1. Lista de libros prestados con nombre del libro, autor, fechas y nombre del usuario
SELECT 
    libros.titulo,
    autores.nombre AS nombre_autor,
    prestamos.fecha_prestamo,
    prestamos.fecha_devolucion,
    CONCAT(usuarios.nombre, ' ', usuarios.apellido) AS nombre_usuario
FROM prestamos
JOIN libros ON prestamos.id_libro = libros.id_libro
JOIN autores ON libros.id_autor = autores.id_autor
JOIN usuarios ON prestamos.id_usuario = usuarios.id;

-- 2. Consultar los libros por el género "Novela"
SELECT 
    libros.titulo,
    generos.nombre AS genero
FROM libros
JOIN generos ON libros.id_genero = generos.id_genero
WHERE generos.nombre LIKE '%Novela%';

-- 3. Consultar libros ordenados por año de publicación (añade columna de año si quieres más precisión)
-- Vamos a suponer que añadimos una columna "anio_publicacion"
ALTER TABLE libros ADD COLUMN anio_publicacion INT;

UPDATE libros SET anio_publicacion = 1813 WHERE id_libro = 3;
UPDATE libros SET anio_publicacion = 2002 WHERE id_libro = 4;
UPDATE libros SET anio_publicacion = 1981 WHERE id_libro = 5;

SELECT titulo, anio_publicacion
FROM libros
ORDER BY anio_publicacion ASC;

-- 4. Consultar libros por autor (Group By con conteo)
SELECT 
    autores.nombre AS autor,
    COUNT(libros.id_libro) AS cantidad_libros
FROM libros
JOIN autores ON libros.id_autor = autores.id_autor
GROUP BY autores.nombre;
