CREATE DATABASE db_jardineria1;

-- Tablas
SELECT * FROM oficina;

SELECT * FROM empleado;

SELECT * FROM categoria_producto;

SELECT * FROM cliente;

SELECT * FROM pedido;

SELECT * FROM producto;

SELECT * FROM detalle_pedido;

SELECT * FROM pago;

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
  id_oficina INT NOT NULL,
  id_jefe INT,
  puesto VARCHAR(50),
  FOREIGN KEY (id_oficina) REFERENCES oficina (id_oficina),
  FOREIGN KEY (id_jefe) REFERENCES empleado (id_empleado)
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
  id_empleado_rep_ventas INT,
  limite_credito NUMERIC(15,2),
  FOREIGN KEY (id_empleado_rep_ventas) REFERENCES empleado (id_empleado)
);

CREATE TABLE pedido (
  id_pedido SERIAL PRIMARY KEY,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT,
  id_cliente INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

CREATE TABLE producto (
  id_producto VARCHAR(15) PRIMARY KEY,
  nombre VARCHAR(70) NOT NULL,
  categoria INT NOT NULL,
  dimensiones VARCHAR(25),
  proveedor VARCHAR(50),
  descripcion TEXT,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2),
  FOREIGN KEY (categoria) REFERENCES categoria_producto (id_categoria)
);

