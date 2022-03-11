CREATE DATABASE Ejercicio_1;
USE Ejercicio_1;

CREATE TABLE Alumno(
    numero_de_cuenta VARCHAR(11) PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR (50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
);

INSERT INTO Alumno VALUES('20201004513','Bob Esponja','32202020','12-01-1980');
INSERT INTO Alumno VALUES('20191004569','Pedro Picapiedras','98762022','12-01-2000');
SELECT * FROM Alumno;

CREATE TABLE Docente(
    id_docente VARCHAR(11) PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR (50) NOT NULL,
    
);
INSERT INTO Docente VALUES('20011004612','Rick Sanchez','95202020');
INSERT INTO Docente VALUES('20021004612','Kerlyn Avalo','99889988');
SELECT *FROM Docente;

CREATE TABLE Asignatura(
    codigo_asignatura VARCHAR (20) PRIMARY KEY NOT NULL,
    nombre VARCHAR (100) NOT NULL,
    unidades_valorativas VARCHAR (10),
    id_docente VARCHAR(11) FOREIGN KEY REFERENCES Docente,
    numero_de_cuenta VARCHAR (11) FOREIGN KEY REFERENCES Alumno

);

INSERT INTO Asignatura VALUES ('is-501','BASE DE DATOS 1','5','20011004612','20201004513');
INSERT INTO Asignatura VALUES ('MM-110','MATEMATICAS 1','5','20021004612','20191004569');
SELECT * FROM Asignatura;



