

-- a. List the customers.  For each customer, indicate which category he or she falls into, and his or her contact information.  If you have more than one independent categorization of customers, please indicate which category the customer falls into for all of the categorizations.
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


-- b. List the top three customers in terms of their net spending for the past two years, and the total that they have spent in that period.


-- c. Find all of the sous chefs who have three or more menu items that they can prepare.  For each sous chef, list their name, the number of menu items that they can prepare, and each of the menu items.  You can use group_concat to get all of a given sous chef’s data on one row, or print out one row per sous chef per menu item.


-- d. Find all of the sous chefs who have three or more menu items in common.


-- . Please give the name of each of the two sous chefs sharing three or more menu items.


-- . Please make sure that any given pair of sous chefs only shows up once.


-- e. Find the three menu items most often ordered from the Children’s menu and order them from most frequently ordered to least frequently ordered.


-- f. List all the menu items, the shift in which the menu item was ordered, and the sous chef on duty at the time, when the sous chef was not an expert in that menu item.


-- g. List the customers, sorted by the amount of Miming’s Money that they have, from largest to smallest.


-- h. List the customers and the total that they have spent at Miming’s ever, in descending order by the amount that they have spent.


-- i. Report on the customers at Miming’s by the number of times that they come in by month and order the report from most frequent to least frequent.


-- j. List the three customers who have spent the most at Miming’s over the past year.  Order by the amount that they spent, from largest to smallest.


-- k. List the five menu items that have generated the most revenue for Miming’s over the past year.


-- l. Find the sous chef who is mentoring the most other sous chef.  List the menu items that the sous chef is passing along to the other sous chefs.


-- m. Find the three menu items that have the fewest sous chefs skilled in those menu items.


-- n. List all of the customers who eat at Miming’s on their own as well as ordering for their corporation.


-- o. List the contents and prices of each of the menus.


-- p. Three additional queries that demonstrate the five additional business rules.  Feel free to create additional views to support these queries if you so desire.
