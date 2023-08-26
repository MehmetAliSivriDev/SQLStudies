--1. Soru HILARION-Abastos isimli m��teriye ait sat�� bilgilerinin sevk tarihini, sevk �lkesini ve sevk �ehri bilgilerini listeleyiniz.

select m.MusteriAdi,s.SevkTarihi,s.SevkUlkesi,s.SevkSehri from Satislar s, Musteriler m
where s.MusteriID = m.MusteriID and m.MusteriAdi = 'Hilarion Abastos'

--2. Soru Birim fiyat� 50 ve �zeri olan �r�nlerin sat�� miktar� ve indirim oranlar�n� listeleyiniz. 

select s.UrunID,s.Miktar,s.�ndirim from [Satis Detaylari] s where s.BirimFiyati >= 50

--3. Soru Sat�� miktar� 10 ve �zeri olan �Geitost� adl� �r�n�n sat�� bilgilerine ait m��teri Id ve Sat�� Tarihi bilgilerini listeleyiniz.

select u.UrunAdi,s.MusteriID, s.SatisTarihi from [Satis Detaylari] sd , Urunler u , Satislar s 
where sd.UrunID = u.UrunID and sd.SatisID = s.SatisID and sd.Miktar > 10 and u.UrunAdi = 'Geitost'

--4. Soru Birim fiyat�, Birim fiyatlar ortalamas�ndan b�y�k olan �r�nlerin sat�� bilgilerine ait m��teri id bilgisi ve sat�� tarihi bilgisini listeleyiniz. 

select MusteriID,SatisTarihi,Miktar,�ndirim, sd.BirimFiyati from Satislar s, [Satis Detaylari] sd
where s.SatisID = sd.SatisID and BirimFiyati > (select AVG(BirimFiyati) from Urunler)

--5. Soru Sat��� yap�lan deniz �r�nlerinin �r�n ad�, miktar� ve birim fiyat� bilgilerini listeleyiniz.  Deniz �r�nleri kategorisine ait �r�nler: 

select u.UrunAdi,u.BirimdekiMiktar,u.BirimFiyati from Kategoriler k , Urunler u where k.KategoriID = u.KategoriID and
k.KategoriAdi = 'Seafood'

--6. Soru M��terinin ad�, telefonu ve yap�lan sat��lara ait sat�� tarihi, sevk tarihi ve sevk �lkesi bilgilerini i�eren bir view tablosu olu�turunuz. 

USE NorthwindTr 
GO
CREATE VIEW vw_musteri_satis_tablosu
AS
Select m.MusteriAdi,m.Telefon,s.SatisTarihi,s.SevkTarihi,s.SevkUlkesi from Musteriler m, Satislar s where m.MusteriID = s.MusteriID

--7.Soru Olu�turulan view�i sorgulay�n�z. 

select * from vw_musteri_satis_tablosu

--8. Soru Olu�turulan view nesnesini kullanarak Sevk �lkesi Germany olan kay�tlar� isimlerine g�re s�ralay�n�z.

select * from vw_musteri_satis_tablosu v where v.SevkUlkesi = 'Germany' 

--9. Soru Olu�turulan view nesnesini kullanarak 1997 y�l�ndan sonraki ve m��teri ad� �Q� ile ba�layan m��terilere ait sat�� bilgilerini listeleyiniz

select * from vw_musteri_satis_tablosu v where v.SatisTarihi > '01.01.1998' and v.MusteriAdi like 'Q%'

--10. Soru Efektif olarak kullan�labilece�ini d���nd���n�z bir view nesnesi olu�turunuz. 


--11. Soru SevkAdi bilgisine g�re bir index olu�turup arama s�resi aras�ndaki fark� kontrol ediniz. Daha sonra olu�turdu�unuz index�i siliniz. 

select * from Satislar where SevkAdi = 'Island Trading'

create index idx_satis_isim ON Satislar(SevkAdi);

drop index Satislar.idx_satis_isim