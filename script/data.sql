
-- charge ciclos
INSERT INTO CICLO(nombre) VALUES('1S');
INSERT INTO CICLO(nombre) VALUES('2S');
INSERT INTO CICLO(nombre) VALUES('VJ');
INSERT INTO CICLO(nombre) VALUES('VD');

SELECT * FROM CICLO;

-- crearCarrera
CALL crearCarrera('Área Común');
CALL crearCarrera('Ingenieria Civil');
CALL crearCarrera('Ingenieria Mecánica Industrial');
CALL crearCarrera('Ingenieria en Ciencias y Sistemas');
CALL crearCarrera('Ingenieria Mecánica');

SELECT * FROM CARRERA;

-- registrarEstudiante
CALL registrarEstudiante(202109567,'Alvaro Norberto','García Meza','2003-02-01','ga1318garcia@gmail.com',40584065,'Zona 2 de Bocal del Monte',3046971840116,1);
CALL registrarEstudiante(202110568,'Damián Ignacio','Peña Afre','2003-03-22','floppagato@gmail.com',22322212,'Cenma Villa Nueva',3046201440136,2);
CALL registrarEstudiante(202112145,'Daniel Estuardo','Cuque Ruíz','2003-10-08','cuquedaniel@gmail.com',23024843,'Carretera El Salvador',3046201440136,3);
CALL registrarEstudiante(202100239,'Aída Alejandra','Mansilla Orantes','2003-11-19','alejamolleja@gmail.com',94830221,'Ciudad Vieja, Antigua Guatemala',3046201440126,4);
CALL registrarEstudiante(202110897,'Lesther Kevin','López Miculax','2000-03-20','lestherlo@gmail.com',83293848,'Zona 11, Ciudad de Guatemala',3046201440166,1);
CALL registrarEstudiante(201901803,'Benjamin Alexander','Torcelli Barrios','1999-05-22','benjatorre@gmail.com',23893821,'Zona 2, Ciudad de Guatemala',3046201440129,3);
CALL registrarEstudiante(202000549,'Luis Daniel','Salán Letona','2001-08-11','luisdaniel@gmail.com',38394019,'Zona 4, Quiche',3046214401309,3);
CALL registrarEstudiante(202113553,'Kevin Ernesto','García Hernandez','2003-10-26','kevinbarca@gmail.com',92038203,'Ciudad de Mixco',3046201440126,4);
CALL registrarEstudiante(201900462,'Xhunik Nikol','Miguel Mutzutz','2002-06-19','khunikgod@gmail.com',29384948,'Zona 5, Petén',3046201440135,1);
CALL registrarEstudiante(202309421,'Julissa del Rosario','Reyes Cifuentes','2004-01-28','julss@gmail.com',29381912,'Zona 5, Ciudad de Guatemala',3046201440132,2);

SELECT * FROM ESTUDIANTE;

-- registrarDocente
CALL registrarDocente('Glenda Patricia','García Soria','1977-02-17','glenda@gmail.com',40501232,'Villa canales',3560878890101,200200001);
CALL registrarDocente('Kevin Adiel','Lajpop Ajpacaja','1972-03-13','kevinadiel@gmail.com',29823892,'Escuintla',3589135240101,200200002);
CALL registrarDocente('Byron Armando','Cuyan Culajay','1979-05-15','cuyanByron@gmail.com',98394828,'Antigua Guatemala',3011268180801,200200003);
CALL registrarDocente('Luis Fernando','Espino Barrios','1977-02-01','espino@gmail.com',93829304,'Ciudad Vieja',3011568180801,200200004);
CALL registrarDocente('Sergio Leonel','Gomez Bravo','1975-12-29','chocomax@gmail.com',40592039,'Zona 1, Ciudad de Guatemala',3014568180801,200200005);

SELECT * FROM DOCENTE;

