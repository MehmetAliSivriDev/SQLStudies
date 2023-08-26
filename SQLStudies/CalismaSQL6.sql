--VTYS1_11_13 Uygulama 1'in Cevaplar�d�r.

--Sorgu K�s�mlar�

--Employess, orders ve products tablolar�ndaki t�m verileri Select komutu ile listeleyiniz.
select * from Employees
select * from Orders
select * from Products

--(Customers) M��terilerin firma ad�, yetkili ki�i ve telefon numaralar� bilgilerini listeleyiniz.
select CompanyName,ContactName,Phone from Customers

--Bulunulan tarihe(ay-g�n) ait sipari�lerin hangi y�lda verildi�i bilgilerini Ay bilgisine g�re listeleyen
--SQL komutunu yaz�n�z.
select CustomerID,DATEPART(YEAR,OrderDate) as Y�l from Orders where DATEPART(DAY,OrderDate) = DATEPART(DAY,GETDATE())
and DATEPART(MONTH,OrderDate) = DATEPART(MONTH,GETDATE()) order by Y�l

--1996 y�l�nda bug�nk� ay ve g�nde teslimat� yap�lmas� gereken sipari�leri listeleyiniz.
select * from Orders where DATEPART(DAY,ShippedDate) = DATEPART(DAY,GETDATE()) and 
DATEPART(MONTH,ShippedDate) = DATEPART(MONTH,GETDATE()) and DATEPART(YEAR,ShippedDate) = '1996'

--Sipari�lerin, sipari� verildi�i tarih ile sipari�in teslim edilmesi istenilen tarih aras�ndaki fark� (g�n
--baz�nda) ve m��teri id bilgilerini listeleyen SQL kodunu yaz�n�z.
select CustomerID,DATEDIFF(DAY,OrderDate,ShippedDate) as 'G�n Fark�' from Orders

--Teslimat b�lgesi Essex olan sipari�leri listeleyiniz.
select *  from Orders where ShipRegion = 'Essex'

--Birim fiyat� en y�ksek olan �r�n�n fiyat bilgisini listeleyen SQL kodunu yaz�n�z.
select MAX(UnitPrice) as Fiyat from Products

--Yumu�ak i�ime (Soft drinks ) sahip i�eceklerin hangi kategoriye ait oldu�unu listeleyen SQL kodunu yaz�n�z.
select CategoryName,Description from Categories where Description like '%Soft Drinks%'

--1997 y�l�nda teslim edilen ve m��teri �d bilgisi LILAS olan sipari�leri listeleyiniz.
select CustomerID,DATEPART(YEAR,ShippedDate) AS 'Teslim Y�l�' from Orders where
CustomerID = 'LILAS' and DATEPART(YEAR,ShippedDate) = '1997'

--Brezilya veya Meksika�da bulunan m��teri bilgilerini listeleyiniz.
select * from Customers where Country= 'Brazil' or Country = 'Mexico'

--Teslimat b�lgesi �talya, Fransa ve �ngiltere olan sipari�leri listeleyiniz.
select * from Orders where ShipCountry = 'Italy' or ShipCountry = 'France' or ShipCountry = 'England'

--10.02.1996 ve 10.02.1997 tarihleri aras�nda verilmi� olan sipari�leri listeleyiniz.
select * from Orders where OrderDate between '02.10.1990' and '02.10.1997'

--M��teri id bilgisi KOENE olan firman�n sipari�lerini a��rl��a g�re s�ralayan SQL kodunu yaz�n�z.
Select * from Orders where CustomerID = 'KOENE' order by Freight ASC

--Sipari� a��rl��� 100 kg dan fazla olan ve teslimat �lkesi Almanya olan sipari�leri listeleyiniz.
select * from Orders where Freight > 100 and ShipCountry = 'Germany'

--M��teri ad�, firmada ki yetkili ki�i, yetkili ki�inin unvan� ve adres bilgilerini firma ismine g�re
--azalan olarak listeleyen SQL kodunu yaz�n�z.
select CompanyName as 'M��teri Ad�',ContactName as 'Yetkili Ki�i',ContactTitle as �nvan�,Address Adres from Customers
order by CompanyName DESC

--Sipari�lerin m��teri id�sini, Teslimat adresini,a��rl���n� ve teslimat tarihini, sipari� tarihine g�re
--artan ve a��rl��a g�re azalan s�rada listeleyen SQL kodunu yaz�n�z.
select CustomerID,ShipAddress,Freight,ShippedDate from Orders order by OrderDate ASC,Freight DESC

--�lkeler benzersiz olacak �ekilde sipari� al�nan �lkeler bilgilerini listeleyen SQL kodunu yaz�n�z.
select distinct ShipCountry from Orders

--M��terilerin �ehir bilgisini takma ad� M.�ehir olacak �ekilde listeleyiniz.
select Country as 'M.�ehir' from Customers

--1960�dan sonra do�an personellerin ad�n�, soyad�n� ve unvan k�saltmas�n� tek alan alt�nda soyad
--bilgisine g�re azalan olarak listeleyen SQL kodunu yaz�n�z.
select TitleOfCourtesy + FirstName + ' ' + LastName as '�al��an Bilgisi' from Employees
order by FirstName + ' ' + LastName DESC

--Personellerin do�um tarihlerini 107 format�na uygun �ekilde listeleyiniz.
select FirstName + ' ' + LastName as AdSoyad,CONVERT(varchar,BirthDate,107) as 'Do�um Tarihi' from Employees