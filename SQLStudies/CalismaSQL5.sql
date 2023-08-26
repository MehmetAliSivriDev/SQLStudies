--VTYS1_9 Uygulama 2'deki Uygulaman�n Cevaplar�d�r.

--*************************************************************************************************
--Veri Taban�n� Olu�turma
create database calisma5
---------------------------------------------------------------------------------------------------

--Tablolar� Olu�turma
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
--Sorgu K�s�mlar�

--�d�n� tablosunda veri tipi para olacak �ekilde �Gecikme Cezas�� ad�nda yeni bir alan ekleyen SQL kodunu yaz�n�z.
ALTER TABLE odunc ADD gecikme_cezasi money

--�ye tablosundaki adres alan�n� bo� ge�ilemez ve karakter uzunlu�u 80 olacak �ekilde de�i�tiren SQL kodunu yaz�n�z.
ALTER TABLE uye ALTER COLUMN adresi varchar(80) not null

--Aktif �ye olarak, kendi bilgilerinizi ve 3 (�mer, Bade, Feyza) ��renciye ait bilgileri �ye tablosuna ekleyen SQL kodunu yaz�n�z.
insert into uye (uye_no,uye_adi,uye_soyadi,adresi,aktifMi) values
(1,'Mehmet Ali','Sivri','Bursa',1),
(2,'�mer','�elik','�stanbul',1),
(3,'Bade','�zt�rk','Amasya',1),
(4,'Feyza','Ba�r�yan�k','Trabzon',1)

--Ahmet Hamdi Tanp�nar��n Saatleri Ayarlama Enstit�s� adl� kitap bilgilerini kitap, kitap_yazar ve yazar tablolar�na ekleyen SQL
--kodunu yaz�n�z.

insert into yazar(yazar_no,yazar_adi,yazar_soyadi,dogum_tar,biyogrofi) values
(1,'Ahmet Hamdi','Tanp�nar','06.23.1901','Yazar')

insert into kitap(kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti) values
(1,'Saatleri Ayarlama Enstit�s�','9781101613672',382,'�zet')

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(1,1,1)

--Dostoyevksi Su� ve ceza, Beyaz Geceler ve Kumarbaz isimli kitaplar�n� ve onlara ba�l� tablo bilgilerini veri taban�na ekleyen
--SQL kodunu yaz�n�z.
insert into yazar(yazar_no,yazar_adi,yazar_soyadi,dogum_tar,biyogrofi) values
(2,'Dostoyevski','Fyodor','11.11.1821','Yazar2')

insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti) values
(2,'Su� ve Ceza','9781101613673',705,'�zet2')

insert into tur (tur_no,tur_aciklama) values (1,'Roman'),(2,'Distopya'),(3,'Polisiye')

insert into kitap_tur(kitap_tur_no,kitap_no,tur_no) values (1,2,1)

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(2,2,2)

insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (3,'Beyaz Geceler','9781101613675',96,'�zet3')

insert into kitap_tur(kitap_tur_no,kitap_no,tur_no) values (2,3,1)

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(3,3,2)

insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (4,'Kumarbaz','9781101613680',187,'�zet4')

insert into kitap_tur(kitap_tur_no,kitap_no,tur_no) values (3,4,1)

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no) values
(4,4,2)

--Dostoyevski�nin ad�n� Fyodor Dostoyevski olarak g�ncelleyen SQL kodunu yaz�n�z.
update yazar set yazar_adi = 'Fyodor', yazar_soyadi = 'Dostoyevski' where yazar_no = 2

--�mer adl� �yenin 2021 �ubat, Bade�nin 2021 Mart ve Feyza�n�n 2021 Temmuz ay�nda �d�n� ald��� kitab�n �d�n� kay�t
--bilgilerini ekleyen SQL kodunu yaz�n�z.

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (1,2,2,'02.01.2021')

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (2,3,3,'03.01.2021')

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (3,4,4,'07.01.2021')

--Beyaz Geceler adl� kitab� veritaban�ndan siliniz.
delete from kitap_yazar where kitap_no = 3
delete from kitap_tur where kitap_no = 3
delete from odunc where kitap_no = 3
delete from kitap where kitap_no = 3