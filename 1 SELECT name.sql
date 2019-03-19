-- 1. Find the country that start with Y
SELECT NAME
FROM   world
WHERE  NAME LIKE 'y%'

-- 2. Find the countries that end with y
SELECT NAME
FROM   world
WHERE  NAME LIKE '%y'

-- 3. Find the countries that contain the letter x
SELECT NAME
FROM   world
WHERE  NAME LIKE '%x%'

-- 4. Find the countries that end with land
SELECT NAME
FROM   world
WHERE  NAME LIKE '%land'

-- 5. Find the countries that start with C and end with ia
SELECT NAME
FROM   world
WHERE  NAME LIKE 'C%ia'

-- 6. Find the country that has oo in the name
SELECT NAME
FROM   world
WHERE  NAME LIKE '%oo%'

-- 7. Find the countries that have three or more a in the name
SELECT NAME
FROM   world
WHERE  NAME LIKE '%a%a%a%'

-- 8. Find the countries that have "t" as the second character.
SELECT NAME
FROM   world
WHERE  NAME LIKE '_t%'

-- 9. Find the countries that have two "o" characters separated by two others.
SELECT NAME
FROM   world
WHERE  NAME LIKE '%o__o%'

-- 10. Find the countries that have exactly four characters.
SELECT NAME
FROM   world
WHERE  Length(NAME) = 4

-- 11. Find the country where the name is the capital city.
SELECT NAME
FROM   world
WHERE  NAME = capital

-- 12. Find the country where the capital is the country plus "City".
SELECT NAME
FROM   world
WHERE  capital LIKE Concat(NAME, ' city')

-- 13. Find the capital and the name where the capital includes the name of the country.
SELECT capital,
       NAME
FROM   world
WHERE  capital LIKE Concat('%', NAME, '%')

-- 14. Find the capital and the name where the capital is an extension of name of the country.
SELECT capital,
       NAME
FROM   world
WHERE  capital LIKE Concat(NAME, '%')
       AND capital <> NAME

-- 15. Show the name and the extension where the capital is an extension of name of the country.
SELECT NAME,
       Replace(capital, NAME, '')
FROM   world
WHERE  capital LIKE Concat(NAME, '%')
       AND capital <> NAME  
