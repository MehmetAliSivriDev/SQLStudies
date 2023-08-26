-- ROLLBACK: Yap�lan i�lem tamamen geriye al�nabilir (Geri Alma/�ptal Etme)

-- AFTER/FOR: Yap�lan i�lemin yan�nda ba�ka i�lemlerin de yap�lmas� sa�lanabilir. Bu �ekilde iki i�lem ard���k yap�labilir.

-- INSTEAD OF:Yap�lan i�lemin yerine tamamen farkl� bir i�lem yapt�r�labilir.

-------------------------------------------------
create trigger trg_tablo_silmeyi_engelle
on database
for drop_table
as
print 'Silme i�lemi iptal edildi'
rollback

------------------------------------------------------

create trigger trg_tablo_kontrol
on database
for create_table, alter_table, drop_table
as
print 'Tabloda de�i�iklik yapmak i�in trg_tablo_kontrol nesnesini kapatmal�s�n�z'
rollback

--------------------------------------------------------------------------

drop trigger trg_tablo_kontrol on database

drop trigger trg_tablo_kontrol on all server

-------------------------------------------------------------

-- Bir triggeri pasif hale getirmek i�in DISABLE komutu kullan�l�r.
-- Etkisiz haldeki trigger nesnesini aktif hale getirmek i�in ise ENABLE komutu kullan�l�r.

disable trigger trg_tablo_kontrol on database
enable trigger trg_tablo_kontrol on database

disable trigger trg_tablo_kontrol on all server
enable trigger trg_tablo_kontrol on all server
-------------------------------------------------------------------------

-- Bu komutlar genellikle yetki ile ilgili komutlard�r.Bu sebeple bu tip triggernesnelerine logon triggerlar� ad� verilir.
---------------------------------------------------------------------------------------------------------------------------

create trigger trg_deneme
on ogrenci                        
for/after insert
as
insert into departman (departman_Id, departman) values (1,'Okul');
 -- Kodlar hem INSERT i�lemini ger�ekle�tirir hem de AS den sonraki i�lemleri ger�ekle�tirir.
--------------------------------------------------------------------------------------------------------

create trigger trg_deneme5
on departman                        
instead of insert
as
insert into departman (departman_Id, departman) values (1,'Okul');
--��renci tablosuna ekleme i�lemi yap�lmaya �al���ld���nda, ekleme i�lemi yap�lmayacak bunun yerine AS den sonraki kodlar tetiklenecek.
--------------------------------------------------------------------------------------------------------------

-- stok_takipad�nda bir veritaban� olu�turunuz.
-- Veritaban� i�inde iki tablo olu�turunuz.
-- urunler(urun_no, urun_adi, stok_adedi)
-- satis(satis_no, urun_no)
-- �r�nler tablosuna 5 kay�t giriniz.
-- Sat�� yap�ld���nda (yani sat�� tablosuna kay�t girildi�inde), 
-- ilgili �r�n�n stok adedini bir azaltan trg_satad�nda triggernesnesini olu�turunuz.

create database stok_takip

create table urunler(urun_no int primary key not null, urun_adi varchar(30), stok_adedi int )

create table satis(satis_no int primary key not null, urun_no int)

insert into urunler (urun_no, urun_adi, stok_adedi)values(1,'kalem',100)
insert into urunler (urun_no, urun_adi, stok_adedi)values(2,'silgi',25)
insert into urunler (urun_no, urun_adi, stok_adedi)values(3,'defter',50)
insert into urunler (urun_no, urun_adi, stok_adedi)values(4,'�anta',3)
insert into urunler (urun_no, urun_adi, stok_adedi)values(5,'ka��t',50)

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
Sat�� tablosunda sat�� adeti i�in adet ad�nda bir alan ekleyin.
Sat�� tablosuna girilen adet kadar, �r�nler tablosundan stok azaltan triggernesnesini yaz�n.
E�er stok sat�� yap�lamayacak kadarsa yani stokta yeterli �r�n yoksa sat�� i�lemi iptal edilsin.
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

--  b�yle kald�
