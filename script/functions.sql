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