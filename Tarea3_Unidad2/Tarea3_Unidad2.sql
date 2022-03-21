use northwind;

/**EJERCICIO 1 **/
SELECT FirstName, LastName, HireDate FROM Employees AS Em 
WHERE Em.Title = 'Sales Representative' AND Em.Country = 'USA'


/**EJERCICIO 2 **/
SELECT * FROM Products WHERE ProductName LIKE '%Chocolate%'

/**EJERCICIO 3 **/
SELECT * FROM Orders 
WHERE ShipCountry = 'Germany' OR ShipCountry = 'France' OR ShipCountry = 'Brazil' OR ShipCountry = 'Venezuela'
ORDER BY ShipCountry

/**EJERCICIO 4 **/
SELECT Count(CustomerID) AS TotalCustomers FROM Customers

/**EJERCICIO 5 **/
SELECT Country  FROM Customers
GROUP BY Country

/**EJERCICIO 6 **/
SELECT ProductID, ProductName, CompanyName
FROM Products AS P , Suppliers AS S 
ORDER BY ProductID

/**EJERCICIO 7 **/
SELECT ProductName, UnitsInStock , ReorderLevel
FROM Products
WHERE UnitsInStock < ReorderLevel

/**EJERCICIO 8 **/
SELECT ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM Products
WHERE UnitsInStock+UnitsOnOrder <= ReorderLevel AND Discontinued=0

/**EJERCICIO 9 **/
SELECT * FROM Products WHERE UnitPrice BETWEEN 15 and 25
ORDER BY UnitPrice

/**EJERCICIO 10 **/
SELECT * FROM Suppliers WHERE Fax IS NULL


/**EJERCICIO 11 **/
SELECT AVG(Freight) AS Promedio FROM Orders

/**EJERCICIO 12 **/
UPDATE Customers SET ContactName = 'Gerson Funez' WHERE CustomerID = 'ERNSH'
SELECT * FROM Customers WHERE CustomerID = 'ERNSH'

/**EJERCICIO 13 **/
ALTER TABLE Orders ADD FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID) ON DELETE NO ACTION

ALTER TABLE [dbo].[Order Details] ADD FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID) ON DELETE CASCADE

DELETE FROM Customers WHERE CustomerID = 'WOLZA'


/**EJERCICIO 14 **/

SELECT MAX(UnitPrice) AS 'Precio Maximo', MIN(UnitPrice) AS 'Precio Minimo' FROM Products