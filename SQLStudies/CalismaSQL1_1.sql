--1.Soru
select adi,soyadi,DATEPART(Y,dogum_tar) as 'Doðum Tarihi' from ogrenci order by DATEPART(Y,dogum_tar) ASC

--2.Soru
select adi,soyadi,DATEPART(W,dogum_tar) as 'Doðum Tarihi' from ogrenci order by DATEPART(W,dogum_tar) ASC

--3.Soru
select adi,soyadi,dogum_tar from ogrenci where MONTH(GETDATE()) = MONTH(dogum_tar) and DAY(GETDATE()) = DAY(dogum_tar)

--4.Soru
select * from ogrenci where MONTH(GETDATE()) = MONTH(dogum_tar)

--5.Soru
select adi,soyadi,DATEDIFF(DAY,dogum_tar,GETDATE()) AS 'Geçen Gün' from ogrenci

--6.Soru
select STR(ogr_no) + ' ' + adi + ' ' + soyadi as 'Ad Soyad Numara' from ogrenci 

--Kendi Deneme Sorgularým

select adi,soyadi,DATEPART(YYYY,dogum_tar) as 'Doðum Yýlý' from ogrenci order by 'Doðum Yýlý' ASC

select ogr_no,vize,final,(vize * 0.4 + final * 0.6) as Ortalama from notlar where (vize * 0.4 + final * 0.6) >= 50
order by Ortalama ASC

--Dersten Geçen Öðrencileri Gösteren Kod
select ogr_no,vize,final,(vize * 0.4 + final * 0.6) as Ortalama from notlar
where final >= 40 and (vize * 0.4 + final * 0.6) >= 50 order by Ortalama

select MAX((vize * 0.4 + final * 0.6)) as 'En Yüksek Ortalama' from notlar

select MIN((vize * 0.4 + final * 0.6)) as 'En Düþük Ortalama' from notlar 

