INSERT INTO Employee(firstName, lastName, birthdate, hiredDate) VALUES 
('Lorde', 		'Willing', 			'2000-12-25', '2019-07-30'),
('Rip', 		'Harambe', 			'1999-05-27', '2005-05-28'), -- noone dare change this date
('Stefan', 		'Karl', 			'1975-11-19', '2006-05-25'),
('Finel', 		'Bosse', 			'2000-06-13', '2019-11-13'),
('Ash', 		'Ketchum', 			'1993-11-15', '2018-04-26'),
('Aiden',		'Wolff',			'1975-03-12', '1998-10-28'),
('Arnold',		'Bartoletti',		'1975-11-12', '1996-04-29'),
('Bo',			'Hill',				'1974-03-25', '2009-05-07'),
('Claud',		'Jones',			'1965-04-19', '1980-12-14'),
('Daphne',		'Schaefer',			'1979-06-08', '2005-03-05'),
('Daphne',		'Pfannerstill',		'1985-11-22', '1998-02-10'),
('Dax',			'Nader',			'1963-07-10', '1980-08-13'),
('Deven',		'Lebsack',			'1972-02-24', '2003-04-15'),
('Erling',		'Pfannerstill',		'1951-02-04', '1971-04-07'),
('Ethel',		'Veum',				'1983-06-04', '2006-12-26'),
('Guadalupe',	'Lowe',				'1979-03-29', '2019-02-13'),
('Kaley',		'Price',			'1978-01-18', '1996-02-13'),
('Kaley',		'Price',			'1958-01-18', '1973-12-22'),
('Kristin',		'Hand',				'1982-02-03', '1999-08-17'),
('Kylee',		'Wehner',			'1994-05-08', '2012-03-01'),
('Mabelle',		'Quitzon',			'1999-11-23', '2015-08-14'),
('Mandy',		'Rogahn',			'1989-06-16', '2000-05-28'),
('Meghan',		'Hilpert',			'1976-03-13', '2016-03-08'),
('Mireya',		'Mosciski',			'1988-10-27', '2003-03-05'),
('John',		'Mosciski',			'1987-06-19', '2008-06-18'),
('Quincy',		'Smith',			'1985-11-22', '2006-01-10'),
('Roger',		'Smith',			'1973-03-16', '1999-08-11'),
('John',		'Smith',			'1999-08-18', '2002-02-04'),
('Russ',		'Lind',				'1981-01-14', '1999-04-12'),
('Vincent',		'Borer',			'1973-05-06', '2015-08-04'),
('Adelbert',	'Prohaska',			'2005-10-09', '1990-04-22'), -- data not verified for 'plausibility' starting here
('Alvis',		'Satterfield',		'1995-10-11', '1996-10-29'),
('Anastacio',	'Cummings',			'1996-04-19', '2019-10-29'),
('Ashlee',		'Cremin',			'1991-03-22', '1977-11-06'),
('Bridgette',	'Blick',			'2012-04-25', '1985-10-19'),
('Carol',		'Flatley',			'2018-04-23', '1994-10-10'),
('Celine',		'Glover',			'1998-12-24', '2010-09-07'),
('Emmitt',		'Muller',			'2012-07-23', '1984-09-14'),
('Erick',		'Cartwright',		'1989-10-11', '1990-10-20'),
('Fern',		'Denesik',			'1984-12-06', '2013-06-22'),
('Gabriella',	'Homenick',			'1983-09-17', '1970-05-10'),
('Kasey',		'O\'Kon',			'1993-11-02', '1975-02-27'),
('Libbie',		'Kilback',			'1974-06-13', '1971-09-05'),
('Lora',		'Ratke',			'2004-11-12', '2017-01-19'),
('Madison',		'Effertz',			'1989-03-26', '2000-01-15'),
('Maeve',		'Ferry',			'1975-05-17', '2018-05-05'),
('Malika',		'Mayer',			'2015-03-16', '1999-08-14'),
('Osbaldo',		'Lubowitz',			'1988-08-31', '1973-02-08'),
('Sonya',		'Lockman',			'2008-01-15', '1973-10-26'),
('Thea',		'Hoppe',			'1977-01-27', '2015-12-28');

