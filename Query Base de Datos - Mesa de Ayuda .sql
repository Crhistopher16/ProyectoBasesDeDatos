USE [GESTIONASOCEBU]

CREATE TABLE Area(
	idArea INT IDENTITY(1,1) NOT NULL,
	descrip VARCHAR(40) NOT NULL,
	correo VARCHAR(100) NULL,
	PRIMARY KEY (idArea)
 );
 
CREATE TABLE Calificacion(
	idCalificacion INT IDENTITY(1,1) NOT NULL,
	valoracion FLOAT NULL,
	comentarios VARCHAR(MAX) NULL,
	PRIMARY KEY (idCalificacion),
);

CREATE TABLE Tipo(
	idTipo INT IDENTITY(1,1) NOT NULL,
	tipo VARCHAR(50) NOT NULL,
	tiempo INT NOT NULL,
	idArea INT NOT NULL,
	PRIMARY KEY (idTipo),
	FOREIGN KEY (idArea) REFERENCES Area(idArea)
);

CREATE TABLE Descripcion(
	idDescripcion INT IDENTITY(1,1) NOT NULL,
	descripcion VARCHAR(200) NOT NULL,
	idTipo INT NOT NULL,
	PRIMARY KEY (idDescripcion),
	FOREIGN KEY (idTipo) REFERENCES Tipo(idTipo)
);

CREATE TABLE Estado(
	idEstado INT IDENTITY(1,1) NOT NULL,
	estado VARCHAR(20) NOT NULL,
	PRIMARY KEY(idEstado)
);

CREATE TABLE Ticket(
	idTicket INT IDENTITY(1,1) NOT NULL,
	idCalificacion INT NULL,
	idDescripcion INT NOT NULL,
	detalles VARCHAR(MAX) NOT NULL,
	idUsuarioSolicita VARCHAR(20) NOT NULL,
	fhInicio DATETIME NOT NULL,
	fhAsignacion DATETIME NULL,
	IdUsuarioAsignado VARCHAR(20) NULL,
	fhCierre DATETIME NULL,
	idEstado INT NULL,
	PRIMARY KEY (idTicket),
	FOREIGN KEY (idCalificacion) REFERENCES Calificacion(idCalificacion),
	FOREIGN KEY (idDescripcion) REFERENCES Descripcion(idDescripcion),
	FOREIGN KEY (idEstado) REFERENCES Estado(idEstado)
);

CREATE TABLE CuerpoTicket(
	idCuerpo INT IDENTITY(1,1) NOT NULL,
	idTicket INT NOT NULL,
	idUsuarioResponde VARCHAR(20) NOT NULL,
	fhRespuesta DATETIME NULL,
	detalles VARCHAR(MAX) NULL,
	PRIMARY KEY (idCuerpo),
	FOREIGN KEY (idTicket) REFERENCES Ticket(idTicket)
);

-- INSERTAR DATOS DE EJEMPLO EN LAS TABLAS --

INSERT INTO Area
    (correo, descrip)
VALUES
    ('sistemas@asocebu.com', 'SISTEMAS'),
	('registros@asocebu.com','REGISTROS'),
	('comunicaciones@asocebu.com','COMUNICACIONES'),
	('compras@asocebu.com','COMPRAS');

INSERT INTO Calificacion
    (comentarios, valoracion)
VALUES
    ('El Ingeniero de soporte brindó el servicio de manera oportuna y eficiente', '5'),
	('El problema era simple y se tardaron muchisimo','3'),
	('Eficiente y efectivo','4'),
	('El técnico no dio con la solución','1');

INSERT INTO Tipo
    (idArea, tiempo, tipo)
VALUES
    (1,4,'TECNICO'),
	(1,0,'TECNICO ESPECIAL'),
	(1,3,'ADMINISTRATIVO'),
	(1,15,'DESARROLLO'),
	(1,0,'DESARROLLO ESPECIAL');

INSERT INTO Descripcion
    (descripcion, idTipo)
VALUES
    ('Fallos en la linea telefonica',1),
	('Cambio de Equipo',2),
	('Creacion de Email',3),
	('Correcion de Formatos TE',4),
	('Creación de nueva funcionalidad en Plataforma SIR',5);

INSERT INTO Estado
    (estado)
VALUES
    ('Creado'),
	('Asignado'),
	('Solucionado'),
	('Devuelto'),
	('Cerrado');

INSERT INTO Ticket
    (idDescripcion, detalles, idUsuarioSolicita, fhInicio, idEstado)
VALUES
    (1,'Cuando llamo no me escuchan', 'PBC','2024-05-10 14:30:00',1),
	(2,'Necesito un equipo con 16GB de RAM y Tarjeta Gráfica', 'JHA','2024-05-11 15:38:00',1),
	(3,'Crear un Email para el nuevo cargo de "Auxiliar Contable"', 'JCS','2024-05-11 16:22:00',1);

INSERT INTO CuerpoTicket
    (idTicket, detalles, idUsuarioResponde, fhRespuesta)
VALUES
    (1,'Buenos días, noto que tiene asignadas dos extensiones (140 y 145), ¿Cual esta presentando la falla?','MMM','2024-05-11 10:30:00'),
	(1,'Buenos días, la extension es la 140','PCB','2024-05-11 10:40:00'),
	(1,'El telefono con extension "140" se deja funcionando correctamente','MMM','2024-05-11 11:45:00');

	