CREATE TABLE detalle_pedido (
  id_pedido INT NOT NULL,
  id_producto VARCHAR(15) NOT NULL,
  cantidad INT NOT NULL,
  precio_unidad NUMERIC(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
  FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE pago (
  id_cliente INT NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago DATE NOT NULL,
  total NUMERIC(15,2) NOT NULL,
  PRIMARY KEY (id_cliente, id_transaccion),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


INSERT INTO oficina (descripcion, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
VALUES 
('BCN-ES','Barcelona','España','Barcelona','08019','+34 93 3561182','Avenida Diagonal, 38','3A escalera Derecha'),
('BOS-USA','Boston','EEUU','MA','02108','+1 215 837 0825','1550 Court Place','Suite 102'),
('LON-UK','Londres','Inglaterra','EMEA','EC2N 1HN','+44 20 78772041','52 Old Broad Street','Ground Floor'),
('MAD-ES','Madrid','España','Madrid','28032','+34 91 7514487','Bulevar Indalecio Prieto, 32',''),
('PAR-FR','Paris','Francia','EMEA','75017','+33 14 723 4404','29 Rue Jouffroy d''Abbans',''),
('SFC-USA','San Francisco','EEUU','CA','94080','+1 650 219 4782','100 Market Street','Suite 300'),
('SYD-AU','Sydney','Australia','APAC','NSW 2010','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2'),
('TAL-ES','Talavera de la Reina','España','Castilla-La Mancha','45632','+34 925 867231','Francisco Aguirre, 32','5º piso (exterior)'),
('TOK-JP','Tokyo','Japón','Chiyoda-Ku','102-8578','+81 33 224 5000','4-1 Kioicho','');


SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'empleado';

INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, id_oficina, id_jefe, puesto) VALUES
('Ruben','López','Martinez','2899','rlopez@jardineria.es',8,NULL,'Subdirector Marketing'),
('Alberto','Soria','Carrasco','2837','asoria@jardineria.es',8,NULL,'Subdirector Ventas'),
('Maria','Solís','Jerez','2847','msolis@jardineria.es',8,NULL,'Secretaria'),
('Felipe','Rosas','Marquez','2844','frosas@jardineria.es',8,NULL,'Representante Ventas'),
('Juan Carlos','Ortiz','Serrano','2845','cortiz@jardineria.es',8,NULL,'Representante Ventas'),
('Carlos','Soria','Jimenez','2444','csoria@jardineria.es',4,NULL,'Director Oficina'),
('Mariano','López','Murcia','2442','mlopez@jardineria.es',4,NULL,'Representante Ventas'),
('Lucio','Campoamor','Martín','2442','lcampoamor@jardineria.es',4,NULL,'Representante Ventas'),
('Hilario','Rodriguez','Huertas','2444','hrodriguez@jardineria.es',4,NULL,'Representante Ventas'),
('Emmanuel','Magaña','Perez','2518','manu@jardineria.es',1,NULL,'Director Oficina'),
('José Manuel','Martinez','De la Osa','2519','jmmart@hotmail.es',1,NULL,'Representante Ventas'),
('David','Palma','Aceituno','2519','dpalma@jardineria.es',1,NULL,'Representante Ventas'),
('Oscar','Palma','Aceituno','2519','opalma@jardineria.es',1,NULL,'Representante Ventas'),
('Francois','Fignon','', '9981','ffignon@gardening.com',5,NULL,'Director Oficina'),
('Lionel','Narvaez','', '9982','lnarvaez@gardening.com',5,NULL,'Representante Ventas'),
('Laurent','Serra','', '9982','lserra@gardening.com',5,NULL,'Representante Ventas'),
('Michael','Bolton','', '7454','mbolton@gardening.com',6,NULL,'Director Oficina'),
('Walter Santiago','Sanchez','Lopez','7454','wssanchez@gardening.com',6,NULL,'Representante Ventas'),
('Hilary','Washington','', '7565','hwashington@gardening.com',2,NULL,'Director Oficina'),
('Marcus','Paxton','', '7565','mpaxton@gardening.com',2,NULL,'Representante Ventas'),
('Lorena','Paxton','', '7665','lpaxton@gardening.com',2,NULL,'Representante Ventas'),
('Nei','Nishikori','', '8734','nnishikori@gardening.com',9,NULL,'Director Oficina'),
('Narumi','Riko','', '8734','nriko@gardening.com',9,NULL,'Representante Ventas'),
('Takuma','Nomura','', '8735','tnomura@gardening.com',9,NULL,'Representante Ventas'),
('Amy','Johnson','', '3321','ajohnson@gardening.com',3,NULL,'Director Oficina'),
('Larry','Westfalls','', '3322','lwestfalls@gardening.com',3,NULL,'Representante Ventas'),
('John','Walton','', '3322','jwalton@gardening.com',3,NULL,'Representante Ventas'),
('Kevin','Fallmer','', '3210','kfalmer@gardening.com',7,NULL,'Director Oficina'),
('Julian','Bellinelli','', '3211','jbellinelli@gardening.com',7,NULL,'Representante Ventas'),
('Mariko','Kishi','', '3211','mkishi@gardening.com',7,NULL,'Representante Ventas');


INSERT INTO categoria_producto (desc_categoria, descripcion_texto, descripcion_html, imagen) VALUES
('Herbaceas','Plantas para jardín decorativas',NULL,NULL),
('Herramientas','Herramientas para todo tipo de acción',NULL,NULL),
('Aromáticas','Plantas aromáticas',NULL,NULL),
('Frutales','Árboles pequeños de producción frutal',NULL,NULL),
('Ornamentales','Plantas vistosas para la decoración del jardín',NULL,NULL);

INSERT INTO cliente 
(nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, id_empleado_rep_ventas, limite_credito)
VALUES
('GoldFish Garden','Daniel','G','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',NULL,19.30),
('Gardening Associates','Anne','Wright','5557410345','5557410346','Wall-e Avenue',NULL,'Miami','Miami','USA','24010',NULL,19.60),
('Gerudo Valley','Link','Flaute','5552323129','5552323128','Oaks Avenue nº22',NULL,'New York',NULL,'USA','85495',NULL,22.12),
('Tendo Garden','Akane','Tendo','55591233210','55591233211','Null Street nº69',NULL,'Miami',NULL,'USA','696969',NULL,22.60),
('Lasas S.A.','Antonio','Lasas','34916540145','34914851312','C/Leganes 15',NULL,'Fuenlabrada','Madrid','Spain','28945',NULL,8.15),
('Beragua','Jose','Bermejo','654987321','916549872','C/pintor segundo',NULL,'Getafe','Madrid','Spain','28942',NULL,11.20),
('Club Golf Puerta del hierro','Paco','Lopez','62456810','919535678','C/sinesio delgado',NULL,'Madrid','Madrid','Spain','28930',NULL,11.40),
('Naturagua','Guillermo','Rengifo','689234750','916428956','C/majadahonda',NULL,'Boadilla','Madrid','Spain','28947',NULL,11.32),
('DaraDistribuciones','David','Serrano','675598001','916421756','C/azores',NULL,'Fuenlabrada','Madrid','Spain','28946',NULL,11.50),
('Madrileña de riegos','Jose','Tacaño','655983045','916689215','C/Lagañas',NULL,'Fuenlabrada','Madrid','Spain','28943',NULL,11.20),
('Camunas Jardines S.L.','Pedro','Camunas','34914873241','34914871541','C/Virgenes 45','C/Princesas 2 1ºB','San Lorenzo del Escorial','Madrid','Spain','28145',NULL,8.16),
('Dardena S.A.','Juan','Rodriguez','34912453217','34912484764','C/Nueva York 74',NULL,'Madrid','Madrid','Spain','28003',NULL,8.32),
('Jardin de Flores','Javier','Villar','654865643','914538776','C/Oña 34',NULL,'Madrid','Madrid','Spain','28950',NULL,30.40),
('Flores Marivi','Maria','Rodriguez','666555444','912458657','C/Leganes24',NULL,'Fuenlabrada','Madrid','Spain','28945',NULL,5.15),
('Flowers, S.A','Beatriz','Fernandez','698754159','978453216','C/Luis Salquillo4',NULL,'Montornes del valles','Barcelona','Spain','24586',NULL,5.35),
('Naturajardin','Victoria','Cruz','612343529','916548735','Plaza Magallón 15',NULL,'Madrid','Madrid','Spain','28011',NULL,30.50),
('Golf S.A.','Luis','Martinez','916458762','912354475','C/Estancado',NULL,'Santa cruz de Tenerife','Islas Canarias','Spain','38297',NULL,12.30),
('Americh Golf Management SL','Mario','Suarez','964493072','964493063','C/Letardo',NULL,'Barcelona','Cataluña','Spain','12320',NULL,12.20),
('Aloha','Cristian','Rodriguez','916485852','914489898','C/Roman 3',NULL,'Canarias','Canarias','Spain','35488',NULL,12.50),
('El Prat','Francisco','Camacho','916882323','916493211','Avenida Tibidabo',NULL,'Barcelona','Cataluña','Spain','12320',NULL,12.30),
('Sotogrande','Maria','Santillana','915576622','914825645','C/Paseo del Parque',NULL,'Sotogrande','Cadiz','Spain','11310',NULL,12.60),
('Vivero Humanes','Federico','Gomez','654987690','916040875','C/Miguel Echegaray 54',NULL,'Humanes','Madrid','Spain','28970',NULL,30.74),
('Fuenla City','Tony','Muñoz Mena','675842139','915483754','C/Callo 52',NULL,'Fuenlabrada','Madrid','Spain','28574',NULL,5.45),
('Jardines y Mansiones Cactus SL','Eva María','Sánchez','916877445','914477777','Polígono Industrial Maspalomas, Nº52',NULL,'Móstoles','Madrid','Spain','29874',NULL,9.76),
('Jardinerías Matías SL','Matías','San Martín','916544147','917897474','C/Francisco Arce, Nº44',NULL,'Bustarviejo','Madrid','Spain','37845',NULL,9.10),
('Agrojardin','Benito','Lopez','675432926','916549264','C/Mar Caspio 43',NULL,'Getafe','Madrid','Spain','28904',NULL,30.80),
('Top Campo','Joseluis','Sanchez','685746512','974315924','C/Ibiza 32',NULL,'Humanes','Madrid','Spain','28574',NULL,5.55),
('Jardineria Sara','Sara','Marquez','675124537','912475843','C/Lima 1',NULL,'Fuenlabrada','Madrid','Spain','27584',NULL,5.75),
('Campohermoso','Luis','Jimenez','645925376','916159116','C/Peru 78',NULL,'Fuenlabrada','Madrid','Spain','28945',NULL,30.32),
('france telecom','François','Toulou','(33)5120578961','(33)5120578961','6 place d Alleray 15ème',NULL,'Paris',NULL,'France','75010',NULL,16.10),
('Musée du Louvre','Pierre','Delacroux','(33)0140205050','(33)0140205442','Quai du Louvre',NULL,'Paris',NULL,'France','75058',NULL,16.30),
('Tutifruti S.A','Jacob','Jones','292612433','292831695','Level 24, St. Martins Tower - 31 Market St.',NULL,'Sydney','Nueva Gales del Sur','Australia','2000',NULL,31.10),
('Flores S.L.','Antonio','Romero','654352981','685249700','Avenida España',NULL,'Madrid','Fuenlabrada','Spain','29643',NULL,18.60),
('The Magic Garden','Richard','Mcain','926523468','9364875882','Lighting Park',NULL,'London','London','United Kingdom','65930',NULL,18.10),
('El Jardin Viviente S.L','Justin','Smith','280057161','280057162','176 Cumberland Street The Rocks',NULL,'Sydney','Nueva Gales del Sur','Australia','2003',NULL,31.80);


INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2007-10-23','2007-10-28','2007-10-26','Entregado','La entrega llego antes de lo esperado',5);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-06-20','2008-06-25',NULL,'Rechazado','Limite de credito superado',5);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-20','2009-01-26',NULL,'Pendiente',NULL,5);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-11-09','2008-11-14','2008-11-14','Entregado','El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas',1);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-22','2008-12-27','2008-12-28','Entregado','El cliente comprueba la integridad del paquete, todo correcto',1);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-15','2009-01-20',NULL,'Pendiente','El cliente llama para confirmar la fecha - Esperando al proveedor',3);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-20','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 16:00h a 22:00h',1);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-22','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 9:00h a 13:00h',1);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-12','2009-01-14','2009-01-15','Entregado',NULL,7);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-02','2009-01-02',NULL,'Rechazado','mal pago',7);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-09','2009-01-12','2009-01-11','Entregado',NULL,7);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-06','2009-01-07','2009-01-15','Entregado',NULL,7);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-08','2009-01-09','2009-01-11','Entregado','mal estado',7);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-05','2009-01-06','2009-01-07','Entregado',NULL,9);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-18','2009-02-12',NULL,'Pendiente','entregar en murcia',9);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-20','2009-02-15',NULL,'Pendiente',NULL,9);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-09','2009-01-09','2009-01-09','Rechazado','mal pago',9);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-11','2009-01-11','2009-01-13','Entregado',NULL,9);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-30','2009-01-10',NULL,'Rechazado','El pedido fue anulado por el cliente',5);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-07-14','2008-07-31','2008-07-25','Entregado',NULL,14);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-02','2009-02-08',NULL,'Rechazado','El cliente carece de saldo en la cuenta asociada',1);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-06','2009-02-12',NULL,'Rechazado','El cliente anula la operacion para adquirir mas producto',3);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-07','2009-02-13',NULL,'Entregado','El pedido aparece como entregado pero no sabemos en que fecha',3);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-10','2009-02-17','2009-02-20','Entregado','El cliente se queja bastante de la espera asociada al producto',3);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-08-01','2008-09-01','2008-09-01','Rechazado','El cliente no está conforme con el pedido',14);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-08-03','2008-09-03','2008-08-31','Entregado',NULL,13);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-09-04','2008-09-30','2008-10-04','Rechazado','El cliente ha rechazado por llegar 5 dias tarde',13);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2007-01-07','2007-01-19','2007-01-27','Entregado','Entrega tardia, el cliente puso reclamacion',4);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2007-05-20','2007-05-28',NULL,'Rechazado','El pedido fue anulado por el cliente',4);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2007-06-20','2008-06-28','2008-06-28','Entregado','Pagado a plazos',4);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-03-10','2009-03-20',NULL,'Rechazado','Limite de credito superado',4);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-10-15','2008-12-15','2008-12-10','Entregado',NULL,14);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-11-03','2009-11-13',NULL,'Pendiente','El pedido nunca llego a su destino',4);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-05','2009-03-06','2009-03-07','Entregado',NULL,19);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-06','2009-03-07','2009-03-09','Pendiente',NULL,19);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-09','2009-03-10','2009-03-13','Rechazado',NULL,19);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-12','2009-03-13','2009-03-13','Entregado',NULL,19);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-22','2009-03-23','2009-03-27','Entregado',NULL,19);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-25','2009-03-26','2009-03-28','Pendiente',NULL,23);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-26','2009-03-27','2009-03-30','Pendiente',NULL,23);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-04-01','2009-03-04','2009-03-07','Entregado',NULL,23);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-04-03','2009-03-04','2009-03-05','Rechazado',NULL,23);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-04-15','2009-03-17','2009-03-17','Entregado',NULL,23);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-03-17','2008-03-30','2008-03-29','Entregado','Según el Cliente, el pedido llegó defectuoso',26);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-07-12','2008-07-22','2008-07-30','Entregado','El pedido llegó 1 día tarde, pero no hubo queja por parte de la empresa compradora',26);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-03-17','2008-08-09',NULL,'Pendiente','Al parecer, el pedido se ha extraviado a la altura de Sotalbo (Ávila)',26);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-10-01','2008-10-14','2008-10-14','Entregado','Todo se entregó a tiempo y en perfecto estado, a pesar del pésimo estado de las carreteras.',26);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-07','2008-12-21',NULL,'Pendiente','El transportista ha llamado a Eva María para indicarle que el pedido llegará más tarde de lo esperado.',26);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-10-15','2008-11-15','2008-11-09','Entregado','El pedido llega 6 dias antes',13);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-11','2009-02-11',NULL,'Pendiente',NULL,14);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-10','2009-01-10','2009-01-11','Entregado','Retrasado 1 dia por problemas de transporte',14);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-19','2009-01-20',NULL,'Rechazado','El cliente a anulado el pedido el dia 2009-01-10',13);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-05','2009-02-05',NULL,'Pendiente',NULL,13);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-24','2009-01-31','2009-01-30','Entregado','Todo correcto',3);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-14','2009-01-22',NULL,'Rechazado','El pedido no llego el dia que queria el cliente por fallo del transporte',15);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-11','2009-01-13','2009-01-13','Entregado','El pedido llego perfectamente',15);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-11-15','2008-11-23','2008-11-23','Entregado',NULL,15);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-03','2009-01-08',NULL,'Pendiente','El pedido no pudo ser entregado por problemas meteorologicos',15);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-15','2008-12-17','2008-12-17','Entregado','Fue entregado, pero faltaba mercancia que sera entregada otro dia',15);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-12','2009-01-13','2009-01-13','Entregado',NULL,28);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-25','2009-01-26',NULL,'Pendiente','No terminó el pago',28);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-18','2009-01-24',NULL,'Rechazado','Los producto estaban en mal estado',28);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-20','2009-01-29','2009-01-29','Entregado','El pedido llego un poco mas tarde de la hora fijada',28);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-24','2009-01-28',NULL,'Entregado',NULL,28);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-07','2008-02-17',NULL,'Pendiente','Debido a la nevada caída en la sierra, el pedido no podrá llegar hasta el día ',27);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-18','2009-03-29','2009-03-27','Entregado','Todo se entregó a su debido tiempo, incluso con un día de antelación',27);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-04-19','2009-04-30','2009-05-03','Entregado','El pedido se entregó tarde debido a la festividad celebrada en España durante esas fechas',27);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-05-03','2009-05-30','2009-05-17','Entregado','El pedido se entregó antes de lo esperado.',27);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-10-18','2009-11-01',NULL,'Pendiente','El pedido está en camino.',27);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-15','2009-02-27',NULL,'Pendiente',NULL,16);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-10','2009-01-15','2009-01-15','Entregado','El pedido llego perfectamente',16);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-07','2009-03-27',NULL,'Rechazado','El pedido fue rechazado por el cliente',16);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2008-12-28','2009-01-08','2009-01-08','Entregado','Pago pendiente',16);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-01-15','2009-01-20','2009-01-24','Pendiente',NULL,30);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-03-02','2009-03-06','2009-03-06','Entregado',NULL,30);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-02-14','2009-02-20',NULL,'Rechazado','el producto ha sido rechazado por la pesima calidad',30);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-05-13','2009-05-15','2009-05-20','Pendiente',NULL,30);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-04-06','2009-04-10','2009-04-10','Entregado',NULL,30);
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, id_cliente) VALUES ('2009-04-09','2009-04-15','2009-04-15','Entregado',NULL,16);



