--VTYS1_8_9 Uygulama 1'deki Uygulamanýn Cevaplarýdýr.

--1.SORU

--*************************************************************************************************
--Veri Tabanýný Oluþturma
create database calisma4
---------------------------------------------------------------------------------------------------

--Tablolarý Oluþturma
create table hakemler(
	hakem_id int PRIMARY KEY IDENTITY(1,1),
	ad varchar(50),
	soyad varchar(50)
)

create table takimlar(
	takim_id int PRIMARY KEY IDENTITY(1,1),
	takim_adi varchar(100)
)

create table oyuncular(
	oyuncu_id int PRIMARY KEY IDENTITY(1,1),
	ad varchar(50),
	soyad varchar(50),
	forma_no int,
	boy int,
	takim_id int FOREIGN KEY (takim_id) REFERENCES takimlar(takim_id)
)

create table yapilan_maclar(
	mac_id int PRIMARY KEY IDENTITY(1,1),
	takim1_id int FOREIGN KEY (takim1_id) REFERENCES takimlar(takim_id),
	takim2_id int FOREIGN KEY (takim2_id) REFERENCES takimlar(takim_id),
	tarih date,
	saat time,
	takim1_set int,
	takim2_set int
)

create table hakem_mac(
	hakem_mac_id int PRIMARY KEY IDENTITY(1,1),
	mac_id int FOREIGN KEY (mac_id) REFERENCES yapilan_maclar(mac_id),
	hakem_id int FOREIGN KEY (hakem_id) REFERENCES hakemler(hakem_id)
)
---------------------------------------------------------------------------------------------------

--Sorgu Kýsýmlarý
ALTER TABLE takimlar ADD kurulus_tarihi date
ALTER TABLE oyuncular ADD dogum_yeri varchar(50)

Create table gorev_turu(
	gorev_id int PRIMARY KEY IDENTITY(1,1),
	gorev varchar(MAX)
)

ALTER TABLE hakem_mac ADD gorev int FOREIGN KEY (gorev) REFERENCES gorev_turu(gorev_id) 

--*************************************************************************************************

--2.SORU

--*************************************************************************************************

--Veri Tabanýný Oluþturma
create database OKUL
---------------------------------------------------------------------------------------------------

--Tablolarý Oluþturma
 
 create table hocalar(
	hoca_no int PRIMARY KEY IDENTITY(1,1),
	ad varchar(50),
	soyad varchar(50),
	unvan varchar(30)
 )

 create table bolumler(
	bolum_no int PRIMARY KEY,
	bol_adi varchar(100)
 )

 create table dersler(
	ders_kodu int PRIMARY KEY,
	ders_adi varchar(50),
	kredisi int,
	hocasi int FOREIGN KEY (hocasi) REFERENCES hocalar(hoca_no),
	akts int
 )

 create table ogrenci(
	ogr_no int PRIMARY KEY,
	adi varchar(50),
	soyadi varchar(50),
	dogum_yeri varchar(50),
	dogum_tar date,
	cinsiyet bit,
	adres varchar(MAX),
	telefon varchar(11),
	bol_no int FOREIGN KEY (bol_no) REFERENCES bolumler(bolum_no)
 )

 create table notlar(
	not_id int PRIMARY KEY IDENTITY(1,1),
	ogr_no int FOREIGN KEY (ogr_no) REFERENCES ogrenci(ogr_no),
	ders_kodu int FOREIGN KEY (ders_kodu) REFERENCES dersler(ders_kodu)
 )
---------------------------------------------------------------------------------------------------

--Sorgu Kýsýmlarý

--Bölümler tablosuna metin tipinde eposta, telefon ve web adresi alanlarýný ekleyiniz.
--(UYARI!) Hoca Uygulamada varchar ile eklemiþ
ALTER TABLE bolumler ADD eposta text,telefon text,webAdresi text

--Hocalar tablosuna ders sayýsý ve doðum tarihi alan bilgilerini ekleyiniz.
ALTER TABLE hocalar ADD ders_sayisi int,dogum_tar date

--Öðrenciler tablosuna ekleme tarihi adýnda datetime tipinde ve varsayýlan (default) deðer olarak kayýt ekleme
--tarihi ve saati olacak þekilde bir alan ekleyiniz.
ALTER TABLE ogrenci ADD ekleme_tar datetime DEFAULT GETDATE()

--Notlar tablosuna ders yýlý, vize ve final alan bilgilerini ekleyiniz.
ALTER TABLE notlar ADD ders_yili date,vize int,final int

--Dersler tablosuna teori ve uygulama alan bilgilerini ekleyiniz.
ALTER TABLE dersler ADD teori int, uygulama int

--Hocalar tablosuna 1 adet Dr.Öðrt.Üyesi ünvanýna sahip hoca ekleyiniz.
insert into hocalar (ad,soyad,unvan,ders_sayisi,dogum_tar)
values ('Ahmet','Bal','Dr.Öðrt.Üyesi',5,'01.01.1990')

