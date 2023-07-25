---------------- EASY LEVEL ----------------------------------------------------------------------------------

/* Show first name, last name, and gender of patients whose gender is 'M' */

SELECT 
	first_name, last_name, gender
FROM
	patients
WHERE
	gender = 'M'
	
	
/* Show first name and last name of patients who does not have allergies. (null) */

SELECT 
	first_name, last_name
FROM 
	patients
WHERE
	allergies IS null
	
	
/* Show first name of patients that start with the letter 'C' */

SELECT 
	first_name
FROM 
	patients
WHERE
	first_name LIKE 'C%'
	
	
/* Show first name and last name of patients that weight within the range of 100 to 120 (inclusive) */

SELECT 
	first_name, last_name
FROM 
	patients
WHERE
	weight >= 100 AND weight <= 120


/* Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */

UPDATE
	patients
SET
	allergies = 'NKA'
WHERE
	allergies IS null

-- Rows modified: 2059 -- 


/* Show first name and last name concatinated into one column to show their full name. */

SELECT
	CONCAT(first_name, ' ', last_name) AS full_name
FROM
	patients
	
	
/* Show first name, last name, and the full province name of each patient.

Example: 'Ontario' instead of 'ON'*/

SELECT
	pat.first_name, pat.last_name,
   	pro.province_name
FROM 
	patients pat
INNER JOIN
	province_names pro ON pat.province_id = pro.province_id


/* Show how many patients have a birth_date with 2010 as the birth year. */

SELECT
	COUNT(*)
FROM 
	patients 
WHERE
	YEAR(birth_date) = 2010

-- result: 55


/* Show the first_name, last_name, and height of the patient with the greatest height. */

SELECT
	first_name, last_name, MAX(height)
FROM 
	patients 


/* Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000 */

SELECT
	*
FROM 
	patients 
WHERE 
	patient_id IN (1,45,534,879,1000)


/* Show the total number of admissions */

SELECT
	COUNT(patient_id)
FROM 
	admissions 


/* Show all the columns from admissions where the patient was admitted and discharged on the same day. */

SELECT
	*
FROM 
	admissions 
WHERE
	admission_date = discharge_date


/* Show the patient id and the total number of admissions for patient_id 579. */

SELECT
	patient_id,
    COUNT(admission_date)
FROM 
	admissions
WHERE 
	patient_id = 579


/* Based on the cities that our patients live in, show unique cities that are in province_id 'NS'? */

SELECT
	distinct(city)
FROM 
	patients
WHERE 
	province_id = 'NS'


/* Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70 */

SELECT
	first_name, last_name, birth_date
FROM 
	patients
WHERE 
	height > 160 AND weight > 70


/* Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null */

SELECT
	first_name, last_name, allergies
FROM 
	patients
WHERE 
	city = 'Hamilton' AND allergies IS NOT NULL


/* Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). 
Show the result order in ascending by city. */

SELECT
	DISTINCT(city)
FROM 
	patients
WHERE 
	lower(SUBSTR(city,1,1)) in ('a','e','i','o','u')
ORDER BY city

-- Outra Solução

SELECT 
	DISTINCT city
FROM 
	patients
WHERE
  city LIKE 'a%'
  OR city LIKE 'e%'
  OR city LIKE 'i%'
  OR city LIKE 'o%'
  OR city LIKE 'u%'
ORDER BY 
	city


---------- MEDIUM LEVEL----------------------------------------------------------------------------------------------

/* Show unique birth years from patients and order them by ascending. */

SELECT 
	distinct(YEAR(birth_date))
FROM 
	patients
order by
	birth_date
	

/* Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 
'Leo' then include them in the output. */

SELECT 
	first_name
FROM
	patients
GROUP BY 
	first_name
HAVING 
	COUNT(*) = 1
order by
	first_name

/* Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. */

SELECT 
	patient_id, first_name
FROM
	patients
WHERE
	first_name LIKE 's%s'
AND len(first_name) >= 6

/* Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table.*/

SELECT 
	pat.patient_id, pat.first_name, pat.last_name
FROM
	patients pat
INNER JOIN
	admissions adm ON adm.patient_id = pat.patient_id
WHERE
	adm.diagnosis = 'Dementia'

/* Display every patient's first_name. Order the list by the length of each name and then by alphbetically */

SELECT 
	first_name
FROM
	patients
ORDER BY
	LEN(first_name),
    first_name

/* Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.*/

SELECT 
	sum(CASE WHEN gender = 'M' then 1 else 0 end) AS QTD_MASC,
    sum(CASE WHEN gender = 'F' then 1 else 0 end) AS QTD_FEM
FROM
	patients

-- OUTRA FORMA DE FAZER MENOS PERFORMÁTICA--
SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;
 
-- OU --
SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients

-- OU --
select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients

/* Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
Show results ordered ascending by allergies then by first_name then by last_name. */

SELECT 
	first_name, last_name, allergies
FROM
	patients
where
	allergies IN ('Penicillin','Morphine')
order by
	allergies,
    first_name,
    last_name

/* Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */

SELECT 
	patient_id, diagnosis
FROM
	admissions
group by
	patient_id, diagnosis
HAVING COUNT (patient_id) > 1

/* Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending. */

SELECT 
	city, 
    COUNT(1) AS [QTD]
FROM
	patients
group by
	city
ORDER BY
	QTD DESC,
    city 
