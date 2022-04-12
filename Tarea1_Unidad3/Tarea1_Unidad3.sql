USE Northwind;

/** 1.Cree una vista que muestre todos los empleados (employees) que reportan (ReportsTo) a un jefe **/
CREATE VIEW Reportan as
SELECT EmployeeID, LastName, FirstName, ReportsTo FROM Employees
WHERE ReportsTo >=1

SELECT *FROM Reportan;

/** 2.Crear una vista que muestre el ProductID, CompanyName, ProductName, CategoryName, Description, QuantityPerUnit,
   UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued de la tabla Supplier, products and Categories. **/

CREATE VIEW DETALLE AS
SELECT PR.ProductID, SUP.CompanyName, PR.ProductName, CA.CategoryName, CA.Description, 
PR.QuantityPerUnit, PR.UnitPrice, PR.UnitsInStock, PR.UnitsOnOrder, PR.ReorderLevel, PR.Discontinued
FROM Suppliers AS SUP
INNER JOIN Products AS PR
ON SUP.SupplierID=PR.SupplierID
INNER JOIN Categories CA 
ON CA.CategoryID = PR.CategoryID


SELECT * FROM DETALLE;
/** 3.Cree una vista que muestre el CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Country, 
   Phone, OrderDate, RequiredDate, ShippedDate de la table Customer y Orders**/

CREATE VIEW COMPRAS AS
SELECT Cu.CustomerID, Cu.CompanyName, Cu.ContactName,Cu.ContactTitle, Cu.Address, Cu.City, Cu.Country, Cu.Phone,
OD.OrderDate, OD.RequiredDate, OD.ShippedDate
   FROM Customers AS Cu
INNER JOIN Orders OD
   ON Cu.CustomerID =OD.CustomerID  

SELECT * FROM COMPRAS;

/**4. Modifique la vista del item 3 y remueva el campo Campo ContactTitle **/
ALTER VIEW COMPRAS AS
SELECT Cu.CustomerID, Cu.CompanyName, Cu.ContactName, Cu.Address, Cu.City, Cu.Country, Cu.Phone,
OD.OrderDate, OD.RequiredDate, OD.ShippedDate
   FROM Customers AS Cu
INNER JOIN Orders OD
   ON Cu.CustomerID =OD.CustomerID  
   
SELECT * FROM COMPRAS;

/**5. Elimine la vista del item 3**/
DROP VIEW COMPRAS;



/**Procedimientos Almacenados**/

/**1. Cree un procedimiento almacenado que muestre todas las ordenes (Orders) 
   realizadas por un empleado en un determinado año. **/

CREATE PROCEDURE getOrdenes 
    (@fecha  VARCHAR(15), @Empleado VARCHAR(20))
AS
   SELECT * FROM Orders AS OD
   INNER JOIN Employees EM
   ON OD.EmployeeID = EM.EmployeeID
   WHERE OD.OrderDate LIKE '%' + @fecha + '%' and EM.FirstName LIKE '%' + @Empleado + '%'



Execute getORDENES @Empleado = 'Andrew', @fecha = '1997';


/**2. Realice un procedimiento almacenado que muestre los clientes que pertencen a determinada ciudad.**/
CREATE PROCEDURE getClientes
   (@Ciudad VARCHAR(20))
AS
   SELECT * FROM Customers AS CM
   WHERE CM.City LIKE '%'+ @Ciudad + '%'


EXECUTE getClientes @Ciudad = 'Madrid'

/**3. Construya un procedimiento almacenado que filtre los empleados que cumpleaños cada mes utilizando el BirthDate.**/
CREATE PROCEDURE getCumpleaños
   (@Cumpleaños VARCHAR(30))
AS
SELECT FirstName, LastName, BirthDate FROM Employees AS EM
WHERE EM.BirthDate LIKE '____-%'+ @Cumpleaños + '__-%'




EXECUTE getCumpleaños @Cumpleaños='01'

drop PROCEDURE getCumpleaños
