SELECT  * FROM DimCustomer
select * from DimCustomer where  FirstName LIKE 'E%' AND EmailAddress LIKE '%m'  
select * from  DimCustomer where  FirstName LIKE 'E%' OR  EmailAddress LIKE 'b%'
select  * from  DimDate 
where FullDateAlternateKey BETWEEN '2005.01.01'AND '2014.02.03' AND EnglishDayNameOfWeek = 'Saturday' AND ---istediðimiz kadar and  ekleyebiliriz

select  D.FirstName,D.LastName,G.City from  DimCustomer D
INNER  JOIN  DimGeography G on g.GeographyKey=d.GeographyKey
where D.BirthDate BETWEEN  '1950.10.05' AND '1970.10.05'  AND GENDER = 'M'

select D.FirstName,D.LastName,(select City from DimGeography Where GeographyKey=D.GeographyKey) as City from DimCustomer D ---ýnneer joýn kullanmadan subquery  ilee
where D.BirthDate BETWEEN '1950.10.05' AND '1970.10.05' AND GENDER = 'M'

---DISTINCT  
SELECT * FROM DimCustomer
select distinct FirstName,MaritalStatus from DimCustomer
select distinct MaritalStatus,FirstName from DimCustomer


select * from DimCustomer

select  * from  DimCustomer where  TotalChildren in(3,2,4) and YearlyIncome>40000 and  Gender = 'M'


select  * from  DimCustomer order by 14,2,1
select  FirstName,upper(FirstName)as büyükisim from DimCustomer
select  FirstName,lower(FirstName)as büyükisim from DimCustomer

----CONCAT 
select  concat(FirstName,LastName,Gender,G.City) from DimCustomer D
INNER JOIN DimGeography G on G.GeographyKey=d.GeographyKey

select D.FirstName + ' ' + D.LastName + ' ' + G.City From  DimCustomer D -----Birer Boþluklu
INNER JOIN DimGeography G on G.GeographyKey=d.GeographyKey

select  SUBSTRING(FirstName,1,5) from DimCustomer


select  len(FirstName) as isimuzunluklarý  from DimCustomer


----aradýðýmýz harf  öbeðinin kaçýncý sýrada  olduðunu söyler
select  CHARINDEX('B',FirstName) from DimCustomer
select  RIGHT(FirstName,5) from DimCustomer
select  left(FirstName,5) from DimCustomer

---Hücredeki kelime hardlerini deðiþtirmemiz  saðlar
select REPLACE(FirstName,'A','M') from DimCustomer
----Dönüþüm Fonksiyonlarý
select  FORMAT(S.BirthDate, '1999/01/01') as FormatBirthdate from DimCustomer S

---karater  bir ifadeyi sayýsal bir  ifadeye  dönüþtürme  
select CAST('123456' as INT) AS SayýsalDeðer----üçü de ayný  iþlevi görüyor
select TRY_CAST('ABC' as varchar) AS SAYISALDEÐER
select TRY_CAST('ABC' as int) AS SAYISALDEÐER----HATA VERMEZ  NULL DÖNER
SELECT TRY_CONVERT(float , '123.23') AS SAYISALDÐER
select  CAST(D.BirthDate as  Date) as veritipi FROM DimCustomer D
select  CAST(D.BirthDate as  varchar) as veritipi FROM DimCustomer D
select  CAST(D.BirthDate as  int) as veritipi FROM DimCustomer D
select  CAST(D.BirthDate as  float) as veritipi FROM DimCustomer D

SELECT CONVERT(varchar,BirthDate,103) from DimCustomer--DATE  OLUNCA DEÐÝÞTÝREMÝYORUZ 

SELECT ROUND(48.856,2)
SELECT ROUND(48.756,0)
SELECT ROUND(751.1569,3)
SELECT  ROUND(1456.1256,3,1)---3 saða geklip 1 yardýmýyla atýyor
select 1000%3


--Genel Fonksiyonlar

ALTER TABLE DimCustomer
ADD yenikolon NVARCHAR(MAX) NULL
SELECT * FROM DimCustomer
select ISNULL(yenikolon,'A') FROM DimCustomer
select * from DimCustomer

