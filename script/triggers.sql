-- -- Triggers

-- ESTUDIANTE
DELIMITER  $$
CREATE TRIGGER INSERT_ESTUDIANTE
    AFTER INSERT  ON ESTUDIANTE
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "ESTUDIANTE"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_ESTUDIANTE
    AFTER UPDATE  ON ESTUDIANTE
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "ESTUDIANTE"', 'UPDATE');
    END;
$$
DELIMITER ;

-- CARRERA
DELIMITER  $$
CREATE TRIGGER INSERT_CARRERA
    AFTER INSERT  ON CARRERA
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "CARRERA"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_CARRERA
    AFTER UPDATE  ON CARRERA
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "CARRERA"', 'UPDATE');
    END;
$$
DELIMITER ;

-- DOCENTE
DELIMITER  $$
CREATE TRIGGER INSERT_DOCENTE
    AFTER INSERT  ON DOCENTE
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "DOCENTE"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_DOCENTE
    AFTER UPDATE  ON DOCENTE
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "DOCENTE"', 'UPDATE');
    END;
$$
DELIMITER ;

-- CURSO
DELIMITER  $$
CREATE TRIGGER INSERT_CURSO
    AFTER INSERT  ON CURSO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "CURSO"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_CURSO
    AFTER UPDATE  ON CURSO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "CURSO"', 'UPDATE');
    END;
$$
DELIMITER ;

-- CURSO_HABILITADO
DELIMITER  $$
CREATE TRIGGER INSERT_CURSO_HABILITADO
    AFTER INSERT  ON CURSO_HABILITADO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "CURSO_HABILITADO"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_CURSO_HABILITADO
    AFTER UPDATE  ON CURSO_HABILITADO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "CURSO_HABILITADO"', 'UPDATE');
    END;
$$
DELIMITER ;

-- HORARIO
DELIMITER  $$
CREATE TRIGGER INSERT_HORARIO
    AFTER INSERT  ON HORARIO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "HORARIO"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_HORARIO
    AFTER UPDATE  ON HORARIO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "HORARIO"', 'UPDATE');
    END;
$$
DELIMITER ;

-- DETALLE_CURSO_HABILITADO
DELIMITER  $$
CREATE TRIGGER INSERT_DETALLE_CURSO_HABILITADO
    AFTER INSERT  ON DETALLE_CURSO_HABILITADO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "DETALLE_CURSO_HABILITADO"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_DETALLE_CURSO_HABILITADO
    AFTER UPDATE  ON DETALLE_CURSO_HABILITADO
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "DETALLE_CURSO_HABILITADO"', 'UPDATE');
    END;
$$
DELIMITER ;

-- ASIGNACION
DELIMITER  $$
CREATE TRIGGER INSERT_ASIGNACION
    AFTER INSERT  ON ASIGNACION
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "ASIGNACION"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_ASIGNACION
    AFTER UPDATE  ON ASIGNACION
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "ASIGNACION"', 'UPDATE');
    END;
$$
DELIMITER ;
-- NOTA
DELIMITER  $$
CREATE TRIGGER INSERT_NOTA
    AFTER INSERT  ON NOTA
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "NOTA"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_NOTA
    AFTER UPDATE  ON NOTA
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "NOTA"', 'UPDATE');
    END;
$$
DELIMITER ;
-- ACTA
DELIMITER  $$
CREATE TRIGGER INSERT_ACTA
    AFTER INSERT  ON ACTA
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "ACTA"', 'INSERT');
    END;
$$
DELIMITER ;
DELIMITER  $$
CREATE TRIGGER UPDATE_ACTA
    AFTER UPDATE  ON ACTA
    FOR EACH ROW
    BEGIN
        CALL InsertTransaccion('Se ha realizado una acción en la tabla "ACTA"', 'UPDATE');
    END;
$$
DELIMITER ;