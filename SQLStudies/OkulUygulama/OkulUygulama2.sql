create table tur(
	tur_no int primary key,
	tur_aciklama varchar(MAX),
)

create table yazar(
	yazar_no int primary key,
	yazar_adi varchar(50),
	yazar_soyadi varchar(50),
	dogum_tar date,
	biyogrofi varchar(MAX)

)

create table uye(
	uye_no int primary key,
	uye_adi varchar(50),
	uye_soyadi varchar(50),
	adresi varchar(MAX),
	aktifmi bit,
	
)

create table kitap(
	kitap_no int primary key,
	kitap_adi varchar(50),
	isbn_no varchar(20),
	sayfa_sayisi int,
	kitap_ozeti varchar(MAX)

)

create table kitap_yazar(
	kitap_yazar_no int primary key,
	yazar_no int FOREIGN KEY (yazar_no) REFERENCES yazar(yazar_no),
	kitap_no int FOREIGN KEY (kitap_no) REFERENCES kitap(kitap_no),

)

create table kitap_tur(
	kitap_tur_no int primary key,
	kitap_no int FOREIGN KEY (kitap_no) REFERENCES kitap(kitap_no),
	tur_no int FOREIGN KEY (tur_no) REFERENCES tur(tur_no)
)

create table odunc(
	odunc_no int primary key,
	kitap_no int FOREIGN KEY (kitap_no) REFERENCES kitap(kitap_no),
	uye_no int FOREIGN KEY (uye_no) REFERENCES uye(uye_no),
	verme_tarihi date,
	verme_suresi time,
	geldimi bit

)

