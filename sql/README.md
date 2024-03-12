# Introduction


# SQL Quries


## Inserting a New Facility (Spa)

```sql
INSERT INTO cd.facilities (
  facid, name, membercost, guestcost, 
  initialoutlay, monthlymaintenance
) 
VALUES 
  (9, 'Spa', 20, 30, 100000, 800);
```

This query inserts a new facility named 'Spa' into the `cd.facilities` table.

---

## Inserting a New Facility (Spa) with Automatic facid Generation

```sql
INSERT INTO cd.facilities (
  facid, name, membercost, guestcost, 
  initialoutlay, monthlymaintenance
) 
SELECT 
  COALESCE(MAX(facid), 0) + 1, 
  'Spa', 
  20, 
  30, 
  100000, 
  800 
FROM 
  cd.facilities;
```

This query inserts a new facility named 'Spa' into the `cd.facilities` table, automatically generating the `facid`.

---

## Updating the initialoutlay for a Facility

```sql
UPDATE 
  cd.facilities 
SET 
  initialoutlay = 10000 
WHERE 
  facid = 1;
```

This query updates the `initialoutlay` for the facility with `facid` equal to 1 in the `cd.facilities` table.

---

## Updating guestcost and membercost for a Facility based on another Facility

```sql
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
```

This query updates the `guestcost` and `membercost` for the facility with `facid` equal to 1 in the `cd.facilities` table based on the values of another facility (facid = 0).

---

## Deleting all Bookings

```sql
DELETE FROM 
  cd.bookings;
```

This query deletes all rows from the `cd.bookings` table, effectively removing all bookings.

---

## Deleting a Member by memid

```sql
DELETE FROM 
  cd.members 
WHERE 
  memid = 37;
```

This query deletes the member with `memid` equal to 37 from the `cd.members` table.

---

## Selecting Facilities with Membercost less than Monthlymaintenance / 50

```sql
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
```

This query selects facilities from the `cd.facilities` table where the `membercost` is less than one-fiftieth of the `monthlymaintenance` cost and the `membercost` is not equal to 0.

---

## Selecting Facilities with 'Tennis' in Name

```sql
SELECT 
  * 
FROM 
  cd.facilities 
WHERE 
  name LIKE '%Tennis%';
```

This query selects facilities from the `cd.facilities` table where the name contains the word 'Tennis'.

---

## Selecting Facilities with facid equal to 1 or 5

```sql
SELECT 
  * 
FROM 
  cd.facilities 
WHERE 
  facid IN (1, 5);
```

This query selects facilities from the `cd.facilities` table where the `facid` is equal to 1 or 5.

---


## Selecting Members who Joined after September 1st, 2012

```sql
SELECT 
  memid, 
  surname, 
  firstname, 
  joindate 
FROM 
  cd.members 
WHERE 
  joindate > '2012-09-01';
```

This query selects members from the `cd.members` table who joined after September 1st, 2012.

---

## Union of Surname from Members and Name from Facilities

```sql
SELECT 
  surname 
FROM 
  cd.members 
UNION 
SELECT 
  name AS surname 
FROM 
  cd.facilities;
```

This query performs a union operation on the `surname` column from the `cd.members` table and the `name` column (aliased as `surname`) from the `cd.facilities` table.

---

## Selecting Starttime for Bookings by David Farrell

```sql
SELECT 
  starttime 
FROM 
  cd.bookings 
JOIN 
  cd.members 
ON 
  cd.bookings.memid = cd.members.memid 
WHERE 
  cd.members.firstname = 'David' 
  AND cd.members.surname = 'Farrell';
```

This query selects the `starttime` for bookings made by a member named 'David Farrell' by joining the `cd.bookings` table with the `cd.members` table based on `memid`.

---

## Selecting Starttime and Facility Name for Tennis Court Bookings on September 21st, 2012

```sql
SELECT 
  b.starttime AS start, 
  f.name AS name 
FROM 
  cd.bookings b 
JOIN 
  cd.facilities f 
ON 
  b.facid = f.facid 
WHERE 
  b.starttime::date = '2012-09-21'::date 
  AND f.name LIKE '%Tennis Court%' 
ORDER BY 
  b.starttime;
```

This query selects the `starttime` and `name` of facilities for bookings made on September 21st, 2012, for tennis courts from the `cd.bookings` and `cd.facilities` tables.

---


## Selecting Members and Their Recommenders

```sql
SELECT 
  m1.firstname AS memfname, 
  m1.surname AS memsname, 
  m2.firstname AS recfname, 
  m2.surname AS recsname 
FROM 
  cd.members m1 
LEFT JOIN 
  cd.members m2 
ON 
  m1.recommendedby = m2.memid 
ORDER BY 
  m1.surname, 
  m1.firstname;
```

This query selects members and their recommenders from the `cd.members` table, joining the table with itself based on the `recommendedby` column.

---

## Selecting Members who have Recommended Another Member