INSERT INTO FullTimeEmployee(empID, weeklySalary) VALUES
(1,'86376.60'),
(2,'80759.75'),
(3,'81289.00'),
(4,'116906.68'),
(5,'98374.79'),
(6,'92921.71'),
(7,'44586.26'),
(8,'81829.47'),
(9,'27848.62'),
(10,'99315.37'),
(11,'114747'),
(12,'75045.74'),
(13,'100649.86'),
(14,'68821.65'),
(15,'58459.22'),
(16,'103709.08'),
(17,'57934.50'),
(18,'99122'),
(19,'108918.29'),
(20,'32489.35'),
(21,'109236.5'),
(22,'43424.95'),
(23,'41726.66'),
(24,'70818.14'),
(25,'47821.79'),
(26,'27518.3'),
(27,'116722.84'); 

INSERT INTO PartTimeEmployee(empID, hourlyRate) VALUES 
(28,'20.15'),
(29,'16.21'),
(30,'15.87'),
(31,'21.36'),
(32,'20.15'),
(33,'14.22'),
(34,'17'),
(35,'17.42'),
(36,'9.41'),
(37,'22.76'),
(38,'8.5'),
(39,'19.42'),
(40,'12.9'),
(41,'16.28'),
(42,'22.23'),
(43,'10.21'),
(44,'8.8'),
(45,'12.08'),
(46,'14.1'),
(47,'20.8'),
(48,'15.54'),
(49,'14.61'),
(50,'9.94'); 

INSERT INTO Manager(empID, supervisorCredentials) VALUES 
(1,	'Ph.D. at School of Managerial Duties'),
(2,	'5-week Supervising Online Course');

INSERT INTO Chef(empID, favoriteFoodToCook) VALUES
(3,		'Dumplings'),
(4,		'Har gow'),
(5,		'Oxtail soup'),
(6,		'Fried chicken wings'),
(7,		'Hot sour soup'),
(8,		'Corn crab soup'),
(9,		'Oxtail soup'),
(10,	'Sweet potato soup'),
(11,	'Crispy chow mein'),
(12,	'Steamed chow mein'),
(13,	'Egg foo young'),
(14,	'Chop suey'),
(15,	'Kung pao chicken'),
(16,	'Spring roll'),
(17,	'Fried rice'),
(18,	'Seasame chicken'),
(19,	'Egg roll'),
(20,	'Wonton soup'),
(21,	'Orange chicken'),
(22,	'Pot sticker'),
(23,	'Crab rangoon'),
(24,	'Fortune cookies'),
(25,	'Jellyfish'),
(26,	'Tofu'),
(27,	'Taro');

INSERT INTO HeadChef(empID, headChefHatSize) VALUE
(3, 'S'),
(4, 'M'),
(5, 'XL');

INSERT INTO SousChef(empID, level) VALUE
(6, 'I'),
(7, 'I'),
(8, 'IV'),
(9, 'III'),
(10, 'IV'),
(11, 'II'),
(12, 'I'),
(13, 'III');

INSERT INTO LineCook(empID) VALUE
(14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27);

INSERT INTO MaitreD(empID) VALUE
(28), (29), (30);

INSERT INTO Dishwasher(empID) VALUE
(31), (32), (33), (34), (35), (36), (37), (38);

INSERT INTO Waiter(empID) VALUE
(39), (40), (41), (42), (43), (44), (45), (46), (47), (48), (49), (50);

INSERT INTO Recipe(empID, recipeName) VALUE
(3, 'Awesome Pancakes with a Twist'),
(4, 'Italian Lobster Fries'),
(5, 'Malaysian Flower Curry'),
(5, 'Momma and Papa Cake'),
(4, 'Drizzling Dribble Dragon Head Steak'),
(5, 'Zombie Flesh Popcorn Chicken'),
(4, 'The Average Burger');

