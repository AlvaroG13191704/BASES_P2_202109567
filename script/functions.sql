-- FUNCTIONS
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
DROP FUNCTION proyecto2.ValidateOnlyLetters;
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
        --
        SELECT id_carrera INTO id FROM CARRERA WHERE id_carrera = (inputId + 1);
        RETURN id;
    END $$
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