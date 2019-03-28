-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id,
       title
FROM   movie
WHERE  yr = 1962

-- 2. Give year of 'Citizen Kane'. 
SELECT yr
FROM   movie
WHERE  title = 'Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
SELECT id,
       title,
       yr
FROM   movie
WHERE  title LIKE '%Star Trek%'
ORDER  BY yr

-- 4. What id number does the actor 'Glenn Close' have? 
SELECT id
FROM   actor
WHERE  NAME = 'Glenn Close'

-- 5. What is the id of the film 'Casablanca' 
SELECT id
FROM   movie
WHERE  title = 'Casablanca'

-- 6. Obtain the cast list for 'Casablanca'. 
SELECT NAME
FROM   actor
       JOIN casting
         ON actor.id = casting.actorid
       JOIN movie
         ON casting.movieid = movie.id
WHERE  title = 'Casablanca'

-- 7. Obtain the cast list for the film 'Alien' 
SELECT NAME
FROM   actor
       JOIN casting
         ON actor.id = casting.actorid
       JOIN movie
         ON casting.movieid = movie.id
WHERE  title = 'Alien'

-- 8. List the films in which 'Harrison Ford' has appeared 
SELECT title
FROM   movie
       JOIN casting
         ON movie.id = casting.movieid
       JOIN actor
         ON casting.actorid = actor.id
WHERE  actor.NAME = 'Harrison Ford'

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
SELECT title
FROM   movie
       JOIN casting
         ON movie.id = casting.movieid
       JOIN actor
         ON actor.id = casting.actorid
WHERE  actor.NAME = 'Harrison Ford'
       AND casting.ord != 1

-- 10. List the films together with the leading star for all 1962 films. 
SELECT title,
       NAME
FROM   movie
       JOIN casting
         ON movie.id = casting.movieid
       JOIN actor
         ON actor.id = casting.actorid
WHERE  casting.ord = 1
       AND yr = 1962

-- 11. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
SELECT yr,
       Count(*)
FROM   movie
       JOIN casting
         ON movie.id = casting.movieid
       JOIN actor
         ON actor.id = casting.actorid
WHERE  NAME = 'John Travolta'
GROUP  BY yr
HAVING Count(*) > 2

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
SELECT movie.title,
       actor.NAME
FROM   (SELECT movieid,
               actorid
        FROM   casting
        WHERE  movieid IN (SELECT movieid
                           FROM   casting
                                  JOIN actor
                                    ON actor.id = casting.actorid
                           WHERE  NAME = 'Julie Andrews')
               AND ord = 1) a
       JOIN movie
         ON movie.id = a.movieid
       JOIN actor
         ON actor.id = a.actorid

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 
SELECT NAME
FROM   actor
       JOIN (SELECT actorid
             FROM   actor
                    JOIN casting
                      ON actor.id = casting.actorid
             WHERE  ord = 1
             GROUP  BY actorid
             HAVING Count(id) >= 30) a
         ON actor.id = a.actorid
ORDER  BY NAME

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
SELECT title,
       count
FROM   (SELECT id,
               Count(id) AS count
        FROM   movie
               JOIN casting
                 ON movie.id = casting.movieid
        WHERE  yr = 1978
        GROUP  BY id) a
       JOIN movie
         ON movie.id = a.id
ORDER  BY count DESC,
          title

-- 15. List all the people who have worked with 'Art Garfunkel'. 
SELECT NAME
FROM   actor
WHERE  actor.id IN (SELECT actorid
                    FROM   casting
                    WHERE  casting.movieid IN (SELECT movieid
                                               FROM   casting
                                                      JOIN actor
                                                        ON
                                              actor.id = casting.actorid
                                               WHERE  NAME = 'Art Garfunkel'))
       AND NAME != 'Art Garfunkel'  
