create database stagingarea;
select * from producto



CREATE TABLE oficina (
  id_oficina SERIAL PRIMARY KEY, 
  descripcion VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50),
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50)
);

CREATE TABLE empleado (
  id_empleado SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  puesto VARCHAR(50)
);

CREATE TABLE categoria_producto (
  id_categoria SERIAL PRIMARY KEY,
  desc_categoria VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256)
);

CREATE TABLE cliente (
  id_cliente SERIAL PRIMARY KEY,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30),
  apellido_contacto VARCHAR(30),
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50),
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50),
  pais VARCHAR(50),
  codigo_postal VARCHAR(10),
  limite_credito NUMERIC(15,2)
);

CREATE TABLE pedido (
  id_pedido SERIAL PRIMARY KEY,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT
);

CREATE TABLE producto (
  id_producto VARCHAR(15) PRIMARY KEY,
  nombre VARCHAR(70) NOT NULL,
  dimensiones VARCHAR(25),
  proveedor VARCHAR(50),
  descripcion TEXT,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2),
  id_categoria INT 
);


CREATE TABLE detalle_pedido (
  id_pedido INT NOT NULL,
  id_producto VARCHAR(15) NOT NULL,
  cantidad INT NOT NULL,
  precio_unidad NUMERIC(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  PRIMARY KEY (id_pedido, id_producto)
);

CREATE TABLE pago (
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) PRIMARY KEY,
  fecha_pago DATE NOT NULL,
  total NUMERIC(15,2) NOT NULL
);




CREATE EXTENSION IF NOT EXISTS dblink;

INSERT INTO oficina
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT id_oficina, descripcion, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2 FROM public.oficina')
AS t(id_oficina int, descripcion varchar(10), ciudad varchar(30), pais varchar(50), region varchar(50), codigo_postal varchar(10),
      telefono varchar(20), linea_direccion1 varchar(50), linea_direccion2 varchar(50));

INSERT INTO empleado
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT id_empleado, nombre, apellido1, apellido2, extension, email, puesto FROM public.empleado')
AS t(id_empleado int, nombre varchar(50), apellido1 varchar(50), apellido2 varchar(50),
      extension varchar(10), email varchar(100), puesto varchar(50));

INSERT INTO categoria_producto
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT id_categoria, desc_categoria, descripcion_texto, descripcion_html, imagen FROM public.categoria_producto')
AS t(id_categoria int, desc_categoria varchar(50), descripcion_texto text, descripcion_html text, imagen varchar(256));

INSERT INTO cliente
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT id_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, limite_credito FROM public.cliente')
AS t(id_cliente int, nombre_cliente varchar(50), nombre_contacto varchar(30), apellido_contacto varchar(30),
     telefono varchar(15), fax varchar(15), linea_direccion1 varchar(50), linea_direccion2 varchar(50),
     ciudad varchar(50), region varchar(50), pais varchar(50), codigo_postal varchar(10), limite_credito numeric(15,2));

INSERT INTO pedido
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT id_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios FROM public.pedido')
AS t(id_pedido int, fecha_pedido date, fecha_esperada date, fecha_entrega date, estado varchar(15), comentarios text);

INSERT INTO producto (
    id_producto,
    nombre,
    dimensiones,
    proveedor,
    descripcion,
    cantidad_en_stock,
    precio_venta,
    precio_proveedor,
    id_categoria
)
SELECT id_producto,
       nombre,
       dimensiones,
       proveedor,
       descripcion,
       cantidad_en_stock,
       precio_venta,
       precio_proveedor,
       categoria  
FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6 host=localhost',
            'SELECT id_producto,
                    nombre,
                    dimensiones,
                    proveedor,
                    descripcion,
                    cantidad_en_stock,
                    precio_venta,
                    precio_proveedor,
                    categoria
             FROM producto')
AS t(id_producto VARCHAR(15),
     nombre VARCHAR(70),
     dimensiones VARCHAR(25),
     proveedor VARCHAR(50),
     descripcion TEXT,
     cantidad_en_stock SMALLINT,
     precio_venta NUMERIC(15,2),
     precio_proveedor NUMERIC(15,2),
     categoria INT);  




INSERT INTO detalle_pedido
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT id_pedido, id_producto, cantidad, precio_unidad, numero_linea FROM public.detalle_pedido')
AS t(id_pedido int, id_producto varchar(15), cantidad int, precio_unidad numeric(15,2), numero_linea smallint);

INSERT INTO pago
SELECT * FROM dblink('dbname=db_jardineria1 user=postgres password=Manuel2309lm6',
  'SELECT forma_pago, id_transaccion, fecha_pago, total FROM public.pago')
AS t(forma_pago varchar(40), id_transaccion varchar(50), fecha_pago date, total numeric(15,2));


SELECT 'oficina' AS tabla, COUNT(*) AS registros FROM oficina
UNION ALL
SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL
SELECT 'categoria_producto', COUNT(*) FROM categoria_producto
UNION ALL
SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL
SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL
SELECT 'producto', COUNT(*) FROM producto
UNION ALL
SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido
UNION ALL
SELECT 'pago', COUNT(*) FROM pago;