```sql
SELECT 
  DISTINCT m1.firstname, 
  m1.surname 
FROM 
  cd.members m1 
INNER JOIN 
  cd.members m2 
ON 
  m1.memid = m2.recommendedby 
ORDER BY 
  m1.surname, 
  m1.firstname;
```

This query selects members who have recommended another member from the `cd.members` table by joining the table with itself based on the `recommendedby` column.

---

## Selecting Members and Their Recommenders Without Using Joins

```sql
SELECT 
  DISTINCT m1.firstname || ' ' || m1.surname AS member, 
  (
    SELECT 
      m2.firstname || ' ' || m2.surname 
    FROM 
      cd.members m2 
    WHERE 
      m2.memid = m1.recommendedby
  ) AS recommender 
FROM 
  cd.members m1 
ORDER BY 
  member;
```

This query selects members and their recommenders from the `cd.members` table without using joins, by correlating the subquery with the main query.

---

## Counting Recommendations by Members

```sql
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
```

This query counts the number of recommendations made by each member from the `cd.members` table.

---

## Selecting Total Slots Booked per Facility

```sql
SELECT 
  facid, 
  SUM(slots) AS "Total Slots" 
FROM 
  cd.bookings 
GROUP BY 
  facid 
ORDER BY 
  facid;
```

This query calculates the total number of slots booked per facility from the `cd.bookings` table.

---


## Produce a list of the total number of slots booked per facility per month in the year of 2012

```sql
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
```

This query extracts the month from the `starttime` column in the `cd.bookings` table and calculates the total number of slots booked for each facility in each month of the year 2012.

---

## Counting Total Members with at Least One Booking

```sql
SELECT 
  COUNT(DISTINCT memid) as count 
FROM 
  cd.bookings;
```

This query counts the total number of members (including guests) who have made at least one booking in the `cd.bookings` table.

---

## Selecting First Element with MAX() Aggregate Function

```sql
SELECT 
  MAX(memid) 
FROM 
  cd.members;
```

This query selects the maximum value of the `memid` column from the `cd.members` table.

---

## Selecting Members and Their First Booking after September 1st, 2012

```sql
SELECT 
  memid, 
  surname, 
  firstname, 
  joindate 
FROM 
  cd.members 
WHERE 
  joindate > '2012-09-01';
```

This query selects members from the `cd.members` table whose join date is after September 1st, 2012.

---


## Selecting Member Names with Total Member Count

```sql
SELECT 
  firstname || ' ' || surname AS member_name, 
  COUNT(*) OVER () AS total_member_count 
FROM 
  cd.members 
ORDER BY 
  joindate;
```

This query selects member names from the `cd.members` table and includes the total count of members in the result set using a window function. The results are ordered by join date.

---

## Using ROW_NUMBER() Window Function

```sql
SELECT 
  ROW_NUMBER() OVER (), 
  firstname, 
  surname 
FROM 
  cd.members 
ORDER BY 
  joindate;
```

This query uses the ROW_NUMBER() window function to assign a unique row number to each row in the result set from the `cd.members` table. The results are ordered by join date.

---

## Selecting Facility with Highest Number of Slots Booked

```sql
SELECT facid, total
FROM (
    SELECT facid, 
           COUNT(slots) AS total,
           RANK() OVER (ORDER BY COUNT(slots) DESC) AS rank
    FROM cd.bookings
    GROUP BY facid
) AS sq
WHERE rank = 1;

```

This query selects the facility with the highest number of slots booked from the `cd.bookings` table. In the event of a tie, all facilities with the highest number of slots booked are returned.

--


## Concatenating Surname and Firstname with a Comma

```sql
SELECT 
  surname || ', ' || firstname AS name 
FROM 
  cd.members;
```

This query concatenates the `surname` and `firstname` columns of the `cd.members` table, separated by a comma, to create a formatted full name.

---

## Selecting Members with Telephone Numbers Containing Parentheses

```sql
SELECT 
  memid, 
  telephone 
FROM 
  cd.members 
WHERE 
  telephone LIKE '%(%' 
  AND telephone LIKE '%)%';
```

This query selects members from the `cd.members` table whose telephone numbers contain parentheses.

---

## Counting Members by Surname Initial Letter

```sql
SELECT 
  LEFT(surname, 1) AS letter, 
  COUNT(*) AS count 
FROM 
  cd.members 
GROUP BY 
  letter;
```

This query counts the number of members in the `cd.members` table based on the initial letter of their surname, using the `LEFT` function to extract the first character.

---

###### Table Setup (DDL)

We have a relational database constitued with three tables (`cd.members`, `cd.bookings`, `cd.facilities`) which have been created in the cd schema. The three primary keys of the tables are respectively `memid` , `bookid` and `facid` which allows us to identify each row of the table in unique way. The tables are related to eachother thanks to `recommendedby`(foreign key) and `memid` (primary key) of the `cd.members` table, `facid` and `memid`(foreign keys) from `cd.bookings` table and finally `facid` (primary key) from `cd.facilities` table.

###### Question 1: Show all members 



###### Questions 2: Lorem ipsum...



