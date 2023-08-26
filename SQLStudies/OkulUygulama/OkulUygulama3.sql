--1.Soru
select * from Employees
select * from Orders
select * from Products

select * from customers

--2.Soru
select CompanyName,ContactName,Phone from customers

--3.Soru
select CustomerID,DATEPART(YEAR,OrderDate) as Yýl from Orders where DATEPART(DAY,OrderDate) = DATEPART(DAY,GETDATE())
and DATEPART(MONTH,OrderDate) = DATEPART(MONTH,GETDATE()) order by Yýl

--4.Soru
select * from Orders where DATEPART(DAY,ShippedDate) = DATEPART(DAY,GETDATE())
and DATEPART(MONTH,ShippedDate) = DATEPART(MONTH,GETDATE()) and DATEPART(YEAR,ShippedDate) = '1996'

--5.Soru
select CustomerID,DATEDIFF(DAY,OrderDate,ShippedDate) as Fark from Orders  

--6.Soru
select * from Orders where ShipRegion = 'Essex'

--7.Soru
select MAX(UnitPrice) as Fiyat from Products 

--8.Soru
select CategoryName from Categories where Description like '%Soft Drinks%' 

--9.Soru
select * from Orders where CustomerID = 'LILAS' and Year(ShippedDate) = '1997'

--10.Soru
select * from Customers where Country = 'Brazil' or Country = 'Mexico'

--11.Soru
select * from Orders where ShipCountry = 'Italy' or ShipCountry = 'France' or ShipCountry = 'England' 

--12.Soru
select * from Orders where OrderDate between '10.02.1996' and '10.02.1997'

--13.Soru
select * from Orders where CustomerID = 'KOENE' order by Freight ASC 

--14.Soru
select * from Orders where ShipCountry = 'Germany' and Freight > 100

--15.Soru
select CompanyName as 'Müþteri Adý', ContactName as 'Yetkili Kiþi', ContactTitle as Unvaný,Address as Adres from Customers
order by CompanyName DESC

--16.Soru
select CustomerID,ShipAddress,Freight,ShippedDate from Orders order by Freight DESC, OrderDate 

--17.Soru
select distinct ShipCountry from Orders

--18.Soru
select Country as 'M.Þehir' from Customers

--19.Soru
select TitleOfCourtesy+FirstName + ' ' + LastName as 'Çalýþan Bilgisi' from Employees order by FirstName + ' ' + LastName DESC

--20.Soru
select FirstName as Ad,convert(varchar, BirthDate, 107) as 'Doðum Tarihi' from Employees