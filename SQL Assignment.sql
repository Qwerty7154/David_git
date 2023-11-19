--1. List all suppliers in the UK
SELECT 
	CompanyName, 
	Id, 
	ContactName, 
	City, 
	Country,
	Phone  
FROM dbo.Supplier
WHERE lower(Country) = 'uk';
--2. List the first name, last name, and city for all customers.
--Concatenate the first and last name separated by a space and a comma as a single column
SELECT 
	CONCAT(FirstName,' ,',LastName) AS Customer_FullName, 
	City
FROM dbo.Customer;
--3. List all customers in Sweden
SELECT *
FROM dbo.Customer
WHERE lower(Country) = 'sweden';
--4. List all suppliers in alphabetical order
SELECT 
	CompanyName, 
	Id, 
	ContactName, 
	City, 
	Country,
	Phone,
	Fax
FROM dbo.Supplier
ORDER BY CompanyName ASC;
--5. List all suppliers with their products
SELECT s.CompanyName, p.ProductName
FROM dbo.Supplier s
LEFT JOIN dbo.Product p ON (s.Id = p.SupplierId)
;
--6. List all orders with customers information
SELECT
	O.Id AS OrderID,
	O.OrderDate,
	CONCAT(C.FirstName,' ,',C.LastName) AS Customer_FullName, 
	C.City, 
	C.Id AS CustomerId, 
	C.Country,
	C.Phone
FROM [dbo].[Order] O
LEFT JOIN dbo.Customer C ON (O.CustomerId = C.Id);
--7. List all orders with product name, quantity, and price, sorted by order number
SELECT
	OI.OrderId,
	P.ProductName,
	OI.ProductId,
	OI.Quantity,
	OI.UnitPrice
FROM dbo.OrderItem OI
LEFT JOIN dbo.Product P ON (P.Id = OI.ProductId)
ORDER BY OI.OrderId;
--8. Using a case statement, list all the availability of products. When 0 then not available, else available
SELECT 
	ProductName, 
	Id as ProductID,
	CASE WHEN IsDiscontinued = 0 THEN 'Not Available'
	ELSE 'Available'
	END AS Availability
FROM dbo.Product;
--9. Using case statement, list all the suppliers and the language they speak. 
--The language they speak should be their country E.g if UK, then English
SELECT CompanyName, Id AS SupplierID,
	CASE 
		WHEN lower(Country) = 'australia' THEN 'English'
		WHEN lower(Country) = 'brazil' THEN 'Portuguese'
		WHEN lower(Country) = 'canada' THEN 'English and French'
		WHEN lower(Country) = 'denmark' THEN 'English'
		WHEN lower(Country) = 'finland' THEN 'Finnish and Swedish'
		WHEN lower(Country) = 'france' THEN 'French'
		WHEN lower(Country) = 'germany' THEN 'German'
		WHEN lower(Country) = 'italy' THEN 'Italian'
		WHEN lower(Country) = 'japan' THEN 'Japanese'
		WHEN lower(Country) = 'netherland' THEN 'Dutch'
		WHEN lower(Country) = 'norway' THEN 'Norwegian and Sami'
		WHEN lower(Country) = 'singapore' THEN 'English, Malay, Tamil and Singaporean Madarin'
		WHEN lower(Country) = 'spain' THEN 'Spanish'
		WHEN lower(Country) = 'sweden' THEN 'Swedish'
		WHEN lower(Country) = 'uk' THEN 'English'
		WHEN lower(Country) = 'usa' THEN 'English'
		ELSE 'Location not specified'
	END AS Language_Spoken
FROM dbo.Supplier;
--10. List all products that are packaged in Jars 
SELECT 
	ProductName, 
	Id AS ProductID,
	Package
FROM dbo.Product
WHERE lower(Package) LIKE '%jars%';
--11. List procucts name, unitprice and packages for products that starts with Ca 
SELECT 
	ProductName, 
	UnitPrice,
	Package
FROM dbo.Product
WHERE lower(ProductName) LIKE 'ca%';
--12. List the number of products for each supplier, sorted high to low. 
SELECT 
	S.CompanyName, 
	S.Id, 
	COUNT(P.SupplierId) AS Number_Of_Products
FROM dbo.Supplier AS S
INNER JOIN dbo.Product AS P ON (S.Id = P.SupplierId)
GROUP BY S.CompanyName, S.Id
ORDER BY COUNT(P.SupplierId) DESC;
--13. List the number of customers in each country. 
SELECT 
	C.Country,  
	COUNT(C.Id) AS Number_Of_Customers
FROM dbo.Customer AS C
GROUP BY C.Country;
--14. List the number of customers in each country, sorted high to low. 
SELECT 
	C.Country,  
	COUNT(C.Id) AS Number_Of_Customers
FROM dbo.Customer AS C
GROUP BY C.Country
ORDER BY COUNT(C.Id) DESC;
--15. List the total order amount for each customer, sorted high to low. 
SELECT
	C.Id,
	CONCAT(C.FirstName,' ,',C.LastName) AS Customer_FullName,
	SUM(O.TotalAmount) Total_amount_per_customer
FROM dbo.Customer C
LEFT JOIN [dbo].[Order] O ON (C.Id = O.CustomerId)
GROUP BY C.Id,CONCAT(C.FirstName,' ,',C.LastName)
ORDER BY SUM(O.TotalAmount) DESC;
--16. List all countries with more than 2 suppliers.
SELECT 
	S.Country,  
	COUNT(S.Id) AS Number_Of_Suppliers
FROM dbo.Supplier AS S
GROUP BY S.Country
HAVING COUNT(S.Id) > 2
ORDER BY COUNT(S.Id) DESC;
--17. List the number of customers in each country. Only include countries with more than 10 customers. 
SELECT 
	C.Country,  
	COUNT(C.Id) AS Number_Of_Customers
FROM dbo.Customer AS C
GROUP BY C.Country
HAVING COUNT(C.Id) > 10
ORDER BY COUNT(C.Id) DESC;
--18. List the number of customers in each country, except the USA, sorted high to low. 
--Only include countries with 9 or more customers. 
SELECT 
	C.Country,  
	COUNT(C.Id) AS Number_Of_Customers
FROM dbo.Customer AS C
WHERE C.Country <> 'USA'
GROUP BY C.Country
HAVING COUNT(C.Id) > 9
ORDER BY COUNT(C.Id) DESC;
--19. List customer with average orders between $1000 and $1200. 
SELECT
	CONCAT(C.FirstName,' ,',C.LastName) AS Customer_FullName,
	C.Id,
	AVG(O.TotalAmount) Total_amount_per_customer
FROM dbo.Customer C
LEFT JOIN [dbo].[Order] O ON (C.Id = O.CustomerId)
GROUP BY CONCAT(C.FirstName,' ,',C.LastName), C.Id
HAVING (AVG(O.TotalAmount) BETWEEN 1000 AND 1200)
ORDER BY AVG(O.TotalAmount) DESC;
--20. Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013.
SELECT
	CONCAT(MONTH(OrderDate),'-',YEAR(OrderDate)) AS Month_and_Year,
	COUNT(OrderDate) AS Total_number_of_orders,
	SUM(TotalAmount) AS Total_Amount_Sold
FROM [dbo].[Order]
WHERE (YEAR(OrderDate) = '2013' AND MONTH(OrderDate) = '1')
GROUP BY CONCAT(MONTH(OrderDate),'-',YEAR(OrderDate));