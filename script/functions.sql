-- validate if it's a positive integer or cero
DELIMITER $$
CREATE FUNCTION IsPositiveIntegerOrZero(value INTEGER)
    RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE is_valid BOOLEAN;
    SET is_valid = FALSE;

    IF value >= 0 AND value = FLOOR(value) THEN
        SET is_valid = TRUE;
    END IF;

    RETURN is_valid;
END;
$$
DELIMITER ;

-- validate if the docente is already created
DELIMITER $$
CREATE FUNCTION IsNewDocente(inputDPI BIGINT(13))
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE already_exist BOOLEAN;
        SET already_exist = FALSE;

        -- Use COUNT(*) to check for existence
        SELECT COUNT(*) INTO already_exist FROM DOCENTE WHERE dpi = inputDPI;

        RETURN already_exist;
    END
$$
DELIMITER ;


-- Validate if a string only contain letters
-- DROP FUNCTION proyecto2.ValidateOnlyLetters;
DELIMITER $$
CREATE FUNCTION ValidateOnlyLetters(name VARCHAR(100))
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE valid BOOLEAN;
        SET valid = TRUE;
        IF name REGEXP '^[a-zA-Zaáéíóú ]*$' THEN
            SET valid = TRUE;
        ELSE
            SET valid = FALSE;
        END IF;

        RETURN valid;
    END $$
DELIMITER ;

-- DROP FUNCTION proyecto2.GetCareer;
-- Function to get the "CARRERA" id
DELIMITER $$
CREATE FUNCTION GetCareer(inputId INTEGER)
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE id INTEGER;
        -- get the id from the carrera table
        SELECT id_carrera INTO id FROM CARRERA WHERE id_carrera = (inputId + 1);
        RETURN id;
    END $$
DELIMITER ;

-- Function to return the id of the "CICLO"
DELIMITER $$
CREATE FUNCTION GetCicloName(inputId integer)
    RETURNS VARCHAR(100) READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE ciclo_id INTEGER;
        DECLARE return_value VARCHAR(100);
        -- get the id from CICLO table
        SELECT id_ciclo INTO ciclo_id FROM CICLO WHERE  id_ciclo = inputId ;

        IF ciclo_id = 1 THEN
            SET return_value = 'PRIMER SEMESTRE';
        ELSEIF ciclo_id = 2 THEN
            SET return_value = 'SEGUNDO SEMESTRE';
        ELSEIF ciclo_id = 3 THEN
            SET return_value = 'VACACIONES DE JUNIO';
        ELSEIF ciclo_id = 4 THEN
            SET return_value = 'VACACIONES DE DICIEMBRE';
        END IF;

        return return_value;
    END ;
    $$
DELIMITER ;


-- Function to return the id of the "CICLO"
DELIMITER $$
CREATE FUNCTION GetCiclo(inputName VARCHAR(2))
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE id INTEGER;
        -- get the id from CICLO table
        SELECT id_ciclo INTO id FROM CICLO WHERE nombre = inputName ;
        RETURN id;
    END $$
DELIMITER ;

-- Function to validate if the code of the "CURSO" exist
DELIMITER $$
CREATE FUNCTION GetCurso(inputCode INT)
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE id INTEGER;
        -- get the id from CICLO table
        SELECT id_curso INTO id FROM CURSO WHERE codigo = inputCode ;
        RETURN id;
    END $$
DELIMITER ;

-- Function to validate if the code of the "DOCENTE" exist
DELIMITER $$
CREATE FUNCTION GetDocente(inputSIIF INTEGER)
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE id INTEGER;
        -- get the id from CICLO table
        SELECT id_docente INTO id FROM DOCENTE WHERE registro_siif = inputSIIF ;
        RETURN id;
    END $$
DELIMITER ;

-- Function to get or insert section in "SECCION"
DELIMITER $$
CREATE FUNCTION GetOrInsertSeccion(inputSeccion CHAR(1))
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE seccion_id INTEGER;

        -- check if the section exits
        SELECT id_seccion INTO seccion_id FROM SECCION WHERE seccion = inputSeccion;
        -- if it exists, return the id
        IF seccion_id IS NOT NULL THEN
            RETURN seccion_id;
        ELSE
            -- insert and return the new id
            INSERT INTO SECCION(seccion) VALUES (inputSeccion);
            SET seccion_id = LAST_INSERT_ID();
            RETURN seccion_id;
        END IF;
    END;
    $$
DELIMITER ;

