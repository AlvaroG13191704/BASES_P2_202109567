-- PROCEDURES

-- 1.
DELIMITER $$
CREATE PROCEDURE crearCarrera(IN inputName VARCHAR(50))
    BEGIN
      DECLARE carrera_exist INT;
      DECLARE name_valid BOOLEAN;

      -- Evaluate if the name is already declared
        SELECT COUNT(*) INTO carrera_exist FROM CARRERA WHERE nombre = inputName;

      -- Evaluate if the name is only letters
        SET name_valid = ValidateOnlyLetters(inputName);

      -- add if's
        IF carrera_exist > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera ya existe.';
        ELSEIF name_valid = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre invalido.';
        ELSE
            INSERT INTO CARRERA(nombre) VALUES (inputName);
        END IF;
    END $$
DELIMITER ;

-- 2.
DELIMITER $$
CREATE PROCEDURE registrarEstudiante(
    IN newCarnet BIGINT,
    IN newNames VARCHAR(50),
    IN newLastName VARCHAR(50),
    IN newBirthDay DATE,
    IN newEmail VARCHAR(50),
    IN newPhone INTEGER,
    IN newAddress VARCHAR(50),
    IN newDpi BIGINT,
    IN newCarrera INTEGER
)
    BEGIN
        DECLARE is_email_valid BOOLEAN;
        DECLARE new_id_carrera INTEGER;
        DECLARE currentDate DATETIME;


        -- Evaluate if the email is valid
        SET is_email_valid = IsEmailValid(newEmail);

        -- Get the id from "CARRERA" table
        SET new_id_carrera = GetCareer(newCarrera);

        -- get current date
        SET currentDate = Get_Date();

        -- Validate
        IF is_email_valid = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El email no es valido.';
        ELSEIF new_id_carrera IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera no existe.';
        ELSE
            INSERT INTO ESTUDIANTE( carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, creditos, registro_creacion, id_carrera )
                VALUES (
                        newCarnet,
                        newNames,
                        newLastName,
                        newBirthDay,
                        newEmail,
                        newPhone,
                        newAddress,
                        newDpi,
                        0,
                        currentDate,
                        new_id_carrera
                       );
        END IF;
    END;
    $$
DELIMITER ;