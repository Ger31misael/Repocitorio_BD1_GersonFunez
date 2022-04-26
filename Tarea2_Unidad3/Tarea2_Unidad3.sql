/*Tarea 2-Unidad 3*/
USE Northwind;
alter table territories alter column TerritoryDescription varchar(100)
alter table CustomerDemographics alter COLUMN CustomerDesc int


/* 1. Cree un trigger que se active cuando se inserte o actualice un registro de la tabla Territories 
recuerde tomar el registro actual desde la tabla inserted y concatene al nombre del Territorio 
(TerritoryDescription) el prefijo “_try” al final del mismo.*/

CREATE TRIGGER Territorios
ON Territories
AFTER INSERT, UPDATE
AS
BEGIN
    SELECT TerritoryDescription + '_try' FROM inserted
    PRINT('Dato concatenado')
END


insert into Territories VALUES(0010, 'Choluteca',1);


/* 2.Cree un trigger para la tabla CustomerCustomerDemo que se active cuando se inserte o actualice
 un registro y calcule el campo CustomerDesc multiplicando el valor proveído en el 
 insert *  0.25 y sumando 150. */

CREATE TRIGGER Calcular
  ON CustomerDemographics
    AFTER INSERT, UPDATE 
  AS
    BEGIN
      SELECT CustomerTypeID, CustomerDesc*0.25+150 FROM inserted
    END



INSERT into CustomerDemographics values(9,3)

UPDATE CustomerDemographics
SET CustomerDesc = 90
WHERE CustomerTypeID = 5;




/*3. Cree un trigger a la tabla CusomerDemogragraphics que se active cuando un registro es eliminado
  y que muestre un mensaje que diga “registro eliminado” y muestre un select de la tabla deleted.*/

CREATE TRIGGER Registro 
  ON CustomerDemographics
  AFTER DELETE
AS
    BEGIN
      SELECT * FROM deleted
      PRINT('REGISTRO ELIMINADO')
    END


DELETE FROM CustomerDemographics WHERE CustomerTypeID= 8;

SELECT * FROM CustomerDemographics


/*
Funciones
*/

/*
1. Construya una función que reciba como parámetro el año de contratación  de un empleado 
(HireDate) de la tabla employees y devuelva una tabla con todos los registros asociados.
*/

CREATE FUNCTION fn_Contratacion(@año DATETIME)
RETURNS TABLE
AS RETURN(SELECT * FROM Employees WHERE DATEPART(YEAR,HireDate)=@año)
  
   
SELECT * FROM fn_Contratacion(1992)

/*
2. Cree una función que reciba como parámetro el id de la tabla producto (products) y 
retorne el precio (UnitPrice) aplicando el 10% de descuento.
*/

CREATE FUNCTION fn_Descuento (@id int)
RETURNS MONEY
AS
  BEGIN
      DECLARE @Des MONEY
      SELECT @Des = (UnitPrice-UnitPrice*0.10) FROM Products WHERE ProductID = @id
      RETURN @Des
  END

drop FUNCTION fn_Descuento


SELECT * FROM dbo.fn_Descuento


/*
3. Cree una función que reciba como parámetro el OrderId y muestre información de la orden (Order) y 
    de su detalle (Order Details) mostrando ProductName, UnitPrice y Quantitiy, OrderDate, CustomerID
*/

CREATE FUNCTION fn_Detalle(@id VARCHAR(5))
RETURNS TABLE 
AS RETURN(
    SELECT P.ProductName,P.UnitPrice, OD.Quantity, O.OrderDate,C.CustomerID
    FROM Products AS P
    INNER JOIN [dbo].[Order Details] AS OD
      ON P.ProductID = OD.ProductID
    INNER JOIN Orders O 
      ON O.OrderID = OD.OrderID
    INNER JOIN Customers C 
      ON C.CustomerID = O.CustomerID

    WHERE  C.CustomerID = @id 

)

SELECT * FROM fn_Detalle('ANATR')


/*
4. Construya una función que reciba la fecha de nacimiento (BirthDate) de un empleado (Employees)
  y retorne el nombre del mes en el que nació el empleado considere el uso de la sentencia case.

*/

CREATE FUNCTION fn_Cumpleaños (@fecha DATETIME)
  RETURNS VARCHAR(12)
  AS 
  BEGIN
    DECLARE @MES VARCHAR(12)
    SELECT BirthDate=@fecha,
      CASE
          WHEN DATEPART(MONTH,BirthDate) = 1   THEN 'ENERO'
          WHEN DATEPART(MONTH,BirthDate) = 2   THEN 'FEBRERO'
          WHEN DATEPART(MONTH,BirthDate) = 3   THEN 'MARZO'
          WHEN DATEPART(MONTH,BirthDate) = 4   THEN 'ABRIL'
          WHEN DATEPART(MONTH,BirthDate) = 5   THEN 'MAYO'
          WHEN DATEPART(MONTH,BirthDate) = 6   THEN 'JUNIO'
          WHEN DATEPART(MONTH,BirthDate) = 7   THEN 'JULIO'
          WHEN DATEPART(MONTH,BirthDate) = 8   THEN 'AGOSTO'
          WHEN DATEPART(MONTH,BirthDate) = 9   THEN 'SEPTIEMBRE'
          WHEN DATEPART(MONTH,BirthDate) = 10   THEN 'OCTUBRE'
          WHEN DATEPART(MONTH,BirthDate) = 11   THEN 'NOVIEMBRE'
          ELSE 'DICIEMBRE'
      END AS 'MES DE CUMPLEAÑOS'
      FROM Employees
      RETURN @MES
  END
    

/*
5. Construya una función que reciba el código de un cliente y retorne todos los pedidos (Orders) 
ordenados por fecha.
*/


CREATE FUNCTION fn_Pedidos (@IdCliente VARCHAR(5))
RETURNS TABLE
AS RETURN(
  SELECT * FROM Orders
  WHERE Orders.CustomerID = @IdCliente
)

SELECT * FROM fn_Pedidos('HANAR')

