--VTYS1-11'deki 3 Sorunun Cevaplarý

--1.Soru Matematik dersinden 70 -95 arasýnda final notu alan öðrencilerin numarasýný ve final notunu ekranda listeleyin.
select ogr_no,ders_kodu,final from notlar where ders_kodu = 106 and final >= 70 and
final <= 95

--2.Soru Vize ve final ortalamasý (vize*0.4+final*0.6) 75 üzerindeki öðrencilerin numarasýný ve ortalamasýný ekrandaki gibi listeleyin.
select ogr_no, (vize*0.4 + final * 0.6) as Ortalama from notlar where (vize*0.4 + final * 0.6)  >= 75

--Deneme 3.Soruya benzer
select ogr_no,adi + ' ' + soyadi as AdSoyad, DATEDIFF(YEAR,dogum_tar,GETDATE()) as Yaþ from ogrenci where ogr_no like ('109%')

