/*creacion de base de datos*/
CREATE DATABASE IF NOT EXISTS fundacionev;

USE fundacionev;

/*creacion de tablas entidades*/
CREATE TABLE empleados(
documento INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
fecha_nacimiento DATE,
estado_civil CHAR(20) DEFAULT NULL,
nacionalidad VARCHAR(30) DEFAULT "Argentina",
telefono VARCHAR(20) DEFAULT NULL,
email VARCHAR(100) DEFAULT NULL UNIQUE,
domicilio VARCHAR(100),
id_localidad INT NOT NULL,
id_provincia INT NOT NULL,
id_pais INT DEFAULT "1",
titulo VARCHAR(100) DEFAULT NULL
);

CREATE TABLE puestos_trabajo(
	id_puesto INT PRIMARY KEY AUTO_INCREMENT,
	puesto VARCHAR(30)
    );
CREATE TABLE localidades(
	codigo_postal INT PRIMARY KEY,
	localidad VARCHAR(50),
	provincia INT DEFAULT NULL,
    FOREIGN KEY (provincia) REFERENCES provincias(id_provincia)
    );
CREATE TABLE provincias(
	id_provincia INT PRIMARY KEY AUTO_INCREMENT,
	provincia VARCHAR(50),
	pais INT DEFAULT NULL,
    FOREIGN KEY (pais) REFERENCES paises(id_pais)
);
CREATE TABLE paises(
	id_pais INT PRIMARY KEY AUTO_INCREMENT,
	pais VARCHAR(50)
);
CREATE TABLE sectores(
	id_sector INT PRIMARY KEY AUTO_INCREMENT,
	sector VARCHAR(50),
	siglas VARCHAR(3)
);
CREATE TABLE legajos(
id_legajo INT PRIMARY KEY AUTO_INCREMENT,
documento INT NOT NULL,
puesto INT NOT NULL,
fecha_alta TIMESTAMP,
fecha_baja DATETIME,
causa_baja VARCHAR(1000),
antiguedad INT,
FOREIGN KEY (puesto) REFERENCES puestos_trabajo(id_puesto),
FOREIGN KEY (documento) REFERENCES empleados(documento)
);

/*algunos ajustes realizados posteriormente*/
/*ALTER TABLE fundacionev.empleados RENAME COLUMN email TO email_personal;
ALTER TABLE fundacionev.empleados RENAME COLUMN id_localidad TO localidad;
ALTER TABLE fundacionev.empleados RENAME COLUMN id_provincia TO provincia;
ALTER TABLE fundacionev.empleados RENAME COLUMN id_pais TO pais;
UPDATE empleados SET nacionalidad = "argentino" WHERE documento = 30765387;
ALTER TABLE empleados ADD CONSTRAINT FK_localidad FOREIGN KEY (localidad) REFERENCES localidades(codigo_postal);
ALTER TABLE empleados ADD CONSTRAINT FK_provincia FOREIGN KEY (provincia) REFERENCES provincias(id_provincia);
ALTER TABLE empleados ADD CONSTRAINT FK_pais FOREIGN KEY (pais) REFERENCES paises(id_pais);
UPDATE empleados SET provincia = 34;*/


SELECT * FROM provincias;


