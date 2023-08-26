-- T-SQL de deðiþken tanýmlama örnekleri 
declare @personel_adi nvarchar(30)
declare @tckimlik int 
declare @dog_tar datetime
declare @ad varchar(20) = 'Hasan Emre'
declare @ise_baslam_tarihi date = '01/30/2012'
declare @sayi1 int = 10, @sayi2 int = 20


-- SET komutu deðiþkene deðer atamak için kullanýlýr.
declare @vize int 
set @vize = 100

-- Genellikle SELECT ile deðer atama tablo sorgulandýðýnda bir deðerin saklanmasý gerektiðinde kullanýlýr.
declare @final int
select @final = 100

declare @isim varchar(30), @soyisim varchar(30)
select @ad = adi, @soyisim = soyadi from ogrenci where ogr_no = 1195613033

-- uygulama 1
-- FAKULTE veritabanýnagöre 104 kodlu dersin finalinden en yüksek notu alanlarýn ad, soyadve final notu bilgilerini 
-- listeleyen SQL sorgusunu hazýrlayýnýz.
declare @enyuksekfinal int 

select @enyuksekfinal = max(final) from ogrenci, notlar       -- en yüksek final notunu atar
where ders_kodu = 104

select adi,soyadi, final from ogrenci, notlar
where ogrenci.ogr_no = notlar.ogr_no and ders_kodu = 104  and  final = @enyuksekfinal

-- bu soruyu içiçe select ile de çözebiliriz
select adi,soyadi, final from ogrenci, notlar
where ogrenci.ogr_no = notlar.ogr_no and ders_kodu = 104  and  
final = (select max(final) from notlar where ders_kodu = 104) 



-- uygulama 2
-- FAKULTE veritabanýnagöre 104 kodlu dersin finalinden en düþük notu alanlarýn ad, soyad ve final notu bilgilerini listeleyiniz.

declare @endusukfinal int 

select @endusukfinal = min(final) from notlar where ders_kodu = 104

select adi, soyadi, final from ogrenci,notlar where ogrenci.ogr_no = notlar.ogr_no and  ders_kodu = 104  and final = @endusukfinal




-- @@CONNECTIONS:Sunucu baþlatýldýðýndan itibaren açýlan veya açýlmaya çalýþýlan oturum sayýsýný verir.
select @@CONNECTIONS as 'Oturum Açma'

-- @@MAX_CONNECTIONS: Sunucuya ayný anda yapýlabilecek baðlantý sayýsýný verir.
select @@MAX_CONNECTIONS as 'Maks. baðlantý'

-- @@SERVERNAME: Sunucunun ismini verir.
select @@SERVERNAME 

-- @@VERSION: SQL Server versiyonunu verir.
select @@VERSION

-- @@ROWCOUNT: Çalýþtýrýlan son sorgu sonucu etkilenen satýr sayýsýný verir.
select * from ogrenci
PRINT @@ROWCOUNT
PRINT 'Adet Öðrenci Var'

-- @@LANGID: Sunucunun dil id’siniverir. Eðer dil id0 ise sunucu “us_english” olarak ayarlanmýþtýr. Türkçenin dil id’si22 dir.
select @@LANGID

-- @@LANGUAGE: Sunucunun dil bilgisini ekrana yazar.
select @@LANGUAGE



-- if else yapýsý
if MONTH(GETDATE()) = 3
	print 'Aylardan Nisan'   -- true
else 
	print 'Aylardan Nisan deðil'   -- false



if YEAR(GETDATE())  <>  YEAR(DATEADD (DAY, 1, GETDATE()))
	print 'Bugün yýlýn son günü'
else
	if MONTH(GETDATE()) <>  MONTH(DATEADD(DAY, 1, GETDATE()))
		print 'Bugün Ayýn son günü fakat yýlýn son günü deðil'
	else
		print 'Bugün ayýn son günü deðil'


-- Bir tabloda kayýt olup olmadýðý kontrol edilmek isteniyorsa, IFEXISTS (Varsa)komut yapýsý kullanýlabilir.
-- Genellikle tablonun boþ olup olmadýðý veya aranan kayýtýn bulunup bulunmadýðýna bakýldýðýndan IF NOT EXISTS (Eðer Yoksa) daha çok kullanýlýr.
/*
if not exists(select *  from ogrenci)
	begin
		drop table ogrenci
		print 'ogrenci tablosu veri tabanýndan silindi'
	end
else 
	begin 
		print 'Ogrenci tablosunda ogrenci bulunmaktadýr'
	end
*/


-- CASEyapýsý T-SQL’de oldukça iþlevli olarak kullanýlabilecek bir koþul ifadesidir.
-- CASE yapýsýnýn önemli bir noktasý da DML komutlarýnýn (SELECT gibi) arasýna yazýlabilmesidir.

select adi, soyadi, 
	case cinsiyet 
		when 0 then 'Erkek'
		when 1 then 'Kadýn'
	end as 'Cinsiyet'
from ogrenci

--yukarýdakinin farklý versiyonu
select adi, soyadi, 
	IIF(cinsiyet = 0, 'Erkek', 'Kadýn') as 'Cinsiyet'  -- koþuldan sonra doðru ise gelir deðilse ikinci deðer gelir
from ogrenci


-- Uygulama 3
-- Vizenin %40’ý ve finalin %60’ý alýnarak hesaplanan dersin baþarý notu 50 ve 50 den büyük olanlarýn 
-- durum alanýnda BAÞARILI, deðilse BAÞARISIZ yazan ve ekrandaki çýktýyý veren SQL sorgusunu yazýnýz.

select ogr_no, vize, final, (vize*0.4 + final*0.6) as 'bn',
	case 
		when vize*0.4 + final*0.6 >= 50 then 'Baþarýlý'
		when vize*0.4 + final*0.6 < 50 then 'Baþarýsýz'
	end as 'Durum'
from notlar
order by bn desc




-- odev
-- Tablodaki harf notu aralýklarýna ve baþarý deðerlendirmesine göre aþaðýdaki ekran çýktýsýný veren SQL sorgusunu hazýrlayýnýz.
select o.ogr_no, adi, soyadi, ders_adi, vize, final, (vize*0.4 + final*0.6) as 'ort', 
	case 
		when 100 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 90 then 'AA' 
		when 89 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 85 then 'BA'
		when 84 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 80 then 'BB'
		when 79 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 75 then 'CB'
		when 74 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 65 then 'CC'
		when 64 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 55 then 'DC'
		when 54 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 50 then 'DD'
		when 49 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 30 then 'FD'
		when 29 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 0 then 'FF'
	end as 'harf_notu',
	
	case
		when 100 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 90 then 'Pekiyi' 
		when 89 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 85 then 'Ýyi-Pekiyi'
		when 84 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 80 then 'Ýyi'
		when 79 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 75 then 'orta-iyi'
		when 74 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 65 then 'orta'
		when 64 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 55 then 'orta-geçer'
		when 54 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 50 then 'koþullu geçer'
		when 49 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 30 then 'Baþarýsýz'
		when 29 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 0 then 'Baþarýsýz'
	end as 'durum'
from ogrenci o, notlar n, dersler d
where o.ogr_no = n.ogr_no  and  n.ders_kodu = d.ders_kodu
order by vize*0.4 + final*0.6 desc

