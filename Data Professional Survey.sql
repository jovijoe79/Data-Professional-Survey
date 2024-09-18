Select * 
FROM first_project;


SELECT *
FROM first_project_staging;

-- Simply to check for duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER()
OVER(
PARTITION BY Unique_ID, Email, Date_Taken, Time_Spent, Browser, OS, City, Country, Referrer, Time_Spent, Job_Title, 
Career_Switch, Annual_Salary, Work_Industry, Favorite_Language, Happy_with_salary, Happy_with_worklife, Happy_with_Coworkers,
Happy_with_Management, Happy_with_Mobility, Happy_with_learning_new_things, Difficult_to_enter_Data, New_job_most_important_thing,
Gender, Current_Age, Country_of_Residence, Level_of_Education, Ethnicity) AS row_num
FROM first_project
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

ALTER TABLE first_project
DROP COLUMN row_num;

SELECT *
FROM first_project;

CREATE TABLE `first_project_staging` (
  `Unique_ID` text,
  `Email` text,
  `Date_Taken` text,
  `Time_Taken` text,
  `Browser` text,
  `OS` text,
  `City` text,
  `Country` text,
  `Referrer` text,
  `Time_Spent` text,
  `Job_Title` text,
  `Career_Switch` text,
  `Annual_Salary` text,
  `Work_Industry` text,
  `Favorite_Language` text,
  `Happy_with_salary` int DEFAULT NULL,
  `Happy_with_worklife` int DEFAULT NULL,
  `Happy_with_Coworkers` int DEFAULT NULL,
  `Happy_with_Management` int DEFAULT NULL,
  `Happy_with_Mobility` int DEFAULT NULL,
  `Happy_with_learning_new_things` int DEFAULT NULL,
  `Difficult_to_enter_Data` text,
  `New_job_most_important_thing` text,
  `Gender` text,
  `Current_Age` int DEFAULT NULL,
  `Country_of_Residence` text,
  `Level_of_Education` text,
  `Ethnicity` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM first_project_staging;

INSERT INTO first_project_staging
SELECT *
FROM first_project;

ALTER TABLE first_project_staging
DROP COLUMN Browser;
ALTER TABLE first_project_staging
DROP COLUMN OS;
ALTER TABLE first_project_staging
DROP COLUMN City;
ALTER TABLE first_project_staging
DROP COLUMN Country;
ALTER TABLE first_project_staging
DROP COLUMN Referrer;


SELECT *
FROM first_project_staging;

SELECT DISTINCT Job_Title
FROM first_project_staging;

SELECT *
FROM first_project_staging;

SELECT DISTINCT Career_Switch
FROM first_project_staging;

DELETE
FROM first_project_staging
WHERE Job_Title LIKE "Other%";

WITH Avg_Salary_cte AS
(
SELECT *, SUBSTRING_INDEX(Annual_Salary, '-', 1) AS first_num,
	   SUBSTRING_INDEX(Annual_Salary, '-', -1) AS second_num
FROM first_project_staging
), Avg_Sala_cte AS 
(
SELECT *, (first_num + second_num)/2 AS Avg_Sal
FROM Avg_Salary_cte
) 

SELECT *
FROM Avg_Sala_cte;

ALTER TABLE first_project_staging
MODIFY COLUMN Annual_Salary text;
-- UPDATE first_project_staging
-- JOIN Yearly_Sal 
-- 	ON first_project_staging.Unique_ID = Yearly_Sal.Unique_ID
--     SET first_project_staging.Annual_Salary = Yearly_Sal.Avg_Sal;
-- UPDATE first_project_staging
-- SET Annual_Salary = Avg_Sala_cte;

SELECT *
FROM first_project_staging;

SELECT DISTINCT Work_Industry
FROM first_project_staging;

DELETE 
FROM first_project_staging
WHERE Work_Industry LIKE "Other%";

SELECT DISTINCT Favorite_Language
FROM first_project_staging;

DELETE 
FROM first_project_staging
WHERE Favorite_Language LIKE "Other%";

SELECT *
FROM first_project_staging;

SELECT DISTINCT Country_of_Residence
FROM first_project_staging;


WITH CTE AS
(
SELECT Unique_ID, RIGHT(Country_of_Residence, CHAR_LENGTH(Country_of_Residence) - LOCATE(':', Country_of_Residence)) AS COUNTRY
FROM first_project_staging
WHERE Country_of_Residence LIKE "Other%"
)
UPDATE first_project_staging
JOIN CTE 
	ON first_project_staging.Unique_ID = CTE.Unique_ID
SET first_project_staging.Country_of_Residence = CTE.COUNTRY;
SELECT *
FROM first_project_staging;

CREATE TABLE `first_project_staging_2` (
  `Unique_ID` text,
  `Email` text,
  `Date_Taken` text,
  `Time_Taken` text,
  `Time_Spent` text,
  `Job_Title` text,
  `Career_Switch` text,
  `Annual_Salary` text,
  `Work_Industry` text,
  `Favorite_Language` text,
  `Happy_with_salary` int DEFAULT NULL,
  `Happy_with_worklife` int DEFAULT NULL,
  `Happy_with_Coworkers` int DEFAULT NULL,
  `Happy_with_Management` int DEFAULT NULL,
  `Happy_with_Mobility` int DEFAULT NULL,
  `Happy_with_learning_new_things` int DEFAULT NULL,
  `Difficult_to_enter_Data` text,
  `New_job_most_important_thing` text,
  `Gender` text,
  `Current_Age` int DEFAULT NULL,
  `Country_of_Residence` text,
  `Level_of_Education` text,
  `Ethnicity` text,
  `Average_Salary` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM first_project_staging_2;

INSERT INTO first_project_staging_2
SELECT *, SUBSTRING_INDEX(Annual_Salary, '-', 1) AS first_num,
	   SUBSTRING_INDEX(Annual_Salary, '-', -1) AS second_num
FROM first_project_staging;
-- WHERE (first_num + second_num)/2 IS NOT NULL

SELECT *
FROM first_project_staging;

DELETE
FROM first_project_staging
WHERE Country_of_Residence LIKE 'Other%';

SELECT *
FROM first_project_staging
WHERE Annual_Salary = 0;

UPDATE first_project_staging
SET Annual_Salary = 40
WHERE Annual_Salary = 0;




