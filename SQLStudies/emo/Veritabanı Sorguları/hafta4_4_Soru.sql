-- 1- Yazýlým Mühendisliðinde okuyan öðrencilerin numarasýný, adýný ve soyadýný listeleyiniz.
select ogr_no, adi, soyadi  from ogrenci
where ogrenci.bol_no = (select bol_no from bolumler where bol_adi = 'Yazýlým Mühendisliði')

select ogr_no , adi, soyadi from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no and bol_adi = 'Yazýlým Mühendisliði'


-- 2- Vize sýnavý 40 ve üzeri olan öðrencilerin ad ve soyad bilgilerini listeleyin.
select adi,soyadi from ogrenci 
where ogr_no in (select ogr_no from notlar where vize >= 40)
order by ogrenci.ogr_no

select adi,soyadi from ogrenci ,notlar
where ogrenci.ogr_no = notlar.ogr_no and vize >= 40 
order by ogrenci.ogr_no


-- 3-Matematik 2 dersinden Vize sýnavý 40 ve üzeri olan öðrencilerin 
-- ad ve soyad bilgilerini ada göre artan olacak þekilde ekrandaki gibi listeleyin.
select adi, soyadi from ogrenci
where ogr_no in (select ogr_no from notlar where vize >= 40  and  ders_kodu = (select ders_kodu from dersler where ders_adi = 'Matematik 2'))
order by adi


-- 4- 108 kodlu dersin vize notu, vize ortalamasýndan büyük olan öðrencilerin ad, soyad ve vize notunu listeleyen SQL kodunu yazýnýz.
select adi, soyadi, vize, ders_kodu from ogrenci
inner join notlar on ogrenci.ogr_no = notlar.ogr_no 
where vize > (select avg(vize) from notlar where notlar.ders_kodu = 108) and 
notlar.ders_kodu = 108

select adi, soyadi, vize, ders_kodu from ogrenci, notlar where ogrenci.ogr_no = notlar.ogr_no 
and vize > (select avg(vize) from notlar where notlar.ders_kodu = 108) and 
notlar.ders_kodu = 108







