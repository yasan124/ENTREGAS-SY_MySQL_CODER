USE fundacionev;


CREATE VIEW vista_auditoria_asistencias AS
SELECT 
    e.documento,
    e.nombre AS "Nombre Empleado",
    a.id_asistencia,
    a.fecha_hora_in AS "Ingreso",
    a.fecha_hora_out AS "Salida",
    a.tipo_asistencia AS "Asistencia",
    a.turno AS "Turno"
FROM empleados e
JOIN asistencias a ON e.documento = a.documento
ORDER BY a.fecha_hora_in DESC;

-- EJEMPLO:  SELECT * FROM vista_auditoria_asistencias;

--

CREATE VIEW vista_legajos_completos AS
SELECT 
e.documento,
e.nombre,
l.id_legajo,
p.puesto AS nombre_puesto,
s.sector AS nombre_sector,
l.fecha_alta,
l.fecha_baja,
l.antiguedad
FROM empleados e
JOIN legajos l ON e.documento = l.documento
JOIN puestos_trabajo p ON l.puesto = p.id_puesto
JOIN sectores s ON s.id_sector = p.sector
ORDER BY l.id_legajo;

-- EJEMPLO:  SELECT * FROM vista_legajos_completos;

--

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

--

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

--

DELIMITER //
CREATE PROCEDURE sp_consultar_asistencias_por_empleado(IN p_documento INT)
BEGIN
    SELECT 
		e.documento,
		e.nombre AS "Nombre Empleado",
		a.id_asistencia,
		a.fecha_hora_in AS "Ingreso",
		a.fecha_hora_out AS "Salida",
		a.tipo_asistencia AS "Asistencia",
		a.turno AS "Turno"
    FROM empleados e
    JOIN asistencias a ON e.documento = a.documento
    WHERE e.documento = p_documento
    ORDER BY a.fecha_hora_in DESC;
END;
//
DELIMITER ;

-- EJEMPLO: CALL sp_consultar_asistencias_por_empleado(20593143);

--

DELIMITER //
CREATE PROCEDURE sp_registrar_asistencia(
    IN p_documento INT,
    IN p_ingreso DATETIME,
    IN p_salida DATETIME,
    IN p_tipo_asistencia VARCHAR(50),
    IN p_turno ENUM('mañana','tarde','noche')
)
BEGIN
    IF p_salida > p_ingreso THEN
		IF DATE(p_ingreso) = DATE(p_salida) THEN
			INSERT INTO asistencias (documento, fecha_hora_in, fecha_hora_out, tipo_asistencia, turno)
			VALUES (p_documento, p_ingreso, p_salida, p_tipo_asistencia, p_turno);
		ELSE
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'La fecha de ingreso y salida deben ser el mismo día.';
		END IF;
	ELSE 
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'La hora de salida debe ser posterior a la hora de ingreso';
	END IF;
END //
DELIMITER ;

-- EJEMPLO:  CALL sp_registrar_asistencia(30765387, '2025-04-23 07:30:00', '2025-04-23 16:30:00', 'Normal', 'mañana');

--

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

--

DELIMITER //
CREATE TRIGGER trg_calcular_antiguedad
BEFORE INSERT ON legajos
FOR EACH ROW
BEGIN
    SET NEW.antiguedad = TIMESTAMPDIFF(YEAR, NEW.fecha_alta, CURDATE());
END;
//
DELIMITER ;