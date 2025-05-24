USE fundacionev;

-- Objetivo: Filtrar las asistencias por empleado, a partir de su documento, como si fuera una vista con parámetro.
-- Tablas: empleados, asistencias.

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