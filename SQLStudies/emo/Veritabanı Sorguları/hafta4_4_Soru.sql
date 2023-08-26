-- 1- Yaz�l�m M�hendisli�inde okuyan ��rencilerin numaras�n�, ad�n� ve soyad�n� listeleyiniz.
select ogr_no, adi, soyadi  from ogrenci
where ogrenci.bol_no = (select bol_no from bolumler where bol_adi = 'Yaz�l�m M�hendisli�i')

select ogr_no , adi, soyadi from ogrenci, bolumler
where ogrenci.bol_no = bolumler.bol_no and bol_adi = 'Yaz�l�m M�hendisli�i'


-- 2- Vize s�nav� 40 ve �zeri olan ��rencilerin ad ve soyad bilgilerini listeleyin.
select adi,soyadi from ogrenci 
where ogr_no in (select ogr_no from notlar where vize >= 40)
order by ogrenci.ogr_no

select adi,soyadi from ogrenci ,notlar
where ogrenci.ogr_no = notlar.ogr_no and vize >= 40 
order by ogrenci.ogr_no


-- 3-Matematik 2 dersinden Vize s�nav� 40 ve �zeri olan ��rencilerin 
-- ad ve soyad bilgilerini ada g�re artan olacak �ekilde ekrandaki gibi listeleyin.
select adi, soyadi from ogrenci
where ogr_no in (select ogr_no from notlar where vize >= 40  and  ders_kodu = (select ders_kodu from dersler where ders_adi = 'Matematik 2'))
order by adi


-- 4- 108 kodlu dersin vize notu, vize ortalamas�ndan b�y�k olan ��rencilerin ad, soyad ve vize notunu listeleyen SQL kodunu yaz�n�z.
select adi, soyadi, vize, ders_kodu from ogrenci
inner join notlar on ogrenci.ogr_no = notlar.ogr_no 
where vize > (select avg(vize) from notlar where notlar.ders_kodu = 108) and 
notlar.ders_kodu = 108

select adi, soyadi, vize, ders_kodu from ogrenci, notlar where ogrenci.ogr_no = notlar.ogr_no 
and vize > (select avg(vize) from notlar where notlar.ders_kodu = 108) and 
notlar.ders_kodu = 108







