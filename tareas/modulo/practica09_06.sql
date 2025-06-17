CREATE DATABASE IF NOT EXISTS compras;
USE compras;

CREATE TABLE Clientes (
  ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Correo VARCHAR(100),
  Edad INT
);

CREATE TABLE Categorias (
  ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Productos (
  ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(150) NOT NULL,
  Precio DECIMAL(10,2) NOT NULL,
  ID_Categoria INT,
  FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria)
);

CREATE TABLE Ordenes (
  ID_Orden INT AUTO_INCREMENT PRIMARY KEY,
  ID_Cliente INT,
  Fecha_Compra DATETIME,
  FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);
INSERT INTO Ordenes (ID_Cliente, Fecha_Compra) VALUES
 (1,'1984-03-15 12:25:12'),
 (2,'1985-03-15 12:25:12'),
 (3,'1986-03-15 12:25:12'),
 (4,'1987-03-15 12:25:12'),
 (5,'1988-03-15 12:25:12');
CREATE TABLE Detalle_Ordenes (

  ID_DetalleOrdenes INT AUTO_INCREMENT PRIMARY KEY,
  ID_Producto INT NOT NULL,
  ID_Orden INT NOT NULL,
  Cantidad INT,
  Total DECIMAL(10,2),
  FOREIGN KEY (ID_Orden) REFERENCES Ordenes(ID_Orden),
  FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

INSERT INTO Clientes (Nombre, Apellido, Correo, Edad) VALUES
  ('Adaberto', 'Reinosa', 'Adabertoreinosa28@gmail.com', 28),
  ('Gilberta', 'Jocosa', 'Gilbertonajoocosa288@gmail.com', 28),
  ('Lucia', 'Estrados', 'luciaestrasados22@gmail.com', 22),
  ('Estefany', 'Gallegos', 'estanygallegos27@gmail.com', 27),
  ('Maria', 'Barahona', 'mariabarahona19@gmail.com', 19);

INSERT INTO Categorias (Nombre) VALUES 
  ('romance'),
  ('accion'),
  ('terror'),
  ('comedia'),
  ('ciencia ficcion');

INSERT INTO Productos (Nombre, ID_Categoria, Precio) VALUES
  ('Destornilladores', 1, 5.50),
  ('Organizador Estanteria Cocina', 3, 27.00),
  ('Lampara De Jardin', 2, 32.50),
  ('Tubo PVC 4 Inch', 4, 7.40),
  ('Lijador', 5, 55.00);
SELECT P.Nombre, C.Nombre AS Categoria, P.Precio
FROM Productos P
INNER JOIN Categorias C ON P.ID_Categoria = C.ID_Categoria;

INSERT INTO Detalle_Ordenes (ID_Producto, Cantidad, Total, ID_Orden) VALUES
 (6,10,25,3),
 (7,10,25,3),
 (8,10,25,3),
 (9,10,25,3),
 (10,10,25,3);
 SELECT * FROM Detalle_Ordenes;
 SELECT * FROM Ordenes;