INSERT INTO Ingredients(recID, ingredientName, quantity) VALUE
(1, 'Chicken wings', 12),
(1, 'Black pepper', 3),
(1, 'Sea salt', 5),
(1, 'Flour', 2),
(1, 'Vegestable oil', 5),
(1, 'Cornstarch', 8),
(2, 'Soda', 4),
(2, 'Powder', 5),
(2, 'Soy sauce', 5),
(2, 'Dry sherry', 1),
(2, 'Sesame oil', 25),
(2, 'Chicken breast meat', 10),
(3, 'Egg', 26),
(3, 'Green Onion', 20),
(3, 'Mushrooms', 10),
(3, 'Carrots', 2),
(3, 'Peas', 2),
(3, 'Bell pepper', 5),
(3, 'Water chestnuts', 10),
(3, 'Bamboo shoots', 32),
(3, 'Bean sprouts', 12),
(4, 'Oyster Sauce', 23),
(4, 'Sriracha', 28),
(4, 'Canola oil', 68),
(4, 'Noodles', 8),
(4, 'Baby bok choy', 4),
(5, 'Bean sprouts', 1),
(5, 'Butter', 42),
(5, 'Chicken broth', 5),
(5, 'Potato', 3),
(5, 'Whole milk', 5),
(5, 'Crab', 5),
(6, 'Cornstarch', 42),
(6, 'Egg whites', 12),
(6, 'Chicken ', 23),
(6, 'Orange juice', 24),
(6, 'Brown sugar', 10),
(6, 'Wine vinegar', 1),
(6, 'Dash salt', 1),
(7, 'Soy Sauce', 22),
(7, 'Bean sprouts', 12);

INSERT INTO Station(stationName, responsibilityDesc) VALUE
('Butcher', 'butches stuff'),
('Fry Cook', 'fries stuff'),
('Grill', 'grill stuff'),
('Pantry', 'ensures filled pantries'),
('Pastry', 'makes deserts'),
('Roast', 'roasts meats'),
('Saute', 'makes sauces and gravies'),
('Vegetable', 'cuts vegetables');

INSERT INTO CookingStation(empID, stationName, dateStationed) VALUE
(25,'Butcher','2002-09-20'),
(24,'Butcher','1990-05-09'),
(25,'Butcher','2005-10-23'),
(14,'Butcher','1990-01-18'),
(21,'Butcher','1994-07-08'),
(22,'Butcher','2018-06-27'),
(24,'Butcher','2002-07-26'),
(22,'Butcher','1970-06-22'),
(17,'Butcher','1998-09-02'),
(27,'Butcher','1985-01-18'),
(15,'Butcher','1976-07-08'),
(22,'Fry Cook','1993-08-20'),
(14,'Fry Cook','1973-12-01'),
(22,'Fry Cook','1982-12-14'),
(24,'Fry Cook','2007-01-05'),
(15,'Fry Cook','1993-04-03'),
(25,'Fry Cook','1977-03-13'),
(27,'Fry Cook','2018-10-01'),
(24,'Fry Cook','1971-05-25'),
(16,'Fry Cook','2019-04-16'),
(22,'Fry Cook','1980-06-05'),
(19,'Fry Cook','2018-08-13'),
(14,'Fry Cook','2008-08-10'),
(21,'Fry Cook','1991-01-10'),
(16,'Fry Cook','1978-01-19'),
(19,'Fry Cook','1994-12-11'),
(19,'Fry Cook','2011-01-20'),
(19,'Fry Cook','1992-02-15'),
(15,'Fry Cook','2000-06-25'),
(24,'Fry Cook','1972-11-29'),
(17,'Fry Cook','1985-03-21'),
(26,'Fry Cook','2003-08-04'),
(24,'Grill','1990-09-20'),
(22,'Grill','2019-07-19'),
(24,'Grill','1992-12-22'),
(20,'Grill','2014-07-04'),
(24,'Grill','1997-01-24'),
(27,'Grill','2011-10-08'),
(16,'Grill','1972-07-25'),
(18,'Grill','1999-05-06'),
(25,'Grill','2008-08-27'),
(24,'Grill','1975-05-16'),
(21,'Grill','1989-04-23'),
(18,'Pantry','1976-11-21'),
(23,'Pantry','1995-09-20'),
(15,'Pantry','2003-06-30'),
(14,'Pantry','2002-07-01'),
(22,'Pantry','2019-07-01'),
(14,'Pantry','2002-01-17'),
(16,'Pantry','2017-02-26'),
(21,'Pantry','1996-05-22'),
(16,'Pantry','1979-06-07'),
(19,'Pantry','1980-07-26'),
(15,'Pantry','1974-12-14'),
(15,'Pastry','2000-02-23'),
(25,'Pastry','2013-11-24'),
(15,'Pastry','1976-07-21'),
(19,'Pastry','1995-06-20'),
(20,'Pastry','1977-08-03'),
(24,'Pastry','1974-12-09'),
(24,'Pastry','2006-11-30'),
(26,'Pastry','1991-12-06'),
(24,'Pastry','2018-10-06'),
(15,'Pastry','1976-07-28'),
(22,'Pastry','1992-08-15'),
(21,'Roast','2002-08-18'),
(21,'Roast','2003-10-28'),
(21,'Roast','1974-10-10'),
(24,'Roast','2001-10-15'),
(26,'Roast','2003-10-21'),
(25,'Roast','1976-02-03'),
(27,'Roast','1988-02-28'),
(17,'Roast','1995-05-08'),
(27,'Saute','2016-12-02'),
(25,'Saute','2019-02-24'),
(20,'Saute','2019-06-07'),
(17,'Saute','2002-11-21'),
(18,'Saute','1986-10-04'),
(22,'Saute','2008-05-17'),
(23,'Saute','1972-02-25'),
(27,'Saute','2018-12-05'),
(14,'Saute','2009-08-06'),
(16,'Saute','2006-08-02'),
(26,'Saute','1984-07-03'),
(22,'Saute','1976-07-04'),
(26,'Vegetable','2003-03-18'),
(15,'Vegetable','2019-03-29'),
(14,'Vegetable','1997-01-11'),
(14,'Vegetable','1992-03-01'),
(22,'Vegetable','1990-08-02'),
(22,'Vegetable','1999-04-17'),
(15,'Vegetable','1995-03-29'),
(23,'Vegetable','2010-08-03'),
(26,'Vegetable','1981-03-24'),
(18,'Vegetable','2013-05-14'),
(19,'Vegetable','2008-12-24'),
(22,'Vegetable','1982-07-23'),
(24,'Vegetable','2017-03-25'),
(15,'Vegetable','2013-10-23'),
(23,'Vegetable','1999-05-12'); 

