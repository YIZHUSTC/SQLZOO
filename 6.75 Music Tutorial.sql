-- https://sqlzoo.net/wiki/Music_Tutorial
-- 1. Find the title and artist who recorded the song 'Alison'. 
SELECT title,
       artist
FROM   album
       JOIN track
         ON asin = album
WHERE  song = 'Alison'

-- 2. Which artist recorded the song 'Exodus'? 
SELECT artist
FROM   album
       JOIN track
         ON asin = album
WHERE  song = 'Exodus'

-- 3. Show the song for each track on the album 'Blur'
SELECT song
FROM   track
       JOIN album
         ON asin = album
WHERE  title = 'Blur'

-- 4. For each album show the title and the total number of track. 
SELECT title,
       Count(*)
FROM   album
       JOIN track
         ON asin = album
GROUP  BY title

-- 5. For each album show the title and the total number of tracks containing the word 'Heart' (albums with no such tracks need not be shown). 
SELECT title,
       Count(*)
FROM   album
       JOIN track
         ON asin = album
WHERE  song LIKE '%Heart%'
GROUP  BY title

-- 6. A "title track" is where the song is the same as the title. Find the title tracks. 
SELECT song
FROM   album
       JOIN track
         ON asin = album
WHERE  title = song

-- 7. An "eponymous" album is one where the title is the same as the artist (for example the album 'Blur' by the band 'Blur'). Show the eponymous albums. 
SELECT title
FROM   album
WHERE  title = artist

-- 8. Find the songs that appear on more than 2 albums. Include a count of the number of times each shows up. 
SELECT song,
       Count(DISTINCT album)
FROM   track
       JOIN album
         ON asin = album
GROUP  BY song
HAVING Count(DISTINCT album) > 2

-- 9. A "good value" album is one where the price per track is less than 50 pence. Find the good value album - show the title, the price and the number of tracks. 
SELECT title,
       price,
       Count(song)
FROM   album
       JOIN track
         ON asin = album
GROUP  BY title,
          price
HAVING price / Count(song) < 0.5

-- 10. List albums so that the album with the most tracks is first. Show the title and the number of tracks. Where two or more albums have the same number of tracks you should order alphabetically
SELECT title,
       Count(song)
FROM   album
       JOIN track
         ON asin = album
GROUP  BY title
ORDER  BY Count(song) DESC,
          title  