-- crearCurso(id_curso,nombre, creditos_necesarios, creditos_otorgados, obligatorio, id_carrera)
-- Area Común
CALL crearCurso(101, 'Mate Basica 1', 0, 6, 1, 0);
CALL crearCurso(102, 'Etica', 0, 1, 1, 0);
CALL crearCurso(103, 'Idioma Técnico', 0, 4, 1, 0);
CALL crearCurso(104, 'Física General', 0, 5, 1, 0);
CALL crearCurso(105, 'Química Aplicada', 0, 4, 1, 0);
-- Ingenieria Civil
CALL crearCurso(201, 'Mecánica de Materiales', 0, 6, 1, 1);
CALL crearCurso(202, 'Diseño Estructural', 0, 9, 1, 1);
CALL crearCurso(203, 'Hidráulica', 10, 7, 1, 1);
CALL crearCurso(204, 'Geotecnia', 8, 6, 1, 1);
CALL crearCurso(205, 'Topografía', 6, 5, 1, 1);
-- Ingenieria Mecánica Industrial
CALL crearCurso(301, 'Procesos de Manufactura', 0, 8, 1, 2);
CALL crearCurso(302, 'Gestión de la Calidad', 0, 7, 1, 2);
CALL crearCurso(303, 'Automatización Industrial', 10, 9, 1, 2);
CALL crearCurso(304, 'Logística y Cadena de Suministro', 8, 7, 1, 2);
CALL crearCurso(305, 'Diseño de Productos', 12, 10, 1, 2);
-- Ingenieria en Ciencias y Sistemas
CALL crearCurso(401, 'Programación Avanzada', 0, 7, 1, 3);
CALL crearCurso(402, 'Bases de Datos', 0, 7, 1, 3);
CALL crearCurso(403, 'Redes de Computadoras', 10, 8, 1, 3);
CALL crearCurso(404, 'Inteligencia Artificial', 10, 9, 1, 3);
CALL crearCurso(405, 'Seguridad Informática', 8, 7, 1, 3);
-- Ingenieria Mecánica
CALL crearCurso(501, 'Termodinámica', 0, 7, 1, 4);
CALL crearCurso(502, 'Dinámica de Máquinas', 0, 9, 1, 4);
CALL crearCurso(503, 'Diseño de Elementos Mecánicos', 10, 8, 1, 4);
CALL crearCurso(504, 'Mecánica de Fluidos', 8, 7, 1, 4);
CALL crearCurso(505, 'Proyectos de Ingeniería Mecánica', 12, 10, 1, 4);

SELECT * FROM CURSO;


-- Habilitación de Cursos de Área Común
CALL habilitarCurso(101, '1S', 200200001, 75, 'A');
CALL habilitarCurso(102, '1S', 200200002, 50, 'B');
CALL habilitarCurso(101, '2S', 200200002, 50, 'C');
CALL habilitarCurso(103, '1S', 200200003, 40, 'D');
CALL habilitarCurso(104, '2S', 200200004, 90, 'E');

-- Habilitación de Cursos de Carrera Civil
CALL habilitarCurso(201, '1S', 200200001, 70, 'A');
CALL habilitarCurso(201, 'VJ', 200200001, 70, 'B');
CALL habilitarCurso(202, '1S', 200200002, 35, 'C');
CALL habilitarCurso(202, '2S', 200200002, 35, 'D');
CALL habilitarCurso(203, '1S', 200200003, 80, 'E');
CALL habilitarCurso(203, '2S', 200200003, 80, 'F');
CALL habilitarCurso(204, '1S', 200200004, 45, 'A');
CALL habilitarCurso(204, 'VD', 200200004, 45, 'B');
CALL habilitarCurso(205, '1S', 200200005, 55, 'C');
CALL habilitarCurso(205, 'VD', 200200005, 55, 'D');

-- Habilitación de Cursos de Carrera Industrial
CALL habilitarCurso(301, '1S', 200200001, 95, 'E');
CALL habilitarCurso(301, '2S', 200200001, 95, 'F');
CALL habilitarCurso(302, '1S', 200200002, 30, 'A');
CALL habilitarCurso(302, 'VJ', 200200002, 30, 'B');
CALL habilitarCurso(303, 'VJ', 200200003, 110, 'C');
CALL habilitarCurso(303, '2S', 200200003, 110, 'D');
CALL habilitarCurso(304, '1S', 200200004, 75, 'E');
CALL habilitarCurso(304, '2S', 200200004, 75, 'F');
CALL habilitarCurso(305, '1S', 200200005, 65, 'A');
CALL habilitarCurso(305, 'VD', 200200005, 65, 'B');

