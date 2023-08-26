-- 1-Ýlk 10 sipariþte yer alan ürünlerin birim fiyat toplamýný bulan SQL kodunu yazýnýz. 
-- net cevap bu deðil 
Select SUM(od.UnitPrice) as 'Toplam' from [Order Details] od where od.OrderID <= 10251

    
-- 2-Ürünlerin ortalama fiyatlarýný TL eki ile birlikte kategorilerine göre þekildeki gibi gösteren SQL kodunu yazýnýz. 
Select str(ROUND(AVG(p.UnitPrice),0))+ ' TL' as 'Ortalama Fiyat' ,p.CategoryID as 'Kategori' from Products p group by p.CategoryID


-- 3-Her müþterinin toplamda kaç adet sipariþ verdiði bilgisini getiren SQL kodunu yazýnýz. 
Select CustomerID , COUNT(*) as 'Sipariþ Sayýsý' from Orders group by CustomerID

-- 4-En çok sipariþ veren müþterinin (3. Soru referans alýnabilir) aðýrlýðý en yüksek olan sipariþindeki 
--aðýrlýk miktarýný getiren SQL kodunu yazýnýz. 
Select top 1 CustomerID , COUNT(*) as 'Sipariþ Sayýsý' , max(Freight) as Aðýrlýk from Orders group by CustomerID 
order by 'Sipariþ Sayýsý' desc  
 

-- 5-Kategorilerine göre fiyatý en düþük olan ürünlerin ürün fiyatlarýný döken SQL kodunu yazýnýz. 
Select p.CategoryID, MIN(p.UnitPrice) as 'En Düþük Fiyat' from Products p group by p.CategoryID


-- 6-Ýndirim uygulanmýþ sipariþlerde %15 ve üzerinde olan ürünleri indirim oranlarýna göre listeleyen SQL kodunu yazýnýz.
select Discount, count(*) as 'Ürün Sayisi' from [Order Details] group by Discount
	having Discount >=0.15

-- 7-Sipariþlerin ilgili sipariþ ile ilgilenen personel adý ve soyadýný, sipariþ tarihini, gemi adresi ve aðýrlýk bilgilerini, gemi bölgesi Essex olacak þekilde aðýrlýklarýna göre büyükten küçüðe doðru sýralayan SQL kodunu yazýnýz. 
select e.FirstName, e.LastName, o.OrderDate, o.ShipAddress, o.Freight
from  Employees e 
inner join Orders o on e.EmployeeID = o.EmployeeID 
where o.ShipRegion = 'Essex' order by Freight desc



-- 8-Kadýn personellerin adýný, soyadýný, yaþýný ve hangi bölgeden olduðu bilgilerini listeleyen SQL kodunu her iki yöntemi kullanarak ayrý ayrý yazýnýz. 
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


-- 9-Sipariþ edilen ilk 10 sipariþe ait ürün ismi, ürün fiyatý, miktar bilgisi ve ürünün kategori bilgilerini listeleyen SQL kodunu yazýnýz.
select top 10 od.UnitPrice, od.Quantity, p.ProductName, c.CategoryName
from [Order Details] od
inner join Products p on od.ProductID = p.ProductID
inner join Categories c on p.CategoryID = c.CategoryID

select top 10 o.UnitPrice,o.Quantity,p.ProductName,c.CategoryName
from [Order Details] o,Products p,Categories c
where o.ProductID = p.ProductID and p.CategoryID = c.CategoryID


-- 10-Gelen sipariþ ve stok durumu kontrol edildiðinde yeniden tedarik edilmesi gereken ürünlerin ürün ismi, kategori ismi, 
-- tedarik edilmesi gereken miktar bilgisi ve tedarikçi firma ismi bilgilerini listeleyen SQL kodunu yazýnýz.   
select p.ReorderLevel, p.ProductName, s.CompanyName , c.CategoryName
from Products p
inner join Suppliers s on p.SupplierID = s.SupplierID
inner join Categories c on p.CategoryID = c.CategoryID
where p.ReorderLevel > 0

select p.ReorderLevel,p.ProductName,s.CompanyName,c.CategoryName
from Products p,Suppliers s, Categories c
where p.SupplierID = s.SupplierID and p.CategoryID = c.CategoryID and p.ReorderLevel > 0