-- Function to get the id from "CURSO_HABILITADO"
DELIMITER $$
CREATE FUNCTION GetCursoHabilitado(inputId INTEGER)
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE curso_h_id INTEGER;
        -- check if the section exits
        SELECT id_curso_habilitado INTO curso_h_id FROM CURSO_HABILITADO WHERE id_curso_habilitado = inputId;
        RETURN curso_h_id;
    END;
    $$
DELIMITER ;

-- Function to validate if it's an email
DELIMITER $$
CREATE FUNCTION IsEmailValid(inputEmail varchar(255))
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE is_valid BOOLEAN;
        SET is_valid = FALSE;
        -- Evaluate with REGEX if the email is valid
    IF inputEmail REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
        SET is_valid = TRUE;
    END IF;

        RETURN is_valid;
    END $$
DELIMITER ;

-- Function to return the current date
DELIMITER $$
CREATE FUNCTION GetDate()
    RETURNS DATE READS SQL DATA
BEGIN
    RETURN CURDATE();
END;
$$
DELIMITER ;

-- Function to return the current datetime
DELIMITER $$
CREATE FUNCTION GetDateTime()
    RETURNS DATETIME READS SQL DATA
BEGIN
    RETURN CURDATE();
END;
$$
DELIMITER ;

-- function to insert a new "HORARIO"
DELIMITER $$
CREATE FUNCTION InsertHorario(inputDay INTEGER, inputHorario VARCHAR(30))
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE new_id_horario INTEGER;
        -- insert new horario
        INSERT INTO HORARIO( dia, horario) VALUES (inputDay,inputHorario);
        SET new_id_horario = LAST_INSERT_ID();
        RETURN new_id_horario;
    END;
    $$
DELIMITER ;


-- Function to validate if the days are in the correct range
DELIMITER $$
CREATE FUNCTION IsDayInRange(n INT)
    RETURNS BOOLEAN READS SQL DATA
BEGIN
    IF n >= 1 AND n <= 7 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
DELIMITER ;

-- Function to validate if the
DELIMITER $$
CREATE FUNCTION IsCupoAvailable(input_curso_habilitado_id INT)
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE cupo_max_reached BOOLEAN;
    SET cupo_max_reached = FALSE;

    -- Count the total assignments for the curso_habilitado
    SELECT COUNT(*) INTO cupo_max_reached
    FROM ASIGNACION a
    WHERE a.id_curso_habilitado = input_curso_habilitado_id;

    -- Compare the count to cupo_maximo
    IF cupo_max_reached >= (SELECT cupo_maximo FROM CURSO_HABILITADO WHERE id_curso_habilitado = input_curso_habilitado_id) THEN
        SET cupo_max_reached = TRUE;
    ELSE
        SET cupo_max_reached = FALSE;
    END IF;

    RETURN cupo_max_reached;
END;
$$
DELIMITER ;

-- Function to validate if the student owns for tha carreer
DROP FUNCTION proyecto2.IsSameCarrera;
DELIMITER $$
CREATE FUNCTION IsSameCarrera(inputCarnet BIGINT, input_curso_h INTEGER)
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE is_same_carrera BOOLEAN;
    SET is_same_carrera = FALSE;

    -- Check if the assignment exists for the given carnet and course_id
    SELECT 1 INTO is_same_carrera
    FROM CURSO_HABILITADO CH
    JOIN CURSO C ON CH.id_curso = C.id_curso
    JOIN ESTUDIANTE E ON E.carnet = inputCarnet
    WHERE (C.id_carrera = E.id_carrera OR C.id_carrera = 1)
    AND CH.id_curso_habilitado = input_curso_h
    LIMIT 1;
    -- If is the same carrera or area comun, return true
    IF is_same_carrera THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
DELIMITER ;

-- Function to validate if the student is already assign
-- DROP FUNCTION proyecto2.IsAsignado;
DELIMITER $$
CREATE FUNCTION IsAsignado(inputCaret BIGINT, input_curso_h INTEGER)
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE assignment_exists BOOLEAN;
    SET assignment_exists = FALSE;

    -- Check if the assignment exists for the given carnet and course_id
    SELECT 1 INTO assignment_exists
    FROM ASIGNACION
    WHERE inputCaret = carnet AND id_curso_habilitado = input_curso_h
    LIMIT 1;
    -- If assignment exists, return TRUE; otherwise, return FALSE
    IF assignment_exists THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
DELIMITER ;

