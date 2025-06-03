--I hope it works as it should
CREATE DATABASE IF NOT EXISTS la_nueva_lectura;
USE la_nueva_lectura;

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255),
    nacionalidad VARCHAR(255)
);

CREATE TABLE generos (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE editoriales (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anio_publicacion INT,
    id_autor INT NOT NULL,
    id_genero INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL DEFAULT 0,
    id_editorial INT NOT NULL,
    cantidad_stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial),
    UNIQUE (titulo)
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

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    edad INT,
    direccion VARCHAR(255),
    telefono VARCHAR(50)
);

CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO autores (id_autor, nombre, apellido, nacionalidad) VALUES
(1, 'Gabriel', 'García Márquez', 'Colombia'),
(2, 'Jane', 'Austen', 'Reino Unido'),
(3, 'Haruki', 'Murakami', 'Japón');

INSERT INTO generos (id_genero, nombre) VALUES
(1, 'Novela romántica'),
(2, 'Ficción'),
(3, 'Novela');

INSERT INTO editoriales (id_editorial, nombre) VALUES
(1, 'Editorial Clásicos'),
(2, 'Editorial Moderna'),
(3, 'Editorial Latinoamericana');

INSERT INTO libros (id_libro, titulo, anio_publicacion, id_autor, id_genero, precio, id_editorial, cantidad_stock) VALUES
(3, 'Orgullo y prejuicio', 1813, 2, 1, 25.99, 1, 10),
(4, 'Kafka en la orilla', 2002, 3, 2, 30.50, 2, 8),
(5, 'Crónica de una muerte anunciada', 1981, 1, 3, 22.75, 3, 12);

INSERT INTO categorias (nombre) VALUES
('Clásicos'), ('Contemporáneo'), ('Latinoamericano'), ('Premio Nobel'), ('Fantasía');

INSERT INTO libro_categoria (id_libro, id_categoria) VALUES
(3, 1), (4, 2), (5, 3);

INSERT INTO usuarios (nombre, apellido, edad, direccion, telefono) VALUES
('María', 'González', 28, 'Av. Principal 123, Ciudad', '+52-555-0123'),
('Carlos', 'Rodríguez', 35, 'Calle Secundaria 456, Pueblo', '+52-555-0124'),
('Ana', 'López', 22, 'Boulevard Norte 789, Metrópoli', '+52-555-0125'),
('José', 'Martínez', 41, 'Carrera 15 #32-45, Villa', '+52-555-0126'),
('Laura', 'Hernández', 29, 'Avenida Sur 321, Centro', '+52-555-0127');

INSERT INTO prestamos (id_libro, fecha_prestamo, fecha_devolucion, id_usuario) VALUES
(3, '2025-01-15', '2025-02-15', 1),
(4, '2025-02-01', '2025-03-01', 2),
(5, '2025-02-10', NULL, 3),
(3, '2025-03-01', '2025-04-01', 4),
(4, '2025-03-15', NULL, 5);

SELECT 
    l.titulo AS 'Nombre del Libro',
    CONCAT(a.nombre, ' ', a.apellido) AS 'Nombre del Autor',
    p.fecha_prestamo AS 'Fecha de Préstamo',
    p.fecha_devolucion AS 'Fecha de Devolución',
    CONCAT(u.nombre, ' ', u.apellido) AS 'Usuario'
FROM prestamos p
INNER JOIN libros l ON p.id_libro = l.id_libro
INNER JOIN autores a ON l.id_autor = a.id_autor
INNER JOIN usuarios u ON p.id_usuario = u.id_usuario;

SELECT 
    l.titulo,
    CONCAT(a.nombre, ' ', a.apellido) AS autor,
    l.anio_publicacion,
    l.precio
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id_autor
INNER JOIN generos g ON l.id_genero = g.id_genero
WHERE g.nombre = 'Novela';

SELECT 
    l.titulo,
    CONCAT(a.nombre, ' ', a.apellido) AS autor,
    l.anio_publicacion,
    g.nombre AS genero
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id_autor
INNER JOIN generos g ON l.id_genero = g.id_genero
ORDER BY l.anio_publicacion ASC;

SELECT 
    CONCAT(a.nombre, ' ', a.apellido) AS 'Autor',
    COUNT(l.id_libro) AS 'Cantidad de Libros',
    GROUP_CONCAT(l.titulo SEPARATOR ', ') AS 'Títulos'
FROM autores a
LEFT JOIN libros l ON a.id_autor = l.id_autor
GROUP BY a.id_autor, a.nombre, a.apellido
HAVING COUNT(l.id_libro) > 0;
