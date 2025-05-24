USE fundacionev;

-- Objetivo: Registrar automáticamente un nuevo legajo cuando se inserta un nuevo empleado en la tabla empleados.
-- Tabla: empleados, legajos.

DELIMITER //
CREATE TRIGGER trg_insertar_legajo
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO legajos (documento, fecha_alta, puesto)
    VALUES (NEW.documento, NOW(), 10);
END;
//
DELIMITER ;