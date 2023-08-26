-- 1.En y�ksek nakliye �cretinin �dendi�i sat��a ait Nakliye firmas�, Sevk ad� ve Sevk  tarihi bilgilerini 
-- @enyuksekfiyat de�i�kenini kullanarak listeleyiniz listeleyiniz. 

declare @enyuksekfiyat int 

select @enyuksekfiyat = max(NakliyeUcreti) from Satislar   

select SirketAdi, SevkAdi, SevkTarihi, NakliyeUcreti from Satislar s ,Nakliyeciler n
where s.NakliyeUcreti = n.NakliyeciID and NakliyeUcreti = @enyuksekfiyat



-- 2-En gen� personelin ad�n�, soyad�n�, unvan� ve ya� bilgisini listeleyiniz. 

declare @enazyas int
select @enazyas = (DATEDIFF(YEAR,DogumTarihi,GETDATE()))  from Personeller
select Adi, SoyAdi, Unvan,DATEDIFF(YEAR,DogumTarihi,GETDATE()) as 'Ya�' from Personeller
where DATEDIFF(YEAR,DogumTarihi,GETDATE()) = @enazyas

-- 3.Veri taban�nda bulunan �r�nlerin ad�n�, miktar bilgisini, birim fiyat�n� ve birim fiyata g�re durumunu 
-- �Ortalaman�n Alt�nda�, �Ortalaman�n �st�nde� olacak �ekilde listeleyiniz. 
declare @ort float
select @ort = avg(BirimFiyati) from Urunler
select UrunAdi, Miktar,  u.BirimFiyati,
	case 
		when u.BirimFiyati >= @ort then 'Ortalaman�n �st�nde'
		when u.BirimFiyati < @ort  then 'Ortalaman�n Alt�nda'
	end as 'Durumu'
from Urunler u , [Satis Detaylari] sd
where u.UrunID = sd.UrunID

-- ifli
declare @ort float
select @ort = avg(BirimFiyati) from Urunler
select UrunAdi, Miktar,  u.BirimFiyati,
	IIF(u.BirimFiyati > @ort, 'Ortalaman�n �st�nde', 'Ortalaman�n Alt�nda')
from Urunler u , [Satis Detaylari] sd
where u.UrunID = sd.UrunID


-- 4.�lk 10 sipari�te yer alan �r�nlerin birim fiyat toplam�n� bulan SQL kodunu yaz�n�z. 
-- (ilk 10 adet sati� id si bilgisini tablo tipi bir de�i�kende tutup birim fiyat toplam�n� o tablodaki id lere g�re hesaplay�n�z.) 
select sum(BirimFiyati) as ToplamFiyat from 
(select BirimFiyati from[Satis Detaylari] where SatisID between 10248 and 10257) as T

-- t-sql
declare @satis_id table(
	idno int 
)
insert into @satis_id select top 10 SatisID from Satislar order by SatisID asc
select * from @satis_id
select sum(BirimFiyati) as ToplamFiyat from [Satis Detaylari] where SatisID in (select idno from @satis_id)



-- 5.Northwind_tr veri taban�nda her hangi bir tabloya s�tun eklemeyi engelleyen trigger nesnesini yaz�n�z ve 
-- engelleme mesaj�n� test ettikten sonra olu�turdu�unuz trigger nesnesini siliniz. 

create trigger trg_alterkontrol ondatabasefor alter_table asprint'Tablo s�tunlar�na ekleme yapman�z engellenmi�tir!'ROLLBACK altertable Musteriler add yenialan varchar(10);droptrigger trg_alterkontrol ondatabase


-- 6.Bir sat�� i�lemi ger�ekle�ti�inde sat�lan �r�n�n stok de�erleri ile ilgili (birimdeki miktar bilgisi hari�) 
-- gerekli de�i�imleri yapan trigger nesnesini yaz�n�z. 



-- 7.�r�nlerin ad�n�, mevcut stok bilgisini, kategori ismini ve tedarik edilen firma bilgilerini listeleyen bir sakl� prosed�r yaz�n�z. 



-- 8.Ald��� karakter dizisi parametresine g�re m��teri arayan ve listeleyen sakl� prosed�r� yaz�n�z. 


-- 9.M��teri id bilgisini alarak m��teriye ait unvan bilgisi i�in g�ncelleme yapan sakl� prosed�r� yaz�n�z. 



-- 10.Ad�, Soyad� veya unvan bilgilerinden herhangi biri parametre olarak verildi�inde ilgili personel bilgilerini 
-- listeleyen sakl� prosed�r� yaz�n�z. Olu�turdu�unuz sakl� prosed�r� siliniz. 





