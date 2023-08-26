--Bu veritabaný https://www.oguzhantas.com/sql-server/364-sql-sorularindan-veritabani-ornek-sinav.html adlý siteye göre tasarlanmýþtýr.

create database personeldb

create table tblDepartman(
	
	departmanID int PRIMARY KEY IDENTITY(1,1),
	departman varchar(50)
)

create table tblPersonel(

	personelID int PRIMARY KEY IDENTITY(1,1),
	adi varchar(50),
	soyadi varchar(50),
	telefon varchar(11),
	eposta varchar(50),
	tc_no varchar(11),
	departmanID int FOREIGN KEY (departmanID) REFERENCES tblDepartman(departmanID),
	sifre int,
	gorevi varchar(50)
)

create table tblMaas(

	maasID int PRIMARY KEY IDENTITY(1,1),
	maas int, 
	tarih date,
	personelID int FOREIGN KEY (personelID) REFERENCES tblPersonel(personelID)
)