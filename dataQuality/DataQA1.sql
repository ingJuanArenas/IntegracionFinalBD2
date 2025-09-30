

-- Productos
SELECT 
    (SELECT COUNT(*) FROM dim_producto) AS productos_datamart,
    (SELECT c FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT COUNT(*) FROM producto'
    ) AS t(c BIGINT)) AS productos_staging;

-- Categorías
SELECT 
    (SELECT COUNT(*) FROM dim_categoria_producto) AS categorias_datamart,
    (SELECT c FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT COUNT(*) FROM categoria_producto'
    ) AS t(c BIGINT)) AS categorias_staging;

-- Tiempo (pedidos)
SELECT 
    (SELECT COUNT(*) FROM dim_tiempo) AS tiempo_datamart,
    (SELECT COUNT(DISTINCT fecha_pedido) FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT fecha_pedido FROM pedido'
    ) AS t(fecha_pedido DATE)) AS tiempo_staging;

-- Hechos: detalle de pedidos / actividad negocio
SELECT 
    (SELECT COUNT(*) FROM fact_actividad_negocio) AS hechos_datamart,
    (SELECT c FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT COUNT(*) FROM detalle_pedido'
    ) AS t(c BIGINT)) AS hechos_staging;

-- Comparar suma de cantidades
SELECT 
    (SELECT SUM(cantidad_vendida) FROM fact_actividad_negocio) AS total_cantidades_datamart,
    (SELECT s FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT SUM(cantidad) FROM detalle_pedido'
    ) AS t(s BIGINT)) AS total_cantidades_staging;

-- Comparar suma de ventas
SELECT 
    (SELECT SUM(monto_total) FROM fact_actividad_negocio) AS total_ventas_datamart,
    (SELECT s FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT SUM(cantidad * precio_unidad) FROM detalle_pedido'
    ) AS t(s NUMERIC)) AS total_ventas_staging;



-- 1. Conteo de registros por dimensión y hechos
SELECT 'dim_categoria_producto' AS tabla, COUNT(*) AS registros FROM dim_categoria_producto
UNION ALL
SELECT 'dim_producto', COUNT(*) FROM dim_producto
UNION ALL
SELECT 'dim_tiempo', COUNT(*) FROM dim_tiempo
UNION ALL
SELECT 'fact_actividad_negocio', COUNT(*) FROM fact_actividad_negocio;

-- 2. Validar que las sumas coincidan con staging
SELECT SUM(cantidad_vendida) AS total_unidades,
       SUM(monto_total) AS total_ventas
FROM fact_actividad_negocio;

-- 3. Verificar duplicados en dimensiones
SELECT codigo_producto, COUNT(*) AS veces
FROM dim_producto
GROUP BY codigo_producto
HAVING COUNT(*) > 1;

SELECT desc_categoria, COUNT(*) AS veces
FROM dim_categoria_producto
GROUP BY desc_categoria
HAVING COUNT(*) > 1;

SELECT fecha, COUNT(*) AS veces
FROM dim_tiempo
GROUP BY fecha
HAVING COUNT(*) > 1;

-- 4. Validar integridad referencial en tabla de hechos
SELECT COUNT(*) AS errores_categoria
FROM fact_actividad_negocio f
LEFT JOIN dim_categoria_producto c ON f.id_categoria = c.id_categoria
WHERE c.id_categoria IS NULL;

SELECT COUNT(*) AS errores_producto
FROM fact_actividad_negocio f
LEFT JOIN dim_producto p ON f.id_producto = p.id_producto
WHERE p.id_producto IS NULL;

SELECT COUNT(*) AS errores_tiempo
FROM fact_actividad_negocio f
LEFT JOIN dim_tiempo t ON f.id_tiempo = t.id_tiempo
WHERE t.id_tiempo IS NULL;

-- 5. Verificar valores nulos
SELECT COUNT(*) AS nulos_en_fact
FROM fact_actividad_negocio
WHERE id_categoria IS NULL
   OR id_producto IS NULL
   OR id_tiempo IS NULL
   OR cantidad_vendida IS NULL
   OR monto_total IS NULL;

-- 6. Validar rango de fechas 
SELECT MIN(anio) AS anio_minimo, MAX(anio) AS anio_maximo
FROM dim_tiempo;
