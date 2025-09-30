create database dataMart;

CREATE TABLE dim_categoria_producto (
    id_categoria SERIAL PRIMARY KEY,
    desc_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE dim_producto (
    id_producto SERIAL PRIMARY KEY,
    codigo_producto VARCHAR(15) NOT NULL,
    nombre VARCHAR(70) NOT NULL
);


CREATE TABLE dim_tiempo (
    id_tiempo SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    anio INT NOT NULL
);

CREATE TABLE fact_actividad_negocio (
    id_fact SERIAL PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_producto INT NOT NULL,
    id_tiempo INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    monto_total NUMERIC(10,2),
    FOREIGN KEY (id_categoria) REFERENCES dim_categoria_producto (id_categoria),
    FOREIGN KEY (id_producto) REFERENCES dim_producto (id_producto),
    FOREIGN KEY (id_tiempo) REFERENCES dim_tiempo (id_tiempo)
);




CREATE EXTENSION IF NOT EXISTS dblink;

INSERT INTO dim_categoria_producto (desc_categoria)
SELECT desc_categoria
FROM dblink('dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
            'SELECT desc_categoria FROM categoria_producto')
AS t(desc_categoria VARCHAR(50));

INSERT INTO dim_producto (codigo_producto, nombre)
SELECT id_producto, nombre
FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        'SELECT id_producto, nombre FROM producto'
) AS t(id_producto VARCHAR(15), nombre VARCHAR(70));


-- Insertar fechas únicas desde staging
INSERT INTO dim_tiempo (fecha, anio)
SELECT DISTINCT fecha_pedido AS fecha,
       EXTRACT(YEAR FROM fecha_pedido)::INT AS anio
FROM dblink('dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
            'SELECT fecha_pedido FROM pedido')
AS t(fecha_pedido DATE)
ORDER BY fecha;


SELECT 'dim_categoria_producto' AS dimension, COUNT(*) AS registros FROM dim_categoria_producto
UNION ALL
SELECT 'dim_producto', COUNT(*) FROM dim_producto
UNION ALL
SELECT 'dim_tiempo', COUNT(*) FROM dim_tiempo;

INSERT INTO fact_actividad_negocio (id_categoria, id_producto, id_tiempo, cantidad_vendida, monto_total)
SELECT 
    dc.id_categoria,                                 
    dp.id_producto,                                  
    dt.id_tiempo,                                    
    src.cantidad,                                    
    (src.cantidad * src.precio_unidad)::NUMERIC(10,2) AS monto_total
FROM dblink(
        'dbname=stagingarea user=postgres password=Manuel2309lm6 host=localhost',
        $$
        SELECT det.id_producto,
               det.cantidad,
               det.precio_unidad,
               ped.fecha_pedido,
               prod.id_categoria,        
               c.desc_categoria
        FROM detalle_pedido det
        JOIN pedido ped ON ped.id_pedido = det.id_pedido
        JOIN producto prod ON prod.id_producto = det.id_producto
        JOIN categoria_producto c ON c.id_categoria = prod.id_categoria
        $$
) AS src(
        id_producto VARCHAR(15),
        cantidad INT,
        precio_unidad NUMERIC(15,2),
        fecha_pedido DATE,
        id_categoria INT,
        desc_categoria VARCHAR(50)
)
JOIN dim_producto dp ON dp.codigo_producto = src.id_producto
JOIN dim_categoria_producto dc ON dc.desc_categoria = src.desc_categoria
JOIN dim_tiempo dt ON dt.fecha = src.fecha_pedido;

SELECT dp.nombre AS producto,
       SUM(f.cantidad_vendida) AS total_vendido
FROM fact_actividad_negocio f
JOIN dim_producto dp ON dp.id_producto = f.id_producto
GROUP BY dp.nombre
ORDER BY total_vendido DESC
LIMIT 1;


SELECT dc.desc_categoria,
       COUNT(dp.id_producto) AS total_productos
FROM dim_categoria_producto dc
JOIN fact_actividad_negocio f ON f.id_categoria = dc.id_categoria
JOIN dim_producto dp ON dp.id_producto = f.id_producto
GROUP BY dc.desc_categoria
ORDER BY total_productos DESC
LIMIT 1;


SELECT dt.anio,
       SUM(f.monto_total) AS ventas_totales
FROM fact_actividad_negocio f
JOIN dim_tiempo dt ON dt.id_tiempo = f.id_tiempo
GROUP BY dt.anio
ORDER BY ventas_totales DESC
LIMIT 1;
