#I found a dataset on video game sales on Kaggle. I was interested so I thought I'd dive into it. I acted as my own
higher up and asked myself questions about things I would want to know. I found some good insights on which genre
is the most lucrative and which games are the most popular in each region. I comment all of my insights below.

Legend:
### - Question
## - Insights
# - Breaking the fourth wall comments

------------------------------------------------------------------------------------------------------------------------
#Getting basic idea of this data using this query
SELECT *
FROM `video_game_sales.sales_data`
ORDER BY Rank ASC

#I have been really liking this game about space exploration so I thought I'd look it up quick!
SELECT *
FROM `video_game_sales.sales_data`
WHERE Name = "No Man's Sky"

Question #1
------------------------------------------------------------------------------------------------------------------------
###I want to know how many releases each platform has. Additionally give me a column that has the global sales of each platforms. 
SELECT DISTINCT Platform, COUNT(Platform) AS Game_Releases, SUM(Global_Sales) as Global_Sales_Millions
FROM `video_game_sales.sales_data`
GROUP BY Platform
ORDER BY Game_Releases DESC

##Im finding that the most games released were for the DS, PS2, and PS3. That makes sense considering these were the most popular systems during their respective times.

Question #2
------------------------------------------------------------------------------------------------------------------------
###I need to know the global sales of our game 'The Sims' across all plaftorms.
SELECT SUM(Global_Sales) AS global_sales_millions_sims
FROM `video_game_sales.sales_data`
WHERE Name LIKE 'The Sims%'

###I need to see how well each Game and Expansion Pack performed.
SELECT Platform, Name, SUM(Global_Sales) AS global_sales_millions
FROM `video_game_sales.sales_data`
WHERE Name LIKE 'The Sims%'
GROUP BY Platform, Name 
ORDER BY Name

Question #3
------------------------------------------------------------------------------------------------------------------------
###If I wanted to make a video game what are the most popular genres and which have made the most money. I will need
a suggestion based off of your findings.
SELECT DISTINCT Genre, COUNT(Genre) AS Genre_Releases, SUM(Global_Sales) as Global_Sales_Millions
FROM `video_game_sales.sales_data`
GROUP BY Genre
ORDER BY Global_Sales_Millions DESC

##The top three genres are Action, Sports and Role-Playing while the most grossing are Action, Sports and Shooter.
I would recommend getting into the shooter genre as it seems it has the best ratio of games made to sales. 

Question #3 Cont.
------------------------------------------------------------------------------------------------------------------------
##Using these querires to double check the previous one
SELECT *
FROM `video_game_sales.sales_data`
WHERE Platform = "DS"

SELECT *
FROM `video_game_sales.sales_data`
WHERE Platform = "XB"

SELECT SUM(Global_Sales) AS ps2_global_sales
FROM `video_game_sales.sales_data`
WHERE Platform = "PS2"

SELECT COUNT(Platform) AS each
FROM `video_game_sales.sales_data`

Question #4
------------------------------------------------------------------------------------------------------------------------
###How many distinct publishers are there?
SELECT DISTINCT(Publisher)
FROM `video_game_sales.sales_data`

##There are 579 distinct publishers however I noticed one named "Unknown" going to dig deeper into that

##I decide to do the same query as before but with a order by statement to more easily find common things like "Null", "Unknown", "N/A" etc
SELECT DISTINCT(Publisher)
FROM `video_game_sales.sales_data`
ORDER BY Publisher

##Then decide to look at these weird ones

SELECT *
FROM `video_game_sales.sales_data`
WHERE Publisher = 'Unknown' OR Publisher = 'N/A' OR Publisher = 'New' OR Publisher = 'Sony Music Entertainment'
ORDER By Publisher

Question #5 Rank() and subqueries
------------------------------------------------------------------------------------------------------------------------
###What are the top 10 performing games in each region?
SELECT Publisher, Platform, Year, Name, NA_Sales, ranking,
FROM (
  SELECT *,
  rank() over(ORDER BY NA_Sales DESC) as ranking,
  from `video_game_sales.sales_data`) rnk
WHERE ranking <= 10
ORDER BY Ranking

SELECT Publisher, Platform, Year, Name, EU_Sales, ranking,
FROM (
  SELECT *,
  rank() over(ORDER BY EU_Sales DESC) as ranking,
  from `video_game_sales.sales_data`) rnk
WHERE ranking <= 10
ORDER BY Ranking

SELECT Publisher, Platform, Year, Name, JP_Sales, ranking,
FROM (
  SELECT *,
  rank() over(ORDER BY JP_Sales DESC) as ranking,
  from `video_game_sales.sales_data`) rnk
WHERE ranking <= 10
ORDER BY Ranking

##These queries finds the top 10 games in each region

###Find me the top 5 performing Publishers. Then find out which one is the most profitable.
SELECT Distinct Publisher, SUM(Global_Sales) as Global_Sales
FROM(
SELECT Publisher, Platform, Year, Name, Global_Sales, ranking,
FROM (
  SELECT *,
  rank() over(partition by Publisher ORDER BY Global_Sales DESC) as ranking,
  from `video_game_sales.sales_data`) rnk
WHERE rnk.ranking < 10 AND Global_Sales > 11)
GROUP BY Publisher
ORDER BY Global_Sales DESC

##After using this query I find that the top 5 performing Publishers are, Nintendo, Activisions, Take-Two Interactive, 
Microsoft Game Studios, and Sony Computer Entertainment. In that order. I also notice that the difference between 1st
and 2nd is about three times the amount of global sales. Same for 3rd and 4th. 





