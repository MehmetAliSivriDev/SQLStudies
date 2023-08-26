alter table bolumler add telefon varchar(11), web_adresi varchar(50)
alter table hocalar add ders_sayisi int, dogum_tarihi date
alter table ogrenci add ekleme_tar datetime DEFAULT GETDATE()
alter table notlar add ders_yili date, vize int, final int
alter table dersler add teori int, uygulama int