-- Habilitación de Cursos de Carrera de Sistemas
CALL habilitarCurso(401, '1S', 200200001, 85, 'C');
CALL habilitarCurso(401, '2S', 200200001, 85, 'D');
CALL habilitarCurso(402, '1S', 200200002, 100, 'E');
CALL habilitarCurso(402, 'VJ', 200200002, 100, 'F');
CALL habilitarCurso(403, '1S', 200200003, 70, 'G');
CALL habilitarCurso(403, '2S', 200200003, 70, 'H');
CALL habilitarCurso(404, '1S', 200200004, 45, 'I');
CALL habilitarCurso(404, '2S', 200200004, 45, 'J');
CALL habilitarCurso(405, '1S', 200200005, 60, 'K');
CALL habilitarCurso(405, 'VD', 200200005, 60, 'L');

-- Habilitación de Cursos de Carrera Mecánica
CALL habilitarCurso(501, '1S', 200200001, 85, 'L');
CALL habilitarCurso(501, '2S', 200200001, 85, 'M');
CALL habilitarCurso(502, '1S', 200200002, 100, 'N');
CALL habilitarCurso(502, '2S', 200200002, 100, 'O');
CALL habilitarCurso(503, '1S', 200200003, 70, 'P');
CALL habilitarCurso(503, 'VJ', 200200003, 70, 'A');
CALL habilitarCurso(504, '1S', 200200004, 45, 'B');
CALL habilitarCurso(504, '2S', 200200004, 45, 'C');
CALL habilitarCurso(505, '2S', 200200005, 60, 'M');
CALL habilitarCurso(505, 'VD', 200200005, 60, 'N');


SELECT * FROM CURSO_HABILITADO;

-- agregarHorario
CALL agregarHorario(1, 2, '6:50-7:40');
CALL agregarHorario(2, 5, '7:50-8:40');
CALL agregarHorario(3, 3, '8:50-9:40');
CALL agregarHorario(4, 7, '9:50-10:40');
CALL agregarHorario(5, 1, '10:50-11:40');
CALL agregarHorario(6, 4, '11:50-12:40');
CALL agregarHorario(7, 6, '12:50-13:40');
CALL agregarHorario(8, 2, '13:50-14:40');
CALL agregarHorario(9, 5, '14:50-15:40');
CALL agregarHorario(10, 3, '15:50-16:40');
CALL agregarHorario(11, 1, '16:50-17:40');
CALL agregarHorario(12, 4, '17:50-18:40');
CALL agregarHorario(13, 2, '18:50-19:40');
CALL agregarHorario(14, 6, '19:50-20:40');
CALL agregarHorario(15, 1, '6:50-7:40');
CALL agregarHorario(16, 4, '7:50-8:40');
CALL agregarHorario(17, 6, '8:50-9:40');
CALL agregarHorario(18, 2, '9:50-10:40');
CALL agregarHorario(19, 5, '10:50-11:40');
CALL agregarHorario(20, 3, '11:50-12:40');
CALL agregarHorario(21, 2, '12:50-13:40');
CALL agregarHorario(22, 5, '13:50-14:40');
CALL agregarHorario(23, 3, '14:50-15:40');
CALL agregarHorario(24, 7, '15:50-16:40');
CALL agregarHorario(25, 1, '16:50-17:40');
CALL agregarHorario(26, 4, '17:50-18:40');
CALL agregarHorario(27, 6, '18:50-19:40');
CALL agregarHorario(28, 2, '19:50-20:40');
CALL agregarHorario(29, 5, '6:50-7:40');
CALL agregarHorario(30, 3, '7:50-8:40');
CALL agregarHorario(31, 1, '8:50-9:40');
CALL agregarHorario(32, 4, '9:50-10:40');
CALL agregarHorario(33, 2, '10:50-11:40');
CALL agregarHorario(34, 6, '11:50-12:40');
CALL agregarHorario(35, 1, '12:50-13:40');
CALL agregarHorario(36, 4, '13:50-14:40');
CALL agregarHorario(37, 6, '14:50-15:40');
CALL agregarHorario(38, 2, '15:50-16:40');
CALL agregarHorario(39, 5, '16:50-17:40');
CALL agregarHorario(40, 3, '17:50-18:40');
CALL agregarHorario(41, 2, '18:50-19:40');
CALL agregarHorario(42, 5, '19:50-20:40');
CALL agregarHorario(43, 3, '17:50-18:40');
CALL agregarHorario(44, 2, '18:50-19:40');
CALL agregarHorario(45, 5, '19:50-20:40');
CALL agregarHorario(1, 4, '6:50-7:40');
CALL agregarHorario(2, 7, '7:50-8:40');
CALL agregarHorario(3, 4, '8:50-9:40');
CALL agregarHorario(4, 1, '9:50-10:40');
CALL agregarHorario(5, 6, '10:50-11:40');
CALL agregarHorario(6, 5, '11:50-12:40');
CALL agregarHorario(7, 3, '12:50-13:40');
CALL agregarHorario(8, 2, '13:50-14:40');
CALL agregarHorario(9, 1, '14:50-15:40');
CALL agregarHorario(10, 5, '15:50-16:40');