--EKSTRA---------------------------------------------------------
insert into hocalar (ad,soyad,unvan,ders_sayisi,dogum_tar)
values ('Mehmet','Çetinkaya','Dr.Öðrt.Üyesi',2,'03.15.2000')

insert into hocalar (ad,soyad,unvan,ders_sayisi,dogum_tar)
values ('Ali','Çakýr','Dr.Öðrt.Üyesi',3,'12.21.1980')
-----------------------------------------------------------------

--Dersler tablosuna 4 kredili Matematik, 3 kredili Yazýlým Mühendisliðine Giriþ ve 4 kredili Veritabaný Yönetim
--Sistemleri derslerini ayný anda ekleyiniz.
insert into dersler (ders_kodu,ders_adi,kredisi,hocasi,akts,teori,uygulama)
values (1,'Matematik',4,1,6,1,1),(2,'Yazýlým Mühendisliðine Giriþ',3,2,5,2,2),
(3,'Veritabaný Yönetim Sistemi',4,3,4,2,2)

--Bölümler tablosuna 2 adet bölüm ekleyiniz. (Yazýlým Mühendisliði, Ýnþaat Mühendisliði)
insert into bolumler (bolum_no,bol_adi,eposta,telefon,webAdresi) values
(1,'Yazýlým Mühendisliði','yazilim@gmail.com','12312312312','www.yazilim.com'),
(2,'Ýnþaat Mühendisliði','insaat@gmail.com','12312312312','www.insaat.com')


--Öðrenciler tablosuna 3 öðrenci bilgisi ekleyiniz.
insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tar,cinsiyet,adres,telefon,bol_no,ekleme_tar)
values (1210505007,'Mehmet Ali','Sivri','Bursa','03.18.2002',1,'Bursa','12312312312',1,'09.01.2021'),
(1210505023,'Hasan Emre','Baðrýyanýk','Hatay','02.05.2003',1,'Hatay','12312312312',1,'09.01.2021'),
(1210505037,'Veysel','Uðurlu','Ýstanbul','04.20.2002',1,'Ýstanbul','12312312312',1,'09.01.2021')

--Notlar tablosuna otomotik artan alanda dahil olmak üzere 3 öðrenciye vize not bilgisi ekleyiniz.
set identity_insert notlar on
insert into notlar(not_id,ogr_no,ders_kodu,ders_yili,vize,final) values
(1,1210505007,1,'12.31.2022',70,70),(2,1210505023,1,'12.31.2022',75,75),(3,1210505037,1,'12.31.2022',80,80)
set identity_insert notlar off

--Öðrenciler tablosuna girilen deðerleri insert iþleminden sonra gösterecek þekilde yeni bir öðrenci ekleyiniz.
insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tar,cinsiyet,adres,telefon,bol_no,ekleme_tar) 
output inserted.ogr_no,inserted.adi,inserted.soyadi,inserted.dogum_yeri,inserted.dogum_tar,inserted.cinsiyet,
inserted.adres,inserted.telefon,inserted.ekleme_tar
values(1210505072,'Duygu','Teker','Çanakkale','06.14.2003',0,'Çanakkale','12312312312',1,'09.01.2021')

--Bölümü Ýnþaat Mühendisliði olan öðrencinin adres bilgisini Ýstanbul olarak güncelleyiniz.

--EKSTRA---------------------------------------------------------
insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tar,cinsiyet,adres,telefon,bol_no,ekleme_tar)
values (1210504014,'Dursun','Dursun','Amasya','05.28.2000',1,'Amasya','12312312312',2,'09.01.2019')
-----------------------------------------------------------------

update ogrenci set adres = 'Ýstanbul' where ogr_no = 1210504014 and bol_no = 2

--Öðrenci numarasý “1120505018” olan öðrencinin matematik dersi vize notunu 75 olarak güncelleyiniz.
update notlar set vize = 75 where ogr_no = 1210505007 and ders_kodu = 1

--Adý Sait olan hocanýn unvan bilgisini “Doç.Dr.” olarak güncelleyiniz.
update hocalar set unvan = 'Doc.Dr.' where ad = 'Mehmet' and soyad = 'Çetinkaya'

--Ders kodu 4 olan ve vize notu 70 olan not bilgisini veritabanýndan siliniz.

--EKSTRA---------------------------------------------------------
insert into dersler (ders_kodu,ders_adi,kredisi,hocasi,akts,teori,uygulama)
values (4,'Web Programlama',4,1,6,3,3)

set identity_insert notlar on
insert into notlar(not_id,ogr_no,ders_kodu,ders_yili,vize,final) values
(4,1210505007,4,'12.31.2022',70,80)
set identity_insert notlar off
----------------------------------------------------------------

delete from notlar where ders_kodu = 4 and vize = 70

--Hocalar tablosundaki ders sayýsý alanýný siliniz.
ALTER TABLE hocalar DROP COLUMN ders_sayisi

--Notlar tablosunu veritabanýndan siliniz.
DROP TABLE notlar

--Veritabanýný SQL Server dan siliniz.
DROP DATABASE OKUL