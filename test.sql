INSERT HeadChef(empID, chefHatSize) VALUES
(3, 'M');
INSERT SousChef(empID, level) VALUES
(4, 'I');
INSERT LineCook(empID, startingStation) VALUES
(5, 'cool');

INSERT HeadChef(empID, chefHatSize) VALUES
(4, 'M');



INSERT SousChef(empID, level) VALUES
(3, 'I');
INSERT HeadChef(empID, chefHatSize) VALUES
(4, 'L');
INSERT LineCook(empID, startingStation) VALUES
(5, 'cool');
INSERT SousChef(empID, level) VALUES
(4, 'I');




INSERT LineCook(empID, startingStation) VALUES
(8, 'cool');
INSERT HeadChef(empID, chefHatSize) VALUES
(9, 'L');
INSERT SousChef(empID, level) VALUES
(10, 'II');
INSERT LineCook(empID, startingStation) VALUES
(10, 'chot');


SELECT * FROM Employee;
SELECT * FROM FullTimeEmployee;
SELECT * FROM PartTimeEmployee;
SELECT * FROM Employee NATURAL JOIN FullTimeEmployee;
SELECT * FROM Employee NATURAL JOIN PartTimeEmployee;

SELECT * FROM Chef NATURAL JOIN FullTimeEmployee;
SELECT * FROM Manager NATURAL JOIN FullTimeEmployee;
SELECT * FROM Employee NATURAL JOIN PartTimeEmployee;

SELECT * FROM Employee NATURAL JOIN HeadChef NATURAL JOIN Recipe NATURAL JOIN Ingredients;

SELECT * FROM LineCook NATURAL JOIN CookingStation;

INSERT INTO FullTimeEmployee(empID, salary) values
(33, 23);

INSERT INTO PartTimeEmployee(empID, hourlyRate) values
(33, 23);



INSERT INTO PartTimeEmployee(empID, hourlyRate) values
(5, 19);
INSERT INTO PartTimeEmployee(empID, hourlyRate) values
(3, 8.50);
INSERT INTO FullTimeEmployee(empID, salary) values
(6, 50000.39);
INSERT INTO FullTimeEmployee(empID, salary) values
(1, 10000.99);

SELECT * FROM MoraleBonus NATURAL JOIN Employee;

SELECT * FROM OrderDetails;
SELECT * FROM Orders;

SELECT *
FROM MenuMenuItem NATURAL JOIN OrderDetails
WHERE orderID = 1;

SELECT * FROM MenuItem;
SELECT * FROM MenuMenuItem;
SELECT * FROM Orders NATURAL JOIN OrderDetails;


SELECT * FROM Orders;

SELECT orderID, SUM(price)
FROM MenuMenuItem NATURAL JOIN OrderDetails
GROUP BY orderID;
