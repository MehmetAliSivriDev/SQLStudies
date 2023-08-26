--1. 1.En y�ksek nakliye �cretinin �dendi�i sat��a ait Nakliye firmas�, Sevk ad� ve Sevk  
--tarihi bilgilerini @enyuksekfiyat de�i�kenini kullanarak listeleyiniz listeleyiniz.   

DECLARE @enyuksekfiyat int
Select @enyuksekfiyat = MAX(NakliyeUcreti) from Satislar
Select n.SirketAdi,s.SevkAdi, s.SatisTarihi, s.NakliyeUcreti from Satislar s, Nakliyeciler n
where s.ShipVia = n.NakliyeciID and NakliyeUcreti = @enyuksekfiyat

--2. En gen� personelin ad�n�, soyad�n�, unvan� ve ya� bilgisini listeleyiniz. 

DECLARE @engenc int
SELECT @engenc = MIN(DATEDIFF(YEAR,DogumTarihi,GETDATE())) from Personeller
Select Adi,SoyAdi,Unvan,DATEDIFF(YEAR,DogumTarihi,GETDATE()) as 'Ya�' from Personeller where DATEDIFF(YEAR,DogumTarihi,GETDATE()) = @engenc

--3. Veri taban�nda bulunan �r�nlerin ad�n�, miktar bilgisini, 
--birim fiyat�n� ve birim fiyata g�re durumunu �Ortalaman�n Alt�nda�, �Ortalaman�n �st�nde� olacak �ekilde listeleyiniz. 
declare @ort float
select @ort = avg(BirimFiyati) from Urunler
select UrunAdi, Miktar,  u.BirimFiyati,
	case 
		when u.BirimFiyati >= @ort then 'Ortalaman�n �st�nde'
		when u.BirimFiyati < @ort  then 'Ortalaman�n Alt�nda'
	end as 'Durumu'
from Urunler u , [Satis Detaylari] sd
where u.UrunID = sd.UrunID

--4.�lk 10 sipari�te yer alan �r�nlerin birim fiyat toplam�n� bulan SQL kodunu yaz�n�z. 
--(ilk 10 adet sati� id si bilgisini tablo tipi bir de�i�kende tutup birim fiyat toplam�n� o tablodaki id lere g�re hesaplay�n�z.) 
