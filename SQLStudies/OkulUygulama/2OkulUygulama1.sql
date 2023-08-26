--1.Soru -> Ýlk 10 sipariþte yer alan ürünlerin birim fiyat toplamýný bulan SQL kodunu yazýnýz.

Select o.OrderID as 'Birim Fiyat Toplamý' from [Order Details] od , Orders o 
where o.OrderID = od.OrderID and o.OrderDate <= '1996-07-16 00:00:00.000'

Select SUM(od.UnitPrice) as 'Toplam' from [Order Details] od where od.OrderID <= 10251

select SUM(UnitPrice) as ToplamFiyat From (
    select top 10 UnitPrice
    from [Order Details]) as T

--2.Soru -> Ürünlerin ortalama fiyatlarýný TL eki ile birlikte kategorilerine göre þekildeki gibi gösteren SQL kodunu yazýnýz.

Select p.CategoryID as 'Kategori', ROUND(AVG(p.UnitPrice),0) as 'Ortalama Fiyat' from Products p group by p.CategoryID

select str(AVG(UnitPrice)) + 'TL' as 'Ortalama Fiyat', CategoryID as 'Kategori' from Products group by CategoryID

--3.Soru -> Her müþterinin toplamda kaç adet sipariþ verdiði bilgisini getiren SQL kodunu yazýnýz.

Select o.CustomerID as 'Müþteriler', COUNT(*) as 'Toplam Adet' from Orders o group by o.CustomerID

select CustomerID,count(*) as 'Sipraiþ Sayýsý' from Orders group by CustomerID
--4.Soru -> En çok sipariþ veren müþterinin (3. Soru referans alýnabilir) 
--aðýrlýðý en yüksek olan sipariþindeki aðýrlýk miktarýný getiren SQL kodunu yazýnýz. 

Select top 1 CustomerID , COUNT(*) as 'Toplam Adet' , max(Freight) as Aðýrlýk from Orders group by CustomerID 
order by 'Toplam Adet' desc

select MAX(Freight) from Orders where CustomerID = 'SAVEA' 

--5.SORU -> Kategorilerine göre fiyatý en düþük olan ürünlerin ürün fiyatlarýný döken SQL kodunu yazýnýz. 

Select p.CategoryID, MIN(p.UnitPrice) as 'En Düþük Fiyat' from Products p group by p.CategoryID

select min(UnitPrice) from Products group by CategoryID

--6.SORU -> Ýndirim oraný %15 ve üzerinde olan ürünleri indirim oranlarýna göre listeleyen SQL kodunu yazýnýz.
select Discount, COUNT(*) as 'Ürün Sayýsý' from [Order Details] group by Discount having Discount >= 0.15

--7.SORU -> Sipariþlerin ilgili sipariþ ile ilgilenen personel adý ve soyadýný, sipariþ tarihini, gemi adresi 
--ve aðýrlýk bilgilerini, gemi bölgesi Essex olacak þekilde aðýrlýklarýna göre büyükten küçüðe doðru sýralayan SQL kodunu yazýnýz. 
select e.FirstName,e.LastName,o.OrderDate,o.ShipAddress,o.Freight from Employees e, Orders o where e.EmployeeID = o.EmployeeID and o.ShipRegion = 'Essex' order by Freight desc

--8.SORU -> Kadýn personellerin adýný, soyadýný, yaþýný ve hangi bölgeden olduðu bilgilerini listeleyen SQL kodunu her iki yöntemi kullanarak ayrý ayrý yazýnýz. 
select distinct r.RegionDescription,e.FirstName,e.LastName,DATEDIFF(year,e.BirthDate,GETDATE()) 
from Employees e,EmployeeTerritories t1, Territories t2, Region r
where e.EmployeeID = t1.EmployeeID and t1.TerritoryID = t2.TerritoryID
and t2.RegionID = r.RegionID and e.TitleOfCourtesy = 'Ms.'

select distinct r.RegionDescription,e.FirstName,e.LastName,DATEDIFF(year,e.BirthDate,GETDATE()) 
from Employees e 
INNER JOIN EmployeeTerritories t1 ON e.EmployeeID = t1.EmployeeID
INNER JOIN Territories t2 ON t1.TerritoryID = t2.TerritoryID 
INNER JOIN Region r ON t2.RegionID = r.RegionID
where e.TitleOfCourtesy = 'Ms.'

--9.SORU -> Sipariþ edilen ilk 10 sipariþe ait ürün ismi, ürün fiyatý, miktar bilgisi ve ürünün kategori bilgilerini listeleyen SQL kodunu yazýnýz. 
select top 10 o.UnitPrice,o.Quantity,p.ProductName,c.CategoryName
from [Order Details] o,Products p,Categories c
where o.ProductID = p.ProductID and p.CategoryID = c.CategoryID

select top 10 od.UnitPrice, od.Quantity, p.ProductName, c.CategoryName
from [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID

--10.SORU -> Gelen sipariþ ve stok durumu kontrol edildiðinde yeniden tedarik edilmesi gereken ürünlerin ürün ismi, kategori ismi, tedarik edilmesi gereken miktar bilgisi ve tedarikçi firma ismi bilgilerini listeleyen SQL kodunu yazýnýz.   
select p.ReorderLevel,p.ProductName,s.CompanyName,c.CategoryName
from Products p,Suppliers s, Categories c
where p.SupplierID = s.SupplierID and p.CategoryID = c.CategoryID and p.ReorderLevel > 0

select p.ReorderLevel, p.ProductName, s.CompanyName , c.CategoryName
from Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
where p.ReorderLevel > 0