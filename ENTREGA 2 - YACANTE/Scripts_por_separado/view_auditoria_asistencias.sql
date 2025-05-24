USE fundacionev;

-- Objetivo: Mostrar una tabla de auditoria para controlar los ingresos y salidas de los empleados.
-- Tablas: empleados, asistencias.

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