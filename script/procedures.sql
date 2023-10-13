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

-- 5.
DELIMITER $$
CREATE PROCEDURE habilitarCurso(
    IN newCodeCurso INT,
    IN newCicle VARCHAR(2),
    IN newDocente INTEGER,
    IN newMaxCupo INTEGER,
    IN newSeccion CHAR(1)
)
    BEGIN
        DECLARE valid_max_cupo BOOLEAN;
        DECLARE curso_id INTEGER;
        DECLARE ciclo_id INTEGER;
        DECLARE docente_id INTEGER;
        DECLARE seccion_id INTEGER;
        DECLARE dateCreation DATE;

        -- set values
        SET curso_id = GetCurso(newCodeCurso);
        SET ciclo_id = GetCiclo(newCicle);
        SET docente_id = GetDocente(newDocente);
        SET valid_max_cupo = IsPositiveIntegerOrZero(newMaxCupo);
        SET seccion_id = GetOrInsertSeccion(UPPER(newSeccion));
        SET dateCreation = GetDate();

        -- add if's
        IF curso_id IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
        ELSEIF ciclo_id IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ciclo ingresado no existe';
        ELSEIF  docente_id IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL docente no existe';
        ELSEIF valid_max_cupo = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL cupo máximo no es un entero positivo';
        ELSE
            -- insert
            INSERT INTO CURSO_HABILITADO (cupo_maximo, cantidad_asignados, fecha, id_curso, id_docente, id_ciclo, id_seccion)
                VALUES (
                newMaxCupo,0,dateCreation,curso_id,docente_id,ciclo_id,seccion_id
                );
        END IF;
    END;
    $$
DELIMITER ;

-- 6.
DELIMITER $$
CREATE PROCEDURE agregarHorario(
    IN new_id_curso_habilitado INTEGER,
    IN new_day INTEGER,
    in new_schedule VARCHAR(30)
)
    BEGIN
        -- declare
        DECLARE is_valid_day BOOLEAN;
        DECLARE curso_habilitado_id INTEGER;
        DECLARE horario_id INTEGER;
        -- set
        SET curso_habilitado_id = GetCursoHabilitado(new_id_curso_habilitado);
        set is_valid_day = IsDayInRange(new_day);
        -- validate
        IF curso_habilitado_id IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso habilitado no existe.';
        ELSEIF is_valid_day = FALSE THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El día esta fuera de rango.';
        ELSE
            -- Insert horario
            SET horario_id = InsertHorario(new_day,new_schedule);
            -- insert in "DETALLE HORARIO"
            INSERT INTO DETALLE_CURSO_HABILITADO (id_horario, id_curso_habilitado)
                VALUES (horario_id, curso_habilitado_id );
        END IF;
    END;
    $$
DELIMITER ;