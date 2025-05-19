--hoy hice 205 libras en sentadilla a 6 repeticiones con pausa :D
CREATE DATABASE IF NOT EXISTS gestion_equipos;
USE gestion_equipos;

CREATE TABLE generos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    genero VARCHAR(50) NOT NULL
);

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(50) NOT NULL
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    cedula VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    genero_id INT,
    contra VARCHAR(255) NOT NULL,
    rol_id INT,
    correo VARCHAR(100),
    FOREIGN KEY (genero_id) REFERENCES generos(id),
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

CREATE TABLE discos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    disco_duro VARCHAR(100)
);

CREATE TABLE memorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(100),
    capacidad VARCHAR(50)
);

-- Tabla torres
CREATE TABLE torres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    n_bien VARCHAR(50),
    n_serie VARCHAR(50),
    marca VARCHAR(100),
    modelo VARCHAR(100),
    procesador VARCHAR(100),
    discoduro_id INT,
    memoria_id INT,
    FOREIGN KEY (discoduro_id) REFERENCES discos(id),
    FOREIGN KEY (memoria_id) REFERENCES memorias(id)
);

CREATE TABLE teclados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    n_bien VARCHAR(50),
    n_serie VARCHAR(50),
    marca VARCHAR(100),
    modelo VARCHAR(100)
);

-- Tabla ratones
CREATE TABLE ratones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    n_bien VARCHAR(50),
    n_serie VARCHAR(50),
    marca VARCHAR(100),
    modelo VARCHAR(100)
);

CREATE TABLE monitores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    n_bien VARCHAR(50),
    n_serie VARCHAR(50),
    tipo VARCHAR(50),
    marca VARCHAR(100),
    modelo VARCHAR(100)
);

-- Tabla otros
CREATE TABLE otros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dispositivo VARCHAR(50),
    n_bien VARCHAR(50),
    n_serie VARCHAR(50),
    marca VARCHAR(100),
    modelo VARCHAR(100)
);

CREATE TABLE estados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(50) NOT NULL
);

CREATE TABLE equipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estado_id INT,
    torre_id INT,
    monitor_id INT,
    teclado_id INT,
    raton_id INT,
    otro_id INT,
    FOREIGN KEY (estado_id) REFERENCES estados(id),
    FOREIGN KEY (torre_id) REFERENCES torres(id),
    FOREIGN KEY (monitor_id) REFERENCES monitores(id),
    FOREIGN KEY (teclado_id) REFERENCES teclados(id),
    FOREIGN KEY (raton_id) REFERENCES ratones(id),
    FOREIGN KEY (otro_id) REFERENCES otros(id)
);

CREATE TABLE tipos_act (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE actividades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    tipo_id INT,
    equipo_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tipo_id) REFERENCES tipos_act(id),
    FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

CREATE TABLE historial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    actividad_id INT,
    usuario_id INT,
    equipo_id INT,
    FOREIGN KEY (actividad_id) REFERENCES actividades(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

CREATE TABLE soporte_act (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    actividad_id INT,
    tipo_id INT,
    fecha DATE,
    localidad VARCHAR(100),
    atencion VARCHAR(100),
    descripcion TEXT,
    tiempo_solucion VARCHAR(50),
    solucion TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (actividad_id) REFERENCES actividades(id),
    FOREIGN KEY (tipo_id) REFERENCES tipos_act(id)
);

CREATE TABLE taller_act (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    actividad_id INT,
    tipo_id INT,
    fecha DATE,
    origen VARCHAR(100),
    localidad VARCHAR(100),
    proceso TEXT,
    descripcion TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (actividad_id) REFERENCES actividades(id),
    FOREIGN KEY (tipo_id) REFERENCES tipos_act(id)
);

CREATE TABLE feedback (
    id INT PRIMARY KEY,
    usuario_id INT,
    comentarios TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

