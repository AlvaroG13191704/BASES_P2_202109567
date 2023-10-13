

-- charge ciclos
INSERT INTO CICLO(nombre) VALUES('1S');
INSERT INTO CICLO(nombre) VALUES('2S');
INSERT INTO CICLO(nombre) VALUES('VJ');
INSERT INTO CICLO(nombre) VALUES('VD');

SELECT * FROM CICLO;

-- crearCarrera
CALL crearCarrera('Área Común');
CALL crearCarrera('Ingenieria en Ciencias y Sistemas');
CALL crearCarrera('Ingenieria Mecánica Industrial');
CALL crearCarrera('Ingenieria Industrial');
CALL crearCarrera('Ingenieria Química');

SELECT * FROM CARRERA;

-- registrarEstudiante								
CALL registrarEstudiante(202109567,'Alvaro Norberto','García Meza','2003-02-01','ga1318garcia@gmail.com',40584065,'Zona 2 de Bocal del Monte',3046971840116,1);
CALL registrarEstudiante(202110568,'Damián Ignacio','Peña Afre','2003-03-22','floppagato@gmail.com',22322212,'Cenma Villa Nueva',3046201440136,1);
CALL registrarEstudiante(202112145,'Daniel Estuardo','Cuque Ruíz','2003-10-08','cuquedaniel@gmail.com',23024843,'Carretera El Salvador',3046201440136,1);
CALL registrarEstudiante(202100239,'Aída Alejandra','Mansilla Orantes','2003-11-19','alejamolleja@gmail.com',94830221,'Ciudad Vieja, Antigua Guatemala',3046201440126,1);
CALL registrarEstudiante(202110897,'Lesther Kevin','López Miculax','2000-03-20','lestherlo@gmail.com',83293848,'Zona 11, Ciudad de Guatemala',3046201440166,1);
CALL registrarEstudiante(201901803,'Benjamin Alexander','Torcelli Barrios','1999-05-22','benjatorre@gmail.com',23893821,'Zona 2, Ciudad de Guatemala',3046201440129,1);
CALL registrarEstudiante(202000549,'Luis Daniel','Salán Letona','2001-08-11','luisdaniel@gmail.com',38394019,'Zona 4, Quiche',3046214401309,1);
CALL registrarEstudiante(202113553,'Kevin Ernesto','García Hernandez','2003-10-26','kevinbarca@gmail.com',92038203,'Ciudad de Mixco',3046201440126,1);
CALL registrarEstudiante(201900462,'Xhunik Nikol','Miguel Mutzutz','2002-06-19','khunikgod@gmail.com',29384948,'Zona 5, Petén',3046201440135,1);
CALL registrarEstudiante(202309421,'Julissa del Rosario','Reyes Cifuentes','2004-01-28','julss@gmail.com',29381912,'Zona 5, Ciudad de Guatemala',3046201440132,1);

SELECT * FROM ESTUDIANTE;

-- registrarDocente
CALL registrarDocente('Glenda Patricia','García Soria','1977-02-17','glenda@gmail.com',40501232,'Villa canales',3560878890101,200200001);
CALL registrarDocente('Kevin Adiel','Lajpop Ajpacaja','1972-03-13','kevinadiel@gmail.com',29823892,'Escuintla',3589135240101,200200002);
CALL registrarDocente('Byron Armando','Cuyan Culajay','1979-05-15','cuyanByron@gmail.com',98394828,'Antigua Guatemala',3011268180801,200200003);
CALL registrarDocente('Luis Fernando','Espino Barrios','1977-02-01','espino@gmail.com',93829304,'Ciudad Vieja',3011568180801,200200004);
CALL registrarDocente('Sergio Leonel','Gomez Bravo','1975-12-29','chocomax@gmail.com',40592039,'Zona 1, Ciudad de Guatemala',3014568180801,200200005);

SELECT * FROM DOCENTE;

-- crearCurso
CALL crearCurso(0107,'Matemática Intermedia 1',33,9,1,0);
CALL crearCurso(0150,'Física 1',33,5,1,0);
CALL crearCurso(0039,'Deportes 1',0,2,0,0);
CALL crearCurso(0152,'Física 2',60,6,1,0);
CALL crearCurso(0009,'Idioma Técnico 4',4,3,0,0);
CALL crearCurso(0960,'Matemática Computación 1',33,5,1,1);
CALL crearCurso(0795,'Lógica de Sistemas',33,3,1,1);
CALL crearCurso(0772,'Estructura de datos',90,6,1,1);
CALL crearCurso(0777,'Compiladores 1',90,6,1,1);

SELECT * FROM CURSO;

-- habilitarCurso
CALL habilitarCurso(0107, '1S', 200200001, 100, 'A');

SELECT * FROM CURSO_HABILITADO;

-- agregarHorario
CALL agregarHorario(1, 2, '9:00-10:40');

SELECT * FROM HORARIO;
SELECT * FROM DETALLE_CURSO_HABILITADO;