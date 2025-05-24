USE fundacionev;

-- Objetivo: Calcular años de antigüedad a partir de la fecha de alta.
-- Tabla: legajos.

DELIMITER //
CREATE FUNCTION fx_antiguedad(FechaDeAlta DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = TIMESTAMPDIFF(YEAR, FechaDeAlta, CURDATE());
    RETURN resultado;
END //
DELIMITER ;

-- EJEMPLO: SELECT id_legajo, fecha_alta, antiguedad, fx_antiguedad(fecha_alta) AS antiguedad FROM legajos;