

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


























