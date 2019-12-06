-- a. List the customers.  For each customer, indicate which category he or she falls into, 
-- and his or her contact information.  
-- If you have more than one independent categorization of customers, 
-- please indicate which category the customer falls into for all of the categorizations.

-- Private ONLY
SELECT P.customerID, 'Private' as typeOfCustomer, P.cFirstName, P.cLastName, P.email, P.snailMailAddress, P.phone
FROM 
	(SELECT * FROM PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P
	LEFT JOIN 
    (SELECT * FROM CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
ON P.customerID = C.customerID 
WHERE C.customerID IS NULL
UNION
-- Corporate ONLY
SELECT C.customerID, 'Corporate' as typeOfCustomer, C.cFirstName, C.cLastName, C.email, C.snailMailAddress, C.phone
FROM 
	(SELECT * FROM CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
	LEFT JOIN 
	(SELECT * FROM PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P	
ON C.customerID = P.customerID
WHERE P.customerID IS NULL
UNION
-- BOTH:
SELECT DISTINCT customerID, 'BOTH' as typeOfCustomer, P.cFirstName, P.cLastName, P.email, P.snailMailAddress, P.phone
FROM
	(SELECT * FROM PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P
	INNER JOIN
	(SELECT * FROM CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
USING (customerID);

-- b. List the top three customers in terms of their net spending for the past two years, 
-- and the total that they have spent in that period.
SELECT A.customerID, A.cFirstName, A.cLastName, SUM(A.total) AS 'Total Spent Last 2 Years'
FROM
(
	SELECT *
	FROM Customer NATURAL JOIN Orders
	WHERE orderDate >= DATE_SUB(NOW(), INTERVAL 2 YEAR)
) AS A
GROUP BY A.customerID
ORDER BY SUM(A.total) DESC
LIMIT 3;

-- c. Find all of the sous chefs who have three or more menu items that they can prepare.  
-- For each sous chef, list their name, the number of menu items that they can prepare, 
-- and each of the menu items.  
-- You can use group_concat to get all of a given sous chef’s data on one row, 
-- or print out one row per sous chef per menu item.
SELECT empID, firstName, lastName, menuItemName
FROM Expertise NATURAL JOIN Employee
WHERE empID IN
(
	SELECT empID
	FROM Expertise NATURAL JOIN Employee
	GROUP BY empID
	HAVING COUNT(empID) >= 3
)
ORDER BY empID;

-- d. Find all of the sous chefs who have three or more menu items in common.
-- i. Please give the name of each of the two sous chefs sharing three or more menu items.
-- i..Please make sure that any given pair of sous chefs only shows up once.
SELECT 
A.empID AS 'SousChef A ID', A.lastName AS 'SousChef A LastName', A.firstName AS 'SousChef A FirstName',
B.empID AS 'SousChef B ID', B.lastName AS 'SousChef B LastName', B.firstName AS 'SousChef B FirstName',
count(B.empID) AS '# of MenuItems shared'
FROM 
	(SELECT * FROM Expertise NATURAL JOIN Employee) AS A
	INNER JOIN
	(SELECT * FROM Expertise NATURAL JOIN Employee) AS B
ON A.menuItemName = B.menuItemName
WHERE A.empID < B.empID
GROUP BY A.empID, B.empID
HAVING count(B.empID) >= 3;
    
-- e. Find the three menu items most often ordered from the Children’s menu 
-- and order them from most frequently ordered to least frequently ordered.
SELECT menuType, menuItemName, sum(quantity) AS '# of times ordered'
FROM OrderDetails
WHERE menuType = 'Children'
GROUP BY menuItemName
ORDER BY sum(quantity) DESC
LIMIT 3;

-- f. List all the menu items, the shift in which the menu item was ordered, 
-- and the sous chef on duty at the time, when the sous chef was not an expert in that menu item.
SELECT A.menuItemName, B.shiftType, B.dateOfShift, B.empID, B.lastName AS 'SousChef Last Name', B.firstName AS 'SousChef First Name'
FROM
(SELECT *
FROM OrderDetails NATURAL JOIN Orders) AS A
INNER JOIN
(SELECT *
FROM Employee NATURAL JOIN WorkSchedule NATURAL JOIN WorkShift NATURAL JOIN ShiftDetails
WHERE empID IN
(SELECT empID FROM SousChef)) AS B
ON orderDate = dateOfShift AND orderTime >= startTime AND orderTime <= endTime
ORDER BY menuItemName, empID, dateOfShift;

-- g. List the customers, sorted by the amount of Miming’s Money that they have, from largest to smallest.
SELECT customerID, cFirstName, cLastName, currentBalance AS 'Mimings Credit Balance'
FROM MimingsMoney NATURAL JOIN Customer
ORDER BY currentBalance DESC;

-- h. List the customers and the total that they have spent at Miming’s ever, 
-- in descending order by the amount that they have spent.
SELECT cFirstName, cLastName, cDOB, SUM(total) AS 'Lifetime Total Spent'
FROM Customer NATURAL JOIN Orders
GROUP BY customerID
ORDER BY SUM(total) DESC;

-- i. Report on the customers at Miming’s by the number of times that they come in by month 
-- and order the report from most frequent to least frequent.
SELECT monthname(orderDate) AS 'Month' , count(month(orderDate)) AS 'Visits'
FROM EatInOrder NATURAL JOIN Orders
GROUP BY month(orderDate)
ORDER BY count(month(orderDate)) DESC;

-- j. List the three customers who have spent the most at Miming’s over the past year.  
-- Order by the amount that they spent, from largest to smallest.
SELECT A.customerID, A.cFirstName, A.cLastName, SUM(A.total) AS 'Total Spent Last Year'
FROM
(
	SELECT *
	FROM Customer NATURAL JOIN Orders
	WHERE orderDate >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
) AS A
GROUP BY A.customerID
ORDER BY SUM(A.total) DESC
LIMIT 3;

-- k. List the five menu items that have generated the most revenue for Miming’s over the past year.
SELECT menuItemName, sum(price * quantity) AS 'Revenue Generated Over The Past Year'
FROM MenuMenuItem NATURAL JOIN OrderDetails NATURAL JOIN
(SELECT orderID
FROM Orders
WHERE orderDate >= DATE_SUB(NOW(), INTERVAL 1 YEAR)) AS X
GROUP BY menuType, menuItemName
ORDER BY sum(price * quantity) DESC
LIMIT 5;

-- l. Find the sous chef who is mentoring the most other sous chef.  
-- List the menu items that the sous chef is passing along to the other sous chefs.
SELECT empID, firstName, lastName, count(empID) AS '# of students taught', group_concat(DISTINCT menuItemName) AS 'Menu Items taught'
FROM Employee INNER JOIN Mentorship
ON empID = mentorID
WHERE empID IN
(
	SELECT mentorID
	FROM Mentorship
	GROUP BY mentorID
	HAVING count(studentID) =
	(
		SELECT max(X.numOfStudentsMentored)
		FROM
		(
			SELECT mentorID, count(studentID) AS numOfStudentsMentored
			FROM Mentorship
			GROUP BY mentorID
		) AS X
	)
)
GROUP BY empID;

-- m. Find the three menu items that have the fewest sous chefs skilled in those menu items.
SELECT menuItemName, count(menuItemName) AS '# of Expert SousChefs'
FROM Expertise
GROUP BY menuItemName
ORDER BY count(menuItemName)
LIMIT 3;

-- n. List all of the customers who eat at Miming’s on their own as well as ordering for their corporation.
SELECT DISTINCT customerID, P.cFirstName, P.cLastName, P.email, P.snailMailAddress, P.phone
FROM
	(SELECT * FROM PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P
	INNER JOIN
	(SELECT * FROM CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
USING (customerID);

-- o. List the contents and prices of each of the menus.
SELECT menuType, menuItemName, price
FROM MenuMenuItem
ORDER BY menuType, menuItemName;

-- p. Three additional queries that demonstrate the five additional business rules.  
-- Feel free to create additional views to support these queries if you so desire.

-- Business Rule #1:
-- DishwashingStaff gets paid an extra $1 per washed plate AFTER 100 washed plates; 
-- washed plate count resets each shift.
SELECT empID, lastName, firstName, dateWorked, dishesWashed, extraDishMoney
FROM Employee NATURAL JOIN Dishwasher NATURAL JOIN DishBonus;

-- Business Rule #2:
-- Happy Hour Discount: Orders between 5pm-6pm get 50% off the total.
SELECT A.orderID, A.orderTime, A.happyHourDiscount, B.withoutHHDiscount AS 'Total w/o HH discount', A.total AS 'Total WITH HH discount'
FROM
	(SELECT * FROM Orders) AS A
	INNER JOIN
	(SELECT *, sum(price*quantity) AS withoutHHDiscount
	FROM OrderDetails NATURAL JOIN MenuMenuItem
	GROUP BY orderID) AS B
ON A.orderID = B.orderID;

-- Business Rule #3:
-- Wait Staff Morale Bonus: Customer service can be a draining and thankless job. 
-- Every month we pick a waiter at random to get bonus based on 10% of the tips they made for the month.

SELECT A.month, A.year, A.empID, A.firstName, A.lastName, B.tipsEarned, A.bonusAmount
FROM
	(SELECT * FROM Employee NATURAL JOIN MoraleBonus) AS A
	LEFT JOIN
	(SELECT *, month(dateOfTip) AS monthB, year(dateOfTip) AS yearB, sum(tipAmount) AS tipsEarned
	FROM Tip
	GROUP BY empID, month(dateOfTip), year(dateOfTip)) AS B
ON A.empID = B.empID AND A.month = month(B.dateOfTip) AND A.year = year(B.dateOfTip)
ORDER BY A.year, A.month;


-- Business Rule #4:
-- Employee of the month: tracks the best performing employee for each month.
SELECT month, year, empID, lastName, firstName, notableAchievement
FROM EmployeeOfTheMonth NATURAL JOIN Employee
ORDER BY year, month;

-- Business Rule #5:
-- An employee may not work both the morning and evening shifts of the same date. 
-- This is against state/federal law because an Employee working both the morning and 
-- evening shifts of the same day would be working 16 hours per day.
-- (this one is implemented using triggers, but you can see that there is no employee that works 
-- boththe evening and morning shifts for a particular date)
SELECT empID, lastName, firstName, dateOfShift, shiftType 
FROM Employee NATURAL JOIN WorkSchedule NATURAL JOIN WorkShift
ORDER BY empID, dateOfShift, shiftType;