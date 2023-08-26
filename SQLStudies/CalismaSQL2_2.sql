--Bu Sorular https://www.oguzhantas.com/sql-server/364-sql-sorularindan-veritabani-ornek-sinav.html adlý siteden alýnmýþtýr

--1.Soru
select adi,soyadi,sifre from tblPersonel where eposta = 'sivri109@gmail.com'

--2.Soru
select adi,soyadi from tblPersonel where soyadi like '%can%'

--3.Soru
select * from tblPersonel
update tblPersonel set telefon = '0545' + SUBSTRING(telefon,5,11) where telefon like '123%'

--4.Soru
insert into tblDepartman (departman) values ('Pazarlama')

--5.Soru
insert into tblPersonel(adi,soyadi,telefon,eposta,tc_no,departmanID,sifre,gorevi)
values ('Halil Can','Çelik','54354354354','celik@gmail.com','12345678912',1,1234,'Bilgisayar Mühendisi')

insert into tblMaas (maas,tarih,personelID) values ('20000','12.15.2022',5)

update tblPersonel set adi = 'Ali', soyadi = 'Can' where tc_no = '12345678912'

select * from tblPersonel

--6.Soru
select SUM(maas) as 'Toplam Maaþ' from tblMaas m , tblPersonel p
where m.personelID = p.personelID and m.tarih <= '12.30.2022' and m.tarih >= '01.01.2022'
and p.tc_no = '24310464970'

--7.Soru
select distinct p.adi,p.soyadi,d.departman,m.maas from tblPersonel p, tblMaas m, tblDepartman d
where p.personelID = m.personelID and p.departmanID = d.departmanID

--8.Soru
select d.departman, SUM(m.maas) from tblDepartman d, tblMaas m, tblPersonel p
where p.departmanID = d.departmanID and p.personelID = m.personelID
group by d.departman order by SUM(maas)

--9.Soru
select d.departman,COUNT(p.personelID) as 'Çalýþan Kiþi Sayýsý' from tblDepartman d, tblPersonel p
where d.departmanID = p.departmanID group by d.departman


