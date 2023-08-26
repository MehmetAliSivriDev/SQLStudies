--Bu Sorgular Northwind Veri Tabanýna Göre Yazýlmýþtýr

--***************************************************************************
-- Hiç Satýþ Yapamayan Personel Kontrol Sorgusu

Select *  From Employees e left join Orders o on e.EmployeeID = o.EmployeeID
where o.EmployeeID is null
--***************************************************************************

--Hangi Üründen Kaç Adet Satmýþýz Sorgusu

Select p.ProductName,sum(od.Quantity) as Adet from Products p inner join [Order Details] od on p.ProductID = od.ProductID
group by p.ProductName
--***************************************************************************

--Hangi Kategoriden Kaç Tane Satmýþýz Sorgusu
Select c.CategoryID,c.CategoryName,sum(od.Quantity) as Adet from Products p inner join Categories c on p.CategoryID = c.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID group by c.CategoryID,c.CategoryName
--****************************************************************************

--Çalýþanýn Adý Soyadý ve Üst Makamýný Kime Rapor Verdiðini Gösteren Sorgu
Select e2.LastName +' ' + e2.FirstName as EmployeeName, e1.LastName + ' ' + e1.FirstName as ReportsToWho 
from Employees e1 right join Employees e2 
on e1.EmployeeID = e2.ReportsTo
--****************************************************************************

