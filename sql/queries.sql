INSERT INTO cd.facilities (
  facid, name, membercost, guestcost, 
  initialoutlay, monthlymaintenance
) 
VALUES 
  (9, 'Spa', 20, 30,100000, 800);

---------------------------

INSERT INTO cd.facilities (
  facid, name, membercost, guestcost, 
  initialoutlay, monthlymaintenance
) 
SELECT 
  COALESCE(
    MAX(facid), 
    0
  ) + 1, 
  'Spa', 
  20, 
  30, 
  100000, 
  800 
FROM 
  cd.facilities;

---------------------------


UPDATE 
  cd.facilities 
SET 
  initialoutlay = 10000 
WHERE 
  facid = 1;

---------------------------

UPDATE 
  cd.facilities 
SET 
  guestcost = (
    SELECT 
      guestcost * 1.1 
    FROM 
      cd.facilities 
    WHERE 
      facid = 0
  ), 
  membercost = (
    SELECT 
      membercost * 1.1 
    FROM 
      cd.facilities 
    WHERE 
      facid = 0
  ) 
WHERE 
  facid = 1;

---------------------------

DELETE FROM 
  cd.bookings;
---------------------------

DELETE FROM 
  cd.members 
WHERE 
  memid = 37;
---------------------------

SELECT 
  facid, 
  name, 
  membercost, 
  monthlymaintenance 
FROM 
  cd.facilities 
WHERE 
  membercost < monthlymaintenance / 50 
  AND membercost != 0;
---------------------------

SELECT 
  * 
FROM 
  cd.facilities 
WHERE 
  name like '%Tennis%';
---------------------------

SELECT 
  * 
FROM 
  cd.facilities 
WHERE 
  facid IN (1, 5);

-----------------------------

SELECT 
  memid, 
  surname, 
  firstname, 
  joindate 
FROM 
  cd.members 
WHERE 
  joindate > '2012-09-01';

------------------------------

SELECT 
  surname 
from 
  cd.members 
union 
SELECT 
  name as surname 
from 
  cd.facilities;

-------------------------------

SELECT 
  starttime 
FROM 
  cd.bookings 
  JOIN cd.members ON cd.bookings.memid = cd.members.memid 
WHERE 
  cd.members.firstname = 'David' 
  AND cd.members.surname = 'Farrell';
--------------------------------

SELECT 
  b.starttime AS start, 
  f.name AS name 
FROM 
  cd.bookings b 
  JOIN cd.facilities f ON b.facid = f.facid 
WHERE 
  b.starttime :: date = '2012-09-21' :: date 
  AND f.name LIKE '%Tennis Court%' 
ORDER BY 
  b.starttime;

----------------------------------

SELECT 
  m1.firstname AS memfname, 
  m1.surname AS memsname, 
  m2.firstname AS recfname, 
  m2.surname AS recsname 
FROM 
  cd.members m1 
  LEFT JOIN cd.members m2 ON m1.recommendedby = m2.memid 
ORDER BY 
  m1.surname, 
  m1.firstname;
---------------------------------

SELECT 
  DISTINCT m1.firstname, 
  m1.surname 
FROM 
  cd.members m1 
  INNER JOIN cd.members m2 ON m1.memid = m2.recommendedby 
ORDER BY 
  m1.surname, 
  m1.firstname;

---------------------------------------

SELECT 
  DISTINCT firstname || ' ' || surname AS member, 
  (
    SELECT 
      firstname || ' ' || surname 
    FROM 
      cd.members 
    WHERE 
      memid = m.recommendedby
  ) AS recommender 
FROM 
  cd.members m 
ORDER BY 
  member;
---------------------------------------

SELECT 
  recommendedby, 
  COUNT(memid) AS count 
FROM 
  cd.members 
WHERE 
  recommendedby > 0 
GROUP BY 
  recommendedby 
ORDER BY 
  recommendedby;


-----------------------------------------

SELECT 
  facid, 
  sum(slots) AS "Total Slots" 
FROM 
  cd.bookings 
GROUP BY 
  facid 
ORDER by 
  facid;
-----------------------------------------

SELECT facid, SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime BETWEEN '2012-09-01' AND '2012-10-01'
GROUP BY facid
ORDER BY "Total Slots";

-----------------------------------------

SELECT 
  facid, 
  EXTRACT(
    MONTH 
    FROM 
      starttime
  ) AS month, 
  sum (slots) as "Total Slots" 
FROM 
  cd.bookings 
WHERE 
  EXTRACT (
    YEAR 
    FROM 
      starttime
  ) = 2012 
GROUP BY 
  facid, 
  month 
ORDER BY 
  facid, 
  month;

-------------------------------------------
SELECT 
  COUNT (DISTINCT memid) as count 
FROM 
  cd.bookings 
-------------------------------------------

SELECT m.surname, m.firstname, m.memid, b.starttime
FROM cd.members m
JOIN (
    SELECT memid, MIN(starttime) AS starttime
    FROM cd.bookings
    WHERE starttime >= '2012-09-01'
    GROUP BY memid
) b ON m.memid = b.memid
ORDER BY m.memid;

---------------------------------------------

SELECT 
  count (*) OVER () as count, 
  firstname, 
  surname 
FROM 
  cd.members 
ORDER BY 
  joindate;
----------------------------------------------
SELECT 
  row_number() over (), 
  firstname, 
  surname 
FROM 
  cd.members 
ORDER BY 
  joindate;

----------------------------------------------

SELECT facid, total
FROM (
    SELECT facid, 
           COUNT(slots) AS total,
           RANK() OVER (ORDER BY COUNT(slots) DESC) AS rank
    FROM cd.bookings
    GROUP BY facid
) AS sq
WHERE rank = 1;

-------------------------------------------------
SELECT 
  surname || ', ' || firstname AS name 
FROM 
  cd.members;
----------------------------------------------

SELECT 
  memid, 
  telephone 
FROM 
  cd.members 
WHERE 
  telephone LIKE '%(%' 
  AND telephone LIKE '%)%';

-----------------------------------------------

SELECT 
  LEFT(surname, 1) AS letter, 
  COUNT(*) AS count 
FROM 
  cd.members 
GROUP BY 
  letter 
ORDER BY 
  letter;