INSERT INTO DishBonus(empID, dateWorked, dishesWashed) VALUES
(31, '2018-02-16', 123),
(31, '2018-02-17', 256),
(31, '2018-02-18', 132),
(32, '2018-02-17', 164),
(32, '2018-02-18', 105),
(32, '2018-02-19', 68),
(33, '2018-02-01', 138),
(33, '2018-02-23', 112),
(34, '2018-02-23', 72),
(34, '2018-02-08', 83),
(35, '2018-02-01', 15),
(35, '2018-02-12', 62),
(36, '2018-02-01', 92),
(37, '2018-02-02', 99),
(38, '2018-02-09', 102);

INSERT INTO Tip(empID, dateOfTip, timeOfTip, tipAmount) VALUES
(39, '1999-05-01', current_time(), 6.01),
(39, '1999-05-03', current_time(), 2.5),
(39, '1999-05-04', current_time(), 1),
(39, '1999-05-09', current_time(), 100),
(39, '1999-05-13', current_time(), 18),
(39, '1999-05-18', current_time(), 10),
(39, '1999-05-26', current_time(), 6),
(39, '1999-05-30', current_time(), 5),
(42, '2000-06-01', current_time(), 1.69),
(42, '2000-06-03', current_time(), 10),
(42, '2000-06-04', current_time(), 6),
(42, '2000-06-09', current_time(), 8),
(42, '2000-06-13', current_time(), 3),
(42, '2000-06-18', current_time(), 8),
(42, '2000-06-26', current_time(), 4),
(42, '2000-06-30', current_time(), 2);

INSERT INTO MoraleBonus(empID, month, year) VALUES
(39, 5, 1999),
(42, 6, 2000),
(43, 8, 1993);

INSERT INTO Menu(menuType, priceModifierPercentage, dateCreated) VALUES
('Evening', 				0, 	'2018-11-23'),
('Lunch', 					10, '2018-03-29'),
('Sunday Brunch Buffet', 	50, '2018-08-09'),
('Children', 				20, '2018-02-18');

