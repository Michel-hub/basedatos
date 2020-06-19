CREATE TABLE categoria (
    id SERIAL  PRIMARY KEY,
    nombre VARCHAR,
    descricion TEXT
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR,
    direccion VARCHAR,
    rut TEXT
);

CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR,
    descripcion TEXT,
    precio INT,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

CREATE TABLE factura (
    id SERIAL PRIMARY KEY,
    numero INT,
    fecha DATE,
    iva INT,
    subtotal INT,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE factura_producto (
    id SERIAL PRIMARY KEY,
    cantidad INT,
    factura_id INT,
    producto_id INT,
    FOREIGN KEY (factura_id) REFERENCES factura(id),
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);







-- insertar 5 clientes

INSERT INTO cliente (nombre, direccion, rut) VALUES ('Leonardo', 'Direccion Noruega', '123456'),('Victor', 'Direccion Colina', '123456'), ('Felipe', 'Direccion Colina', '1234567'),('Michel', 'Direccion Pintana', '12345678'),('Nicolas', 'Direccion Florida', '123456789');

-- insertar 3 categorias 

INSERT INTO categoria ( nombre, descricion) VALUES ('categoria 1', 'Descripcion 1'), ('categoria 2', 'Descripcion 2'), ('categoria 3', 'Descripcion 3');


-- insertar 8 productos 

INSERT INTO producto (nombre, descripcion, precio, categoria_id) VALUES ('producto 1_1', 'Descripcion producto 1_1', 100, 1), ('producto 1_2', 'Descripcion producto 1_2', 100, 1), ('producto 1_3', 'Descripcion producto 1_3', 100, 1), ('producto 2_1', 'Descripcion producto 2_1', 200, 2), ('producto 2_2', 'Descripcion producto 2_2', 200, 2), ('producto 2_3', 'Descripcion producto 2_3', 200, 2), ('producto 3_1', 'Descripcion producto 3_1', 300, 3), ('producto 3_2', 'Descripcion producto 3_2', 300, 3);


-- insertar facturas 10 

-- CLIENTE 1

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 200, 1);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (3,1), (3,2);

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 500,1);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (4, 3), (4, 4), (4,5);


-- CLIENTE 2 
INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 800, 2);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (5, 6), (5, 7), (5,8);

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 400, 2);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (6, 4), (6, 6);

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 400, 2);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (7, 4), (7, 2), (7,3);


-- CLIENTE 3 

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 100, 3);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (8, 3);

-- CLIENTE 4 

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 400, 4);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (9, 4), (9,5);

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 500, 4);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (10, 3), (10, 6), (10,5);

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 700, 4);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (11, 3), (11, 4), (11, 8), (11,1);

INSERT INTO factura (fecha, iva, subtotal, cliente_id) VALUES (CURRENT_DATE, 19, 100, 4);
INSERT INTO factura_producto (factura_id, producto_id) VALUES  (12, 1);



-- PUNTO 3

-- pregunta 1

SELECT c.rut, f.subtotal FROM cliente AS c INNER JOIN factura AS f ON f.cliente_id = c.id ORDER BY f.subtotal DESC LIMIT 1;

SELECT c.rut, f.subtotal FROM cliente AS c INNER JOIN factura AS f ON f.cliente_id = c.id WHERE f.subtotal = (SELECT MAX(subtotal) FROM factura);


-- pregunta 2 

SELECT DISTINCT c.rut "Rut Cliente", c.nombre "Nombre Cliente que pago sobre $100.000", f.numero "Factura N°", f.precio_total "Monto Factura" FROM cliente c INNER JOIN factura f ON c.id = f.cliente_id WHERE f.precio_total > 100000; 

SELECT DISTINCT (c.rut), c.nombre  FROM cliente AS c INNER JOIN factura AS f ON f.cliente_id = c.id WHERE f.subtotal > 250;

-- Pregunta 3

SELECT COUNT(d.producto_id) "N°clientes que Compraron el Producto 6" FROM cliente c INNER JOIN factura f ON c.id = f.cliente_id INNER JOIN detalle d ON f.numero = d.factura_numero WHERE d.producto_id = 6 ; 


SELECT  producto_id, cliente.nombre cliente_nombre FROM factura_producto INNER JOIN factura ON factura.id = factura_producto.factura_id INNER JOIN cliente ON cliente.id = factura.cliente_id WHERE producto_id =6;