/*insercion de datos a las tablas*/
INSERT INTO empleados(documento, nombre, fecha_nacimiento, estado_civil, nacionalidad, telefono, email_personal, domicilio, localidad, provincia, pais, titulo)
VALUES
(30765387, "Gustavo Adolfo Valente", "1971-09-16", "casado", "", "+54 (380) 102-1436", "gustavo.valente@outlook.com", "Ruela Velásquez 405", 5300, 8, 1, "Contador Publico"),
(20593143, "Maria Cruz Vera", "1965-09-16", "casada", "argentino", "+54 (380) 698-0715", "maria_vera@yahoo.com.ar", "Av. Rivadavia 4590", 5300, 8, 1, "Licenciada en Administracion de Empresas"),
(22076040, "Bernardo Saavedra", "1971-06-14", "casado", "argentino", "+54 (380) 530-7084", "bernardo_saavedra@hotmail.com", "Calle Mendoza 812", 5300, 8, 1, "Licenciado en Recuros Humanos"),
(30074659, "Abril Cabanillas", "1982-04-07", "viuda", "uruguaya", "+54 (380) 387-6723", "abril-cabanillas@hotmail.com", "Calle Tucumán 1223", 5300, 8, 1, "Escribana"),
(18963626, "Francisco Javier Vazquez", "1960-09-12", "soltero", "argentino", "+54 (380) 022-6256", "francisco_vazquez@outlook.com", "Av. Belgrano Sur 3456", 5300, 8, 1, "Tecnico electricista"),
(32309480, "Maria Montivero", "1988-01-14", "casada", "argentino", "+54 (380) 433-8872", "meri.montivero@gmail.com", "Pasaje Sufan 1145", 5300, 8, 1, "Contadora Publica"),
(35580496, "Emilio Riveros", "1992-01-16", "soltero", "chileno", "+54 (380) 488-3901", "emiriveros@gmail.com", "Bulevar Sarmiento 2060", 5300, 8, 1, "Licenciado en Relaciones Publicas"),
(34947055, "Carmen Zapata", "1990-06-21", "soltera", "argentino", "+54 (380) 663-8145", "carmen_zapata@hotmail.com", "Calle Los Tilos 1433", 5300, 8, 1, "");

INSERT INTO puestos_trabajo(puesto)
VALUES ("Presidente"), ("Secretario"), ("Tesorero"), ("Analista Administrativo"), ("Analista Contable"), ("Auxiliar Tecnico"), ("Coordinador Legal"), ("Auxiliar Administrativo"), ("Coordinador General");

INSERT INTO paises(pais)
VALUES("Argentina"), ("Uruguay"), ("Chile"), ("Paraguay"), ("Brasil");

INSERT INTO provincias(pais, provincia)
VALUES(1, "Ciudad Autónoma de Buenos Aires"), (1, "Buenos Aires"), (1 , "Catamarca"), (1, "Córdoba"), (1 , "Corrientes"), (1 , "Entre Ríos"), (1 , "Jujuy"), (1 , "Mendoza"), (1 , "La Rioja"), (1 , "Salta"), (1 , "San Juan"), (1 , "San Luis"), (1 , "Santa Fe"), (1 , "Santiago del Estero"), (1 , "Tucumán"), (1 , "Chaco"), (1 , "Chubut"), (1 , "Formosa"), (1 , "Misiones"), (1 , "Neuquén"), (1 , "La Pampa"), (1 , "Río Negro"), (1 , "Santa Cruz"),(1 , "Tierra del Fuego");

INSERT INTO localidades(codigo_postal, localidad, provincia)
VALUES (5300, "La Rioja", 33), (5360, "Chilecito", 33), (5310, "Aimogasta", 33), (5365, "Famatina", 33), (5380, "Chamical", 33);



















/*VALUES(0, "Ciudad Autónoma de Buenos Aires"), (1, "Buenos Aires"), (2 , "Catamarca"), (3, "Córdoba"), (4 , "Corrientes"), (5 , "Entre Ríos"), (6 , "Jujuy"), (7 , "Mendoza"), (8 , "La Rioja"), (9 , "Salta"), (10 , "San Juan"), (11 , "San Luis"), (12 , "Santa Fe"), (13 , "Santiago del Estero"), (14 , "Tucumán"), (15 , "Chaco"), (16 , "Chubut"), (17 , "Formosa"), (18 , "Misiones"), (19 , "Neuquén"), (20 , "La Pampa"), (21 , "Río Negro"), (22 , "Santa Cruz"),(23 , "Tierra del Fuego");*/







