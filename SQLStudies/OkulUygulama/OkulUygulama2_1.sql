alter table odunc add gecikme_cezasi money


alter table uye alter column adresi varchar(80) not null


insert into uye (uye_no,uye_adi,uye_soyadi,adresi,aktifmi)
values (1,'Mehmet Ali','Sivri','Bursa',1)

insert into uye (uye_no,uye_adi,uye_soyadi,adresi,aktifmi)
values (2,'Ömer','Özçevik','Ýstanbul',1)

insert into uye (uye_no,uye_adi,uye_soyadi,adresi,aktifmi)
values (3,'Bade','Türkoðlu','Ankara',1)

insert into uye (uye_no,uye_adi,uye_soyadi,adresi,aktifmi)
values (4,'Feyza','Kaplan','Kýrklareli',1)


insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (1,'Saatleri Ayarlama Enstitüsü','9781101613672',382,'Özet')

insert into yazar (yazar_no,yazar_adi,yazar_soyadi,dogum_tar,biyogrofi)
values (1,'Ahmet Hamdi','Tanpýnar','06.23.1901','Yazar')

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no)
values (1,1,1)


insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (2,'Suç ve Ceza','9781101613673',705,'Özet2')

insert into yazar (yazar_no,yazar_adi,yazar_soyadi,dogum_tar,biyogrofi)
values (2,'Dostoyevski','Fyodor','11.11.1821','Yazar2')

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no)
values (2,2,2)


insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (3,'Beyaz Geceler','9781101613675',96,'Özet3')

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no)
values (3,3,2)


insert into kitap (kitap_no,kitap_adi,isbn_no,sayfa_sayisi,kitap_ozeti)
values (4,'Kumarbaz','9781101613680',187,'Özet4')

insert into kitap_yazar (kitap_yazar_no,kitap_no,yazar_no)
values (4,4,2)


update yazar set yazar_adi = 'Fyador Dostoyevski' where yazar_no = 2


insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (1,1,2,'02.01.2021')

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (2,2,3,'03.01.2021')

insert into odunc (odunc_no,kitap_no,uye_no,verme_tarihi)
values (3,4,4,'07.01.2021')


delete from kitap_yazar where kitap_yazar_no = 3
delete from kitap where kitap_no = 3

