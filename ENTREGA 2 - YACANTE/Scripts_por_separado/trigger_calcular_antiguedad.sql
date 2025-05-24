USE fundacionev;

-- Objetivo: Calcular la antigüedad automáticamente al generar un legajo nuevo de empleado.
-- Tabla: legajos.

DELIMITER //
CREATE TRIGGER trg_calcular_antiguedad
BEFORE INSERT ON legajos
FOR EACH ROW
BEGIN
    SET NEW.antiguedad = TIMESTAMPDIFF(YEAR, NEW.fecha_alta, CURDATE());
END;
//
DELIMITER ;	