--1a. Create a table that lists all country IDs for countries that competed in both the summer and winter Olympics.
SELECT DISTINCT(country_id) 
FROM summer_games INNER JOIN winter_games
USING (country_id)
--Answer: 78

--1b. Create a table that lists all country IDs for countries that competed in either the summer or winter Olympics.
SELECT DISTINCT(country_id)
FROM summer_games FULL JOIN winter_games
USING (country_id)
--Answer: 203

--2a. For each country give the average height and average weight of their athletes.
SELECT country, ROUND(AVG(height), 2) AS average_height, ROUND(AVG(weight), 2) AS average_weight
FROM athletes INNER JOIN summer_games ON athletes.id = summer_games.athlete_id
			  INNER JOIN countries ON summer_games.country_id = countries.id 
GROUP BY country 
ORDER BY country ASC;

--2b. For each country give the average height and average weight of their male athletes who won a gold medal. 
--The first CTE gives the summer gold medal winners and the second CTE gives the winter gold medal winners.
WITH summer_gold_men AS (SELECT country, ROUND(AVG(height), 2) AS average_height, ROUND(AVG(weight), 2) AS average_weight, 
						 'summer' AS season
						 FROM athletes INNER JOIN summer_games ON athletes.id = summer_games.athlete_id
			  			 INNER JOIN countries ON summer_games.country_id = countries.id
						 WHERE gender = 'M' AND gold IS NOT null
						 GROUP BY country 
						 ORDER BY country ASC),						 

winter_gold_men AS (SELECT country, ROUND(AVG(height), 2) AS average_height, ROUND(AVG(weight), 2) AS average_weight, 
					'winter' AS season
				     FROM athletes INNER JOIN winter_games ON athletes.id = winter_games.athlete_id
			  	     INNER JOIN countries ON winter_games.country_id = countries.id
				     WHERE gender = 'M' AND gold IS NOT null
					 GROUP BY country 
					 ORDER BY country ASC)
SELECT *
FROM summer_gold_men
UNION
SELECT *
FROM winter_gold_men
ORDER BY country ASC;
			