SELECT  * FROM DimCustomer
select * from DimCustomer where  FirstName LIKE 'E%' AND EmailAddress LIKE '%m'  
select * from  DimCustomer where  FirstName LIKE 'E%' OR  EmailAddress LIKE 'b%'
select  * from  DimDate 
where FullDateAlternateKey BETWEEN '2005.01.01'AND '2014.02.03' AND EnglishDayNameOfWeek = 'Saturday' AND ---istedi�imiz kadar and  ekleyebiliriz

select  D.FirstName,D.LastName,G.City from  DimCustomer D
INNER  JOIN  DimGeography G on g.GeographyKey=d.GeographyKey
where D.BirthDate BETWEEN  '1950.10.05' AND '1970.10.05'  AND GENDER = 'M'

select D.FirstName,D.LastName,(select City from DimGeography Where GeographyKey=D.GeographyKey) as City from DimCustomer D ---�nneer jo�n kullanmadan subquery  ilee
where D.BirthDate BETWEEN '1950.10.05' AND '1970.10.05' AND GENDER = 'M'

---DISTINCT  
SELECT * FROM DimCustomer
select distinct FirstName,MaritalStatus from DimCustomer
select distinct MaritalStatus,FirstName from DimCustomer


select * from DimCustomer

select  * from  DimCustomer where  TotalChildren in(3,2,4) and YearlyIncome>40000 and  Gender = 'M'


select  * from  DimCustomer order by 14,2,1
select  FirstName,upper(FirstName)as b�y�kisim from DimCustomer
select  FirstName,lower(FirstName)as b�y�kisim from DimCustomer

----CONCAT 
select  concat(FirstName,LastName,Gender,G.City) from DimCustomer D
INNER JOIN DimGeography G on G.GeographyKey=d.GeographyKey

select D.FirstName + ' ' + D.LastName + ' ' + G.City From  DimCustomer D -----Birer Bo�luklu
INNER JOIN DimGeography G on G.GeographyKey=d.GeographyKey

select  SUBSTRING(FirstName,1,5) from DimCustomer


select  len(FirstName) as isimuzunluklar�  from DimCustomer


----arad���m�z harf  �be�inin ka��nc� s�rada  oldu�unu s�yler
select  CHARINDEX('B',FirstName) from DimCustomer
select  RIGHT(FirstName,5) from DimCustomer
select  left(FirstName,5) from DimCustomer

---H�credeki kelime hardlerini de�i�tirmemiz  sa�lar
select REPLACE(FirstName,'A','M') from DimCustomer
----D�n���m Fonksiyonlar�
select  FORMAT(S.BirthDate, '1999/01/01') as FormatBirthdate from DimCustomer S

---karater  bir ifadeyi say�sal bir  ifadeye  d�n��t�rme  
select CAST('123456' as INT) AS Say�salDe�er----��� de ayn�  i�levi g�r�yor
select TRY_CAST('ABC' as varchar) AS SAYISALDE�ER
select TRY_CAST('ABC' as int) AS SAYISALDE�ER----HATA VERMEZ  NULL D�NER
SELECT TRY_CONVERT(float , '123.23') AS SAYISALD�ER
select  CAST(D.BirthDate as  Date) as veritipi FROM DimCustomer D
select  CAST(D.BirthDate as  varchar) as veritipi FROM DimCustomer D
select  CAST(D.BirthDate as  int) as veritipi FROM DimCustomer D
select  CAST(D.BirthDate as  float) as veritipi FROM DimCustomer D

SELECT CONVERT(varchar,BirthDate,103) from DimCustomer--DATE  OLUNCA DE���T�REM�YORUZ 

SELECT ROUND(48.856,2)
SELECT ROUND(48.756,0)
SELECT ROUND(751.1569,3)
SELECT  ROUND(1456.1256,3,1)---3 sa�a geklip 1 yard�m�yla at�yor
select 1000%3


--Genel Fonksiyonlar

ALTER TABLE DimCustomer
ADD yenikolon NVARCHAR(MAX) NULL
SELECT * FROM DimCustomer
select ISNULL(yenikolon,'A') FROM DimCustomer
select * from DimCustomer

ALTER TABLE DimCustomer
ADD MaasKategorisi NVARCHAR(20);


--ko�ullu ifadeler 
select 
      FirstName,
	  d.YearlyIncome,CASE
	               WHEN YearlyIncome>40000 THEN 'Y�KSEK MAA�'
				   WHEN YearlyIncome BETWEEN 30000 AND 40000 THEN 'ORTA MAA�'
				   ELSE 'D���K'
				   END AS Maa�Kategorisi
				   FROM DimCustomer D
-----Doldurma ��lemi(�zellik M�hendisli�i) yeni  bir de�i�ken Maa� Kategorisi
Update DimCustomer
Set Maa�Kategorisi = 
    CASE 
	    WHEN YearlyIncome>40000 then 'Y�ksek Maa�'
		WHEN YearlyIncome BETWEEN 30000 AND  40000 THEN 'Orta Maa�'
		ELSE 'D���k Maa�'
	END
WHERE Maa�Kategorisi IS NULL;

SELECT Maa�Kategorisi,count(*) as Maa�Kategorisi FROM DimCustomer
GROUP BY  Maa�Kategorisi

UPDATE DimCustomer
SET MaasKategorisi= ISNULL(MaasKategorisi,100) ;


select  
      FirstName,
	  LastName,
	  Gender,
	 MaritalStatus,CASE
	               WHEN GENDER = 'M' and MaritalStatus = 'M' THEN  'ERKEK EVL�'
				   WHEN GENDER ='F' and  MaritalStatus = 'M' THEN  'KADIN EVL�'
				   ELSE  'EVL� DE��L'
				   END AS  C�NS�YET�L��K�
				   FROM DimCustomer D

