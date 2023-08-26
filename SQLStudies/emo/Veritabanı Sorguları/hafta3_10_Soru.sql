-- 1-�lk 10 sipari�te yer alan �r�nlerin birim fiyat toplam�n� bulan SQL kodunu yaz�n�z. 
-- net cevap bu de�il 
Select SUM(od.UnitPrice) as 'Toplam' from [Order Details] od where od.OrderID <= 10251

��� 
-- 2-�r�nlerin ortalama fiyatlar�n� TL eki ile birlikte kategorilerine g�re �ekildeki gibi g�steren SQL kodunu yaz�n�z. 
Select str(ROUND(AVG(p.UnitPrice),0))+ ' TL' as 'Ortalama Fiyat' ,p.CategoryID as 'Kategori' from Products p group by p.CategoryID


-- 3-Her m��terinin toplamda ka� adet sipari� verdi�i bilgisini getiren SQL kodunu yaz�n�z. 
Select CustomerID , COUNT(*) as 'Sipari� Say�s�' from Orders group by CustomerID

-- 4-En �ok sipari� veren m��terinin (3. Soru referans al�nabilir) a��rl��� en y�ksek olan sipari�indeki 
--a��rl�k miktar�n� getiren SQL kodunu yaz�n�z. 
Select top 1 CustomerID , COUNT(*) as 'Sipari� Say�s�' , max(Freight) as A��rl�k from Orders group by CustomerID 
order by 'Sipari� Say�s�' desc  
 

-- 5-Kategorilerine g�re fiyat� en d���k olan �r�nlerin �r�n fiyatlar�n� d�ken SQL kodunu yaz�n�z. 
Select p.CategoryID, MIN(p.UnitPrice) as 'En D���k Fiyat' from Products p group by p.CategoryID


-- 6-�ndirim uygulanm�� sipari�lerde %15 ve �zerinde olan �r�nleri indirim oranlar�na g�re listeleyen SQL kodunu yaz�n�z.
select Discount, count(*) as '�r�n Sayisi' from [Order Details] group by Discount
	having Discount >=0.15

-- 7-Sipari�lerin ilgili sipari� ile ilgilenen personel ad� ve soyad�n�, sipari� tarihini, gemi adresi ve a��rl�k bilgilerini, gemi b�lgesi Essex olacak �ekilde a��rl�klar�na g�re b�y�kten k����e do�ru s�ralayan SQL kodunu yaz�n�z. 
select e.FirstName, e.LastName, o.OrderDate, o.ShipAddress, o.Freight
from  Employees e 
inner join Orders o on e.EmployeeID = o.EmployeeID 
where o.ShipRegion = 'Essex' order by Freight desc



-- 8-Kad�n personellerin ad�n�, soyad�n�, ya��n� ve hangi b�lgeden oldu�u bilgilerini listeleyen SQL kodunu her iki y�ntemi kullanarak ayr� ayr� yaz�n�z. 
select r.RegionDescription, e.FirstName, e.LastName, DATEDIFF(year,e.BirthDate,GETDATE())
from Employees e
inner join EmployeeTerritories et on e.EmployeeID = et.EmployeeID
inner join Territories t on et.TerritoryID = t.TerritoryID 
inner join Region r on t.RegionID = r.RegionID
where e.TitleOfCourtesy = 'MS.'

select distinct r.RegionDescription,e.FirstName,e.LastName,DATEDIFF(year,e.BirthDate,GETDATE()) 
from Employees e,EmployeeTerritories t1, Territories t2, Region r
where e.EmployeeID = t1.EmployeeID and t1.TerritoryID = t2.TerritoryID
and t2.RegionID = r.RegionID and e.TitleOfCourtesy = 'Ms.'


-- 9-Sipari� edilen ilk 10 sipari�e ait �r�n ismi, �r�n fiyat�, miktar bilgisi ve �r�n�n kategori bilgilerini listeleyen SQL kodunu yaz�n�z.
select top 10 od.UnitPrice, od.Quantity, p.ProductName, c.CategoryName
from [Order Details] od
inner join Products p on od.ProductID = p.ProductID
inner join Categories c on p.CategoryID = c.CategoryID

select top 10 o.UnitPrice,o.Quantity,p.ProductName,c.CategoryName
from [Order Details] o,Products p,Categories c
where o.ProductID = p.ProductID and p.CategoryID = c.CategoryID


-- 10-Gelen sipari� ve stok durumu kontrol edildi�inde yeniden tedarik edilmesi gereken �r�nlerin �r�n ismi, kategori ismi, 
-- tedarik edilmesi gereken miktar bilgisi ve tedarik�i firma ismi bilgilerini listeleyen SQL kodunu yaz�n�z.   
select p.ReorderLevel, p.ProductName, s.CompanyName , c.CategoryName
from Products p
inner join Suppliers s on p.SupplierID = s.SupplierID
inner join Categories c on p.CategoryID = c.CategoryID
where p.ReorderLevel > 0

select p.ReorderLevel,p.ProductName,s.CompanyName,c.CategoryName
from Products p,Suppliers s, Categories c
where p.SupplierID = s.SupplierID and p.CategoryID = c.CategoryID and p.ReorderLevel > 0


