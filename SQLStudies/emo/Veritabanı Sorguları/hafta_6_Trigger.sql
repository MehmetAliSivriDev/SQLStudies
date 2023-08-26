-- ROLLBACK: Yapýlan iþlem tamamen geriye alýnabilir (Geri Alma/Ýptal Etme)

-- AFTER/FOR: Yapýlan iþlemin yanýnda baþka iþlemlerin de yapýlmasý saðlanabilir. Bu þekilde iki iþlem ardýþýk yapýlabilir.

-- INSTEAD OF:Yapýlan iþlemin yerine tamamen farklý bir iþlem yaptýrýlabilir.

-------------------------------------------------
create trigger trg_tablo_silmeyi_engelle
on database
for drop_table
as
print 'Silme iþlemi iptal edildi'
rollback

------------------------------------------------------

create trigger trg_tablo_kontrol
on database
for create_table, alter_table, drop_table
as
print 'Tabloda deðiþiklik yapmak için trg_tablo_kontrol nesnesini kapatmalýsýnýz'
rollback

--------------------------------------------------------------------------

drop trigger trg_tablo_kontrol on database

drop trigger trg_tablo_kontrol on all server

-------------------------------------------------------------

-- Bir triggeri pasif hale getirmek için DISABLE komutu kullanýlýr.
-- Etkisiz haldeki trigger nesnesini aktif hale getirmek için ise ENABLE komutu kullanýlýr.

disable trigger trg_tablo_kontrol on database
enable trigger trg_tablo_kontrol on database

disable trigger trg_tablo_kontrol on all server
enable trigger trg_tablo_kontrol on all server
-------------------------------------------------------------------------

-- Bu komutlar genellikle yetki ile ilgili komutlardýr.Bu sebeple bu tip triggernesnelerine logon triggerlarý adý verilir.
---------------------------------------------------------------------------------------------------------------------------

create trigger trg_deneme
on ogrenci                        
for/after insert
as
insert into departman (departman_Id, departman) values (1,'Okul');
 -- Kodlar hem INSERT iþlemini gerçekleþtirir hem de AS den sonraki iþlemleri gerçekleþtirir.
--------------------------------------------------------------------------------------------------------

create trigger trg_deneme5
on departman                        
instead of insert
as
insert into departman (departman_Id, departman) values (1,'Okul');
--Öðrenci tablosuna ekleme iþlemi yapýlmaya çalýþýldýðýnda, ekleme iþlemi yapýlmayacak bunun yerine AS den sonraki kodlar tetiklenecek.
--------------------------------------------------------------------------------------------------------------

-- stok_takipadýnda bir veritabaný oluþturunuz.
-- Veritabaný içinde iki tablo oluþturunuz.
-- urunler(urun_no, urun_adi, stok_adedi)
-- satis(satis_no, urun_no)
-- Ürünler tablosuna 5 kayýt giriniz.
-- Satýþ yapýldýðýnda (yani satýþ tablosuna kayýt girildiðinde), 
-- ilgili ürünün stok adedini bir azaltan trg_satadýnda triggernesnesini oluþturunuz.

create database stok_takip

create table urunler(urun_no int primary key not null, urun_adi varchar(30), stok_adedi int )

create table satis(satis_no int primary key not null, urun_no int)

insert into urunler (urun_no, urun_adi, stok_adedi)values(1,'kalem',100)
insert into urunler (urun_no, urun_adi, stok_adedi)values(2,'silgi',25)
insert into urunler (urun_no, urun_adi, stok_adedi)values(3,'defter',50)
insert into urunler (urun_no, urun_adi, stok_adedi)values(4,'çanta',3)
insert into urunler (urun_no, urun_adi, stok_adedi)values(5,'kaðýt',50)

insert into satis (satis_no, urun_no) values (1,1)



create trigger trg_satis
on satis
for insert 
as
declare @satilan_urun_no int 
select @satilan_urun_no = urun_no from inserted

update urunler set stok_adedi = stok_adedi - 1
where urun_no = @satilan_urun_no

select * from urunler

----------------------------------------------------------------------------------------
/*
Satýþ tablosunda satýþ adeti için adet adýnda bir alan ekleyin.
Satýþ tablosuna girilen adet kadar, ürünler tablosundan stok azaltan triggernesnesini yazýn.
Eðer stok satýþ yapýlamayacak kadarsa yani stokta yeterli ürün yoksa satýþ iþlemi iptal edilsin.
*/

alter table satis add adet int
insert into satis(satis_no, urun_no, adet) values(2,2,5)
insert into satis(satis_no, urun_no, adet) values(3,2,5)
insert into satis(satis_no, urun_no, adet) values(4,2,1)

create trigger trg_satislar
on satis
for insert 
as
declare @satilan_urun_no int 
select @satilan_urun_no = urun_no from inserted

update urunler set stok_adedi = stok_adedi - 1
where urun_no = @satilan_urun_no

select * from urunler

--  böyle kaldý