-- Function to get  carnet from "ESTUDIANTE"
DELIMITER $$
CREATE FUNCTION GetEstudiante(inputCarnet BIGINT)
    RETURNS BIGINT READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE carnet_id INTEGER;
        -- check if the section exits
        SELECT carnet INTO carnet_id FROM ESTUDIANTE WHERE carnet = inputCarnet;
        -- return the id
        RETURN carnet_id;
    END;
    $$
DELIMITER ;
-- Function to get  section in "SECCION"
DELIMITER $$
CREATE FUNCTION GetSeccion(inputSeccion CHAR(1))
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE seccion_id INTEGER;
        -- check if the section exits
        SELECT id_seccion INTO seccion_id FROM SECCION WHERE seccion = inputSeccion;
        -- return the id
        RETURN seccion_id;
    END;
    $$
DELIMITER ;

-- Function to get the id from "CURSO_HABILITADO"
-- DROP FUNCTION proyecto2.GetCursoHabilitadoByCode;
DELIMITER $$
CREATE FUNCTION GetCursoHabilitadoByCode(inputCode INT, input_id_ciclo INTEGER, input_id_seccion INTEGER)
    RETURNS INT READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE curso_h_id INTEGER;
        -- check if the section exits
        SELECT CH.id_curso_habilitado INTO curso_h_id
        FROM CURSO_HABILITADO CH
        JOIN CURSO C
        ON CH.id_curso = C.id_curso
        WHERE C.codigo = inputCode AND (CH.id_ciclo = input_id_ciclo AND CH.id_seccion = input_id_seccion);

        RETURN curso_h_id;
    END;
    $$
DELIMITER ;

-- Function to validate if the user has the necesary credits
DELIMITER $$
CREATE FUNCTION HasNecesaryCredits(inputCarnet BIGINT, input_curso_h INTEGER)
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE necesary_credits BOOLEAN;
    SET necesary_credits = FALSE;

    -- Check if the assignment exists for the given carnet and course_id
    SELECT 1 INTO necesary_credits
    FROM CURSO_HABILITADO CH
    JOIN CURSO C ON CH.id_curso = C.id_curso
    JOIN ESTUDIANTE E ON E.carnet = inputCarnet
    WHERE E.creditos >= C.creditos_necesarios
    AND CH.id_curso_habilitado = input_curso_h
    LIMIT 1;
    -- If is the same carrera or area comun, return true
    IF necesary_credits THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
DELIMITER ;


-- Function to return a float rounded
DELIMITER $$
CREATE FUNCTION RoundedNote(inputNote FLOAT)
    RETURNS INT READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE new_value INT;

    SET new_value = ROUND(inputNote);

    RETURN new_value;
END
$$
DELIMITER ;


-- Function to get the asignacion
DELIMITER $$
CREATE FUNCTION GetAsignacion(input_id_curso_h INTEGER, input_carnet BIGINT)
    RETURNS INTEGER READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE asignacion_id INTEGER;

    SELECT id_asignacion INTO asignacion_id FROM ASIGNACION WHERE id_curso_habilitado = input_id_curso_h AND carnet = input_carnet;

    RETURN asignacion_id;
END;
$$
DELIMITER ;




-- Function to validate if all the notes
DROP FUNCTION proyecto2.AreNotasComplete;

DELIMITER $$
CREATE FUNCTION AreNotasComplete(input_curso_habilitado_id INTEGER)
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE is_complete BOOLEAN ;
    DECLARE nota_count INT;
    DECLARE assignment_count INT;
    SET is_complete = FALSE;


    -- Get the count of NOTA records for the given id_asignacion
    SELECT COUNT(*) INTO nota_count
        FROM NOTA N
        JOIN ASIGNACION A ON N.id_asignacion = A.id_asignacion
        WHERE A.id_curso_habilitado = input_curso_habilitado_id;

    -- Get the count of assignments for the associated id_curso_habilitado
    SELECT COUNT(*) INTO assignment_count
        FROM ASIGNACION
            WHERE id_curso_habilitado = input_curso_habilitado_id AND fecha_desasignacion IS NULL;

    -- Compare the counts
    IF nota_count = assignment_count THEN
        SET is_complete = TRUE;
    END IF;

    RETURN is_complete;
END;
$$
DELIMITER ;

-- Function to insert transaccion
DELIMITER $$
CREATE PROCEDURE InsertTransaccion(
    IN new_description VARCHAR(200),
    IN new_tipo VARCHAR(30)
)
    BEGIN
        INSERT INTO TRANSACCION(fecha_hora, descripcion, tipo) VALUES (NOW(), new_description, new_tipo);
    END;
    $$
DELIMITER ;