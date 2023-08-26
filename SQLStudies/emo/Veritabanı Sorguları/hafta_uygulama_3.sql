-- 1.En yüksek nakliye ücretinin ödendiði satýþa ait Nakliye firmasý, Sevk adý ve Sevk  tarihi bilgilerini 
-- @enyuksekfiyat deðiþkenini kullanarak listeleyiniz listeleyiniz. 

declare @enyuksekfiyat int 

select @enyuksekfiyat = max(NakliyeUcreti) from Satislar   

select SirketAdi, SevkAdi, SevkTarihi, NakliyeUcreti from Satislar s ,Nakliyeciler n
where s.NakliyeUcreti = n.NakliyeciID and NakliyeUcreti = @enyuksekfiyat



-- 2-En genç personelin adýný, soyadýný, unvaný ve yaþ bilgisini listeleyiniz. 

declare @enazyas int
select @enazyas = (DATEDIFF(YEAR,DogumTarihi,GETDATE()))  from Personeller
select Adi, SoyAdi, Unvan,DATEDIFF(YEAR,DogumTarihi,GETDATE()) as 'Yaþ' from Personeller
where DATEDIFF(YEAR,DogumTarihi,GETDATE()) = @enazyas

-- 3.Veri tabanýnda bulunan ürünlerin adýný, miktar bilgisini, birim fiyatýný ve birim fiyata göre durumunu 
-- ‘Ortalamanýn Altýnda’, ‘Ortalamanýn Üstünde’ olacak þekilde listeleyiniz. 
declare @ort float
select @ort = avg(BirimFiyati) from Urunler
select UrunAdi, Miktar,  u.BirimFiyati,
	case 
		when u.BirimFiyati >= @ort then 'Ortalamanýn Üstünde'
		when u.BirimFiyati < @ort  then 'Ortalamanýn Altýnda'
	end as 'Durumu'
from Urunler u , [Satis Detaylari] sd
where u.UrunID = sd.UrunID

-- ifli
declare @ort float
select @ort = avg(BirimFiyati) from Urunler
select UrunAdi, Miktar,  u.BirimFiyati,
	IIF(u.BirimFiyati > @ort, 'Ortalamanýn Üstünde', 'Ortalamanýn Altýnda')
from Urunler u , [Satis Detaylari] sd
where u.UrunID = sd.UrunID


-- 4.Ýlk 10 sipariþte yer alan ürünlerin birim fiyat toplamýný bulan SQL kodunu yazýnýz. 
-- (ilk 10 adet satiþ id si bilgisini tablo tipi bir deðiþkende tutup birim fiyat toplamýný o tablodaki id lere göre hesaplayýnýz.) 
select sum(BirimFiyati) as ToplamFiyat from 
(select BirimFiyati from[Satis Detaylari] where SatisID between 10248 and 10257) as T

-- t-sql
declare @satis_id table(
	idno int 
)
insert into @satis_id select top 10 SatisID from Satislar order by SatisID asc
select * from @satis_id
select sum(BirimFiyati) as ToplamFiyat from [Satis Detaylari] where SatisID in (select idno from @satis_id)



-- 5.Northwind_tr veri tabanýnda her hangi bir tabloya sütun eklemeyi engelleyen trigger nesnesini yazýnýz ve 
-- engelleme mesajýný test ettikten sonra oluþturduðunuz trigger nesnesini siliniz. 

create trigger trg_alterkontrol ondatabasefor alter_table asprint'Tablo sütunlarýna ekleme yapmanýz engellenmiþtir!'ROLLBACK altertable Musteriler add yenialan varchar(10);droptrigger trg_alterkontrol ondatabase


-- 6.Bir satýþ iþlemi gerçekleþtiðinde satýlan ürünün stok deðerleri ile ilgili (birimdeki miktar bilgisi hariç) 
-- gerekli deðiþimleri yapan trigger nesnesini yazýnýz. 



-- 7.Ürünlerin adýný, mevcut stok bilgisini, kategori ismini ve tedarik edilen firma bilgilerini listeleyen bir saklý prosedür yazýnýz. 



-- 8.Aldýðý karakter dizisi parametresine göre müþteri arayan ve listeleyen saklý prosedürü yazýnýz. 


-- 9.Müþteri id bilgisini alarak müþteriye ait unvan bilgisi için güncelleme yapan saklý prosedürü yazýnýz. 



-- 10.Adý, Soyadý veya unvan bilgilerinden herhangi biri parametre olarak verildiðinde ilgili personel bilgilerini 
-- listeleyen saklý prosedürü yazýnýz. Oluþturduðunuz saklý prosedürü siliniz. 





