

## US HOUSEHOLD INCOME PROJECT ##

## Data Cleaning ##


# First, fix the import error in the first column name
ALTER TABLE us_household_income.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

# Explore data in both tables
SELECT * FROM us_household_income.us_household_income_statistics;
SELECT * FROM us_household_income.us_household_income;


# Display numbers of records in each data set, the difference are rows not loaded by MySQL
SELECT COUNT(id) 
FROM us_household_income.us_household_income_statistics;

SELECT COUNT(id) 
FROM us_household_income.us_household_income;





# Search for duplicate rows in the us_household_income table using the 'id' column
SELECT id, 
	COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

# Determine row_id for the duplicate rows
SELECT *
FROM (
	SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_household_income
    ) AS duplicates
WHERE row_num > 1
;

# Delete duplicate rows
DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
			id,
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income
		) AS duplicates
	WHERE row_num > 1
				)
;

# Search for duplicate rows in the us_household_income_statistics table using the 'id' column
SELECT id, 
	COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;
# no duplicates





# Standardize state names
SELECT state_name,
	count(state_name)
FROM us_household_income
GROUP BY state_name
;

# One entry for Georgia has an error, correct it
UPDATE us_household_income
SET state_name = 'Georgia'
WHERE state_name = 'georia'
;
# Standardize Alabama
UPDATE us_household_income
SET state_name = 'Alabama'
WHERE state_name = 'alabama'
;





# Check 'place' names for blanks or nulls
SELECT *
FROM us_household_income
WHERE place = ''
;
# Fill the one blank value
UPDATE us_household_income
SET place = 'Autaugaville'
WHERE place = ''
;





# Analyze 'type' column
SELECT type,
	COUNT(type)
FROM us_household_income
GROUP BY type
;
# Fix some spelling differences for types ('CDP' vs 'CPD', and 'Borough' vs 'Boroughs')
UPDATE us_household_income
SET type = 'Borough'
WHERE type = 'Boroughs'
;
UPDATE us_household_income
SET type = 'CDP'
WHERE type = 'CPD'
;





# Explore land area and water area data columns
# Check to see if any rows contain '0' values for both
SELECT ALand,
	AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;
# no entries










