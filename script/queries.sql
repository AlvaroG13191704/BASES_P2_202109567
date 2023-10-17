-- 1.
DELIMITER $$
CREATE PROCEDURE consultarPensum(
    IN new_code_carrera INTEGER
    )
    BEGIN
        DECLARE carrera_id INTEGER;

        SET carrera_id = GetCareer(new_code_carrera);

        IF carrera_id IS  NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera ya existe.';
        END IF;

        SELECT
            codigo AS 'Codígo del curso',
            nombre AS 'Nombre',
            obligatorio AS 'Obligatorio',
            creditos_necesarios AS 'Creditos necesarios'
        FROM CURSO
            WHERE id_carrera = carrera_id OR id_carrera = 1;
    END;
    $$
DELIMITER ;

-- 2.
DELIMITER $$
CREATE PROCEDURE consultarEstudiante(
    IN new_carnet BIGINT
    )
    BEGIN
        DECLARE carnet_id INTEGER;

        SET carnet_id = GetEstudiante(new_carnet);

        IF carnet_id IS  NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no existe.';
        END IF;

        SELECT
            carnet AS 'Carnet',
            CONCAT(nombres , ' ' , apellidos) AS 'Nomble completo',
            fecha_nacimiento AS 'Fecha de nacimiento',
            correo AS 'Correo',
            telefono AS 'Teléfono',
            direccion as 'Dirección',
            dpi AS 'Número de DPI',
            C.nombre as 'Carrera',
            creditos as 'Credítos que posee'
        FROM ESTUDIANTE E
        JOIN CARRERA C on E.id_carrera = C.id_carrera
            WHERE E.carnet = carnet_id;
    END;
    $$
DELIMITER ;


-- 3.
DROP PROCEDURE proyecto2.consultarDocente;
DELIMITER $$
CREATE PROCEDURE consultarDocente(
    IN new_carnet BIGINT
    )
    BEGIN
        DECLARE carnet_id INTEGER;

        SET carnet_id = GetDocente(new_carnet);

        IF carnet_id IS  NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente no existe.';
        END IF;

        SELECT
            registro_siif as 'Registro SIIF',
            CONCAT(nombres , ' ' , apellidos) AS 'Nomble completo',
            fecha_nacimiento AS 'Fecha de nacimiento',
            correo AS 'Correo',
            telefono AS 'Teléfono',
            direccion as 'Dirección',
            dpi AS 'Número de DPI'
        FROM DOCENTE
            WHERE  id_docente = carnet_id;
    END;
    $$
DELIMITER ;