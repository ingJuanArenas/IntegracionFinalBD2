-- Calidad de datos

-- Calidad de completitud en dim_tiempo
SELECT COUNT(*) FROM dim_tiempo WHERE id_tiempo IS NULL;
SELECT COUNT(*) FROM dim_tiempo WHERE fecha IS NULL;
SELECT COUNT(*) FROM dim_tiempo WHERE anio IS NULL;

-- Calidad de completitud en dim_producto
SELECT COUNT(*) FROM dim_producto WHERE id_producto IS NULL;
SELECT COUNT(*) FROM dim_producto WHERE nombre IS NULL;

-- Calidad de completitud en dim_categoria_producto
SELECT COUNT(*) FROM dim_categoria_producto WHERE id_categoria IS NULL;
SELECT COUNT(*) FROM dim_categoria_producto WHERE desc_categoria IS NULL;

-- Calidad de completitud en la tabla hechos
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_fact IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_producto IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE id_tiempo IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE cantidad_vendida IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE precio_unitario IS NULL;
SELECT COUNT(*) FROM fact_actividad_negocio WHERE monto_total IS NULL;

-- Calidad de unicidad en dim_producto
SELECT id_producto, COUNT(*) FROM dim_producto GROUP BY id_producto HAVING COUNT(*) > 1;

-- Calidad de unicidad en dim_categoria_producto
SELECT id_categoria, COUNT(*) FROM dim_categoria_producto GROUP BY id_categoria HAVING COUNT(*) > 1;

-- Calidad de unicidad en tabla hechos
SELECT id_fact, COUNT(*) FROM fact_actividad_negocio GROUP BY id_fact HAVING COUNT(*) > 1;

-- Calidad de rangos en dim_productos
SELECT * FROM dim_producto WHERE LENGTH(id_producto) < 0 OR LENGTH(id_producto) > (15);
SELECT * FROM dim_producto WHERE LENGTH(nombre) < 0 OR LENGTH(nombre) > (70);

-- Calidad de rangos en dim_categoria_producto
SELECT * FROM dim_categoria_producto WHERE LENGTH(desc_categoria) < 0 OR LENGTH(desc_categoria) > (50);

-- Calidad de rangos en tabla hechos
SELECT * FROM fact_actividad_negocio WHERE LENGTH(id_producto) < 0 OR LENGTH(id_producto) > (15);