INSERT INTO MenuItem(menuItemName, spiciness, basePrice) VALUES
('Scallop Fries', 			'Mild', 		5.50),
('Bacon Brussel Sprouts', 	'Tangy', 		6.15),
('Salmon Curry', 			'Hot', 			8.99),
('Pad Thai', 				'Mild', 		12.99),
('Spaghetti Bolognese', 	'Piquant', 		25.79),
('Chicken Wings', 			'Oh My God', 	2.50),
('Steak Wrap', 				'Hot', 			6.99),
('Tacos', 					'Mild', 		4.20),
('Sweet & Sour Chicken', 	'Tangy', 		7.20),
('Cucumber Sandwiches', 	'Hot', 			3.60);

INSERT INTO MenuMenuItem(menuType, menuItemName, portionSize) VALUES
('Evening', 'Salmon Curry', 			'2 oz'),
('Evening', 'Steak Wrap', 				'4 lbs'),
('Evening', 'Bacon Brussel Sprouts', 	'9 lbs'),
('Evening', 'Spaghetti Bolognese', 		'5 oz'),
('Evening', 'Chicken Wings', 			'5 oz'),
('Evening', 'Scallop Fries', 			'6 lbs'),
('Evening', 'Pad Thai', 				'7 lbs'),
('Lunch', 'Steak Wrap', 				'5 oz'),
('Lunch', 'Sweet & Sour Chicken', 		'3.3 lbs'),
('Lunch', 'Cucumber Sandwiches', 		'18 oz'),
('Lunch', 'Tacos', 						'20 lbs'),
('Lunch', 'Pad Thai', 					'19 oz'),
('Sunday Brunch Buffet', 'Scallop Fries', 				'1  oz'),
('Sunday Brunch Buffet', 'Bacon Brussel Sprouts', 		'2 lbs'),
('Sunday Brunch Buffet', 'Salmon Curry', 				'3 lbs'),
('Sunday Brunch Buffet', 'Pad Thai', 					'5 oz'),
('Sunday Brunch Buffet', 'Spaghetti Bolognese', 		'6 lbs'),
('Sunday Brunch Buffet', 'Chicken Wings', 				'8 oz'),
('Sunday Brunch Buffet', 'Steak Wrap', 					'7 lbs'),
('Sunday Brunch Buffet', 'Tacos', 						'11 oz'),
('Sunday Brunch Buffet', 'Sweet & Sour Chicken', 		'9 lbs'),
('Sunday Brunch Buffet', 'Cucumber Sandwiches', 		'12 oz'),
('Children', 'Scallop Fries', 			'8 lbs'),
('Children', 'Pad Thai', 				'9 lbs'),
('Children', 'Tacos', 					'13 oz'),
('Children', 'Cucumber Sandwiches', 	'17 oz');


INSERT INTO Expertise(empID, menuItemName) VALUES
(6, 	'Scallop Fries'),
(7, 	'Bacon Brussel Sprouts'),
(7, 	'Pad Thai'),
(7, 	'Steak Wrap'),
(9, 	'Sweet & Sour Chicken'),
(9, 	'Pad Thai'),
(10, 	'Salmon Curry'),
(11, 	'Bacon Brussel Sprouts'),
(13, 	'Tacos'),
(13, 	'Spaghetti Bolognese'),
(13, 	'Chicken Wings'),
(13, 	'Cucumber Sandwiches'),
(13, 	'Pad Thai');

