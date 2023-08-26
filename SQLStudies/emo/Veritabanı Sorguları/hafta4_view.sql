
create view vw_ogrenci_bolumleri as
select ogr_no, adi, soyadi, bol_adi, ogrenci.bol_no, dogum_yeri from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no


select * from vw_ogrenci_bolumleri

select * from vw_ogrenci_bolumleri where dogum_yeri = 'L�LEBURGAZ'

select * from vw_ogrenci_bolumleri where dogum_yeri = 'L�LEBURGAZ' order by bol_adi desc





-- 1- FAKULTE veritaban� kullan�larak a�a��daki ��kt�y� veren vw_transkriptad�ndaki 
-- View nesnesini olu�turun ve g�r�nt�leyin (ortalama i�in vizenin %40��, finalin %60��).
use FAKULTE go
create view nw_transkript as 
select adi, soyadi, ders_adi, vize, final,(vize*0.4 + final*0.6) as ort from ogrenci, notlar, dersler
where ogrenci.ogr_no = notlar.ogr_no  and  notlar.ders_kodu = dersler.ders_kodu

select * from nw_transkript



-- 2-Olu�turulan vw_transkriptad�ndaki View nesnesini kullanarak ad� E ile ba�layan ��rencilerin t�m bilgilerini listeleyiniz.
select * from nw_transkript 
where adi like 'E%'


-- 3- Vizesi 70 ve 90 aras�ndaki ��rencilerin sadece ad�n�, soyad�n�, dersin ad�n� ve vize s�nav�n� listeleyiniz.
select adi, soyadi, ders_adi, vize from nw_transkript
where vize >= 70 and vize<= 90


-- 4- Daha �nce olu�turulan vw_ogrenci_bolumlerad�ndaki viewtablosundan b�l�m numaras� ve do�um yeri alanlar�n� ��kartarak yeniden d�zenleyin.
use FAKULTE go
alter view vw_ogrenci_bolumleri as 
select ogr_no, adi,soyadi,bol_adi from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no

select * from vw_ogrenci_bolumleri


-- 5-Olu�turulan vw_transkriptad�ndaki View nesnesini sadece ba�ar�l� ��rencileri g�sterecek �ekilde de�i�tiriniz.
-- Not: ortalamas� 50 ve �zeri olan ��renciler ba�ar�l� say�lmaktad�r.
use FAKULTE go 
alter view nw_transkript as
select adi, soyadi, ders_adi, vize, final,(vize*0.4 + final*0.6) as ort from ogrenci, notlar, dersler
where ogrenci.ogr_no = notlar.ogr_no  and  notlar.ders_kodu = dersler.ders_kodu  and (vize*0.4 + final*0.6) > 50

select * from vw_ogrenci_bolumleri  order by ort





-- Kay�tlar, ger�ek tablolarda bulundu�undan viewnesnesinin silinmesi ile silinmeyecektir.
use FAKULTE go 
drop view nw_transkript


-- Bir veritaban�ndakiviewnesneleri hakk�nda bilgi almak veya hangi tablolar �zerinde 
-- viewnesneleri kullan�ld���n� ��renmek i�in a�a��da verilen kod kullan�labilir.
use FAKULTE go
select * from INFORMATION_SCHEMA.VIEWS


-- View nesnesi i�erisindeki kodlar� sp_helptextsakl� prosed�r� kullanarak g�r�lebilir.
use FAKULTE go 
sp_helptext vw_ogrenci_bolumler


-- Yaz�lan kodlar� �ifrelemek i�in View olu�tururken WITH ENCRYPTION kullan�l�r.
use FAKULTE go
create view vw_ogrenci_bolumleri_sifreli 
with encryption
as
select ogr_no, adi, soyadi, bol_adi from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no


sp_helptext vw_ogrenci_bolumleri_sifreli


select * from INFORMATION_SCHEMA.VIEWS    -- �ema g�r�nt�lenince kodlar g�r�nm�yor �ifreli oldu�u i�in




--Bir indeks olu�turmak i�in a�a��daki kod blo�u kullan�labilir:
--CREATE INDEX indeks adi ONtablo ad� (alan ad�)
--Genellikle metin tipindeki alanlar i�in indeks haz�rlan�r.
-- Olu�turulan indeksler ilgili tablonun i�inde Indexesklas�r� alt�nda yer al�r.

--Ders adlar� i�in bir indeks olu�tural�m.
create index ders_ad_indeks on dersler(ders_adi)

sp_helpindex ogrenci



