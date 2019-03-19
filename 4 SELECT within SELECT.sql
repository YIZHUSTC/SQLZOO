 -- 1. List each country name where the population is larger than that of 'Russia'.
SELECT NAME
FROM   world
WHERE  population > (SELECT population
                     FROM   world
                     WHERE  NAME = 'Russia')

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT NAME
FROM   world
WHERE  continent = 'Europe'
       AND gdp / population > (SELECT gdp / population
                               FROM   world
                               WHERE  NAME = 'United Kingdom')

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT NAME,
       continent
FROM   world
WHERE  continent IN (SELECT continent
                     FROM   world
                     WHERE  NAME = 'Argentina'
                             OR NAME = 'Australia')
ORDER  BY NAME

-- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT NAME,
       population
FROM   world
WHERE  population > (SELECT population
                     FROM   world
                     WHERE  NAME = 'Canada')
       AND population < (SELECT population
                         FROM   world
                         WHERE  NAME = 'Poland')

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT NAME,
       Concat(Round(population / (SELECT population
                                  FROM   world
                                  WHERE  NAME = 'Germany') * 100, 0), '%')
FROM   world
WHERE  continent = 'Europe'

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) 
SELECT NAME
FROM   world
WHERE  gdp > ALL (SELECT gdp
                  FROM   world
                  WHERE  continent = 'Europe'
                         AND gdp > 0)

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area: 
SELECT continent,
       NAME,
       area
FROM   world w1
WHERE  area >= ALL (SELECT area
                    FROM   world w2
                    WHERE  w1.continent = w2.continent)

-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT continent,
       NAME
FROM   world w1
WHERE  NAME <= ALL (SELECT NAME
                    FROM   world w2
                    WHERE  w1.continent = w2.continent)

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. 
SELECT NAME,
       continent,
       population
FROM   world
WHERE  continent NOT IN (SELECT continent
                         FROM   world
                         WHERE  population > 25000000)

-- 10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT NAME,
       continent
FROM   world w1
WHERE  population / 3 > ALL (SELECT population
                             FROM   world w2
                             WHERE  w1.continent = w2.continent
                                    AND w1.NAME != w2.NAME)  
