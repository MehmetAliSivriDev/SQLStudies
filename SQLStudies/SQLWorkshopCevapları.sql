--Bu Sorgular Northwind Veri Taban�na G�re Yaz�lm��t�r

--***************************************************************************
-- Hi� Sat�� Yapamayan Personel Kontrol Sorgusu

Select *  From Employees e left join Orders o on e.EmployeeID = o.EmployeeID
where o.EmployeeID is null
--***************************************************************************

--Hangi �r�nden Ka� Adet Satm���z Sorgusu

Select p.ProductName,sum(od.Quantity) as Adet from Products p inner join [Order Details] od on p.ProductID = od.ProductID
group by p.ProductName
--***************************************************************************

--Hangi Kategoriden Ka� Tane Satm���z Sorgusu
Select c.CategoryID,c.CategoryName,sum(od.Quantity) as Adet from Products p inner join Categories c on p.CategoryID = c.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID group by c.CategoryID,c.CategoryName
--****************************************************************************

--�al��an�n Ad� Soyad� ve �st Makam�n� Kime Rapor Verdi�ini G�steren Sorgu
Select e2.LastName +' ' + e2.FirstName as EmployeeName, e1.LastName + ' ' + e1.FirstName as ReportsToWho 
from Employees e1 right join Employees e2 
on e1.EmployeeID = e2.ReportsTo
--****************************************************************************