ALTER TABLE DimCustomer
ADD MaasKategorisi NVARCHAR(20);


--koþullu ifadeler 
select 
      FirstName,
	  d.YearlyIncome,CASE
	               WHEN YearlyIncome>40000 THEN 'YÜKSEK MAAÞ'
				   WHEN YearlyIncome BETWEEN 30000 AND 40000 THEN 'ORTA MAAÞ'
				   ELSE 'DÜÞÜK'
				   END AS MaaþKategorisi
				   FROM DimCustomer D
-----Doldurma Ýþlemi(Özellik Mühendisliði) yeni  bir deðiþken Maaþ Kategorisi
Update DimCustomer
Set MaaþKategorisi = 
    CASE 
	    WHEN YearlyIncome>40000 then 'Yüksek Maaþ'
		WHEN YearlyIncome BETWEEN 30000 AND  40000 THEN 'Orta Maaþ'
		ELSE 'Düþük Maaþ'
	END
WHERE MaaþKategorisi IS NULL;

SELECT MaaþKategorisi,count(*) as MaaþKategorisi FROM DimCustomer
GROUP BY  MaaþKategorisi

UPDATE DimCustomer
SET MaasKategorisi= ISNULL(MaasKategorisi,100) ;


select  
      FirstName,
	  LastName,
	  Gender,
	 MaritalStatus,CASE
	               WHEN GENDER = 'M' and MaritalStatus = 'M' THEN  'ERKEK EVLÝ'
				   WHEN GENDER ='F' and  MaritalStatus = 'M' THEN  'KADIN EVLÝ'
				   ELSE  'EVLÝ DEÐÝL'
				   END AS  CÝNSÝYETÝLÝÞKÝ
				   FROM DimCustomer D

select COUNT(*) AS BOÞDEÐERSAYISI FROM DimCustomer WHERE YearlyIncome IS NULL and FirstName IS NULL AND LastName IS NULL



select * from DimCustomer
----boþ kolonlarý  doldurma
SELECT  ISNULL(MaasKategorisi,'1903') From DimCustomer 

UPDATE DimCustomer
SET MaasKategorisi= ISNULL(MaasKategorisi,100) ;
select* from DimCustomer


---Maaþ Katgeorisi Yüksek Olanlarý Büyükten Küçüðe Doðru sýrala bunlarýn  Posta Kodlarý,Ýsimleri,Soyisimleri,Maaþlarý,Þehirleri-------------

select G.PostalCode,G.City,FirstName,LastName,YearlyIncome,MaaþKategorisi from DimCustomer D
INNER JOIN DimGeography G ON D.GeographyKey=d.GeographyKey WHERE D.MaaþKategorisi = 'Yüksek Maaþ' order by 5 desc

---GRUPLAMA FONKSÝYONLARI 
select AVG(YearlyIncome)AS Maaþortalamasý from DimCustomer
select MAX(YearlyIncome)As enfazlamaaþ from DimCustomer
Select MIN(YearlyIncome)AS enazmaaþ from DimCustomer
select sum(YearlyIncome)AS toplammaaþ from DimCustomer

select * from DimCustomer



select AVG(YearlyIncome),MaritalStatus FROM DimCustomer
group by MaritalStatus
order by avg(YearlyIncome) desc

SELECT AVG(YearlyIncome) AS AvgYearlyIncome, TotalChildren
FROM DimCustomer
GROUP BY TotalChildren
ORDER BY AvgYearlyIncome DESC;


select AVG(YearlyIncome) AS AVGYEAR,TotalChildren
from DimCustomer
GROUP BY TotalChildren
ORDER BY AVGYEAR DESC;


SELECT CommuteDistance,avg(YearlyIncome) FROM DimCustomer
GROUP BY CommuteDistance
HAVING AVG(YearlyIncome) >48000--Grupta  ortalama  aylýk geliri 48 binden  büyük olanlarý filitreliyoruz
ORDER BY AVG(YearlyIncome) DESC	



