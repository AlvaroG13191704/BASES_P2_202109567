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

-- 4.
DROP PROCEDURE proyecto2.consultarAsignados;
DELIMITER $$
CREATE PROCEDURE consultarAsignados(
    IN new_codigo_curso INT,
    IN new_ciclo VARCHAR(2),
    IN new_year INT,
    IN new_seccion CHAR(1)
    )
    BEGIN
        -- declaration
        DECLARE curso_id INTEGER;
        DECLARE ciclo_id INTEGER;
        DECLARE seccion_id INTEGER;
        DECLARE curso_habilitado_id INTEGER;
        -- setters
        SET seccion_id = GetSeccion(UPPER(new_seccion));
        SET ciclo_id = GetCiclo(new_ciclo);
        SET curso_id = GetCurso(new_codigo_curso);
        SET curso_habilitado_id = GetCursoHabilitadoByCode(new_codigo_curso,ciclo_id,seccion_id);

        -- VALIDATE
        IF seccion_id IS NULL THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion no existe';
        ELSEIF ciclo_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no existe';
        ELSEIF curso_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe.';
        ELSEIF curso_habilitado_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este curso no esta habilitado';
        END IF;

        -- return

        SELECT
            E.carnet as 'Carnet',
            CONCAT(E.nombres , ' ' , E.apellidos) AS 'Nomble completo',
            E.creditos as 'Creditos'
        FROM ESTUDIANTE E
        JOIN ASIGNACION A ON E.carnet = A.carnet
        JOIN CURSO_HABILITADO CH ON A.id_curso_habilitado = CH.id_curso_habilitado
        JOIN CURSO C ON CH.id_curso = C.id_curso
        WHERE C.id_curso = curso_id
        AND CH.id_ciclo = ciclo_id
        AND CH.id_seccion = seccion_id
        AND YEAR(CH.fecha) = new_year
        AND A.fecha_desasignacion IS NULL;
    END;
    $$
DELIMITER ;

-- 5.
DROP PROCEDURE proyecto2.consultarAprobacion;
DELIMITER $$
CREATE PROCEDURE consultarAprobacion(
    IN new_codigo_curso INT,
    IN new_ciclo VARCHAR(2),
    IN new_year INT,
    IN new_seccion CHAR(1)
    )
    BEGIN
        -- declaration
        DECLARE curso_id INTEGER;
        DECLARE ciclo_id INTEGER;
        DECLARE seccion_id INTEGER;
        DECLARE curso_habilitado_id INTEGER;
        -- setters
        SET seccion_id = GetSeccion(UPPER(new_seccion));
        SET ciclo_id = GetCiclo(new_ciclo);
        SET curso_id = GetCurso(new_codigo_curso);
        SET curso_habilitado_id = GetCursoHabilitadoByCode(new_codigo_curso,ciclo_id,seccion_id);

        -- VALIDATE
        IF seccion_id IS NULL THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion no existe';
        ELSEIF ciclo_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no existe';
        ELSEIF curso_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe.';
        ELSEIF curso_habilitado_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este curso no esta habilitado';
        END IF;

        -- return

        SELECT
            C.codigo as 'Código',
            E.carnet as 'Carnet',
            CONCAT(E.nombres , ' ' , E.apellidos) AS 'Nomble completo',
            IF(N.nota >= 61, 'APROBADO', 'DESAPROBADO') AS 'Estado'
        FROM ESTUDIANTE E
        JOIN ASIGNACION A ON E.carnet = A.carnet
        JOIN CURSO_HABILITADO CH ON A.id_curso_habilitado = CH.id_curso_habilitado
        JOIN CURSO C ON CH.id_curso = C.id_curso
        JOIN NOTA N ON A.id_asignacion = N.id_asignacion
        WHERE C.id_curso = curso_id
        AND CH.id_ciclo = ciclo_id
        AND CH.id_seccion = seccion_id
        AND YEAR(CH.fecha) = new_year
        AND A.fecha_desasignacion IS NULL;
    END;
    $$
DELIMITER ;

