--1a. Create a table that lists all country IDs for countries that competed in both the summer and winter Olympics.
SELECT DISTINCT(country_id) 
FROM summer_games INNER JOIN winter_games
USING (country_id)

--1b. Create a table that lists all country IDs for countries that competed in either the summer or winter Olympics.