SELECT CommuteDistance,avg(YearlyIncome) FROM DimCustomer
GROUP BY CommuteDistance
HAVING MAX(YearlyIncome) >48000--Grupta aylýk geliri 48 binden  büyük olanlarý filitreliyoruz
ORDER BY MAX(YearlyIncome) DESC	

select CommuteDistance,COUNT(YearlyIncome) FROM DimCustomer---0-1 Miles Grubunda  bulunan 6310 kiþinin maaþý 5000 den  büyüktür.
GROUP BY CommuteDistance
HAVING COUNT(YearlyIncome)>5000
ORDER BY COUNT(YearlyIncome) ASC

select distinct GeographyKey from DimCustomer

select GeographyKey from DimCustomer----iki tablodaki kolonlarýn  bütününü alýyor   ( UNÝON  ) herþeyi birer  kez alýyor 
union
select GeographyKey from DimGeography


SELECT  GeographyKey From DimCustomer---iki tablodaki verileri birleþtirir ayný olanalarý iki defa alýr(UNÝON ALL)
union all
select GeographyKey From DimGeography


select GeographyKey FROM DimCustomer-------iki tablodaki sadece ortak olan  verileri alýyor.(ÝNTERSECT)
intersect
select GeographyKey FROM DimGeography


select GeographyKey FROM DimCustomer-------DimCutomer tablosudaki GeographyKey lerin hepsi DimGeography de var olduðundan dolayý boþ  sorgu döner(EXCEPT)
except
select GeographyKey FROM DimGeography

select Distinct GeographyKey   from  DimGeography---- 655  adet  
select GeographyKey From DimGeography-------sadece dimgeography e özel GeographyKey ler sayýsý ortaklarý almaz ----319  adet  burda  ortak  olanlarý almadý 
except
select GeographyKey from DimCustomer



----TABLO OLUÞTURMA
CREATE TABLE ÖÐRENCÝLER(
 ÖÐRENCÝID INT IDENTITY(1,1) PRIMARY KEY, 
 AD NVARCHAR(20),
 SOYAD NVARCHAR(20),
 SINIF NVARCHAR(10),
 DOÐUMTARÝHÝ DATE,
 GÝRÝÞTARÝHÝ DATETIME,
 YAÞ  INT,
 AKTÝF BIT
 );



INSERT INTO ÖÐRENCÝLER (AD,SOYAD,SINIF,DOÐUMTARÝHÝ,GÝRÝÞTARÝHÝ,YAÞ,AKTÝF)
VALUES ('ALÝ','HANOÐLU','4','2001-06-28','2020-06-19 15:30',24,1);

INSERT INTO ÖÐRENCÝLER (AD,SOYAD,SINIF,DOÐUMTARÝHÝ,GÝRÝÞTARÝHÝ,YAÞ,AKTÝF)
VALUES ('HASAN','HANOÐLU','4','2001/06/28','2020/06/19 15:30',24,1);

INSERT INTO ÖÐRENCÝLER (AD, SOYAD, SINIF, DOÐUMTARÝHÝ, GÝRÝÞTARÝHÝ, YAÞ, AKTÝF)
VALUES ('MUHAMMED', 'HANOÐLU', '4', '2001-06-28', '2020-06-19 15:30:00', 24, 1);


SELECT * FROM ÖÐRENCÝLER

----KAYIT SÝLME
DELETE FROM ÖÐRENCÝLER
WHERE AD = 'HASAN'

TRUNCATE TABLE ÖÐRENCÝLER ---ÖÐRENCÝLER TABLOSUNU SÝL 

ALTER TABLE  ÖÐRENCÝLER
ADD BRANÞ NVARCHAR(20)

SELECT* FROM ÖÐRENCÝLER

UPDATE ÖÐRENCÝLER
SET BRANÞ = CASE 
                WHEN BRANÞ IS NULL THEN 'FUTBOL'
                ELSE BRANÞ
            END;


SELECT  * FROM ÖÐRENCÝLER

ALTER TABLE ÖÐRENCÝLER
DROP  COLUMN SINIF

SELECT * FROM ÖÐRENCÝLER

UPDATE ÖÐRENCÝLER
SET AKTÝF= AKTÝF+9,AD='MUHAMMED'


SELECT * FROM ÖÐRENCÝLER