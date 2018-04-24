/* 1 */

SELECT COUNT(Year)/2700000 AS AverageCrimerate, CRIME_DETAILS.Year
FROM CRIME_DETAILS
GROUP BY Year;

/*
2016- 0.0992
2017- 0.0624
*/


/* 2 */
/*
SELECT CRIME_TYPES.Primary_Type AS Crimes_at_SIDEWALK_Arrest
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_DETAILS.Location_Description='SIDEWALK' and CRIME_INCIDENTS.Arrest='TRUE'
GROUP BY CRIME_TYPES.Primary_Type;
*/

SELECT * FROM CRIME_DETAILS
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID
WHERE CRIME_DETAILS.Location_Description='SIDEWALK' and CRIME_INCIDENTS.Arrest='TRUE';


 /* 3 */
 
SELECT CRIME_TYPES.Primary_Type AS MostCrimes, CRIME_INCIDENTS.District
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_DETAILS.Location_Description='SIDEWALK' and CRIME_INCIDENTS.Arrest='TRUE'
GROUP BY CRIME_INCIDENTS.District;


 /* 4 */
/*
SELECT CRIME_TYPES.Primary_Type As CrimesList
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_INCIDENTS.FBI_Code=26 and CRIME_INCIDENTS.Domestic='TRUE'
GROUP BY CRIME_TYPES.Primary_Type;
*/

SELECT * FROM CRIME_DETAILS
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID
WHERE CRIME_INCIDENTS.FBI_Code=26 and CRIME_INCIDENTS.Domestic='TRUE';

/* 5 */

SELECT COUNT(Year) AS NumberofCrimes, CRIME_DETAILS.Year
FROM CRIME_DETAILS
INNER JOIN CRIME_TYPES ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID
WHERE CRIME_TYPES.Primary_Type='THEFT'
GROUP BY CRIME_DETAILS.Year;

/* There is no increase in the number of crimes from 2016 to 2017 
count in 2016 - 61523
count in 2017 - 39723
*/

SELECT
(SELECT COUNT(Year)
FROM CRIME_DETAILS
INNER JOIN CRIME_TYPES ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID
WHERE CRIME_TYPES.Primary_Type='THEFT' and CRIME_DETAILS.Year=2017) - (SELECT COUNT(Year)
FROM CRIME_DETAILS
INNER JOIN CRIME_TYPES ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID
WHERE CRIME_TYPES.Primary_Type='THEFT' and CRIME_DETAILS.Year=2016) AS INCREASE_IN_CRIME_FROM16to17;

/* Decrease in the number of crimes = 21800 */


/* 6 */

SELECT CRIME_TYPES.Primary_Type AS CRIMETYPE,COUNT(CRIME_TYPES.Primary_Type) AS COUNT
FROM CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID
WHERE CRIME_DETAILS.Block='001XX N PARKSIDE AVE'
GROUP BY CRIME_TYPES.Primary_Type
ORDER BY COUNT DESC
LIMIT 3;

/* 
BATTERY	- 20
THEFT	- 15
ASSAULT	- 14
*/


/* 7 */

SELECT AVG(datediff(CRIME_DETAILS.Updated_On,CRIME_INCIDENTS.Date)) AS AverageDays
FROM CRIME_INCIDENTS
INNER JOIN CRIME_DETAILS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID;

/* Average number of days between the crime incident date and last updated date = 14.1834*/

/* 8 */

SELECT * FROM CRIME_DETAILS
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID
WHERE DATE_FORMAT(CRIME_INCIDENTS.Date,'%d/%m/%Y')='2016/04/30' and DATE_FORMAT(CRIME_DETAILS.Updated_On,'%d/%m/%Y')='30/04/2016';

SELECT CRIME_TYPES.Primary_Type AS ListofCrimes
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_INCIDENTS.Date like'2016-04-30%' and CRIME_DETAILS.Updated_On like '2016-04-30%';

/*
SELECT CRIME_TYPES.Primary_Type AS ListofCrimes
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE DATE_FORMAT(CRIME_INCIDENTS.Date,'%d/%m/%Y')='2016/04/30' and DATE_FORMAT(CRIME_DETAILS.Updated_On,'%d/%m/%Y')='30/04/2016';
*/

/*There are no crimes that were committed on 4/30/2016 and updated on the same day*/

/*
SELECT CRIME_TYPES.Primary_Type
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_INCIDENTS.Date='2016/04/30'
UNION
SELECT CRIME_TYPES.Primary_Type
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE DATE_FORMAT(CRIME_DETAILS.Updated_On,'%d/%m/%Y')='30/04/2016';
*/



/* 9 */


SELECT * FROM CRIME_DETAILS
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID
WHERE CRIME_DETAILS.Year=2016 and CRIME_DETAILS.Location_Description='STREET' and CRIME_INCIDENTS.Domestic='TRUE' and CRIME_INCIDENTS.Arrest='TRUE';

/*
SELECT CRIME_TYPES.Primary_Type AS CrimeList
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_DETAILS.Year=2016 and CRIME_DETAILS.Location_Description='STREET' and CRIME_INCIDENTS.Domestic='TRUE' and CRIME_INCIDENTS.Arrest='TRUE'
GROUP BY CRIME_TYPES.Primary_Type;
*/


/* 10 */

SELECT * FROM CRIME_DETAILS
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID
WHERE CRIME_DETAILS.Description='TELEPHONE THREAT' and CRIME_INCIDENTS.District=10 and CRIME_INCIDENTS.FBI_Code=30;

/*
SELECT CRIME_TYPES.Primary_Type AS CRIMES
FROM ((CRIME_TYPES
INNER JOIN CRIME_DETAILS ON CRIME_TYPES.Primary_Type_ID = CRIME_DETAILS.Primary_Type_ID)
INNER JOIN CRIME_INCIDENTS ON CRIME_DETAILS.Crime_ID = CRIME_INCIDENTS.Crime_ID)
WHERE CRIME_DETAILS.Description='TELEPHONE THREAT' and CRIME_INCIDENTS.District=10 and CRIME_INCIDENTS.FBI_Code=30;
*/

/* No, there aren`t any crimes that involved Telephone threats that occured in Disctric 10 and FBI code 30 */