SELECT * FROM DETALLE_CURSO_HABILITADO;
SELECT * FROM HORARIO;


-- ASIGNAR

-- Estudiante 202109567 (Alvaro) - Carrera: Civil (código 1)
CALL asignarCurso(101, '1S', 'A', 202109567);
CALL asignarCurso(102, '1S', 'B', 202109567);
CALL asignarCurso(201, '1S', 'A', 202109567);
CALL asignarCurso(202, '1S', 'C', 202109567);

-- Estudiante 202100239 (Aida) - Carrera: Mecanica (código 2)
CALL asignarCurso(101, '1S', 'A', 202100239);
CALL asignarCurso(102, '1S', 'B', 202100239);
CALL asignarCurso(501, '1S', 'L', 202100239);
CALL asignarCurso(502, '1S', 'N', 202100239);

-- Estudiante 202110897 (Lesther) - Carrera: Civil (código 1)
CALL asignarCurso(101, '1S', 'A', 202110897);
CALL asignarCurso(102, '1S', 'B', 202110897);
CALL asignarCurso(201, '1S', 'A', 202110897);
CALL asignarCurso(202, '1S', 'C', 202110897);


-- Estudiante 202110568 (Damian) - Carrera: Mecanica Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202110568);
CALL asignarCurso(102, '1S', 'B', 202110568);
CALL asignarCurso(301, '1S', 'E', 202110568);
CALL asignarCurso(302, '1S', 'A', 202110568);

-- Estudiante 202112145 (Daniel) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202112145);
CALL asignarCurso(102, '1S', 'B', 202112145);
CALL asignarCurso(401, '1S', 'C', 202112145);
CALL asignarCurso(402, '1S', 'E', 202112145);

-- Estudiante 202113553 (Kevin) - Carrera: Mecánica (código 4)
CALL asignarCurso(101, '1S', 'A', 202113553);
CALL asignarCurso(102, '1S', 'B', 202113553);
CALL asignarCurso(501, '1S', 'L', 202113553);
CALL asignarCurso(502, '1S', 'N', 202113553);

-- Estudiante 202000549 (Luis) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202000549);
CALL asignarCurso(102, '1S', 'B', 202000549);
CALL asignarCurso(401, '1S', 'C', 202000549);
CALL asignarCurso(402, '1S', 'E', 202000549);

-- Estudiante 202309421 (Julissa) - Carrera: Mecanica Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202309421);
CALL asignarCurso(102, '1S', 'B', 202309421);
CALL asignarCurso(301, '1S', 'E', 202309421);
CALL asignarCurso(302, '1S', 'A', 202309421);

-- Estudiante 201900462 (Xhunik) - Carrera: Civil (código 4)
CALL asignarCurso(101, '1S', 'A', 201900462);
CALL asignarCurso(102, '1S', 'B', 201900462);
CALL asignarCurso(201, '1S', 'A', 201900462);
CALL asignarCurso(202, '1S', 'C', 201900462);

-- Estudiante 201901803 (Benjamin) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 201901803);
CALL asignarCurso(102, '1S', 'B', 201901803);
CALL asignarCurso(401, '1S', 'C', 201901803);
CALL asignarCurso(402, '1S', 'E', 201901803);


-- DESASIGNAR
CALL desasignarCurso(101, '1S', 'A', 202109567); -- Estudiante 202109567
CALL desasignarCurso(101, '1S', 'A', 202110568); -- Estudiante 202110568
CALL desasignarCurso(101, '1S', 'A', 202112145); -- Estudiante 202112145
CALL desasignarCurso(101, '1S', 'A', 202100239); -- Estudiante 202100239
CALL desasignarCurso(101, '1S', 'A', 202309421); -- Estudiante 202309421


SELECT * FROM ASIGNACION;


-- ingresarNota
-- Estudiante 202109567 (Alvaro) - Carrera: Civil (código 1)
-- CALL ingresarNota(101, '1S', 'A', 202109567,72.3);
CALL ingresarNota(102, '1S', 'B', 202109567,60.7);
CALL ingresarNota(201, '1S', 'A', 202109567,86.2);
CALL ingresarNota(202, '1S', 'C', 202109567,95.1);

