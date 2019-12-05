-- MenuItem_v:
-- For each menu item, give it’s spiciness, and all of the different costs for that item.  
-- If a given item is not on a particular menu, then report “N/A” for that particular item for that particular menu. 
-- Also, if an item only appears as a single serving portion, put in “N/A” into the report for the gallon, … prices.


-- Customer_addresses_v:
-- For each customer, indicate whether they are an individual or a corporate account, 
-- and display all of the information that we are managing for that customer.
CREATE OR REPLACE VIEW Customer_addresses_v AS
SELECT P.customerID, 'Private' as typeOfCustomer, P.cFirstName, P.cLastName, P.email, P.snailMailAddress, P.phone, P.creditEarned, P.creditSpent, P.currentBalance
FROM 
	(SELECT * FROM MimingsMoney NATURAL JOIN PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P
	LEFT JOIN 
    (SELECT * FROM MimingsMoney NATURAL JOIN CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
ON P.customerID = C.customerID 
WHERE C.customerID IS NULL
UNION
-- Corporate ONLY
SELECT C.customerID, 'Corporate' as typeOfCustomer, C.cFirstName, C.cLastName, C.email, C.snailMailAddress, C.phone, C.creditEarned, C.creditSpent, C.currentBalance
FROM 
	(SELECT * FROM MimingsMoney NATURAL JOIN CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
	LEFT JOIN 
	(SELECT * FROM MimingsMoney NATURAL JOIN PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P	
ON C.customerID = P.customerID
WHERE P.customerID IS NULL
UNION
-- BOTH:
SELECT DISTINCT customerID, 'BOTH' as typeOfCustomer, P.cFirstName, P.cLastName, P.email, P.snailMailAddress, P.phone, P.creditEarned, P.creditSpent, P.currentBalance
FROM
	(SELECT * FROM MimingsMoney NATURAL JOIN  PrivateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS P
	INNER JOIN
	(SELECT * FROM MimingsMoney NATURAL JOIN  CorporateCustomer NATURAL JOIN Customer NATURAL JOIN ContactInfo) AS C
USING (customerID);
SELECT * FROM Customer_addresses_v;

-- Sous_mentor_v:
-- reports all the mentor/mentee relationships at Miming’s, sorted by the name of the mentor, then the name of the mentee. 
-- Show the skill that the mentorship passes, as well as the start date.
CREATE OR REPLACE VIEW Sous_mentor_v AS
SELECT DISTINCT M.empID AS 'MentorID', M.lastName AS 'Mentor Last Name', M.firstName AS 'Mentor First Name', S.empID AS 'StudentID', S.lastName AS 'Mentee Last Name', S.firstName AS 'Mentee First Name', M.menuItemName AS 'Menu Item Taught'
FROM
(
	SELECT *
	FROM Mentorship INNER JOIN Employee
	ON empID = mentorID
) AS M
INNER JOIN
(
	SELECT * 
	FROM Mentorship INNER JOIN Employee
	ON empID = studentID
) AS S
ON M.mentorID = S.mentorID AND  M.studentID = S.studentID
ORDER BY M.lastName, M.firstName, S.lastName, S.firstName;

SELECT * FROM Sous_mentor_v;

-- Customer_Sales_v – On a year by year basis, show how much each customer has spent at Miming’s.
CREATE OR REPLACE VIEW Customer_Sales_v AS
SELECT customerID, cLastName AS 'Last Name', cFirstName AS 'First Name', year(orderDate) AS 'Year', sum(total) AS 'Total'
FROM Orders NATURAL JOIN Customer
GROUP BY customerID, year(orderDate)
ORDER BY cLastName, cFirstName, year(orderDate); 

SELECT * FROM Customer_Sales_v;

-- Customer_Value_v:
-- List each customer and the total $ amount of their orders for the past year, 
-- in order of the value of customer orders, from highest to the lowest.
CREATE OR REPLACE VIEW Customer_Value_v AS
SELECT A.customerID, A.cFirstName, A.cLastName, SUM(A.total) AS 'Total Spent For The Last Year'
FROM
(
	SELECT *
	FROM Customer NATURAL JOIN Orders
	WHERE orderDate >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
) AS A
GROUP BY A.customerID
ORDER BY SUM(A.total) DESC;

SELECT * FROM Customer_Value_v;