-- INSERT statements corregidos para la tabla producto
-- Estructura: (id_producto, nombre, categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor)

INSERT INTO producto VALUES ('11679','Sierra de Poda 400MM',2,'0.258','HiperGarden Tools','Gracias a la poda se consigue manipular un poco la naturaleza, dándole la forma que más nos guste. Este trabajo básico de jardinería también facilita que las plantas crezcan de un modo más equilibrado, y que las flores y los frutos vuelvan cada año con regularidad.',11,15.14,NULL);

INSERT INTO producto VALUES ('21636','Pala',2,'0.156','HiperGarden Tools','Palas de acero con cresta de corte en la punta para cortar bien el terreno. Buena penetración en tierras muy compactas.',13,15.14,NULL);

INSERT INTO producto VALUES ('22225','Rastrillo de Jardín',2,'1.064','HiperGarden Tools','Fabuloso rastillo que le ayudará a eliminar piedras, hojas, ramas y otros elementos incómodos en su jardín.',11,15.12,NULL);

INSERT INTO producto VALUES ('30310','Azadón',2,'0.168','HiperGarden Tools','Longitud:24cm. Herramienta fabricada en acero y pintura epoxi,alargando su durabilidad y preveniendo la corrosión.Diseño pensado para el ahorro de trabajo.',11,15.12,NULL);

