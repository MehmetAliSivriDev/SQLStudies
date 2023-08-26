--1. Soru HILARION-Abastos isimli müþteriye ait satýþ bilgilerinin sevk tarihini, sevk ülkesini ve sevk þehri bilgilerini listeleyiniz.

select m.MusteriAdi,s.SevkTarihi,s.SevkUlkesi,s.SevkSehri from Satislar s, Musteriler m
where s.MusteriID = m.MusteriID and m.MusteriAdi = 'Hilarion Abastos'

--2. Soru Birim fiyatý 50 ve üzeri olan ürünlerin satýþ miktarý ve indirim oranlarýný listeleyiniz. 

select s.UrunID,s.Miktar,s.Ýndirim from [Satis Detaylari] s where s.BirimFiyati >= 50

--3. Soru Satýþ miktarý 10 ve üzeri olan ‘Geitost’ adlý ürünün satýþ bilgilerine ait müþteri Id ve Satýþ Tarihi bilgilerini listeleyiniz.

select u.UrunAdi,s.MusteriID, s.SatisTarihi from [Satis Detaylari] sd , Urunler u , Satislar s 
where sd.UrunID = u.UrunID and sd.SatisID = s.SatisID and sd.Miktar > 10 and u.UrunAdi = 'Geitost'

--4. Soru Birim fiyatý, Birim fiyatlar ortalamasýndan büyük olan ürünlerin satýþ bilgilerine ait müþteri id bilgisi ve satýþ tarihi bilgisini listeleyiniz. 

select MusteriID,SatisTarihi,Miktar,Ýndirim, sd.BirimFiyati from Satislar s, [Satis Detaylari] sd
where s.SatisID = sd.SatisID and BirimFiyati > (select AVG(BirimFiyati) from Urunler)

--5. Soru Satýþý yapýlan deniz ürünlerinin ürün adý, miktarý ve birim fiyatý bilgilerini listeleyiniz.  Deniz ürünleri kategorisine ait ürünler: 

select u.UrunAdi,u.BirimdekiMiktar,u.BirimFiyati from Kategoriler k , Urunler u where k.KategoriID = u.KategoriID and
k.KategoriAdi = 'Seafood'

--6. Soru Müþterinin adý, telefonu ve yapýlan satýþlara ait satýþ tarihi, sevk tarihi ve sevk ülkesi bilgilerini içeren bir view tablosu oluþturunuz. 

USE NorthwindTr 
GO
CREATE VIEW vw_musteri_satis_tablosu
AS
Select m.MusteriAdi,m.Telefon,s.SatisTarihi,s.SevkTarihi,s.SevkUlkesi from Musteriler m, Satislar s where m.MusteriID = s.MusteriID

--7.Soru Oluþturulan view’i sorgulayýnýz. 

select * from vw_musteri_satis_tablosu

--8. Soru Oluþturulan view nesnesini kullanarak Sevk ülkesi Germany olan kayýtlarý isimlerine göre sýralayýnýz.

select * from vw_musteri_satis_tablosu v where v.SevkUlkesi = 'Germany' 

--9. Soru Oluþturulan view nesnesini kullanarak 1997 yýlýndan sonraki ve müþteri adý ‘Q’ ile baþlayan müþterilere ait satýþ bilgilerini listeleyiniz

select * from vw_musteri_satis_tablosu v where v.SatisTarihi > '01.01.1998' and v.MusteriAdi like 'Q%'

--10. Soru Efektif olarak kullanýlabileceðini düþündüðünüz bir view nesnesi oluþturunuz. 


--11. Soru SevkAdi bilgisine göre bir index oluþturup arama süresi arasýndaki farký kontrol ediniz. Daha sonra oluþturduðunuz index’i siliniz. 

select * from Satislar where SevkAdi = 'Island Trading'

create index idx_satis_isim ON Satislar(SevkAdi);

drop index Satislar.idx_satis_isim