-- 6.
DROP PROCEDURE proyecto2.consultarActas;
DELIMITER $$
CREATE PROCEDURE consultarActas(
    IN new_codigo_curso INT
    )
    BEGIN
        -- declaration
        DECLARE curso_id INTEGER;
        -- setters
        SET curso_id = GetCurso(new_codigo_curso);
        -- VALIDATE
        IF curso_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe.';
        END IF;


        -- return
        SELECT
            C.codigo AS "Código de curso",
            S.seccion AS "Sección",
            GetCicloName(CI.id_ciclo) as 'Ciclo',
            YEAR(CH.fecha) AS "Año",
            COUNT(DISTINCT N.id_asignacion) AS "Cantidad de estudiantes / notas",
            A.fecha_hora AS "Fecha y hora de generado"
        FROM CURSO_HABILITADO CH
        JOIN CURSO C ON CH.id_curso = C.id_curso
        JOIN SECCION S ON CH.id_seccion = S.id_seccion
        JOIN CICLO CI ON CH.id_ciclo = CI.id_ciclo
        JOIN ACTA A ON CH.id_curso_habilitado = A.id_curso_habilitado
        LEFT JOIN ASIGNACION ASG ON CH.id_curso_habilitado = ASG.id_curso_habilitado
        LEFT JOIN NOTA N ON ASG.id_asignacion = N.id_asignacion
        WHERE C.id_curso = curso_id
        GROUP BY A.id_acta, C.codigo, S.seccion, CI.nombre, A.fecha_hora
        ORDER BY A.fecha_hora;

    END;
    $$
DELIMITER ;

-- 7.
DROP PROCEDURE proyecto2.consultarDesasignacion;
DELIMITER $$
CREATE PROCEDURE consultarDesasignacion(
    IN new_codigo_curso INT,
    IN new_ciclo VARCHAR(2),
    IN new_year INT,
    IN new_seccion CHAR(1)
    )
    BEGIN
        -- declaration
        DECLARE curso_id INTEGER;
        DECLARE ciclo_id INTEGER;
        DECLARE seccion_id INTEGER;
        DECLARE curso_habilitado_id INTEGER;
        -- setters
        SET seccion_id = GetSeccion(UPPER(new_seccion));
        SET ciclo_id = GetCiclo(new_ciclo);
        SET curso_id = GetCurso(new_codigo_curso);
        SET curso_habilitado_id = GetCursoHabilitadoByCode(new_codigo_curso,ciclo_id,seccion_id);

        -- VALIDATE
        IF seccion_id IS NULL THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion no existe';
        ELSEIF ciclo_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no existe';
        ELSEIF curso_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe.';
        ELSEIF curso_habilitado_id IS NULL THEN
               SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este curso no esta habilitado';
        END IF;

        -- return
        SELECT
            C.codigo AS "Código de curso",
            S.seccion AS "Sección",
            GetCicloName(CI.id_ciclo) as 'Ciclo',
            YEAR(CH.fecha) AS "Año",
            COUNT(DISTINCT ASG.carnet) AS "Cantidad de estudiantes que llevaron el curso",
            SUM(CASE WHEN ASG.fecha_desasignacion IS NOT NULL THEN 1 ELSE 0 END) AS "Cantidad de estudiantes que se desasignaron",
            (SUM(CASE WHEN ASG.fecha_desasignacion IS NOT NULL THEN 1 ELSE 0 END) / COUNT(DISTINCT ASG.carnet)) * 100 AS "Porcentaje de desasignación"
        FROM CURSO_HABILITADO CH
        JOIN CURSO C ON CH.id_curso = C.id_curso
        JOIN SECCION S ON CH.id_seccion = S.id_seccion
        JOIN CICLO CI ON CH.id_ciclo = CI.id_ciclo
        LEFT JOIN ASIGNACION ASG ON CH.id_curso_habilitado = ASG.id_curso_habilitado
        WHERE C.id_curso = curso_id
            AND CI.id_ciclo = ciclo_id
            AND YEAR(CH.fecha) = new_year
        GROUP BY C.codigo, S.seccion, CI.id_ciclo, YEAR(CH.fecha);

    END;
    $$
DELIMITER ;
