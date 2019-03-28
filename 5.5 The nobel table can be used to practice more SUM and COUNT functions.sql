-- https://sqlzoo.net/wiki/The_nobel_table_can_be_used_to_practice_more_SUM_and_COUNT_functions.
-- 1. Show the total number of prizes awarded. 
SELECT Count(*)
FROM   nobel

-- 2. List each subject - just once 
SELECT DISTINCT subject
FROM   nobel

-- 3. Show the total number of prizes awarded for Physics. 
SELECT Count(*)
FROM   nobel
WHERE  subject = 'Physics'

-- 4. For each subject show the subject and the number of prizes. 
SELECT subject,
       Count(*)
FROM   nobel
GROUP  BY subject

-- 5. For each subject show the first year that the prize was awarded. 
SELECT subject,
       Min(yr)
FROM   nobel
GROUP  BY subject

-- 6. For each subject show the number of prizes awarded in the year 2000. 
SELECT subject,
       Count(*)
FROM   nobel
WHERE  yr = 2000
GROUP  BY subject

-- 7. Show the number of different winners for each subject. 
SELECT subject,
       Count(DISTINCT winner)
FROM   nobel
GROUP  BY subject

-- 8. For each subject show how many years have had prizes awarded. 
SELECT subject,
       Count(DISTINCT yr)
FROM   nobel
GROUP  BY subject

-- 9. Show the years in which three prizes were given for Physics. 
SELECT yr
FROM   nobel
WHERE  subject = 'Physics'
GROUP  BY yr
HAVING Count(*) = 3

-- 10. Show winners who have won more than once. 
SELECT winner
FROM   nobel
GROUP  BY winner
HAVING Count(*) > 1

-- 11. Show winners who have won more than one subject. 
SELECT winner
FROM   nobel
GROUP  BY winner
HAVING Count(DISTINCT subject) > 1

-- 12. Show the year and subject where 3 prizes were given. Show only years 2000 onwards. 
SELECT yr,
       subject
FROM   nobel
WHERE  yr >= 2000
GROUP  BY yr,
          subject
HAVING Count(*) = 3  
