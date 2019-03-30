-- https://sqlzoo.net/wiki/Scottish_Parliament
-- 1. One MSP was kicked out of the Labour party and has no party. Find him. 
SELECT NAME
FROM   msp
WHERE  party IS NULL

-- 2. Obtain a list of all parties and leaders. 
SELECT DISTINCT( party.NAME ),
               leader
FROM   msp
       RIGHT JOIN party
               ON party = code

-- 3. Give the party and the leader for the parties which have leaders. 
SELECT NAME,
       leader
FROM   party
WHERE  leader IS NOT NULL

-- 4. Obtain a list of all parties which have at least one MSP. 
SELECT DISTINCT( party.NAME )
FROM   party
       JOIN msp
         ON party.code = msp.party
WHERE  msp.NAME IS NOT NULL

-- 5. Obtain a list of all MSPs by name, give the name of the MSP and the name of the party where available. Be sure that Canavan MSP, Dennis is in the list. Use ORDER BY msp.name to sort your output by MSP. 
SELECT msp.NAME,
       party.NAME
FROM   msp
       LEFT JOIN party
              ON msp.party = party.code
ORDER  BY msp.NAME

-- 6. Obtain a list of parties which have MSPs, include the number of MSPs. 
SELECT party.NAME,
       Count(msp.NAME)
FROM   party
       JOIN msp
         ON party.code = msp.party
GROUP  BY party.NAME

-- 7. A list of parties with the number of MSPs; include parties with no MSPs. 
SELECT party.NAME,
       Count(msp.NAME)
FROM   party
       LEFT JOIN msp
              ON party.code = msp.party
GROUP  BY party.NAME  
