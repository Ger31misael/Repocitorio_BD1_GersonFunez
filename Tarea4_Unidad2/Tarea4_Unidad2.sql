CREATE DATABASE Tarea4_Unidad2
drop DATABASE Tarea4_Unidad2
USE Tarea4_Unidad2

CREATE TABLE PROVEEDOR(
    Id_Proveedor INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR (100) NOT NULL,
    Categoria VARCHAR (100) NOT NULL,
    Ciudad  VARCHAR(100) NOT NULL
)

INSERT INTO PROVEEDOR VALUES('Diana','Alimentos','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('Pepsi','Bebidas','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('Coca Cola','Bebidas','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('Frito-lay','Alimentos','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('Bimbo','Alimentos','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('SULA','Alimentos','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('Leyde','Alimentos','Tegucigalpa');
INSERT INTO PROVEEDOR VALUES('GAMESA','Alimentos','Tegucigalpa');
SELECT * FROM PROVEEDOR; 

CREATE TABLE PRODUCTO(
    Id_Producto INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(200) NOT NULL,
    Ciudad  VARCHAR(150) NOT NULL,
    Precio  MONEY NOT NULL 
)

INSERT INTO PRODUCTO VALUES('Elotitos Churro pequeño','Tegucigalpa',3);
INSERT INTO PRODUCTO VALUES('Pepsi Envace Vidrio L 1.5','Tegucigalpa',21);
INSERT INTO PRODUCTO VALUES('Coca COla Envace Vidrio L 1.5','Tegucigalpa',23);
INSERT INTO PRODUCTO VALUES('Doritos Churro Mediano','Tegucigalpa',7);
INSERT INTO PRODUCTO VALUES('Donas Espolvoreadas Bimbo','Tegucigalpa',20);
INSERT INTO PRODUCTO VALUES('leche bolsa litro','Tegucigalpa',24);
INSERT INTO PRODUCTO VALUES('Paquete de 6 Coca cola','Tegucigalpa',110);
SELECT * FROM PRODUCTO; 


CREATE TABLE CLIENTE(
    Id_Cliente INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR (100) NOT NULL,
    Ciudad VARCHAR (100) NOT NULL
)

INSERT INTO CLIENTE VALUES('Juan Pablo','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Pedro Picapiedras','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Rick Sanchez','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Bob Esponja','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Mordecai','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Gerson Funez','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Kerlyn','Tegucigalpa');
INSERT INTO CLIENTE VALUES('Alejandra','Tegucigalpa');
SELECT * FROM CLIENTE;

CREATE TABLE PEDIDO(
    Id_Pedido INT PRIMARY KEY IDENTITY(1,1),
    Id_Producto INT FOREIGN KEY REFERENCES PRODUCTO,
    Id_Cliente INT FOREIGN KEY REFERENCES CLIENTE,
    Id_Proveedor INT FOREIGN KEY REFERENCES PROVEEDOR,
    Fecha_Pedido DATE NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Total MONEY NOT NULL
)

INSERT INTO PEDIDO VALUES(1,1,1,'25-03-2022',1,3);
INSERT INTO PEDIDO VALUES(2,2,2,'25-03-2022',20,420);
INSERT INTO PEDIDO VALUES(3,3,3,'25-03-2022',20,460);
INSERT INTO PEDIDO VALUES(4,4,4,'25-03-2022',100,700);
INSERT INTO PEDIDO VALUES(5,5,5,'25-03-2022',20,400);
INSERT INTO PEDIDO VALUES(3,6,3,'25-03-2022',20,1);
INSERT INTO PEDIDO VALUES(3,7,3,'28-03-2022',3,330);
INSERT INTO PEDIDO VALUES(3,8,3,'28-03-2022',1,110);
SELECT * FROM PEDIDO;

CREATE TABLE INVENTARIO(
    Id_Iventario INT PRIMARY KEY IDENTITY (1,1),
    Id_Producto INT FOREIGN KEY REFERENCES PRODUCTO,
    Fecha DATE NOT NULL,
    Cantidad INT NOT NULL  
)

INSERT INTO INVENTARIO VALUES(1,'28-03-2022',40);
INSERT INTO INVENTARIO VALUES(2,'29-03-2022',5);
INSERT INTO INVENTARIO VALUES(3,'31-03-2022',8);
INSERT INTO INVENTARIO VALUES(4,'3-04-2022',60);
INSERT INTO INVENTARIO VALUES(5,'7-04-2022',6);
SELECT * FROM INVENTARIO;

/**1.Encontrar el id y nombre del proveedor que proveen el producto con  id=1**/

SELECT Id_Proveedor, Nombre 
FROM PROVEEDOR PV
INNER JOIN PRODUCTO PR
 ON PV.Id_Proveedor = PR.Id_Producto AND Id_Producto=1

/**2.Encontrar los clientes (nombre cliente) que realizaron pedidos de los productos proveídos por el proveedor con id=1**/

SELECT CL.Nombre
FROM CLIENTE CL 
INNER JOIN PEDIDO PD ON CL.Id_Cliente = PD.Id_Pedido
INNER JOIN PRODUCTO PR ON PR.Id_Producto = PD.Id_Pedido
INNER JOIN PROVEEDOR PV ON PV.Id_Proveedor = PR.Id_Producto
WHERE PV.Id_Proveedor = 1


/**3.Encontrar los proveedores que suministran todos los productos cuyo precio es mayor al precio promedio de los productos.**/

SELECT  Nombre FROM  PROVEEDOR AS PV
INNER JOIN PRODUCTO PD ON PD.Id_Producto = PV.Id_Proveedor
WHERE Precio > (SELECT AVG(Precio) FROM PRODUCTO)


/**4.Listar los proveedores a los cuales no se les haya solicitado ningún producto**/
SELECT Nombre FROM PROVEEDOR AS PV 
FULL OUTER JOIN PRODUCTO AS PR
ON PR.Id_Producto = PV.Id_Proveedor
WHERE Id_Producto IS NULL

/**5.Listar los nombres de los clientes  que hayan pedido más de un producto y que el precio sea mayor a 100**/
SELECT Nombre FROM CLIENTE AS CL
INNER JOIN PEDIDO AS PD ON CL.Id_Cliente = PD.Id_Pedido
INNER JOIN PRODUCTO AS PR  ON PR.Id_Producto = PD.Id_Pedido
WHERE  Cantidad > 1 AND Precio > 100;

/**6.Listar la cantidad y el precio de cada producto que hayan sido pedido por los clientes entre las fechas 01-01-2022 y 20-03-2022, 
se requiere visualizar el nombre del cliente, el nombre del producto, nombre del proveedor , cantidad y precio del producto.**/






/**7.Listar los nombres de los clientes que hayan solicitado más de un producto.**/
SELECT Nombre FROM CLIENTE AS CL
INNER JOIN PEDIDO AS PD ON CL.Id_Cliente = PD.Id_Pedido
INNER JOIN PRODUCTO AS PR  ON PR.Id_Producto = PD.Id_Pedido
WHERE  Cantidad > 1 