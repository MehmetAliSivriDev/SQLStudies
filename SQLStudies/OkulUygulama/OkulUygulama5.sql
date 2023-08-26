--1. 1.En yüksek nakliye ücretinin ödendiði satýþa ait Nakliye firmasý, Sevk adý ve Sevk  
--tarihi bilgilerini @enyuksekfiyat deðiþkenini kullanarak listeleyiniz listeleyiniz.   

DECLARE @enyuksekfiyat int
Select @enyuksekfiyat = MAX(NakliyeUcreti) from Satislar
Select n.SirketAdi,s.SevkAdi, s.SatisTarihi, s.NakliyeUcreti from Satislar s, Nakliyeciler n
where s.ShipVia = n.NakliyeciID and NakliyeUcreti = @enyuksekfiyat

--2. En genç personelin adýný, soyadýný, unvaný ve yaþ bilgisini listeleyiniz. 

DECLARE @engenc int
SELECT @engenc = MIN(DATEDIFF(YEAR,DogumTarihi,GETDATE())) from Personeller
Select Adi,SoyAdi,Unvan,DATEDIFF(YEAR,DogumTarihi,GETDATE()) as 'Yaþ' from Personeller where DATEDIFF(YEAR,DogumTarihi,GETDATE()) = @engenc

--3. Veri tabanýnda bulunan ürünlerin adýný, miktar bilgisini, 
--birim fiyatýný ve birim fiyata göre durumunu ‘Ortalamanýn Altýnda’, ‘Ortalamanýn Üstünde’ olacak þekilde listeleyiniz. 
declare @ort float
select @ort = avg(BirimFiyati) from Urunler
select UrunAdi, Miktar,  u.BirimFiyati,
	case 
		when u.BirimFiyati >= @ort then 'Ortalamanýn Üstünde'
		when u.BirimFiyati < @ort  then 'Ortalamanýn Altýnda'
	end as 'Durumu'
from Urunler u , [Satis Detaylari] sd
where u.UrunID = sd.UrunID

--4.Ýlk 10 sipariþte yer alan ürünlerin birim fiyat toplamýný bulan SQL kodunu yazýnýz. 
--(ilk 10 adet satiþ id si bilgisini tablo tipi bir deðiþkende tutup birim fiyat toplamýný o tablodaki id lere göre hesaplayýnýz.) 
