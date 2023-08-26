insert into hocalar (ad, soyad,unvan,ders_sayisi,dogum_tarihi) 
values ('Sait','Orhan','Dr.Ögr.Üyesi',2,'12.25.1985')

insert into dersler (ders_kodu,ders_adi,kredisi,hocasi,akts,teori,uygulama)
values (1,'Matematik',4,1,5,4,0),(2,'Yazýlým Mühendisliðine Giriþ',3,1,4,3,0),
(3,'Veri Tabaný Yönetim Sistemleri',4,1,5,2,2)

insert into bolumler (bol_no,bol_adi) values (1,'Yazýlým Mühendisliði'),(2,'Ýnþaat Mühendisliði')

insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tarihi,cinsiyet,adres,telefon,bol_no)
values ('1210505045','Ahmet','Iþýk','Ýstanbul','05.09.2000',0,'Kýrklareli','05050505050',1)

set identity_insert notlar on
insert into notlar (not_id,ogr_no,ders_kodu,ders_yili,vize,final) 
values (1,'1210505045',3,'2022',50,1)
set identity_insert notlar off

insert into ogrenci (ogr_no,adi,soyadi,dogum_yeri,dogum_tarihi,cinsiyet,adres,telefon,bol_no)
output inserted.ogr_no,inserted.adi,inserted.soyadi,inserted.dogum_yeri,inserted.dogum_tarihi,inserted.cinsiyet,inserted.adres,inserted.telefon,inserted.bol_no
values ('1212050023','Mehmet','Kaya','Ýstanbul','10.01.2000',1,'Kýrklareli','05050505050',1)

update ogrenci set adres='Ýstanbul' where bol_no = 2

update notlar set vize = 75 where ogr_no = '1210505045' and ders_kodu = 1

update hocalar set unvan = 'Do.Dr.' where ad='Sait'

delete from notlar where ders_kodu = 3 and vize = 75 






