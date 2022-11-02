USE HotelReservation;

-- Q1. Write a query that returns a list of reservations that end in July 2023,
-- including name of guest, room number(s) and reservation dates.
SELECT 
	rs.ReservationId,
    CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    rm.RoomId RoomNumber,
    rs.StartDate,
    rs.EndDate
FROM Reservation rs
INNER JOIN Guest g 
	ON rs.GuestId = g.GuestId
INNER JOIN Room rm
	ON rm.RoomId = rs.RoomId
WHERE EndDate BETWEEN '2023-07-01' AND '2023-07-31';

/*
ANSWER: 4 Rows
# ReservationId, GuestName, RoomNumber, StartDate, EndDate
15, Daryl del Rosario, 205, 2023-06-28, 2023-07-02
16, Walter Holaway, 204, 2023-07-13, 2023-07-14
17, Wilfred Vise, 401, 2023-07-18, 2023-07-21
18, Bettyann Seery, 303, 2023-07-28, 2023-07-29
*/
-- =======

-- Q2. Write a query that returns a list of all reservations for rooms with a jacuzzi
-- displaying the guest's name, the room number and dates of reservation
SELECT
	rs.ReservationId,
    CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    rm.RoomId RoomNumber,
    rs.StartDate,
    rs.EndDate
FROM Reservation rs
INNER JOIN Guest g 
	ON g.GuestId = rs.GuestId
INNER JOIN Room rm
	ON rm.RoomId = rs.RoomId
INNER JOIN RoomAmenity ra 
	ON ra.RoomId = rm.RoomId
INNER JOIN Amenity a 
	ON a.AmenityId = ra.AmenityId
WHERE a.AmenityName = "Jacuzzi";

/*
ANSWER: 11 Rows
# ReservationId, GuestName, RoomNumber, StartDate, EndDate
4, Karie Yang, 201, 2023-03-06, 2023-03-07
2, Bettyann Seery, 203, 2023-02-05, 2023-02-10
21, Karie Yang, 203, 2023-09-13, 2023-09-15
15, Daryl del Rosario, 205, 2023-06-28, 2023-07-02
10, Wilfred Vise, 207, 2023-04-23, 2023-04-24
9, Walter Holaway, 301, 2023-04-09, 2023-04-13
24, Mack Simmer, 301, 2023-11-22, 2023-11-25
18, Bettyann Seery, 303, 2023-07-28, 2023-07-29
3, Duane Cullison, 305, 2023-02-22, 2023-02-24
19, Bettyann Seery, 305, 2023-08-30, 2023-09-01
5, Daryl del Rosario, 307, 2023-03-17, 2023-03-20
*/
-- =======