-- studentID != mentorID
-- (mentorID, menuItemName) combo MUST already exist in Expertise table
-- endDate has to be greater than the startDate
-- if you insert a Mentorship with an endDate that has not passed yet 
-- then the Mentorship has not been completed 
-- therefore the SousChef with studentID will NOT be inserted into the Expertise table
INSERT INTO Mentorship(studentID, mentorID, menuItemName, startDate, endDate) VALUES
(10,		7, 		'Bacon Brussel Sprouts',					'1998-02-16','2012-01-26'),
(6,			7, 		'Bacon Brussel Sprouts',					'1999-04-01','2014-06-13'),
(9,			7, 		'Bacon Brussel Sprouts',					'2004-08-21','2012-02-18'),
(12,		11, 	'Bacon Brussel Sprouts',					'1972-05-26','1987-02-27'),
(11,		13, 	'Chicken Wings',							'1981-07-02','1994-09-05'),
(6,			13, 	'Chicken Wings',							'1987-04-30','1995-03-21'),
(12,		13, 	'Chicken Wings',							'1990-03-16','2004-08-05'),
(9,			13, 	'Chicken Wings',							'1998-08-19','1999-11-04'),
(7,			13, 	'Cucumber Sandwiches',						'1977-03-04','1978-11-21'),
(6,			13, 	'Cucumber Sandwiches',						'1970-08-10','1971-10-25'),
(13,		10, 	'Salmon Curry',								'1992-09-07','2016-07-23'),
(12,		10, 	'Salmon Curry',								'1981-05-20','1989-06-28'),
(6,			10, 	'Salmon Curry',								'1982-04-08','1983-01-24'),
(7,			6, 		'Scallop Fries',							'2001-07-18','2014-11-14'),
(9,			6, 		'Scallop Fries',							'1984-05-19','1985-07-09'),
(6,			7, 		'Steak Wrap',								'1989-06-08','2000-11-15'),
(9,			7, 		'Steak Wrap',								'1971-12-21','1972-08-11'),
(10,		7, 		'Steak Wrap',								'2000-04-16','2001-04-28'),
(11,		7, 		'Steak Wrap',								'1971-01-21','1978-08-29'),
(7,			9, 		'Sweet & Sour Chicken',						'2005-10-12','2005-11-16'),
(12,		9, 		'Sweet & Sour Chicken',						'1975-04-04','2013-02-04'),
(6,			13, 	'Tacos',									'2000-06-19','2000-12-04');

INSERT INTO WorkShift(shiftType, dateOfShift, busyness, mID, hcID, sID, mdID) VALUES
('Morning', '1998-06-25', 'High', 	1, 3, 6, 28),
('Evening', '1998-06-25', 'Medium',	2, 4, 7, 28),
('Morning', '1998-06-26', 'High', 	1, 5, 7, 30),
('Evening', '1998-06-26', 'Low', 	2, 3, 8, 28),
('Morning', '1998-06-27', 'High', 	1, 4, 8, 30),
('Evening', '1998-06-27', 'Low', 	2, 4, 8, 30);

INSERT INTO WorkSchedule(shiftID, empID) VALUES
(1, 39), (1, 5), (1, 6), (2, 40), (2, 41), (3, 7), (4, 28), (4, 39), (5, 29), (6, 27), (6, 31);

INSERT INTO SeatingTable(shiftID, tableNum, empID, maxOccupancy) VALUE
(1, 3, 39, 6),
(2, 4, 40, 4),
(2, 3, 41, 2);


INSERT INTO Customer (cFirstName, cLastName,cDOB) VALUES 
('Amber','Reinger','1974-01-28'),
('Annabell','Fay','1988-03-11'),
('Demario','Jast','1999-02-10'),
('Edythe','Reichel','1988-01-17'),
('Elvera','West','1983-11-20'),
('Emmy','Zieme','1980-04-04'),
('Jovani','Greenfelder','1992-07-31'),
('Kaden','Gislason','2010-06-05'),
('Maximillia','Dicki','1986-05-13'),
('Noemi','Dicki','2005-09-16'); 


INSERT INTO PrivateCustomer (customerID) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO CorporateCustomer (customerID, orgName, deptName, officeAddress) VALUES 
(3, 'Burger King', 'Sales', '17 Fawn St.North Haven, CT 06473'),
(6, 'Yahoo!', 'Engineering', '659 Jockey Hollow Street Attleboro, MA 02703'),
(9, 'eBay' , 'Marketing', '166 South Hill Lane Billerica, MA 01821'),
(5, 'Adobe', 'Art', '723 Warren Street Huntington Station, NY 11746');

INSERT INTO MimingsMoney (customerID, creditEarned, creditSpent, currentBalance) VALUES 
(1, 23, 12.43, 10),
(2, 10, 2.50, 7.50),
(3, 5, 1.00, 4.00),
(4, 11, 10.10, 0.90),
(5, 7, 6.00, 1.00),
(6, 9, 5.00, 4.00),
(7, 10, 4.25, 5.75),
(8, 21, 15.76, 5.24),
(9, 13, 2.56, 10.44),
(10, 6, 3.00, 3.00);

