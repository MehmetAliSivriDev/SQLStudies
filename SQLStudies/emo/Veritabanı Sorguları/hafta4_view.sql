
create view vw_ogrenci_bolumleri as
select ogr_no, adi, soyadi, bol_adi, ogrenci.bol_no, dogum_yeri from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no


select * from vw_ogrenci_bolumleri

select * from vw_ogrenci_bolumleri where dogum_yeri = 'LÜLEBURGAZ'

select * from vw_ogrenci_bolumleri where dogum_yeri = 'LÜLEBURGAZ' order by bol_adi desc





-- 1- FAKULTE veritabaný kullanýlarak aþaðýdaki çýktýyý veren vw_transkriptadýndaki 
-- View nesnesini oluþturun ve görüntüleyin (ortalama için vizenin %40’ý, finalin %60’ý).
use FAKULTE go
create view nw_transkript as 
select adi, soyadi, ders_adi, vize, final,(vize*0.4 + final*0.6) as ort from ogrenci, notlar, dersler
where ogrenci.ogr_no = notlar.ogr_no  and  notlar.ders_kodu = dersler.ders_kodu

select * from nw_transkript



-- 2-Oluþturulan vw_transkriptadýndaki View nesnesini kullanarak adý E ile baþlayan öðrencilerin tüm bilgilerini listeleyiniz.
select * from nw_transkript 
where adi like 'E%'


-- 3- Vizesi 70 ve 90 arasýndaki öðrencilerin sadece adýný, soyadýný, dersin adýný ve vize sýnavýný listeleyiniz.
select adi, soyadi, ders_adi, vize from nw_transkript
where vize >= 70 and vize<= 90


-- 4- Daha önce oluþturulan vw_ogrenci_bolumleradýndaki viewtablosundan bölüm numarasý ve doðum yeri alanlarýný çýkartarak yeniden düzenleyin.
use FAKULTE go
alter view vw_ogrenci_bolumleri as 
select ogr_no, adi,soyadi,bol_adi from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no

select * from vw_ogrenci_bolumleri


-- 5-Oluþturulan vw_transkriptadýndaki View nesnesini sadece baþarýlý öðrencileri gösterecek þekilde deðiþtiriniz.
-- Not: ortalamasý 50 ve üzeri olan öðrenciler baþarýlý sayýlmaktadýr.
use FAKULTE go 
alter view nw_transkript as
select adi, soyadi, ders_adi, vize, final,(vize*0.4 + final*0.6) as ort from ogrenci, notlar, dersler
where ogrenci.ogr_no = notlar.ogr_no  and  notlar.ders_kodu = dersler.ders_kodu  and (vize*0.4 + final*0.6) > 50

select * from vw_ogrenci_bolumleri  order by ort





-- Kayýtlar, gerçek tablolarda bulunduðundan viewnesnesinin silinmesi ile silinmeyecektir.
use FAKULTE go 
drop view nw_transkript


-- Bir veritabanýndakiviewnesneleri hakkýnda bilgi almak veya hangi tablolar üzerinde 
-- viewnesneleri kullanýldýðýný öðrenmek için aþaðýda verilen kod kullanýlabilir.
use FAKULTE go
select * from INFORMATION_SCHEMA.VIEWS


-- View nesnesi içerisindeki kodlarý sp_helptextsaklý prosedürü kullanarak görülebilir.
use FAKULTE go 
sp_helptext vw_ogrenci_bolumler


-- Yazýlan kodlarý þifrelemek için View oluþtururken WITH ENCRYPTION kullanýlýr.
use FAKULTE go
create view vw_ogrenci_bolumleri_sifreli 
with encryption
as
select ogr_no, adi, soyadi, bol_adi from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no


sp_helptext vw_ogrenci_bolumleri_sifreli


select * from INFORMATION_SCHEMA.VIEWS    -- þema görüntülenince kodlar görünmüyor þifreli olduðu için




--Bir indeks oluþturmak için aþaðýdaki kod bloðu kullanýlabilir:
--CREATE INDEX indeks adi ONtablo adý (alan adý)
--Genellikle metin tipindeki alanlar için indeks hazýrlanýr.
-- Oluþturulan indeksler ilgili tablonun içinde Indexesklasörü altýnda yer alýr.

--Ders adlarý için bir indeks oluþturalým.
create index ders_ad_indeks on dersler(ders_adi)

sp_helpindex ogrenci



