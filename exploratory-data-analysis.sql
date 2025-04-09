

## US HOUSEHOLD INCOME PROJECT ##

## Exploratory Data Analysis ##

SELECT * 
FROM us_household_income.us_household_income_statistics;

SELECT * 
FROM us_household_income.us_household_income;





# Explore land and water areas for each state
SELECT state_name,
	SUM(ALand) AS sum_land
FROM us_household_income
GROUP BY state_name
ORDER BY sum_land DESC
;

SELECT state_name,
	SUM(AWater) AS sum_water
FROM us_household_income
GROUP BY state_name
ORDER BY sum_water DESC
;





# Join both tables together, exclude '0' values for income statistics
SELECT * 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
;





# Explore average of the mean and median incomes by state
# Output the top 5 and bottom 5, and then the full table
SELECT u.state_name, 
	ROUND(AVG(mean), 1) AS avg_mean, 
    ROUND(AVG(median), 1) AS avg_median 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
GROUP BY u.state_name
ORDER BY avg_mean DESC
LIMIT 5
;

SELECT u.state_name, 
	ROUND(AVG(mean), 1) AS avg_mean, 
    ROUND(AVG(median), 1) AS avg_median 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
GROUP BY u.state_name
ORDER BY avg_mean ASC
LIMIT 5
;

# Full table
SELECT u.state_name, 
	ROUND(AVG(mean), 1) AS avg_mean, 
    ROUND(AVG(median), 1) AS avg_median 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
GROUP BY u.state_name
ORDER BY avg_mean DESC
;





# # Explore average of the mean and median incomes by type of municipality
SELECT u.type, 
	COUNT(type) as count,
	ROUND(AVG(mean), 1) AS avg_mean, 
    ROUND(AVG(median), 1) AS avg_median 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
GROUP BY u.type
ORDER BY avg_mean DESC
;





# Explore income data with respect to particular cities
# Output the top and bottom 10 cities
SELECT u.state_name,
	u.city,
	ROUND(AVG(mean), 1) AS avg_mean, 
    ROUND(AVG(median), 1) AS avg_median 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
GROUP BY u.state_name, u.city
ORDER BY avg_mean DESC
LIMIT 10
;

SELECT u.state_name,
	u.city,
	ROUND(AVG(mean), 1) AS avg_mean, 
    ROUND(AVG(median), 1) AS avg_median 
FROM us_household_income AS u
JOIN us_household_income_statistics AS us
	ON u.id = us.id
WHERE mean != 0
GROUP BY u.state_name, u.city
ORDER BY avg_mean ASC
LIMIT 10
;











