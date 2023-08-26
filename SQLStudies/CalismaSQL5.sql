--VTYS1_9 Uygulama 2'deki Uygulamanýn Cevaplarýdýr.

--*************************************************************************************************
--Veri Tabanýný Oluþturma
create database calisma5
---------------------------------------------------------------------------------------------------

--Tablolarý Oluþturma
create table yazar(
	yazar_no int PRIMARY KEY not null,
	yazar_adi varchar(50),
	yazar_soyadi varchar(50),
	dogum_tar date,
	biyogrofi varchar(MAX)

)

create table tur(
	tur_no int PRIMARY KEY not null,
	tur_aciklama varchar(40)
)

create table uye(
	uye_no int PRIMARY KEY not null,
	uye_adi varchar(50),
	uye_soyadi varchar(50),
	adresi varchar(MAX),
	aktifMi bit
)

create table kitap(
	kitap_no int PRIMARY KEY not null,
	kitap_adi varchar(50),
	isbn_no varchar(13),
	sayfa_sayisi int,
	kitap_ozeti varchar(MAX)
)

create table kitap_tur(
	kitap_tur_no int PRIMARY KEY not null,
	kitap_no int FOREIGN KEY (kitap_no) REFERENCES kitap(kitap_no),
	tur_no int FOREIGN KEY (tur_no) REFERENCES tur(tur_no)
)

create table kitap_yazar(
	kitap_yazar_no int PRIMARY KEY not null,
	yazar_no int FOREIGN KEY (yazar_no) REFERENCES yazar(yazar_no),
	kitap_no int FOREIGN KEY (kitap_no) REFERENCES kitap(kitap_no)
)

create table odunc(
	odunc_no int PRIMARY KEY not null,
	kitap_no int FOREIGN KEY (kitap_no) REFERENCES kitap(kitap_no),
	uye_no int FOREIGN KEY (uye_no) REFERENCES uye(uye_no),
	verme_tarihi date,
	verme_suresi time,
	geldiMi bit
)
---------------------------------------------------------------------------------------------------
--Sorgu Kýsýmlarý

--Ödünç tablosunda veri tipi para olacak þekilde “Gecikme Cezasý” adýnda yeni bir alan ekleyen SQL kodunu yazýnýz.
ALTER TABLE odunc ADD gecikme_cezasi money

--Üye tablosundaki adres alanýný boþ geçilemez ve karakter uzunluðu 80 olacak þekilde deðiþtiren SQL kodunu yazýnýz.
ALTER TABLE uye ALTER COLUMN adresi varchar(80) not null

--Aktif üye olarak, kendi bilgilerinizi ve 3 (Ömer, Bade, Feyza) öðrenciye ait bilgileri üye tablosuna ekleyen SQL kodunu yazýnýz.
insert into uye (uye_no,uye_adi,uye_soyadi,adresi,aktifMi) values
(1,'Mehmet Ali','Sivri','Bursa',1),
(2,'Ömer','Çelik','Ýstanbul',1),
(3,'Bade','Öztürk','Amasya',1),
(4,'Feyza','Baðrýyanýk','Trabzon',1)

--Ahmet Hamdi Tanpýnar’ýn Saatleri Ayarlama Enstitüsü adlý kitap bilgilerini kitap, kitap_yazar ve yazar tablolarýna ekleyen SQL
--kodunu yazýnýz.

insert into yazar(yazar_no,yazar_adi,yazar_soyadi,dogum_tar,biyogrofi) values
(1,'Ahmet Hamdi','Tanpýnar','06.23.1901','Yazar')

insert into kitap(kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti) values
(1,'Saatleri Ayarlama Enstitüsü','9781101613672',382,'Özet')

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(1,1,1)

--Dostoyevksi Suç ve ceza, Beyaz Geceler ve Kumarbaz isimli kitaplarýný ve onlara baðlý tablo bilgilerini veri tabanýna ekleyen
--SQL kodunu yazýnýz.
insert into yazar(yazar_no,yazar_adi,yazar_soyadi,dogum_tar,biyogrofi) values
(2,'Dostoyevski','Fyodor','11.11.1821','Yazar2')

insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti) values
(2,'Suç ve Ceza','9781101613673',705,'Özet2')

insert into tur (tur_no,tur_aciklama) values (1,'Roman'),(2,'Distopya'),(3,'Polisiye')

insert into kitap_tur(kitap_tur_no,kitap_no,tur_no) values (1,2,1)

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(2,2,2)

insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (3,'Beyaz Geceler','9781101613675',96,'Özet3')

insert into kitap_tur(kitap_tur_no,kitap_no,tur_no) values (2,3,1)

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(3,3,2)

insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (4,'Kumarbaz','9781101613680',187,'Özet4')

insert into kitap_tur(kitap_tur_no,kitap_no,tur_no) values (3,4,1)

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(4,4,2)

--Dostoyevski’nin adýný Fyodor Dostoyevski olarak güncelleyen SQL kodunu yazýnýz.
update yazar set yazar_adi = 'Fyodor', yazar_soyadi = 'Dostoyevski' where yazar_no = 2

--Ömer adlý üyenin 2021 Þubat, Bade’nin 2021 Mart ve Feyza’nýn 2021 Temmuz ayýnda ödünç aldýðý kitabýn ödünç kayýt
--bilgilerini ekleyen SQL kodunu yazýnýz.

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (1,2,2,'02.01.2021')

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (2,3,3,'03.01.2021')

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (3,4,4,'07.01.2021')

--Beyaz Geceler adlý kitabý veritabanýndan siliniz.
delete from kitap_yazar where kitap_no = 3
delete from kitap_tur where kitap_no = 3
delete from odunc where kitap_no = 3
delete from kitap where kitap_no = 3