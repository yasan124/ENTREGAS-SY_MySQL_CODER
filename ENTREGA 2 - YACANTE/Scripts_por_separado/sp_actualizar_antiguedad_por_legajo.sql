USE fundacionev;

-- Objetivo: Actualizar la antiguedad por empleado, a partir de su legajo.
-- Tablas: legajos.

DELIMITER //
CREATE PROCEDURE sp_actualizar_antiguedad_por_legajo(IN p_id_legajo INT)
BEGIN
    UPDATE legajos
    SET antiguedad = fx_antiguedad(fecha_alta)
    WHERE id_legajo = p_id_legajo;
END;
//
DELIMITER ;

-- CALL sp_actualizar_antiguedad_por_legajo(1);