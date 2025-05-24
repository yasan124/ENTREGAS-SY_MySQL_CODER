USE fundacionev;

-- Objetivo: Mostrar información consolidada del empleado junto a su legajo, puesto y sector.
-- Tablas: empleados, legajos, puestos_trabajo, sectores.

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