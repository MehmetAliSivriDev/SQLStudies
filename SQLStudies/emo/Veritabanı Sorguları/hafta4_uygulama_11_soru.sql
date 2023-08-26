-- 1- HILARION-Abastos isimli m��teriye ait sat�� bilgilerinin sevk tarihini, sevk �lkesini ve sevk �ehri bilgilerini listeleyiniz. 
select MusteriAdi,SevkTarihi, SevkUlkesi, SevkSehri from Satislar s, Musteriler m 
where  s.MusteriID = m.MusteriID and  m.MusteriAdi = 'HILARION-Abastos'  


-- 2- Birim fiyat� 50 ve �zeri olan �r�nlerin sat�� miktar� ve indirim oranlar�n� listeleyiniz. 
select Miktar, �ndirim from [Satis Detaylari]
where BirimFiyati >= 50

-- 3- Sat�� miktar� 10 ve �zeri olan �Geitost� adl� �r�n�n sat�� bilgilerine ait m��teri Id ve Sat�� Tarihi bilgilerini listeleyiniz. 
select m.MusteriID, SatisTarihi from Musteriler m, Satislar s, [Satis Detaylari] sd, urunler u
where m.MusteriID = s.MusteriID  and s.SatisID = sd.SatisID  and sd.UrunID = u.UrunID
and Miktar >= 10  and UrunAdi = 'Geitost'


-- 4-Birim fiyat�, Birim fiyatlar ortalamas�ndan b�y�k olan �r�nlerin sat�� bilgilerine ait m��teri id bilgisi ve sat�� tarihi bilgisini listeleyiniz. 
select MusteriID, SatisTarihi, Miktar, �ndirim, sd.BirimFiyati from Satislar s, [Satis Detaylari] sd
where s.SatisID = sd.SatisID  and   BirimFiyati > (select avg(BirimFiyati) from Urunler)



-- 5-Sat��� yap�lan deniz �r�nlerinin �r�n ad�, miktar� ve birim fiyat� bilgilerini listeleyiniz.  Deniz �r�nleri kategorisine ait �r�nler: 
select UrunAdi, BirimdekiMiktar, BirimFiyati from Urunler u, Kategoriler k
where  u.KategoriID = k.KategoriID and k.KategoriAdi = 'Seafood'


-- 6- M��terinin ad�, telefonu ve yap�lan sat��lara ait sat�� tarihi, sevk tarihi ve sevk �lkesi bilgilerini i�eren bir view tablosu olu�turunuz. 
use NorthwindTr go 
create view musterilerDosyasi as
select MusteriAdi, Telefon, SatisTarihi, SevkTarihi, SevkUlkesi from Musteriler m, Satislar s
where m.MusteriID = s.MusteriID


-- 7- Olu�turulan view�i sorgulay�n�z.
select * from musterilerDosyasi


-- 8- Olu�turulan view nesnesini kullanarak Sevk �lkesi Germany olan kay�tlar� isimlerine g�re s�ralay�n�z. 
select *  from musterilerDosyasi where SevkUlkesi = 'Germany'


-- 9- Olu�turulan view nesnesini kullanarak 1997 y�l�ndan sonraki ve m��teri ad� �Q� ile ba�layan m��terilere ait sat�� bilgilerini listeleyiniz. 
select *  from musterilerDosyasi where SatisTarihi >= '01.01.1998'  and MusteriAdi like 'Q%'


-- 10- Efektif olarak kullan�labilece�ini d���nd���n�z bir view nesnesi olu�turunuz. 
	

-- 11- SevkAdi bilgisine g�re bir index olu�turup arama s�resi aras�ndaki fark� kontrol ediniz. Daha sonra olu�turdu�unuz index�i siliniz. 
create index idx_satis_isim ON Satislar(SevkAdi);

select * from Satislar where SevkAdi = 'Island Trading'

drop index Satislar.idx_satis_isim