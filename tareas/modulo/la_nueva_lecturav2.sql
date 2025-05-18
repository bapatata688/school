--version (segun yo) mejorada como fue dicho en el primer comentario de la versino 1,
--aca hice mas tablas separando entidades reutilizables, tambien evitando mas redundancias
--no queria solamente dejar un solo archivo ya que creia conveniente tener tanto la version que es fiel
--al diagrama ER y esta version mas optimizada
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
    titulo VARCHAR(255) NOT NULL,
    id_autor INT NOT NULL,
    id_genero INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_editorial INT NOT NULL,
    cantidad_stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial),
    UNIQUE (titulo)
);
--we miss you mister Anibal I hope you get better
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

--estoy aburrido, estoy aprendiendo dart para la creacion de aplicaciones moviles, ya lo ha ocupado?
CREATE TABLE detalle_compra (
    id_compra INT NOT NULL,
    id_libro INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_compra, id_libro),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra) ON DELETE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
);;
--bye
