USE fundacionev;

-- Objetivo: Insertar una nueva asistencia controlando que Fecha de Salida (fecha_hora_out) sea posterior a Fecha de Ingreso (fecha_hora_in).
-- Tabla: asistencias.

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