--VTYS1_8_9 Uygulama 1'deki Uygulaman�n Cevaplar�d�r.

--1.SORU

--*************************************************************************************************
--Veri Taban�n� Olu�turma
create database calisma4
---------------------------------------------------------------------------------------------------

--Tablolar� Olu�turma
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

--Sorgu K�s�mlar�
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

--Veri Taban�n� Olu�turma
create database OKUL
---------------------------------------------------------------------------------------------------

--Tablolar� Olu�turma
 
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

--Sorgu K�s�mlar�

--B�l�mler tablosuna metin tipinde eposta, telefon ve web adresi alanlar�n� ekleyiniz.
--(UYARI!) Hoca Uygulamada varchar ile eklemi�
ALTER TABLE bolumler ADD eposta text,telefon text,webAdresi text

--Hocalar tablosuna ders say�s� ve do�um tarihi alan bilgilerini ekleyiniz.
ALTER TABLE hocalar ADD ders_sayisi int,dogum_tar date

--��renciler tablosuna ekleme tarihi ad�nda datetime tipinde ve varsay�lan (default) de�er olarak kay�t ekleme
--tarihi ve saati olacak �ekilde bir alan ekleyiniz.
ALTER TABLE ogrenci ADD ekleme_tar datetime DEFAULT GETDATE()

--Notlar tablosuna ders y�l�, vize ve final alan bilgilerini ekleyiniz.
ALTER TABLE notlar ADD ders_yili date,vize int,final int

--Dersler tablosuna teori ve uygulama alan bilgilerini ekleyiniz.
ALTER TABLE dersler ADD teori int, uygulama int

--Hocalar tablosuna 1 adet Dr.��rt.�yesi �nvan�na sahip hoca ekleyiniz.
insert into hocalar (ad,soyad,unvan,ders_sayisi,dogum_tar)
values ('Ahmet','Bal','Dr.��rt.�yesi',5,'01.01.1990')

--EKSTRA---------------------------------------------------------
insert into hocalar (ad,soyad,unvan,ders_sayisi,dogum_tar)
values ('Mehmet','�etinkaya','Dr.��rt.�yesi',2,'03.15.2000')

insert into hocalar (ad,soyad,unvan,ders_sayisi,dogum_tar)
values ('Ali','�ak�r','Dr.��rt.�yesi',3,'12.21.1980')
-----------------------------------------------------------------

--Dersler tablosuna 4 kredili Matematik, 3 kredili Yaz�l�m M�hendisli�ine Giri� ve 4 kredili Veritaban� Y�netim
--Sistemleri derslerini ayn� anda ekleyiniz.
insert into dersler (ders_kodu,ders_adi,kredisi,hocasi,akts,teori,uygulama)
values (1,'Matematik',4,1,6,1,1),(2,'Yaz�l�m M�hendisli�ine Giri�',3,2,5,2,2),
(3,'Veritaban� Y�netim Sistemi',4,3,4,2,2)

--B�l�mler tablosuna 2 adet b�l�m ekleyiniz. (Yaz�l�m M�hendisli�i, �n�aat M�hendisli�i)
insert into bolumler (bolum_no,bol_adi,eposta,telefon,webAdresi) values
(1,'Yaz�l�m M�hendisli�i','yazilim@gmail.com','12312312312','www.yazilim.com'),
(2,'�n�aat M�hendisli�i','insaat@gmail.com','12312312312','www.insaat.com')


--��renciler tablosuna 3 ��renci bilgisi ekleyiniz.
insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tar,cinsiyet,adres,telefon,bol_no,ekleme_tar)
values (1210505007,'Mehmet Ali','Sivri','Bursa','03.18.2002',1,'Bursa','12312312312',1,'09.01.2021'),
(1210505023,'Hasan Emre','Ba�r�yan�k','Hatay','02.05.2003',1,'Hatay','12312312312',1,'09.01.2021'),
(1210505037,'Veysel','U�urlu','�stanbul','04.20.2002',1,'�stanbul','12312312312',1,'09.01.2021')

--Notlar tablosuna otomotik artan alanda dahil olmak �zere 3 ��renciye vize not bilgisi ekleyiniz.
set identity_insert notlar on
insert into notlar(not_id,ogr_no,ders_kodu,ders_yili,vize,final) values
(1,1210505007,1,'12.31.2022',70,70),(2,1210505023,1,'12.31.2022',75,75),(3,1210505037,1,'12.31.2022',80,80)
set identity_insert notlar off

--��renciler tablosuna girilen de�erleri insert i�leminden sonra g�sterecek �ekilde yeni bir ��renci ekleyiniz.
insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tar,cinsiyet,adres,telefon,bol_no,ekleme_tar) 
output inserted.ogr_no,inserted.adi,inserted.soyadi,inserted.dogum_yeri,inserted.dogum_tar,inserted.cinsiyet,
inserted.adres,inserted.telefon,inserted.ekleme_tar
values(1210505072,'Duygu','Teker','�anakkale','06.14.2003',0,'�anakkale','12312312312',1,'09.01.2021')

--B�l�m� �n�aat M�hendisli�i olan ��rencinin adres bilgisini �stanbul olarak g�ncelleyiniz.

--EKSTRA---------------------------------------------------------
insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tar,cinsiyet,adres,telefon,bol_no,ekleme_tar)
values (1210504014,'Dursun','Dursun','Amasya','05.28.2000',1,'Amasya','12312312312',2,'09.01.2019')
-----------------------------------------------------------------

update ogrenci set adres = '�stanbul' where ogr_no = 1210504014 and bol_no = 2

--��renci numaras� �1120505018� olan ��rencinin matematik dersi vize notunu 75 olarak g�ncelleyiniz.
update notlar set vize = 75 where ogr_no = 1210505007 and ders_kodu = 1

--Ad� Sait olan hocan�n unvan bilgisini �Do�.Dr.� olarak g�ncelleyiniz.
update hocalar set unvan = 'Doc.Dr.' where ad = 'Mehmet' and soyad = '�etinkaya'

--Ders kodu 4 olan ve vize notu 70 olan not bilgisini veritaban�ndan siliniz.

--EKSTRA---------------------------------------------------------
insert into dersler (ders_kodu,ders_adi,kredisi,hocasi,akts,teori,uygulama)
values (4,'Web Programlama',4,1,6,3,3)

set identity_insert notlar on
insert into notlar(not_id,ogr_no,ders_kodu,ders_yili,vize,final) values
(4,1210505007,4,'12.31.2022',70,80)
set identity_insert notlar off
----------------------------------------------------------------

delete from notlar where ders_kodu = 4 and vize = 70

--Hocalar tablosundaki ders say�s� alan�n� siliniz.
ALTER TABLE hocalar DROP COLUMN ders_sayisi

--Notlar tablosunu veritaban�ndan siliniz.
DROP TABLE notlar

--Veritaban�n� SQL Server dan siliniz.
DROP DATABASE OKUL