INSERT INTO producto VALUES ('AR-001','Ajedrea',1,'15-20','Murcia Seasons','Planta aromática que fresca se utiliza para condimentar carnes y ensaladas, y seca, para pastas, sopas y guisantes',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-002','Lavándula Dentata',1,'15-20','Murcia Seasons','Espliego de jardín, Alhucema rizada, Alhucema dentada, Cantueso rizado. Familia: Lamiaceae.Origen: España y Portugal. Mata de unos 60 cm de alto.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-003','Mejorana',1,'15-20','Murcia Seasons','Origanum majorana. No hay que confundirlo con el orégano. Su sabor se parece más al tomillo, pero es más dulce y aromático.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-004','Melissa',1,'15-20','Murcia Seasons','Es una planta perenne conocida por el agradable y característico olor a limón que desprenden en verano.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-005','Mentha Sativa',1,'15-20','Murcia Seasons','¿Quién no conoce la Hierbabuena? Se trata de una plantita muy aromática, agradable y cultivada extensamente por toda España.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-006','Petrosilium Hortense (Peregil)',1,'15-20','Murcia Seasons','Nombre científico: Petroselinum hortense, Petroselinum crispum. Nombre común: Perejil, Perejil rizado.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-007','Salvia Mix',1,'15-20','Murcia Seasons','La Salvia es un pequeño arbusto que llega hasta el metro de alto.Tiene una vida breve, de unos pocos años.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-008','Thymus Citriodra (Tomillo limón)',1,'15-20','Murcia Seasons','Nombre común: Tomillo, Tremoncillo Familia: Labiatae (Labiadas).Origen: Región mediterránea.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-009','Thymus Vulgaris',1,'15-20','Murcia Seasons','Nombre común: Tomillo, Tremoncillo Familia: Labiatae (Labiadas). Origen: Región mediterránea.',0,140.1,NULL);

INSERT INTO producto VALUES ('AR-010','Santolina Chamaecyparys',1,'15-20','Murcia Seasons','',0,140.1,NULL);

INSERT INTO producto VALUES ('FR-1','Expositor Cítricos Mix',3,'100-120','Frutales Talavera S.A','',5,15.7,NULL);

INSERT INTO producto VALUES ('FR-10','Limonero 2 años injerto',3,NULL,'NaranjasValencianas.com','El limonero, pertenece al grupo de los cítricos, teniendo su origen hace unos 20 millones de años en el sudeste asiático.',5,15.7,NULL);

INSERT INTO producto VALUES ('FR-100','Nectarina',3,'8/10','Frutales Talavera S.A','Se trata de un árbol derivado por mutación de los melocotoneros comunes.',8,50.11,NULL);

INSERT INTO producto VALUES ('FR-101','Nogal',3,'8/10','Frutales Talavera S.A','',10,50.13,NULL);

INSERT INTO producto VALUES ('FR-102','Olea-Olivos',3,'8/10','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria.',14,50.18,NULL);

INSERT INTO producto VALUES ('FR-103','Olea-Olivos',3,'10/12','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria.',20,50.25,NULL);

INSERT INTO producto VALUES ('FR-104','Olea-Olivos',3,'12/4','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria.',39,50.49,NULL);

INSERT INTO producto VALUES ('FR-105','Olea-Olivos',3,'14/16','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria.',56,50.70,NULL);

INSERT INTO producto VALUES ('FR-106','Peral',3,'8/10','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura.',8,50.11,NULL);

INSERT INTO producto VALUES ('FR-107','Peral',3,'10/12','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura.',17,50.22,NULL);

INSERT INTO producto VALUES ('FR-108','Peral',3,'12/14','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura.',25,50.32,NULL);

INSERT INTO producto VALUES ('FR-11','Limonero 30/40',3,NULL,'NaranjasValencianas.com','El limonero, pertenece al grupo de los cítricos, teniendo su origen hace unos 20 millones de años.',80,15.100,NULL);

INSERT INTO producto VALUES ('FR-12','Kunquat',3,NULL,'NaranjasValencianas.com','Su nombre científico se origina en honor a un horticultor escocés que recolectó especímenes en China.',16,15.21,NULL);

INSERT INTO producto VALUES ('FR-13','Kunquat EXTRA con FRUTA',3,'150-170','NaranjasValencianas.com','Su nombre científico se origina en honor a un horticultor escocés que recolectó especímenes en China.',45,15.57,NULL);

INSERT INTO producto VALUES ('FR-14','Calamondin Mini',3,NULL,'Frutales Talavera S.A','Se trata de un pequeño arbolito de copa densa, con tendencia a la verticalidad.',8,15.10,NULL);

INSERT INTO producto VALUES ('FR-15','Calamondin Copa',3,NULL,'Frutales Talavera S.A','Se trata de un pequeño arbolito de copa densa, con tendencia a la verticalidad.',20,15.25,NULL);

INSERT INTO producto VALUES ('FR-16','Calamondin Copa EXTRA Con FRUTA',3,'100-120','Frutales Talavera S.A','Se trata de un pequeño arbolito de copa densa, con tendencia a la verticalidad.',36,15.45,NULL);

INSERT INTO producto VALUES ('FR-17','Rosal bajo 1ª -En maceta-inicio brotación',3,NULL,'Frutales Talavera S.A','',1,15.2,NULL);

INSERT INTO producto VALUES ('FR-18','ROSAL TREPADOR',3,NULL,'Frutales Talavera S.A','',3,350.4,NULL);

INSERT INTO producto VALUES ('FR-19','Camelia Blanco, Chrysler Rojo, Soraya Naranja',3,NULL,'NaranjasValencianas.com','',3,350.4,NULL);

INSERT INTO producto VALUES ('FR-2','Naranjo -Plantón joven 1 año injerto',3,NULL,'NaranjasValencianas.com','El naranjo es un árbol pequeño, que no supera los 3-5 metros de altura.',4,15.6,NULL);

INSERT INTO producto VALUES ('FR-20','Landora Amarillo, Rose Gaujard bicolor',3,NULL,'Frutales Talavera S.A','',3,350.4,NULL);

INSERT INTO producto VALUES ('FR-21','Kordes Perfect bicolor rojo-amarillo',3,NULL,'Frutales Talavera S.A','',3,350.4,NULL);

INSERT INTO producto VALUES ('FR-22','Pitimini rojo',3,NULL,'Frutales Talavera S.A','',3,350.4,NULL);

INSERT INTO producto VALUES ('FR-23','Rosal copa',3,NULL,'Frutales Talavera S.A','',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-24','Albaricoquero Corbato',3,NULL,'Melocotones de Cieza S.A.','Árbol que puede pasar de los 6 m de altura, en la región mediterránea.',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-25','Albaricoquero Moniqui',3,NULL,'Melocotones de Cieza S.A.','Árbol que puede pasar de los 6 m de altura, en la región mediterránea.',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-26','Albaricoquero Kurrot',3,NULL,'Melocotones de Cieza S.A.','Árbol que puede pasar de los 6 m de altura, en la región mediterránea.',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-27','Cerezo Burlat',3,NULL,'Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce.',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-28','Cerezo Picota',3,NULL,'Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce.',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-29','Cerezo Napoleón',3,NULL,'Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce.',6,400.8,NULL);

INSERT INTO producto VALUES ('FR-3','Naranjo 2 años injerto',3,NULL,'NaranjasValencianas.com','El naranjo es un árbol pequeño, que no supera los 3-5 metros de altura.',5,15.7,NULL);

-- (Continuaría con el resto de los productos...)


INSERT INTO producto (id_producto, nombre, categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES
('OR-127', 'Camelia japonica', 1, '40-60', 'Viveros EL OASIS', 'Arbusto excepcional por su floración otoñal, invernal o primaveral. Flores: solitarias en el ápice de cada rama, corola simple o doble, varios colores. Flores de 7-12 cm, 5 sépalos y 5 pétalos. Estambres numerosos.', 50, 7.50, 5.00),
('OR-128', 'Camelia japonica ejemplar', 1, '200-250', 'Viveros EL OASIS', 'Arbusto excepcional por su floración otoñal, invernal o primaveral. Flores: solitarias en el ápice de cada rama, corola simple o doble, varios colores. Flores de 7-12 cm, 5 sépalos y 5 pétalos. Estambres numerosos.', 50, 9.98, 7.80),
('OR-129', 'Camelia japonica ejemplar', 1, '250-300', 'Viveros EL OASIS', 'Arbusto excepcional por su floración otoñal, invernal o primaveral. Flores: solitarias en el ápice de cada rama, corola simple o doble, varios colores. Flores de 7-12 cm, 5 sépalos y 5 pétalos. Estambres numerosos.', 50, 10.10, 8.80),
('OR-130', 'Callistemom COPA', 1, '110-120', 'Viveros EL OASIS', 'Limpitatubos. Arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ahí lo de "llorón").', 50, 18.00, 14.00),
('OR-131', 'Leptospermum formado PIRAMIDE', 1, '80-100', 'Viveros EL OASIS', '', 50, 18.00, 14.00),
('OR-132', 'Leptospermum COPA', 1, '110-120', 'Viveros EL OASIS', '', 50, 18.00, 14.00),
('OR-133', 'Nerium oleander-CALIDAD "GARDEN"', 1, '40-45', 'Viveros EL OASIS', '', 50, 2.00, 1.00),
('OR-134', 'Nerium Oleander Arbusto GRANDE', 1, '160-200', 'Viveros EL OASIS', '', 100, 38.00, 30.00),
('OR-135', 'Nerium oleander COPA Calibre 6/8', 1, '50-60', 'Viveros EL OASIS', '', 100, 5.00, 4.00),
('OR-136', 'Nerium oleander ARBOL Calibre 8/10', 1, '225-250', 'Viveros EL OASIS', '', 100, 18.00, 14.00),
('OR-137', 'ROSAL TREPADOR', 1, '', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-138', 'Camelia Blanco, Chrysler Rojo, Soraya Naranja', 1, '', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-139', 'Landora Amarillo, Rose Gaujard bicolor blanco-rojo', 1, '', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-140', 'Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte', 1, '', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-141', 'Pitimini rojo', 1, '', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-142', 'Solanum Jazminoide', 1, '150-160', 'Viveros EL OASIS', '', 100, 2.00, 1.00),
('OR-143', 'Wisteria Sinensis azul, rosa, blanca', 1, '', 'Viveros EL OASIS', '', 100, 9.00, 7.00),
('OR-144', 'Wisteria Sinensis INJERTADAS DECÓ', 1, '140-150', 'Viveros EL OASIS', '', 100, 12.00, 9.00),
('OR-145', 'Bougamvillea Sanderiana Tutor', 1, '80-100', 'Viveros EL OASIS', '', 100, 2.00, 1.00),
('OR-146', 'Bougamvillea Sanderiana Tutor', 1, '125-150', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-147', 'Bougamvillea Sanderiana Tutor', 1, '180-200', 'Viveros EL OASIS', '', 100, 7.00, 5.00),
('OR-148', 'Bougamvillea Sanderiana Espaldera', 1, '45-50', 'Viveros EL OASIS', '', 100, 7.00, 5.00),
('OR-149', 'Bougamvillea Sanderiana Espaldera', 1, '140-150', 'Viveros EL OASIS', '', 100, 17.00, 13.00),
('OR-150', 'Bougamvillea roja, naranja', 1, '110-130', 'Viveros EL OASIS', '', 100, 2.00, 1.00),
('OR-151', 'Bougamvillea Sanderiana, 3 tut. piramide', 1, '', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-152', 'Expositor Árboles clima continental', 1, '170-200', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-153', 'Expositor Árboles clima mediterráneo', 1, '170-200', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-154', 'Expositor Árboles borde del mar', 1, '170-200', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-155', 'Acer Negundo', 1, '200-225', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-156', 'Acer platanoides', 1, '200-225', 'Viveros EL OASIS', '', 100, 10.00, 8.00),
('OR-157', 'Acer Pseudoplatanus', 1, '200-225', 'Viveros EL OASIS', '', 100, 10.00, 8.00),
('OR-158', 'Brachychiton Acerifolius', 1, '200-225', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-159', 'Brachychiton Discolor', 1, '200-225', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-160', 'Brachychiton Rupestris', 1, '170-200', 'Viveros EL OASIS', '', 100, 10.00, 8.00),
('OR-161', 'Cassia Corimbosa', 1, '200-225', 'Viveros EL OASIS', '', 100, 6.00, 4.00),
('OR-162', 'Cassia Corimbosa', 1, '200-225', 'Viveros EL OASIS', '', 100, 10.00, 8.00),
('OR-163', 'Chitalpa Summer Bells', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-164', 'Erytrina Kafra', 1, '170-180', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-165', 'Erytrina Kafra', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-166', 'Eucalyptus Citriodora', 1, '170-200', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-167', 'Eucalyptus Ficifolia', 1, '170-200', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-168', 'Eucalyptus Ficifolia', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-169', 'Hibiscus Syriacus Var. Injertadas 1 Tallo', 1, '170-200', 'Viveros EL OASIS', '', 80, 12.00, 9.00),
('OR-170', 'Lagunaria Patersonii', 1, '140-150', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-171', 'Lagunaria Patersonii', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-172', 'Lagunaria patersonii calibre 8/10', 1, '200-225', 'Viveros EL OASIS', '', 80, 18.00, 14.00),
('OR-173', 'Morus Alba', 1, '200-225', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-174', 'Morus Alba calibre 8/10', 1, '200-225', 'Viveros EL OASIS', '', 80, 18.00, 14.00),
('OR-175', 'Platanus Acerifolia', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-176', 'Prunus pisardii', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00);
-- bloque 2
INSERT INTO producto (id_producto, nombre, categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES
('OR-177', 'Robinia Pseudoacacia Casque Rouge', 1, '200-225', 'Viveros EL OASIS', '', 80, 15.00, 12.00),
('OR-178', 'Salix Babylonica Pendula', 1, '170-200', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-179', 'Sesbania Punicea', 1, '170-200', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-180', 'Tamarix Ramosissima Pink Cascade', 1, '170-200', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-181', 'Tamarix Ramosissima Pink Cascade', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-182', 'Tecoma Stands', 1, '200-225', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-183', 'Tecoma Stands', 1, '200-225', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-184', 'Tipuana Tipu', 1, '170-200', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-185', 'Pleioblastus distichus-Bambú enano', 1, '15-20', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-186', 'Sasa palmata', 1, '20-30', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-187', 'Sasa palmata', 1, '40-45', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-188', 'Sasa palmata', 1, '50-60', 'Viveros EL OASIS', '', 80, 25.00, 20.00),
('OR-189', 'Phylostachys aurea', 1, '180-200', 'Viveros EL OASIS', '', 80, 22.00, 17.00),
('OR-190', 'Phylostachys aurea', 1, '250-300', 'Viveros EL OASIS', '', 80, 32.00, 25.00),
('OR-191', 'Phylostachys Bambusa Spectabilis', 1, '180-200', 'Viveros EL OASIS', '', 80, 24.00, 19.00),
('OR-192', 'Phylostachys biseti', 1, '160-170', 'Viveros EL OASIS', '', 80, 22.00, 17.00),
('OR-193', 'Phylostachys biseti', 1, '160-180', 'Viveros EL OASIS', '', 80, 20.00, 16.00),
('OR-194', 'Pseudosasa japonica (Metake)', 1, '225-250', 'Viveros EL OASIS', '', 80, 20.00, 16.00),
('OR-195', 'Pseudosasa japonica (Metake)', 1, '30-40', 'Viveros EL OASIS', '', 80, 6.00, 4.00),
('OR-196', 'Cedrus Deodara', 1, '80-100', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-197', 'Cedrus Deodara "Feeling Blue" Novedad', 1, 'rastrero', 'Viveros EL OASIS', '', 80, 12.00, 9.00),
('OR-198', 'Juniperus chinensis "Blue Alps"', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-199', 'Juniperus Chinensis Stricta', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-200', 'Juniperus horizontalis Wiltonii', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-201', 'Juniperus squamata "Blue Star"', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-202', 'Juniperus x media Phitzeriana verde', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-203', 'Pinus Canariensis', 1, '80-100', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-204', 'Pinus Halepensis', 1, '160-180', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-205', 'Pinus Pinea -Pino Piñonero', 1, '70-80', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-206', 'Thuja Esmeralda', 1, '80-100', 'Viveros EL OASIS', '', 80, 5.00, 4.00),
('OR-207', 'Tuja Occidentalis Woodwardii', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-208', 'Tuja orientalis "Aurea nana"', 1, '20-30', 'Viveros EL OASIS', '', 80, 4.00, 3.00),
('OR-209', 'Archontophoenix Cunninghamiana', 1, '80-100', 'Viveros EL OASIS', '', 80, 10.00, 8.00),
('OR-210', 'Beucarnea Recurvata', 1, '130-150', 'Viveros EL OASIS', '', 2, 39.00, 31.00),
('OR-211', 'Beucarnea Recurvata', 1, '180-200', 'Viveros EL OASIS', '', 5, 59.00, 47.00),
('OR-212', 'Bismarckia Nobilis', 1, '200-220', 'Viveros EL OASIS', '', 4, 217.00, 173.00),
('OR-213', 'Bismarckia Nobilis', 1, '240-260', 'Viveros EL OASIS', '', 4, 266.00, 212.00),
('OR-214', 'Brahea Armata', 1, '45-60', 'Viveros EL OASIS', '', 0, 10.00, 8.00),
('OR-215', 'Brahea Armata', 1, '120-140', 'Viveros EL OASIS', '', 100, 112.00, 89.00),
('OR-216', 'Brahea Edulis', 1, '80-100', 'Viveros EL OASIS', '', 100, 19.00, 15.00),
('OR-217', 'Brahea Edulis', 1, '140-160', 'Viveros EL OASIS', '', 100, 64.00, 51.00),
('OR-218', 'Butia Capitata', 1, '70-90', 'Viveros EL OASIS', '', 100, 25.00, 20.00),
('OR-219', 'Butia Capitata', 1, '90-110', 'Viveros EL OASIS', '', 100, 29.00, 23.00),
('OR-220', 'Butia Capitata', 1, '90-120', 'Viveros EL OASIS', '', 100, 36.00, 28.00),
('OR-221', 'Butia Capitata', 1, '85-105', 'Viveros EL OASIS', '', 100, 59.00, 47.00),
('OR-222', 'Butia Capitata', 1, '130-150', 'Viveros EL OASIS', '', 100, 87.00, 69.00),
('OR-223', 'Chamaerops Humilis', 1, '40-45', 'Viveros EL OASIS', '', 100, 4.00, 3.00),
('OR-224', 'Chamaerops Humilis', 1, '50-60', 'Viveros EL OASIS', '', 100, 7.00, 5.00),
('OR-225', 'Chamaerops Humilis', 1, '70-90', 'Viveros EL OASIS', '', 100, 10.00, 8.00),
('OR-226', 'Chamaerops Humilis', 1, '115-130', 'Viveros EL OASIS', '', 100, 38.00, 30.00);

-- bloque 3 
INSERT INTO producto (id_producto, nombre, categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES
('OR-228','Chamaerops Humilis "Cerifera"', 1, '70-80', 'Viveros EL OASIS', '', 100, 32.00, 25.00),
('OR-229','Chrysalidocarpus Lutescens -ARECA', 1, '130-150', 'Viveros EL OASIS', '', 100, 22.00, 17.00),
('OR-230','Cordyline Australis -DRACAENA', 1, '190-210', 'Viveros EL OASIS', '', 100, 38.00, 30.00),
('OR-231','Cycas Revoluta', 1, '55-65', 'Viveros EL OASIS', '', 100, 15.00, 12.00),
('OR-232','Cycas Revoluta', 1, '80-90', 'Viveros EL OASIS', '', 100, 34.00, 27.00),
('OR-233','Dracaena Drago', 1, '60-70', 'Viveros EL OASIS', '', 1, 13.00, 10.00),
('OR-234','Dracaena Drago', 1, '130-150', 'Viveros EL OASIS', '', 2, 64.00, 51.00),
('OR-235','Dracaena Drago', 1, '150-175', 'Viveros EL OASIS', '', 2, 92.00, 73.00),
('OR-236','Jubaea Chilensis', 1, '', 'Viveros EL OASIS', '', 100, 49.00, 39.00),
('OR-237','Livistonia Australis', 1, '100-125', 'Viveros EL OASIS', '', 50, 19.00, 15.00),
('OR-238','Livistonia Decipiens', 1, '90-110', 'Viveros EL OASIS', '', 50, 19.00, 15.00),
('OR-239','Livistonia Decipiens', 1, '180-200', 'Viveros EL OASIS', '', 50, 49.00, 39.00),
('OR-240','Phoenix Canariensis', 1, '110-130', 'Viveros EL OASIS', '', 50, 6.00, 4.00),
('OR-241','Phoenix Canariensis', 1, '180-200', 'Viveros EL OASIS', '', 50, 19.00, 15.00),
('OR-242','Rhaphis Excelsa', 1, '80-100', 'Viveros EL OASIS', '', 50, 21.00, 16.00),
('OR-243','Rhaphis Humilis', 1, '150-170', 'Viveros EL OASIS', '', 50, 64.00, 51.00),
('OR-244','Sabal Minor', 1, '60-75', 'Viveros EL OASIS', '', 50, 11.00, 8.00),
('OR-245','Sabal Minor', 1, '120-140', 'Viveros EL OASIS', '', 50, 34.00, 27.00),
('OR-246','Trachycarpus Fortunei', 1, '90-105', 'Viveros EL OASIS', '', 50, 18.00, 14.00),
('OR-247','Trachycarpus Fortunei', 1, '250-300', 'Viveros EL OASIS', '', 2, 462.00, 369.00),
('OR-248','Washingtonia Robusta', 1, '60-70', 'Viveros EL OASIS', '', 15, 3.00, 2.00),
('OR-249','Washingtonia Robusta', 1, '130-150', 'Viveros EL OASIS', '', 15, 5.00, 4.00),
('OR-250','Yucca Jewel', 1, '80-105', 'Viveros EL OASIS', '', 15, 10.00, 8.00),
('OR-251','Zamia Furfuracaea', 1, '90-110', 'Viveros EL OASIS', '', 15, 168.00, 134.00),
('OR-99','Mimosa DEALBATA Gaulois Astier', 1, '200-225', 'Viveros EL OASIS', 'Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Árbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...', 100, 14.00, 11.00);




--detalles pedido

INSERT INTO detalle_pedido VALUES (3,'FR-108',1,120.90,6);
INSERT INTO detalle_pedido VALUES (4,'FR-108',1,42.90,8);
INSERT INTO detalle_pedido VALUES (3,'OR-213',1,30.27,1);
INSERT INTO detalle_pedido VALUES (3,'OR-217',1,15.65,2);
INSERT INTO detalle_pedido VALUES (4,'OR-152',1,3.60,5);
INSERT INTO detalle_pedido VALUES (4,'OR-155',1,4.60,3);
INSERT INTO detalle_pedido VALUES (4,'OR-156',1,17.90,4);
INSERT INTO detalle_pedido VALUES (4,'OR-157',1,38.10,2);
INSERT INTO detalle_pedido VALUES (4,'OR-222',1,21.59,1);
INSERT INTO detalle_pedido VALUES (8,'FR-106',1,3.11,1);
INSERT INTO detalle_pedido VALUES (8,'FR-108',1,1.32,2);
INSERT INTO detalle_pedido VALUES (8,'FR-11',1,10.10,3);
INSERT INTO detalle_pedido VALUES (3,'OR-218',1,24.25,3);
INSERT INTO detalle_pedido VALUES (16,'FR-11',1,10.90,2);
INSERT INTO detalle_pedido VALUES (17,'FR-11',1,5.90,2);
INSERT INTO detalle_pedido VALUES (17,'FR-108',1,5.22,4);
INSERT INTO detalle_pedido VALUES (19,'FR-108',1,1.32,2);
INSERT INTO detalle_pedido VALUES (21,'FR-11',1,3.80,2);
INSERT INTO detalle_pedido VALUES (21,'FR-106',1,3.80,2);
INSERT INTO detalle_pedido VALUES (11,'30310',1,180.10,3);
INSERT INTO detalle_pedido VALUES (11,'OR-180',1,80.80,1);
INSERT INTO detalle_pedido VALUES (12,'22225',1,290.10,1);
INSERT INTO detalle_pedido VALUES (15,'OR-156',1,6.10,1);
INSERT INTO detalle_pedido VALUES (15,'OR-203',1,9.10,4);
INSERT INTO detalle_pedido VALUES (17,'11679',1,5.14,1);
INSERT INTO detalle_pedido VALUES (17,'22225',1,5.12,3);
INSERT INTO detalle_pedido VALUES (17,'OR-136',1,5.18,5);
INSERT INTO detalle_pedido VALUES (18,'22225',1,4.12,2);
INSERT INTO detalle_pedido VALUES (18,'FR-22',1,2.40,1);
INSERT INTO detalle_pedido VALUES (18,'OR-159',1,10.60,3);
INSERT INTO detalle_pedido VALUES (19,'30310',1,9.12,5);
INSERT INTO detalle_pedido VALUES (19,'FR-23',1,6.80,4);
INSERT INTO detalle_pedido VALUES (19,'OR-208',1,20.40,3);
INSERT INTO detalle_pedido VALUES (20,'11679',1,14.14,1);
INSERT INTO detalle_pedido VALUES (20,'30310',1,8.12,2);
INSERT INTO detalle_pedido VALUES (21,'21636',1,5.14,3);
INSERT INTO detalle_pedido VALUES (21,'FR-18',1,22.40,1);
INSERT INTO detalle_pedido VALUES (22,'OR-240',1,1.60,1);
INSERT INTO detalle_pedido VALUES (23,'AR-002',1,110.10,4);
INSERT INTO detalle_pedido VALUES (23,'FR-107',1,50.22,3);
INSERT INTO detalle_pedido VALUES (23,'OR-249',1,30.50,1);
INSERT INTO detalle_pedido VALUES (24,'22225',1,3.15,1);
INSERT INTO detalle_pedido VALUES (24,'FR-1',1,4.70,4);
INSERT INTO detalle_pedido VALUES (24,'FR-23',1,2.70,2);
INSERT INTO detalle_pedido VALUES (24,'OR-241',1,10.20,3);
INSERT INTO detalle_pedido VALUES (26,'FR-15',1,9.25,3);
INSERT INTO detalle_pedido VALUES (26,'OR-188',1,4.25,1);
INSERT INTO detalle_pedido VALUES (26,'OR-218',1,14.25,2);
INSERT INTO detalle_pedido VALUES (25,'FR-15',1,15.69,1);
INSERT INTO detalle_pedido VALUES (25,'FR-108',1,4.30,3);
INSERT INTO detalle_pedido VALUES (25,'FR-1',1,10.30,2);
INSERT INTO detalle_pedido VALUES (27,'OR-218',1,22.60,2);
INSERT INTO detalle_pedido VALUES (27,'OR-219',1,22.60,3);
INSERT INTO detalle_pedido VALUES (34,'FR-11',1,12.29,3);
INSERT INTO detalle_pedido VALUES (30,'FR-108',1,2.32,2);
INSERT INTO detalle_pedido VALUES (30,'FR-12',1,2.19,3);
INSERT INTO detalle_pedido VALUES (30,'FR-11',1,4.31,5);
INSERT INTO detalle_pedido VALUES (30,'FR-23',1,10.45,1);
INSERT INTO detalle_pedido VALUES (30,'OR-188',1,5.50,4);

INSERT INTO detalle_pedido VALUES (31,'AR-009',1,25.20,3);
INSERT INTO detalle_pedido VALUES (31,'FR-102',1,1.20,1);
INSERT INTO detalle_pedido VALUES (31,'FR-11',1,6.29,2);
INSERT INTO detalle_pedido VALUES (32,'11679',1,1.14,4);
INSERT INTO detalle_pedido VALUES (32,'21636',1,4.15,5);
INSERT INTO detalle_pedido VALUES (32,'22225',1,1.15,3);
INSERT INTO detalle_pedido VALUES (32,'OR-128',1,29.10,2);
INSERT INTO detalle_pedido VALUES (32,'OR-193',1,5.20,1);
INSERT INTO detalle_pedido VALUES (33,'FR-17',1,423.20,4);
INSERT INTO detalle_pedido VALUES (33,'FR-29',1,120.80,3);
INSERT INTO detalle_pedido VALUES (33,'OR-214',1,212.10,2);
INSERT INTO detalle_pedido VALUES (33,'OR-247',1,150.46,1);
INSERT INTO detalle_pedido VALUES (34,'FR-3',1,56.70,4);

INSERT INTO detalle_pedido VALUES (29,'OR-129',1,2.11,2);
INSERT INTO detalle_pedido VALUES (29,'OR-160',1,10.90,3);
INSERT INTO detalle_pedido VALUES (30,'AR-004',1,10.10,6);
INSERT INTO detalle_pedido VALUES (34,'OR-172',1,20.18,1);
INSERT INTO detalle_pedido VALUES (34,'OR-174',1,24.18,2);
INSERT INTO detalle_pedido VALUES (35,'21636',1,12.14,4);
INSERT INTO detalle_pedido VALUES (31,'FR-106',1,1.20,1);
INSERT INTO detalle_pedido VALUES (31,'FR-100',1,6.29,2);
INSERT INTO detalle_pedido VALUES (32,'OR-181',1,29.10,2);
INSERT INTO detalle_pedido VALUES (32,'OR-182',1,5.20,1);
INSERT INTO detalle_pedido VALUES (33,'FR-108',1,423.20,4);
INSERT INTO detalle_pedido VALUES (33,'FR-11',1,120.80,3);
INSERT INTO detalle_pedido VALUES (33,'OR-183',1,212.10,2);
INSERT INTO detalle_pedido VALUES (33,'OR-184',1,150.46,1);
INSERT INTO detalle_pedido VALUES (34,'FR-108',1,56.70,4);
INSERT INTO detalle_pedido VALUES (34,'FR-106',1,12.29,3);
INSERT INTO detalle_pedido VALUES (34,'OR-185',1,20.18,1);
INSERT INTO detalle_pedido VALUES (34,'OR-186',1,24.18,2);

INSERT INTO detalle_pedido VALUES (35,'FR-100',1,55.80,3);
INSERT INTO detalle_pedido VALUES (35,'OR-187',1,3.10,2);
INSERT INTO detalle_pedido VALUES (35,'OR-188',1,36.10,1);
INSERT INTO detalle_pedido VALUES (35,'OR-189',1,72.10,5);
INSERT INTO detalle_pedido VALUES (36,'30310',1,4.12,2);
INSERT INTO detalle_pedido VALUES (36,'FR-108',1,2.70,3);
INSERT INTO detalle_pedido VALUES (36,'OR-190',1,6.70,4);
INSERT INTO detalle_pedido VALUES (36,'OR-191',1,1.12,5);
INSERT INTO detalle_pedido VALUES (36,'OR-192',1,15.13,1);
INSERT INTO detalle_pedido VALUES (37,'FR-11',1,4.70,1);
INSERT INTO detalle_pedido VALUES (37,'FR-108',1,203.80,2);
INSERT INTO detalle_pedido VALUES (37,'OR-193',1,38.10,3);
INSERT INTO detalle_pedido VALUES (38,'11679',1,5.14,1);
INSERT INTO detalle_pedido VALUES (38,'21636',1,2.14,2);
INSERT INTO detalle_pedido VALUES (39,'22225',1,3.12,1);
INSERT INTO detalle_pedido VALUES (39,'30310',1,6.12,2);
INSERT INTO detalle_pedido VALUES (40,'AR-001',1,4.10,1);
INSERT INTO detalle_pedido VALUES (40,'AR-002',1,8.10,2);

INSERT INTO detalle_pedido VALUES (41,'AR-003',1,5.10,1);
INSERT INTO detalle_pedido VALUES (41,'AR-004',1,5.10,2);
INSERT INTO detalle_pedido VALUES (42,'AR-005',1,3.10,1);
INSERT INTO detalle_pedido VALUES (42,'AR-006',1,1.10,2);
INSERT INTO detalle_pedido VALUES (43,'AR-007',1,9.10,1);
INSERT INTO detalle_pedido VALUES (44,'AR-008',1,5.10,1);
INSERT INTO detalle_pedido VALUES (45,'AR-009',1,6.10,1);
INSERT INTO detalle_pedido VALUES (45,'AR-010',1,4.10,2);
INSERT INTO detalle_pedido VALUES (46,'FR-106',1,4.70,1);
INSERT INTO detalle_pedido VALUES (46,'FR-100',1,8.70,2);
INSERT INTO detalle_pedido VALUES (47,'FR-108',1,9.11,1);
INSERT INTO detalle_pedido VALUES (47,'FR-11',1,5.13,2);
INSERT INTO detalle_pedido VALUES (48,'FR-108',1,1.18,1);
INSERT INTO detalle_pedido VALUES (48,'FR-106',1,1.25,2);
INSERT INTO detalle_pedido VALUES (48,'OR-194',1,50.64,1);
INSERT INTO detalle_pedido VALUES (48,'OR-195',1,45.49,2);
INSERT INTO detalle_pedido VALUES (48,'OR-196',1,50.19,3);
INSERT INTO detalle_pedido VALUES (49,'OR-197',1,50.10,1);
INSERT INTO detalle_pedido VALUES (49,'OR-198',1,10.10,2);
INSERT INTO detalle_pedido VALUES (49,'OR-199',1,5.50,3);
INSERT INTO detalle_pedido VALUES (50,'OR-200',1,12.10,1);
INSERT INTO detalle_pedido VALUES (50,'OR-201',1,15.38,2);
INSERT INTO detalle_pedido VALUES (50,'OR-202',1,44.64,3);
INSERT INTO detalle_pedido VALUES (51,'OR-203',1,50.10,1);
INSERT INTO detalle_pedido VALUES (51,'OR-204',1,80.39,2);
INSERT INTO detalle_pedido VALUES (51,'OR-205',1,70.59,3);
INSERT INTO detalle_pedido VALUES (53,'FR-100',1,1.70,1);
INSERT INTO detalle_pedido VALUES (53,'FR-108',1,1.70,3);

INSERT INTO detalle_pedido VALUES (53,'FR-11',1,2.11,2);
INSERT INTO detalle_pedido VALUES (53,'OR-206',1,6.70,4);
INSERT INTO detalle_pedido VALUES (54,'11679',1,3.14,3);
INSERT INTO detalle_pedido VALUES (54,'FR-108',1,45.10,2);
INSERT INTO detalle_pedido VALUES (54,'FR-106',1,5.40,1);
INSERT INTO detalle_pedido VALUES (54,'FR-100',1,3.22,4);
INSERT INTO detalle_pedido VALUES (54,'OR-207',1,8.70,6);
INSERT INTO detalle_pedido VALUES (54,'OR-208',1,3.50,5);
INSERT INTO detalle_pedido VALUES (54,'OR-209',1,2.10,7);
INSERT INTO detalle_pedido VALUES (55,'OR-210',1,9.70,1);
INSERT INTO detalle_pedido VALUES (55,'OR-211',1,2.27,2);
INSERT INTO detalle_pedido VALUES (55,'OR-212',1,6.64,5);
INSERT INTO detalle_pedido VALUES (55,'OR-213',1,2.64,4);
INSERT INTO detalle_pedido VALUES (55,'OR-214',1,1.46,3);
INSERT INTO detalle_pedido VALUES (56,'OR-215',1,1.12,5);
INSERT INTO detalle_pedido VALUES (56,'OR-216',1,10.18,6);
INSERT INTO detalle_pedido VALUES (56,'OR-217',1,1.60,3);
INSERT INTO detalle_pedido VALUES (56,'OR-218',1,3.10,4);
INSERT INTO detalle_pedido VALUES (56,'OR-219',1,4.40,2);
INSERT INTO detalle_pedido VALUES (56,'OR-220',1,3.10,1);
INSERT INTO detalle_pedido VALUES (57,'FR-108',1,6.91,4);
INSERT INTO detalle_pedido VALUES (57,'FR-11',1,3.49,3);

INSERT INTO detalle_pedido VALUES (58,'OR-180',1,65.18,3);
INSERT INTO detalle_pedido VALUES (58,'OR-181',1,80.40,1);
INSERT INTO detalle_pedido VALUES (58,'OR-182',1,69.15,2);
INSERT INTO detalle_pedido VALUES (58,'OR-183',1,150.15,4);
INSERT INTO detalle_pedido VALUES (74,'FR-100',1,15.70,1);
INSERT INTO detalle_pedido VALUES (74,'OR-184',1,34.64,2);
INSERT INTO detalle_pedido VALUES (74,'OR-185',1,42.80,3);
INSERT INTO detalle_pedido VALUES (75,'AR-006',1,60.10,2);
INSERT INTO detalle_pedido VALUES (75,'FR-108',1,24.22,3);
INSERT INTO detalle_pedido VALUES (75,'OR-186',1,46.10,1);
INSERT INTO detalle_pedido VALUES (76,'AR-009',1,250.10,5);
INSERT INTO detalle_pedido VALUES (76,'FR-11',1,40.22,3);
INSERT INTO detalle_pedido VALUES (76,'FR-108',1,24.22,4);
INSERT INTO detalle_pedido VALUES (76,'FR-106',1,35.90,1);
INSERT INTO detalle_pedido VALUES (76,'OR-196',1,25.10,2);

INSERT INTO detalle_pedido VALUES (77,'22225',1,34.12,2);
INSERT INTO detalle_pedido VALUES (77,'30310',1,15.12,1);
INSERT INTO detalle_pedido VALUES (78,'FR-11',1,25.80,2);
INSERT INTO detalle_pedido VALUES (78,'FR-108',1,56.70,3);
INSERT INTO detalle_pedido VALUES (78,'OR-180',1,42.10,4);
INSERT INTO detalle_pedido VALUES (78,'OR-181',1,30.40,1);
INSERT INTO detalle_pedido VALUES (79,'OR-182',1,50.60,1);


--PAGOS

INSERT INTO pago VALUES (1,'PayPal','ak-std-000001','2008-11-10',2000);
INSERT INTO pago VALUES (1,'PayPal','ak-std-000002','2008-12-10',2000);
INSERT INTO pago VALUES (3,'PayPal','ak-std-000003','2009-01-16',5000);
INSERT INTO pago VALUES (3,'PayPal','ak-std-000004','2009-02-16',5000);
INSERT INTO pago VALUES (3,'PayPal','ak-std-000005','2009-02-19',926);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000006','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000007','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000008','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000009','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000010','2007-01-08',1849);
INSERT INTO pago VALUES (5,'Transferencia','ak-std-000011','2006-01-18',23794);
INSERT INTO pago VALUES (7,'Cheque','ak-std-000012','2009-01-13',2390);
INSERT INTO pago VALUES (9,'PayPal','ak-std-000013','2009-01-06',929);
INSERT INTO pago VALUES (13,'PayPal','ak-std-000014','2008-08-04',2246);
INSERT INTO pago VALUES (14,'PayPal','ak-std-000015','2008-07-15',4160);
INSERT INTO pago VALUES (15,'PayPal','ak-std-000016','2009-01-15',2081);
INSERT INTO pago VALUES (15,'PayPal','ak-std-000035','2009-02-15',10000);
INSERT INTO pago VALUES (16,'PayPal','ak-std-000017','2009-02-16',4399);
INSERT INTO pago VALUES (19,'PayPal','ak-std-000018','2009-03-06',232);
INSERT INTO pago VALUES (23,'PayPal','ak-std-000019','2009-03-26',272);
INSERT INTO pago VALUES (26,'PayPal','ak-std-000020','2008-03-18',18846);
INSERT INTO pago VALUES (27,'PayPal','ak-std-000021','2009-02-08',10972);
INSERT INTO pago VALUES (28,'PayPal','ak-std-000022','2009-01-13',8489);
INSERT INTO pago VALUES (30,'PayPal','ak-std-000024','2009-01-16',7863);
INSERT INTO pago VALUES (35,'PayPal','ak-std-000025','2007-10-06',3321);