select COUNT(*) AS BO�DE�ERSAYISI FROM DimCustomer WHERE YearlyIncome IS NULL and FirstName IS NULL AND LastName IS NULL



select * from DimCustomer
----bo� kolonlar�  doldurma
SELECT  ISNULL(MaasKategorisi,'1903') From DimCustomer 

UPDATE DimCustomer
SET MaasKategorisi= ISNULL(MaasKategorisi,100) ;
select* from DimCustomer


---Maa� Katgeorisi Y�ksek Olanlar� B�y�kten K����e Do�ru s�rala bunlar�n  Posta Kodlar�,�simleri,Soyisimleri,Maa�lar�,�ehirleri-------------

select G.PostalCode,G.City,FirstName,LastName,YearlyIncome,Maa�Kategorisi from DimCustomer D
INNER JOIN DimGeography G ON D.GeographyKey=d.GeographyKey WHERE D.Maa�Kategorisi = 'Y�ksek Maa�' order by 5 desc

---GRUPLAMA FONKS�YONLARI 
select AVG(YearlyIncome)AS Maa�ortalamas� from DimCustomer
select MAX(YearlyIncome)As enfazlamaa� from DimCustomer
Select MIN(YearlyIncome)AS enazmaa� from DimCustomer
select sum(YearlyIncome)AS toplammaa� from DimCustomer

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
HAVING AVG(YearlyIncome) >48000--Grupta  ortalama  ayl�k geliri 48 binden  b�y�k olanlar� filitreliyoruz
ORDER BY AVG(YearlyIncome) DESC	



SELECT CommuteDistance,avg(YearlyIncome) FROM DimCustomer
GROUP BY CommuteDistance
HAVING MAX(YearlyIncome) >48000--Grupta ayl�k geliri 48 binden  b�y�k olanlar� filitreliyoruz
ORDER BY MAX(YearlyIncome) DESC	

select CommuteDistance,COUNT(YearlyIncome) FROM DimCustomer---0-1 Miles Grubunda  bulunan 6310 ki�inin maa�� 5000 den  b�y�kt�r.
GROUP BY CommuteDistance
HAVING COUNT(YearlyIncome)>5000
ORDER BY COUNT(YearlyIncome) ASC

select distinct GeographyKey from DimCustomer

select GeographyKey from DimCustomer----iki tablodaki kolonlar�n  b�t�n�n� al�yor   ( UN�ON  ) her�eyi birer  kez al�yor 
union
select GeographyKey from DimGeography


SELECT  GeographyKey From DimCustomer---iki tablodaki verileri birle�tirir ayn� olanalar� iki defa al�r(UN�ON ALL)
union all
select GeographyKey From DimGeography


select GeographyKey FROM DimCustomer-------iki tablodaki sadece ortak olan  verileri al�yor.(�NTERSECT)
intersect
select GeographyKey FROM DimGeography


select GeographyKey FROM DimCustomer-------DimCutomer tablosudaki GeographyKey lerin hepsi DimGeography de var oldu�undan dolay� bo�  sorgu d�ner(EXCEPT)
except
select GeographyKey FROM DimGeography

select Distinct GeographyKey   from  DimGeography---- 655  adet  
select GeographyKey From DimGeography-------sadece dimgeography e �zel GeographyKey ler say�s� ortaklar� almaz ----319  adet  burda  ortak  olanlar� almad� 
except
select GeographyKey from DimCustomer



----TABLO OLU�TURMA
CREATE TABLE ��RENC�LER(
 ��RENC�ID INT IDENTITY(1,1) PRIMARY KEY, 
 AD NVARCHAR(20),
 SOYAD NVARCHAR(20),
 SINIF NVARCHAR(10),
 DO�UMTAR�H� DATE,
 G�R��TAR�H� DATETIME,
 YA�  INT,
 AKT�F BIT
 );



INSERT INTO ��RENC�LER (AD,SOYAD,SINIF,DO�UMTAR�H�,G�R��TAR�H�,YA�,AKT�F)
VALUES ('AL�','HANO�LU','4','2001-06-28','2020-06-19 15:30',24,1);

INSERT INTO ��RENC�LER (AD,SOYAD,SINIF,DO�UMTAR�H�,G�R��TAR�H�,YA�,AKT�F)
VALUES ('HASAN','HANO�LU','4','2001/06/28','2020/06/19 15:30',24,1);

INSERT INTO ��RENC�LER (AD, SOYAD, SINIF, DO�UMTAR�H�, G�R��TAR�H�, YA�, AKT�F)
VALUES ('MUHAMMED', 'HANO�LU', '4', '2001-06-28', '2020-06-19 15:30:00', 24, 1);


SELECT * FROM ��RENC�LER

----KAYIT S�LME
DELETE FROM ��RENC�LER
WHERE AD = 'HASAN'

TRUNCATE TABLE ��RENC�LER ---��RENC�LER TABLOSUNU S�L 

ALTER TABLE  ��RENC�LER
ADD BRAN� NVARCHAR(20)

SELECT* FROM ��RENC�LER

UPDATE ��RENC�LER
SET BRAN� = CASE 
                WHEN BRAN� IS NULL THEN 'FUTBOL'
                ELSE BRAN�
            END;


SELECT  * FROM ��RENC�LER

ALTER TABLE ��RENC�LER
DROP  COLUMN SINIF

SELECT * FROM ��RENC�LER

UPDATE ��RENC�LER
SET AKT�F= AKT�F+9,AD='MUHAMMED'


SELECT * FROM ��RENC�LER