-- Q3. Write a query that returns all the rooms reserved for a specific guest
-- including guest's name, room(s) reserved, starting date of reservation
-- and how many people were included in the reservation (Choose a guest's name from existing data)
SELECT
	rs.ReservationId,
    CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    rt.RoomTypeName RoomType,
    rs.StartDate,
    rs.Adult,
    rs.Children,
    (rs.Adult + rs.Children) GuestCount
FROM Reservation rs
INNER JOIN Guest g 
	ON g.GuestId = rs.GuestId
INNER JOIN Room rm 
	ON rs.RoomId = rm.RoomId 
INNER JOIN RoomType rt 
	ON rt.RoomTypeId = rm.RoomTypeId
WHERE g.FirstName = 'Maritza'
GROUP BY rs.ReservationId;

/*
ANSWER: 2 Rows
# ReservationId, GuestName, RoomType, StartDate, Adult, Children, GuestCount
11, Maritza Tilton, Suite, 2023-05-30, 2, 4, 6
25, Maritza Tilton, Double, 2023-12-24, 2, 0, 2
*/
-- =======

-- Q4. Write a query that returns a list of rooms, reservation ID 
-- and per-room cost for each reservation. Result should include all rooms, 
-- whether or not there is reservation associated with room
SELECT
	rm.RoomId RoomNumber,
    IFNULL(rs.ReservationId, 'No Reservation') ReservationId,
    IFNULL(rs.TotalRoomCost, rt.BasePrice) TotalRoomCost
FROM Room rm 
LEFT OUTER JOIN Reservation rs 
	ON rs.RoomId = rm.RoomId
LEFT OUTER JOIN RoomType rt 
	ON rt.RoomTypeId = rm.RoomTypeId
ORDER BY rm.RoomId ASC;
 
/*
ANSWER: 26 Rows
# RoomNumber, ReservationId, TotalRoomCost
201, 4, 199.99
202, 7, 349.98
203, 2, 999.95
203, 21, 399.98
204, 16, 184.99
205, 15, 699.96
206, 12, 599.96
206, 23, 449.97
207, 10, 174.99
208, 13, 599.96
208, 20, 149.99
301, 9, 799.96
301, 24, 599.97
302, 6, 924.95
302, 25, 699.96
303, 18, 199.99
304, 14, 184.99
305, 3, 349.98
305, 19, 349.98
306, No Reservation, 149.99
307, 5, 524.97
308, 1, 299.98
401, 11, 1199.97
401, 17, 1259.97
401, 22, 1199.97
402, No Reservation, 399.99
*/
-- =======

-- Q5. Write a query that returns all the rooms accomodating at least three guests
-- and that are reserved on any date in April 2023
SELECT
	rs.ReservationId,
    rm.RoomId RoomNumber,
    rs.Adult,
    rs.Children,
    (rs.Adult + rs.Children) GuestCount,
    rs.StartDate,
    rs.EndDate
FROM Reservation rs 
INNER JOIN Room rm 
	ON rm.RoomId = rs.RoomId
WHERE rs.EndDate BETWEEN '2023-04-01' AND '2023-04-30'
	AND (rs.Adult + rs.Children) >= 3
GROUP BY rs.ReservationId;

/*
ANSWER: 0 Rows
ReservationId, RoomNumber, Adult, Children, GuestCount, StartDate, EndDate
*/
-- =======

-- Q6. Write a query that returns a list of all guest names
-- and the number of reservations per guest. Sorted starting with guest with most reservations 
-- and then by guest's last name
SELECT 
	COUNT(rs.ReservationId) ReservationCount,
    g.LastName,
    g.FirstName,
	CONCAT(g.FirstName, ' ', g.LastName) GuestFullName
FROM Guest g
INNER JOIN Reservation rs 
	ON rs.GuestId = g.GuestId
GROUP BY g.GuestId
ORDER BY COUNT(rs.ReservationId) DESC, g.LastName ASC;

/*
ANSWER: 11 Rows
# ReservationCount, LastName, FirstName, GuestFullName
4, Simmer, Mack, Mack Simmer
3, Seery, Bettyann, Bettyann Seery
2, Cullison, Duane, Duane Cullison
2, del Rosario, Daryl, Daryl del Rosario
2, Holaway, Walter, Walter Holaway
2, Lipton, Aurore, Aurore Lipton
2, Tilton, Maritza, Maritza Tilton
2, Tison, Joleen, Joleen Tison
2, Vise, Wilfred, Wilfred Vise
2, Yang, Karie, Karie Yang
1, Luechtefeld, Zachery, Zachery Luechtefeld
*/
-- =======

-- Q7. Write a query that displays the name, address and phone number of a guest
-- based on their phone number (Choose a phone number in existing data)
SELECT
	CONCAT(g.FirstName, ' ', g.LastName) GuestName,
    g.Address,
    g.City,
    g.StateAbbr,
    g.ZipCode,
    g.PhoneNumber
FROM Guest g 
WHERE g.PhoneNumber = '(446) 351-6860';

/*
ANSWER: 1 Row(s)
# GuestName, Address, City, StateAbbr, ZipCode, PhoneNumber
Maritza Tilton, 939 Linda Rd., Burke, VA, 22015, (446) 351-6860
*/
-- =======

-- Q5 Re-interpreted: 
-- Write a query that returns all rooms
-- that can accomodate 3 or more guests 
-- AND reserved on any date in April 2023

SELECT 
	rs.ReservationId,
    rm.RoomId RoomNumber,
    rt.MaxOccupancy,
    rs.StartDate,
    rs.EndDate
FROM Reservation rs
INNER JOIN Room rm 
	ON rm.RoomId = rs.RoomId
INNER JOIN Roomtype rt 
	ON rm.RoomtypeId = rt.RoomtypeId
WHERE rs.EndDate BETWEEN '2023-04-01' AND '2023-04-30'
	AND (rt.MaxOccupancy >= 3)
GROUP BY rs.ReservationId;

/*
ANSWER: 1 Row
# ReservationId, RoomNumber, MaxOccupancy, StartDate, EndDate
9, 301, 4, 2023-04-09, 2023-04-13
*/