--1.Soru -> �lk 10 sipari�te yer alan �r�nlerin birim fiyat toplam�n� bulan SQL kodunu yaz�n�z.

Select o.OrderID as 'Birim Fiyat Toplam�' from [Order Details] od , Orders o 
where o.OrderID = od.OrderID and o.OrderDate <= '1996-07-16 00:00:00.000'

Select SUM(od.UnitPrice) as 'Toplam' from [Order Details] od where od.OrderID <= 10251

select SUM(UnitPrice) as ToplamFiyat From (
��� select top 10 UnitPrice
��� from [Order Details]) as T

--2.Soru -> �r�nlerin ortalama fiyatlar�n� TL eki ile birlikte kategorilerine g�re �ekildeki gibi g�steren SQL kodunu yaz�n�z.

Select p.CategoryID as 'Kategori', ROUND(AVG(p.UnitPrice),0) as 'Ortalama Fiyat' from Products p group by p.CategoryID

select str(AVG(UnitPrice)) + 'TL' as 'Ortalama Fiyat', CategoryID as 'Kategori' from Products group by CategoryID

--3.Soru -> Her m��terinin toplamda ka� adet sipari� verdi�i bilgisini getiren SQL kodunu yaz�n�z.

Select o.CustomerID as 'M��teriler', COUNT(*) as 'Toplam Adet' from Orders o group by o.CustomerID

select CustomerID,count(*) as 'Siprai� Say�s�' from Orders group by CustomerID
--4.Soru -> En �ok sipari� veren m��terinin (3. Soru referans al�nabilir) 
--a��rl��� en y�ksek olan sipari�indeki a��rl�k miktar�n� getiren SQL kodunu yaz�n�z. 

Select top 1 CustomerID , COUNT(*) as 'Toplam Adet' , max(Freight) as A��rl�k from Orders group by CustomerID 
order by 'Toplam Adet' desc

select MAX(Freight) from Orders where CustomerID = 'SAVEA' 

--5.SORU -> Kategorilerine g�re fiyat� en d���k olan �r�nlerin �r�n fiyatlar�n� d�ken SQL kodunu yaz�n�z. 

Select p.CategoryID, MIN(p.UnitPrice) as 'En D���k Fiyat' from Products p group by p.CategoryID

select min(UnitPrice) from Products group by CategoryID

--6.SORU -> �ndirim oran� %15 ve �zerinde olan �r�nleri indirim oranlar�na g�re listeleyen SQL kodunu yaz�n�z.
select Discount, COUNT(*) as '�r�n Say�s�' from [Order Details] group by Discount having Discount >= 0.15

--7.SORU -> Sipari�lerin ilgili sipari� ile ilgilenen personel ad� ve soyad�n�, sipari� tarihini, gemi adresi 
--ve a��rl�k bilgilerini, gemi b�lgesi Essex olacak �ekilde a��rl�klar�na g�re b�y�kten k����e do�ru s�ralayan SQL kodunu yaz�n�z. 
select e.FirstName,e.LastName,o.OrderDate,o.ShipAddress,o.Freight from Employees e, Orders o where e.EmployeeID = o.EmployeeID and o.ShipRegion = 'Essex' order by Freight desc

--8.SORU -> Kad�n personellerin ad�n�, soyad�n�, ya��n� ve hangi b�lgeden oldu�u bilgilerini listeleyen SQL kodunu her iki y�ntemi kullanarak ayr� ayr� yaz�n�z. 
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

--9.SORU -> Sipari� edilen ilk 10 sipari�e ait �r�n ismi, �r�n fiyat�, miktar bilgisi ve �r�n�n kategori bilgilerini listeleyen SQL kodunu yaz�n�z. 
select top 10 o.UnitPrice,o.Quantity,p.ProductName,c.CategoryName
from [Order Details] o,Products p,Categories c
where o.ProductID = p.ProductID and p.CategoryID = c.CategoryID

select top 10 od.UnitPrice, od.Quantity, p.ProductName, c.CategoryName
from [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID

--10.SORU -> Gelen sipari� ve stok durumu kontrol edildi�inde yeniden tedarik edilmesi gereken �r�nlerin �r�n ismi, kategori ismi, tedarik edilmesi gereken miktar bilgisi ve tedarik�i firma ismi bilgilerini listeleyen SQL kodunu yaz�n�z.   
select p.ReorderLevel,p.ProductName,s.CompanyName,c.CategoryName
from Products p,Suppliers s, Categories c
where p.SupplierID = s.SupplierID and p.CategoryID = c.CategoryID and p.ReorderLevel > 0

select p.ReorderLevel, p.ProductName, s.CompanyName , c.CategoryName
from Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
where p.ReorderLevel > 0