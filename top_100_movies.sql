## Quick overview of data
------------------------------------------------------------------------------------------------------------------------
#Select everything
SELECT *
FROM `movies.top_100_movies`

## Cleaning
------------------------------------------------------------------------------------------------------------------------
#Looking into last column(deleted)
SELECT DISTINCT(string_field_13)
FROM `movies.top_100_movies`

#Deleting last column using the ALTER TABLE statement
ALTER TABLE `movies_2003_to_2022.top_100_movies`
DROP COLUMN string_field_13

#Using this to find bad values(other curriences I will not be using)
SELECT *
FROM `movies.top_100_movies`
ORDER BY Profit

#Deleting the bad values from the previous query using a like operator
DELETE
FROM `movies.top_100_movies`
WHERE Budget LIKE 'A%'

## Highest and Lowest budgets
------------------------------------------------------------------------------------------------------------------------
#Using ORDER BY and limiting it to 1 to see the highest and lowest budgets for movies
#SELECT Title, SAFE_CAST(Budget AS INT64) AS Budget<-----## Needed this before I fixed the table to have budget be an integer!
SELECT Title, Budget
FROM `movies.top_100_movies`
ORDER BY Budget DESC
LIMIT 1

#Lowest
#SELECT Title, SAFE_CAST(Budget AS INT64) AS Budget ##Here as well
SELECT Title, Budget
FROM `movies.top_100_movies`
ORDER BY Budget
LIMIT 1

#Using arithmetic to find out which movies made money and which lost them and then writing if they were a flop or found sucess in making more money than they put in
SELECT Title, (Profit - Budget) AS Net,
CASE
  WHEN (Profit - Budget) < 0  THEN 'Flop'
  ELSE 'Not'
END AS flop_or_not
FROM `movies.top_100_movies`

## Filtering by rating (will be used for later queries)
------------------------------------------------------------------------------------------------------------------------
#Using a where clause to find movies with a rating of 8 or higher and then ordering it from highest to lowest
SELECT * 
FROM `movies.top_100_movies`
WHERE Rating >= 8
ORDER BY Rating DESC

## John Wick! (LIKE operator)
------------------------------------------------------------------------------------------------------------------------
#Using a LIKE operator to find some movies I watched recently!
SELECT *
FROM `movies.top_100_movies`
WHERE Title LIKE "John%"

# CASE statements
------------------------------------------------------------------------------------------------------------------------
#Using a CASE statement to label movies for their ratings
SELECT Title, Rating,
CASE
  WHEN Rating BETWEEN 3 AND 5 THEN 'This movie is bad'
  WHEN Rating BETWEEN 5 AND 7 THEN 'This movie is average'
  WHEN Rating >= 8 THEN 'This movie is very good!'
  ELSE 'We dont talk about these...'
END
FROM `movies.top_100_movies`
ORDER BY Rating

#Using CASE statement to easily tell if a movie was filmed domestically or not
SELECT Title,
CASE
  WHEN Filming_location = 'USA' THEN 'Yes'
  ELSE 'No'
END AS filmed_in_usa_y_or_n
FROM `movies.top_100_movies`

## AVG and DISTINCT
------------------------------------------------------------------------------------------------------------------------
##Finding average of whichever year you want
SELECT Year, AVG(Profit) AS average_profit_2011 #Switch year at end of AS
FROM `movies.top_100_movies`
WHERE Year = 2011 #Switch year here as well
GROUP BY
Year

#Using this to look at the different ratings used in this data (for subquery)
SELECT DISTINCT(Certificate)
FROM `movies.top_100_movies`

## Subqueries
------------------------------------------------------------------------------------------------------------------------
#Using a subquery to find the amount of R rated movies vs G rated movies in the list of most popular movies(surprising!)
SELECT COUNT(Certificate) AS R_rated_movies,
(
  SELECT COUNT(Certificate)
  FROM `movies.top_100_movies`
  WHERE Certificate = 'G'
) AS G_rated_movies
FROM `movies.top_100_movies`
WHERE Certificate = 'R'

#Adding another for PG rated movies and PG-13 rated movies
SELECT COUNT(Certificate) AS PG_rated_movies,
(
  SELECT COUNT(Certificate)
  FROM `movies.top_100_movies`
  WHERE Certificate = 'R'
) AS R_rated_movies,
(
  SELECT COUNT(Certificate)
  FROM `movies.top_100_movies`
  WHERE Certificate = 'G'
) AS G_rated_movies,
(
  SELECT COUNT(Certificate)
  FROM `movies.top_100_movies`
  WHERE Certificate = 'PG-13'
) AS PG13_rated_movies
FROM `movies.top_100_movies`
WHERE Certificate = 'PG'

#R rated and G rated movies with higher than a 7 rating using AND as well as a subquery
SELECT COUNT(Rating) AS G_rated_movies_above_7,
(
  SELECT COUNT(Rating)
  FROM `movies.top_100_movies`
  WHERE Rating > 7 AND Certificate = 'R'
  ) AS R_rated_movies_above_7
FROM `movies.top_100_movies`
WHERE Rating > 7 AND Certificate = 'G'








