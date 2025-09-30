-- =======================================
-- PRUEBAS DE CALIDAD DE DATOS - ADAPTADAS
-- =======================================

-- 1. Completitud en dim_tiempo
SELECT COUNT(*) FROM dim_tiempo WHERE id_tiempo IS NULL;
SELECT COUNT(*) FROM dim_tiempo WHERE fecha IS NULL;
SELECT COUNT(*) FROM dim_tiempo WHERE anio IS NULL;

-- 2. Completitud en dim_producto
SELECT COUNT(*) FROM dim_producto WHERE id_producto IS NULL;
SELECT COUNT(*) FROM dim_producto WHERE codigo_producto IS NULL;
SELECT COUNT(*) FROM dim_producto WHERE nombre IS NULL;

-- 3. Completitud en dim_categoria_producto
SELECT COUNT(*) FROM dim_categoria_producto WHERE id_categoria IS NULL;
SELECT COUNT(*) FROM dim_categoria_producto WHERE desc_categoria IS NULL;

-- 4. Completitud en fact_actividad_negocio
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_fact IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_categoria IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_producto IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_tiempo IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE cantidad_vendida IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE monto_total IS NULL;

-- 5. Unicidad en dim_producto
SELECT codigo_producto, COUNT(*) 
FROM dim_producto 
GROUP BY codigo_producto 
HAVING COUNT(*) > 1;

-- 6. Unicidad en dim_categoria_producto
SELECT desc_categoria, COUNT(*) 
FROM dim_categoria_producto 
GROUP BY desc_categoria 
HAVING COUNT(*) > 1;

-- 7. Unicidad en tabla de hechos
SELECT id_fact, COUNT(*) 
FROM fact_actividad_negocio 
GROUP BY id_fact 
HAVING COUNT(*) > 1;

-- 8. Rango de valores en dim_producto
SELECT * FROM dim_producto 
WHERE LENGTH(codigo_producto) < 1 OR LENGTH(codigo_producto) > 15;

SELECT * FROM dim_producto 
WHERE LENGTH(nombre) < 1 OR LENGTH(nombre) > 70;

-- 9. Rango de valores en dim_categoria_producto
SELECT * FROM dim_categoria_producto 
WHERE LENGTH(desc_categoria) < 1 OR LENGTH(desc_categoria) > 50;
