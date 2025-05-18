--Esto esta basado en el modelo ER que hice en la primera practica, pero despues 
--de analizarlo hice mejorar que estan en "la_nueva_lecturav2"
--para conveniencia, favor evaluar la que sea mejor
CREATE DATABASE IF NOT EXISTS la_nueva_lectura;
USE la_nueva_lectura;

--Ni tenia espacio para workbench asi que lo hice d1 con .sql en mi poderoso nvim cualquier cosa
--le hecho la culpa a los 20 de fmln y 10 de arena
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Correo VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20)
);

CREATE TABLE Compra (
    ID_Compra INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    ID_Cliente INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Libro (
    ISBN VARCHAR(20) PRIMARY KEY,
    Autor VARCHAR(255) NOT NULL,
    Genero VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Editorial VARCHAR(100) NOT NULL,
    Cantidad_Stock INT NOT NULL CHECK (Cantidad_Stock >= 0)
);

CREATE TABLE Detalle_Compra (
    ID_Detalle INT AUTO_INCREMENT PRIMARY KEY,
    ID_Compra INT NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (ID_Compra) REFERENCES Compra(ID_Compra),
    FOREIGN KEY (ISBN) REFERENCES Libro(ISBN)
);
--if you are reading this pls read the footer of this file you might find something funny
CREATE TABLE Categoria (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Libro_Categoria (
    ISBN VARCHAR(20) NOT NULL,
    ID_Categoria INT NOT NULL,
    PRIMARY KEY (ISBN, ID_Categoria),
    FOREIGN KEY (ISBN) REFERENCES Libro(ISBN),
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
);
--agradecimientos especiales a freecodecamp.com por su tutorial de sql y  el presidente de la republica de nejapa (Jonathan) por su frase iconica "se ajusta"
