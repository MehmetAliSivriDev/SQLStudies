-- 1- HILARION-Abastos isimli müþteriye ait satýþ bilgilerinin sevk tarihini, sevk ülkesini ve sevk þehri bilgilerini listeleyiniz. 
select MusteriAdi,SevkTarihi, SevkUlkesi, SevkSehri from Satislar s, Musteriler m 
where  s.MusteriID = m.MusteriID and  m.MusteriAdi = 'HILARION-Abastos'  


-- 2- Birim fiyatý 50 ve üzeri olan ürünlerin satýþ miktarý ve indirim oranlarýný listeleyiniz. 
select Miktar, Ýndirim from [Satis Detaylari]
where BirimFiyati >= 50

-- 3- Satýþ miktarý 10 ve üzeri olan ‘Geitost’ adlý ürünün satýþ bilgilerine ait müþteri Id ve Satýþ Tarihi bilgilerini listeleyiniz. 
select m.MusteriID, SatisTarihi from Musteriler m, Satislar s, [Satis Detaylari] sd, urunler u
where m.MusteriID = s.MusteriID  and s.SatisID = sd.SatisID  and sd.UrunID = u.UrunID
and Miktar >= 10  and UrunAdi = 'Geitost'


-- 4-Birim fiyatý, Birim fiyatlar ortalamasýndan büyük olan ürünlerin satýþ bilgilerine ait müþteri id bilgisi ve satýþ tarihi bilgisini listeleyiniz. 
select MusteriID, SatisTarihi, Miktar, Ýndirim, sd.BirimFiyati from Satislar s, [Satis Detaylari] sd
where s.SatisID = sd.SatisID  and   BirimFiyati > (select avg(BirimFiyati) from Urunler)



-- 5-Satýþý yapýlan deniz ürünlerinin ürün adý, miktarý ve birim fiyatý bilgilerini listeleyiniz.  Deniz ürünleri kategorisine ait ürünler: 
select UrunAdi, BirimdekiMiktar, BirimFiyati from Urunler u, Kategoriler k
where  u.KategoriID = k.KategoriID and k.KategoriAdi = 'Seafood'


-- 6- Müþterinin adý, telefonu ve yapýlan satýþlara ait satýþ tarihi, sevk tarihi ve sevk ülkesi bilgilerini içeren bir view tablosu oluþturunuz. 
use NorthwindTr go 
create view musterilerDosyasi as
select MusteriAdi, Telefon, SatisTarihi, SevkTarihi, SevkUlkesi from Musteriler m, Satislar s
where m.MusteriID = s.MusteriID


-- 7- Oluþturulan view’i sorgulayýnýz.
select * from musterilerDosyasi


-- 8- Oluþturulan view nesnesini kullanarak Sevk ülkesi Germany olan kayýtlarý isimlerine göre sýralayýnýz. 
select *  from musterilerDosyasi where SevkUlkesi = 'Germany'


-- 9- Oluþturulan view nesnesini kullanarak 1997 yýlýndan sonraki ve müþteri adý ‘Q’ ile baþlayan müþterilere ait satýþ bilgilerini listeleyiniz. 
select *  from musterilerDosyasi where SatisTarihi >= '01.01.1998'  and MusteriAdi like 'Q%'


-- 10- Efektif olarak kullanýlabileceðini düþündüðünüz bir view nesnesi oluþturunuz. 
	

-- 11- SevkAdi bilgisine göre bir index oluþturup arama süresi arasýndaki farký kontrol ediniz. Daha sonra oluþturduðunuz index’i siliniz. 
create index idx_satis_isim ON Satislar(SevkAdi);

select * from Satislar where SevkAdi = 'Island Trading'

drop index Satislar.idx_satis_isim