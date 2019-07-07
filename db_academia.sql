
-- create database db_academia;

USE db_academia;

DROP TABLE IF EXISTS talleres;

CREATE TABLE IF NOT EXISTS talleres(
pk INT AUTO_INCREMENT,
nombre VARCHAR(100),
detalle VARCHAR(500),
horas INT,
cupos INT,
PRIMARY KEY(pk));

INSERT INTO talleres (nombre, detalle, horas, cupos) VALUES('Base de datos', 'Base de datos', '40', '20');
INSERT INTO talleres (nombre, detalle, horas, cupos) VALUES('Java', 'Base de datos', '50', '20');
INSERT INTO talleres (nombre, detalle, horas, cupos) VALUES('Python', 'Base de datos', '30', '20');
INSERT INTO talleres (nombre, detalle, horas, cupos) VALUES('Django', 'Base de datos', '30', '20');
INSERT INTO talleres (nombre, detalle, horas, cupos) VALUES('CSS', 'Base de datos', '25', '20');
INSERT INTO talleres (nombre, detalle, horas, cupos) VALUES('Jquery', 'Base de datos', '35', '20');

SELECT * FROM talleres;

