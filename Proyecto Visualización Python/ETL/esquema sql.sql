CREATE SCHEMA IF NOT EXISTS proyecto_3;

USE proyecto_3;

CREATE TABLE hr_raw_data (
id INT AUTO_INCREMENT PRIMARY KEY,
age SMALLINT,
attrition VARCHAR(3),
businesstravel VARCHAR(20),
distancefromhome INT,
education SMALLINT,
gender VARCHAR(2),
jobinvolvement SMALLINT,
joblevel SMALLINT,
jobrole VARCHAR(50),
jobsatisfaction SMALLINT,
maritalstatus VARCHAR(10),
monthlyincome FLOAT,
numcompaniesworked SMALLINT,
overtime VARCHAR(10),
percentsalaryhike INT,
relationshipsatisfaction SMALLINT,
standardhours VARCHAR(10),
stockoptionlevel SMALLINT,
trainingtimeslastyear SMALLINT,
worklifebalance SMALLINT,
yearsatcompany SMALLINT,
yearssincelastpromotion SMALLINT,
yearswithcurrmanager SMALLINT,
remotework VARCHAR(3),
department VARCHAR(30),
environmentsatisfaction SMALLINT);

DROP TABLE hr_raw_data;

SELECT * FROM hr_raw_data;