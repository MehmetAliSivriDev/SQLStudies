-- T-SQL de de�i�ken tan�mlama �rnekleri 
declare @personel_adi nvarchar(30)
declare @tckimlik int 
declare @dog_tar datetime
declare @ad varchar(20) = 'Hasan Emre'
declare @ise_baslam_tarihi date = '01/30/2012'
declare @sayi1 int = 10, @sayi2 int = 20


-- SET komutu de�i�kene de�er atamak i�in kullan�l�r.
declare @vize int 
set @vize = 100

-- Genellikle SELECT ile de�er atama tablo sorguland���nda bir de�erin saklanmas� gerekti�inde kullan�l�r.
declare @final int
select @final = 100

declare @isim varchar(30), @soyisim varchar(30)
select @ad = adi, @soyisim = soyadi from ogrenci where ogr_no = 1195613033

-- uygulama 1
-- FAKULTE veritaban�nag�re 104 kodlu dersin finalinden en y�ksek notu alanlar�n ad, soyadve final notu bilgilerini 
-- listeleyen SQL sorgusunu haz�rlay�n�z.
declare @enyuksekfinal int 

select @enyuksekfinal = max(final) from ogrenci, notlar       -- en y�ksek final notunu atar
where ders_kodu = 104

select adi,soyadi, final from ogrenci, notlar
where ogrenci.ogr_no = notlar.ogr_no and ders_kodu = 104  and  final = @enyuksekfinal

-- bu soruyu i�i�e select ile de ��zebiliriz
select adi,soyadi, final from ogrenci, notlar
where ogrenci.ogr_no = notlar.ogr_no and ders_kodu = 104  and  
final = (select max(final) from notlar where ders_kodu = 104) 



-- uygulama 2
-- FAKULTE veritaban�nag�re 104 kodlu dersin finalinden en d���k notu alanlar�n ad, soyad ve final notu bilgilerini listeleyiniz.

declare @endusukfinal int 

select @endusukfinal = min(final) from notlar where ders_kodu = 104

select adi, soyadi, final from ogrenci,notlar where ogrenci.ogr_no = notlar.ogr_no and  ders_kodu = 104  and final = @endusukfinal




-- @@CONNECTIONS:Sunucu ba�lat�ld���ndan itibaren a��lan veya a��lmaya �al���lan oturum say�s�n� verir.
select @@CONNECTIONS as 'Oturum A�ma'

-- @@MAX_CONNECTIONS: Sunucuya ayn� anda yap�labilecek ba�lant� say�s�n� verir.
select @@MAX_CONNECTIONS as 'Maks. ba�lant�'

-- @@SERVERNAME: Sunucunun ismini verir.
select @@SERVERNAME 

-- @@VERSION: SQL Server versiyonunu verir.
select @@VERSION

-- @@ROWCOUNT: �al��t�r�lan son sorgu sonucu etkilenen sat�r say�s�n� verir.
select * from ogrenci
PRINT @@ROWCOUNT
PRINT 'Adet ��renci Var'

-- @@LANGID: Sunucunun dil id�siniverir. E�er dil id0 ise sunucu �us_english� olarak ayarlanm��t�r. T�rk�enin dil id�si22 dir.
select @@LANGID

-- @@LANGUAGE: Sunucunun dil bilgisini ekrana yazar.
select @@LANGUAGE



-- if else yap�s�
if MONTH(GETDATE()) = 3
	print 'Aylardan Nisan'   -- true
else 
	print 'Aylardan Nisan de�il'   -- false



if YEAR(GETDATE())  <>  YEAR(DATEADD (DAY, 1, GETDATE()))
	print 'Bug�n y�l�n son g�n�'
else
	if MONTH(GETDATE()) <>  MONTH(DATEADD(DAY, 1, GETDATE()))
		print 'Bug�n Ay�n son g�n� fakat y�l�n son g�n� de�il'
	else
		print 'Bug�n ay�n son g�n� de�il'


-- Bir tabloda kay�t olup olmad��� kontrol edilmek isteniyorsa, IFEXISTS (Varsa)komut yap�s� kullan�labilir.
-- Genellikle tablonun bo� olup olmad��� veya aranan kay�t�n bulunup bulunmad���na bak�ld���ndan IF NOT EXISTS (E�er Yoksa) daha �ok kullan�l�r.
/*
if not exists(select *  from ogrenci)
	begin
		drop table ogrenci
		print 'ogrenci tablosu veri taban�ndan silindi'
	end
else 
	begin 
		print 'Ogrenci tablosunda ogrenci bulunmaktad�r'
	end
*/


-- CASEyap�s� T-SQL�de olduk�a i�levli olarak kullan�labilecek bir ko�ul ifadesidir.
-- CASE yap�s�n�n �nemli bir noktas� da DML komutlar�n�n (SELECT gibi) aras�na yaz�labilmesidir.

select adi, soyadi, 
	case cinsiyet 
		when 0 then 'Erkek'
		when 1 then 'Kad�n'
	end as 'Cinsiyet'
from ogrenci

--yukar�dakinin farkl� versiyonu
select adi, soyadi, 
	IIF(cinsiyet = 0, 'Erkek', 'Kad�n') as 'Cinsiyet'  -- ko�uldan sonra do�ru ise gelir de�ilse ikinci de�er gelir
from ogrenci


-- Uygulama 3
-- Vizenin %40�� ve finalin %60�� al�narak hesaplanan dersin ba�ar� notu 50 ve 50 den b�y�k olanlar�n 
-- durum alan�nda BA�ARILI, de�ilse BA�ARISIZ yazan ve ekrandaki ��kt�y� veren SQL sorgusunu yaz�n�z.

select ogr_no, vize, final, (vize*0.4 + final*0.6) as 'bn',
	case 
		when vize*0.4 + final*0.6 >= 50 then 'Ba�ar�l�'
		when vize*0.4 + final*0.6 < 50 then 'Ba�ar�s�z'
	end as 'Durum'
from notlar
order by bn desc




-- odev
-- Tablodaki harf notu aral�klar�na ve ba�ar� de�erlendirmesine g�re a�a��daki ekran ��kt�s�n� veren SQL sorgusunu haz�rlay�n�z.
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
		when 89 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 85 then '�yi-Pekiyi'
		when 84 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 80 then '�yi'
		when 79 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 75 then 'orta-iyi'
		when 74 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 65 then 'orta'
		when 64 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 55 then 'orta-ge�er'
		when 54 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 50 then 'ko�ullu ge�er'
		when 49 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 30 then 'Ba�ar�s�z'
		when 29 >= vize*0.4 + final*0.6 and vize*0.4 + final*0.6 >= 0 then 'Ba�ar�s�z'
	end as 'durum'
from ogrenci o, notlar n, dersler d
where o.ogr_no = n.ogr_no  and  n.ders_kodu = d.ders_kodu
order by vize*0.4 + final*0.6 desc