INSERT INTO ContactInfo (customerID, email, snailMailAddress, phone) VALUES 
(1, 'getmehere@gmail.com', '21 Constitution Ave. Elmont, NY 11003', '202-555-0130'),
(2, 'mobster124@gmail.com', '86 Rock Creek Street Nutley, NJ 07110', '202-555-0185'),
(3, 'osmoJones@gmail.com', '8779 Paris Hill Drive Grosse Pointe, MI 48236', '202-555-0120'),
(4, 'hellokitty5353@gmail.com', '583 South Riverview St. Osseo, MN 55311', '202-555-0139'),
(5, 'starwarsfan231@gmail.com', '102 S. Shipley St. Crawfordsville, IN 47933', '202-555-0122'),
(6, 'stingTakeover@gmail.com', '60 Prospect Street Enterprise, AL 36330', '202-555-0154'),
(7, 'vanillaFan@gmail.com', '904 Golf St. Ottumwa, IA 52501', '202-555-0177'),
(8, 'paintHouse330@gmail.com', '477 Main St. Nampa, ID 83651', '202-555-0101'),
(9, 'newuserhere@gmail.com', '51 North Gregory St. Loganville, GA 30052', '202-555-0129'),
(10, 'jdsfkldlkdsfjjfdk@gmail.com', '507 Gonzales St. Cedar Falls, IA 50613', '202-555-0118');


INSERT INTO Orders(customerID, orderDate, orderTime) VALUES
(1,'2001-02-14','18:30:00'),
(2,'2002-02-14','19:30:00'),
(3,'2003-02-14','18:00:00'),
(4,'2007-05-14', '08:43:12'),
(5, '2014-11-21', '07:01:11'),
(6,'2019-07-02', '02:39:57'),
(7, '1986-06-26', '23:52:49'),
(8, '1999-07-27', '19:04:43'),
(9, '2016-08-02', '17:21:27'),
(10,'2017-09-02', '17:25:42');


INSERT INTO Payment(orderID, paymentType, paymentDate) VALUES
(1,'cash','2001-02-14'),
(2,'card','2001-02-14'),
(3,'card','2001-03-14'),
(4,'cash','2002-04-15'),
(5,'card','2001-08-14'),
(6,'cash','2002-06-14');

INSERT INTO CardPayment(paymentID, cardnum, expirationDate, cvv, cardtype) VALUES
(2,123456789,'2010-02-14',123,'debit'),
(3,987654321,'2009-03-14',456,'credit'),
(5,1029384756,'2001-08-14',789,'debit');
 
Insert into Cash(paymentID) values
(1),
(4),
(6);
 
Insert into PhoneOrder(orderID) VALUES
(2),
(4);
 
INSERT into WebOrder(orderID) values
(3),
(5);
 
Insert into EatInOrder(orderID, numGuest, stID) values
(1,4, 1),
(6,2, 2);

INSERT INTO OrderDetails(menuType, menuItemName, orderID, quantity) VALUES
('Evening', 'Salmon Curry', 1, 1),
('Evening', 'Steak Wrap', 1, 1),
('Evening', 'Chicken Wings', 1, 2),
('Lunch', 'Steak Wrap', 2, 3),
('Lunch', 'Sweet & Sour Chicken', 2, 1),
('Lunch', 'Cucumber Sandwiches', 2, 1),
('Lunch', 'Tacos', 2, 1),
('Evening', 'Scallop Fries', 3, 2),
('Children', 'Scallop Fries', 4, 1),
('Lunch', 'Sweet & Sour Chicken', 4, 3),
('Sunday Brunch Buffet', 'Spaghetti Bolognese', 5, 6),
('Sunday Brunch Buffet', 'Salmon Curry', 5, 1);








SELECT * FROM SeatingTable;
SELECT * FROM WorkShift;
SELECT * FROM WorkSchedule;
SELECT * FROM Expertise;
SELECT * FROM Mentorship;
SELECT * FROM TriggerDebug;