-- Estudiante 202100239 (Aida) - Carrera: Mecanica (código 2)
-- CALL ingresarNota(101, '1S', 'A', 202100239,20);
CALL ingresarNota(102, '1S', 'B', 202100239,59.1);
CALL ingresarNota(501, '1S', 'L', 202100239,82);
CALL ingresarNota(502, '1S', 'N', 202100239,75.3);

-- Estudiante 202110897 (Lesther) - Carrera: Civil (código 1)
CALL ingresarNota(101, '1S', 'A', 202110897,29);
CALL ingresarNota(102, '1S', 'B', 202110897,86.5);
CALL ingresarNota(201, '1S', 'A', 202110897,61.7);
CALL ingresarNota(202, '1S', 'C', 202110897,59.9);

-- Estudiante 202110568 (Damian) - Carrera: Mecanica Industrial (código 2)
-- CALL ingresarNota(101, '1S', 'A', 202110568,98);
CALL ingresarNota(102, '1S', 'B', 202110568,89);
CALL ingresarNota(301, '1S', 'E', 202110568,65);
CALL ingresarNota(302, '1S', 'A', 202110568,76);

-- Estudiante 202112145 (Daniel) - Carrera: Sistemas (código 3)
-- CALL ingresarNota(101, '1S', 'A', 202112145,96);
CALL ingresarNota(102, '1S', 'B', 202112145,96);
CALL ingresarNota(401, '1S', 'C', 202112145,60);
CALL ingresarNota(402, '1S', 'E', 202112145,61);

-- Estudiante 202113553 (Kevin) - Carrera: Mecánica (código 4)
CALL ingresarNota(101, '1S', 'A', 202113553,86);
CALL ingresarNota(102, '1S', 'B', 202113553,76);
CALL ingresarNota(501, '1S', 'L', 202113553,56);
CALL ingresarNota(502, '1S', 'N', 202113553,86);

-- Estudiante 202000549 (Luis) - Carrera: Sistemas (código 3)
CALL ingresarNota(101, '1S', 'A', 202000549,90.3);
CALL ingresarNota(102, '1S', 'B', 202000549,60.8);
CALL ingresarNota(401, '1S', 'C', 202000549,69.23);
CALL ingresarNota(402, '1S', 'E', 202000549,97);

-- Estudiante 202309421 (Julissa) - Carrera: Mecanica Industrial (código 2)
-- CALL ingresarNota(101, '1S', 'A', 202309421,87.5);
CALL ingresarNota(102, '1S', 'B', 202309421,67.5);
CALL ingresarNota(301, '1S', 'E', 202309421,86.3);
CALL ingresarNota(302, '1S', 'A', 202309421,93.3);

-- Estudiante 201900462 (Xhunik) - Carrera: Civil (código 4)
CALL ingresarNota(101, '1S', 'A', 201900462,75);
CALL ingresarNota(102, '1S', 'B', 201900462,57);
CALL ingresarNota(201, '1S', 'A', 201900462,42);
CALL ingresarNota(202, '1S', 'C', 201900462,82);

-- Estudiante 201901803 (Benjamin) - Carrera: Sistemas (código 3)
CALL ingresarNota(101, '1S', 'A', 201901803,76);
CALL ingresarNota(102, '1S', 'B', 201901803,90.5);
CALL ingresarNota(401, '1S', 'C', 201901803,30);
CALL ingresarNota(402, '1S', 'E', 201901803,100);


-- generar acta
CALL generarActa(101, '1S', 'A');
CALL generarActa(102, '1S', 'B');
CALL generarActa(201, '1S', 'A');
CALL generarActa(202, '1S', 'C');
CALL generarActa(301, '1S', 'E');
CALL generarActa(302, '1S', 'A');
CALL generarActa(401, '1S', 'C');
CALL generarActa(402, '1S', 'E');
CALL generarActa(501, '1S', 'L');
CALL generarActa(502, '1S', 'N');


-- queries
CALL consultarPensum(4);
CALL consultarEstudiante(201901803);
CALL consultarDocente(200200001);
CALL consultarAsignados(102, '1S', 2023, 'B');
CALL consultarAprobacion(102, '1S', 2023, 'B');
CALL consultarActas(101);
CALL consultarDesasignacion(101, '1S', 2023, 'A');