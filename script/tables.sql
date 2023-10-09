-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS proyecto2;
USE proyecto2;

SHOW TABLES FROM proyecto2;

-- Create tables
-- CARRERA
CREATE TABLE IF NOT EXISTS CARRERA (
    id_carrera INTEGER AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL ,
    PRIMARY KEY (id_carrera)
);

-- ESTUDIANTE
CREATE TABLE IF NOT EXISTS ESTUDIANTE (
  carnet BIGINT NOT NULL,
  nombres VARCHAR(50) NOT NULL,
  apellidos VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  correo VARCHAR(50) NOT NULL,
  telefono INTEGER NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  dpi BIGINT NOT NULL,
  creditos INTEGER NOT NULL,
  registro_creacion DATE NOT NULL,
  id_carrera INTEGER NOT NULL,
  PRIMARY KEY (carnet),
  FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

-- DOCENTE
CREATE TABLE IF NOT EXISTS DOCENTE (
    id_docente INTEGER AUTO_INCREMENT NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono INTEGER NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    dpi BIGINT NOT NULL,
    registro_siif INTEGER NOT NULL,
    registro_creacion DATE NOT NULL ,
    PRIMARY KEY (id_docente)
);

-- CURSO
CREATE TABLE IF NOT EXISTS CURSO (
  id_curso INTEGER AUTO_INCREMENT NOT NULL,
  codigo INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  creditos_necesarios INTEGER NOT NULL,
  creditos_obligatorios INTEGER NOT NULL,
  id_carrera INTEGER NOT NULL,
  PRIMARY KEY (id_curso),
  FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

-- CICLO
CREATE TABLE IF NOT EXISTS CICLO (
  id_ciclo INTEGER AUTO_INCREMENT NOT NULL ,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_ciclo)
);
-- SECCION
CREATE TABLE IF NOT EXISTS SECCION (
  id_seccion INTEGER AUTO_INCREMENT NOT NULL,
  seccion CHAR,
  PRIMARY KEY (id_seccion)
);

-- CURSO HABILITADO
CREATE TABLE IF NOT EXISTS CURSO_HABILITADO (
  id_curso_habilitado INTEGER NOT NULL AUTO_INCREMENT,
  cupo_maximo INTEGER NOT NULL,
  id_curso INTEGER NOT NULL,
  id_docente INTEGER NOT NULL,
  id_ciclo INTEGER NOT NULL,
  id_seccion INTEGER NOT NULL,
  PRIMARY KEY (id_curso_habilitado),
  FOREIGN KEY (id_curso) REFERENCES CURSO(id_curso),
  FOREIGN KEY (id_docente) REFERENCES DOCENTE(id_docente),
  FOREIGN KEY (id_ciclo) REFERENCES CICLO(id_ciclo),
  FOREIGN KEY (id_seccion) REFERENCES SECCION(id_seccion)
);

-- ASIGNACION
CREATE TABLE IF NOT EXISTS ASIGNACION (
  id_asignacion INTEGER AUTO_INCREMENT NOT NULL,
  fecha_desasignacion DATE NOT NULL,
  id_curso_habilitado INTEGER NOT NULL,
  carnet BIGINT NOT NULL,
  PRIMARY KEY (id_asignacion),
  FOREIGN KEY (id_curso_habilitado) REFERENCES CURSO_HABILITADO(id_curso_habilitado),
  FOREIGN KEY (carnet) REFERENCES ESTUDIANTE(carnet)
);


-- HORARIO
CREATE TABLE IF NOT EXISTS HORARIO (
    id_horario INTEGER AUTO_INCREMENT NOT NULL,
    dia INTEGER NOT NULL,
    horario VARCHAR(30) NOT NULL,
    id_curso_habilitado INTEGER NOT NULL,
    PRIMARY KEY (id_horario),
    FOREIGN KEY (id_curso_habilitado) REFERENCES CURSO_HABILITADO(id_curso_habilitado)
);

-- DETALLE_CURSO_HABILITADO
CREATE TABLE IF NOT EXISTS DETALLE_CURSO_HABILITADO (
  id_horario INTEGER NOT NULL,
  id_curso_habilitado INTEGER NOT NULL,
  FOREIGN KEY (id_horario) REFERENCES HORARIO(id_horario),
  FOREIGN KEY (id_curso_habilitado) REFERENCES  CURSO_HABILITADO(id_curso_habilitado)
);



-- NOTA
CREATE TABLE IF NOT EXISTS NOTA (
    id_nota INTEGER AUTO_INCREMENT NOT NULL,
    nota INTEGER NOT NULL ,
    id_asignacion INTEGER NOT NULL,
    PRIMARY KEY (id_nota),
    FOREIGN KEY (id_asignacion) REFERENCES ASIGNACION(id_asignacion)
);

-- TRANSACCION
CREATE TABLE IF NOT EXISTS TRANSACCION(
    id_transaccion INTEGER AUTO_INCREMENT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    tipo VARCHAR(30),
    PRIMARY KEY (id_transaccion)
);
