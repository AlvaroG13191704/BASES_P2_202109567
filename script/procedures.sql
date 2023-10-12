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
        SET currentDate = GetDate();

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

-- 3.
DELIMITER $$
CREATE PROCEDURE registrarDocente(
    IN newNames VARCHAR(50),
    IN newLastName VARCHAR(50),
    IN newBirthDay DATE,
    IN newEmail VARCHAR(50),
    IN newPhone INTEGER,
    IN newAddress VARCHAR(50),
    IN newDpi BIGINT,
    IN newSIIF BIGINT
)
    BEGIN
        DECLARE is_email_valid BOOLEAN;
        DECLARE currentDate DATETIME;
        DECLARE is_new_docente BOOLEAN;
        -- evaluate if the docente is already created
        SET is_new_docente = IsNewDocente(newDpi);
        IF is_new_docente = TRUE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente ya existe en la base de datos.';
        END IF;

        -- Evaluate if the email is valid
        SET is_email_valid = IsEmailValid(newEmail);

        -- get current date
        SET currentDate = GetDate();

        -- Validate
        IF is_email_valid = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El email no es valido.';
        ELSE
            -- save
            INSERT INTO DOCENTE(
                nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, registro_siif, registro_creacion
                )  VALUES(
                newNames,newLastName,newBirthDay,newEmail,newPhone,newAddress,newDpi,newSIIF,currentDate
                );
        END IF;
    END;
    $$
DELIMITER ;
-- 4.
DELIMITER $$
CREATE PROCEDURE crearCurso(
    IN newCode INT,
    IN newName VARCHAR(50),
    IN newNecesarryCredits INTEGER,
    IN newGiveCredtis INTEGER,
    IN newMandatory BOOLEAN,
    IN newCarrera INTEGER
)
    BEGIN
        DECLARE positiveInteger1 BOOLEAN;
        DECLARE positiveInteger2 BOOLEAN;
        DECLARE new_id_carrera INTEGER;

        -- Get the id from "CARRERA" table
        SET new_id_carrera = GetCareer(newCarrera);

        -- Evaluate if credits are valid
        SET positiveInteger1 = IsPositiveIntegerOrZero(newNecesarryCredits);
        SET positiveInteger2 = IsPositiveIntegerOrZero(newGiveCredtis);

        IF positiveInteger1 = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Creditos necesarios no es un número positivo.';
        ELSEIF positiveInteger2 = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Creditos otorgads no es un número positivo.';
        ELSEIF new_id_carrera IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera no existe.';
        ELSE
            -- insert table
            INSERT INTO CURSO(
                codigo, nombre, creditos_necesarios, creditos_obligatorios, obligatorio, id_carrera
                ) VALUES (
                          newCode, newName, newNecesarryCredits, newGiveCredtis,newMandatory,new_id_carrera
               );
        END IF;
    END;
    $$
DELIMITER ;