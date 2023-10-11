-- FUNCTIONS

-- Validate if a string only contain letters
DELIMITER $$
CREATE FUNCTION ValidateOnlyLetters(name VARCHAR(100))
    RETURNS BOOLEAN READS SQL DATA
    DETERMINISTIC
    BEGIN
        DECLARE valid BOOLEAN;
        SET valid = TRUE;
        IF name REGEXP '^[a-zA-Z ]+$' THEN
            SET valid = TRUE;
        ELSE
            SET valid = FALSE;
        END IF;

        RETURN valid;
    END $$
DELIMITER ;

DROP FUNCTION proyecto2.GetCareer;
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
CREATE FUNCTION Get_Date()
RETURNS DATETIME READS SQL DATA
NOT DETERMINISTIC
BEGIN
    DECLARE fecha_hora DATETIME;
    SET fecha_hora = NOW();
    RETURN fecha_hora;
END;
$$
DELIMITER ;