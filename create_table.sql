DROP TABLE IF EXISTS TriggerDebug;

DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS ChowMein;
DROP TABLE IF EXISTS EggFooYoung;
DROP TABLE IF EXISTS ChopSuey;
DROP TABLE IF EXISTS Appetizer;
DROP TABLE IF EXISTS Soup;
DROP TABLE IF EXISTS MeatEntree;
DROP TABLE IF EXISTS MenuMenuItem;
DROP TABLE IF EXISTS Menu;
------------------------------------------------
DROP TABLE IF EXISTS Cash;
DROP TABLE IF EXISTS CardPayment;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS EatInOrder;
DROP TABLE IF EXISTS PhoneOrder;
DROP TABLE IF EXISTS WebOrder;
DROP TABLE IF EXISTS Orders;
------------------------------------------------
DROP TABLE IF EXISTS MimingsMoney;
DROP TABLE IF EXISTS ContactInfo;
DROP TABLE IF EXISTS PrivateCustomer;
DROP TABLE IF EXISTS CorporateCustomer;
DROP TABLE IF EXISTS Customer;
------------------------------------------------
DROP TABLE IF EXISTS EmployeeOfTheMonth;
------------------------------------------------
DROP TABLE IF EXISTS SeatingTable;
DROP TABLE IF EXISTS WorkSchedule;
DROP TABLE IF EXISTS WorkShift;
DROP TABLE IF EXISTS ShiftDetails;
------------------------------------------------
DROP TABLE IF EXISTS Mentorship;
DROP TABLE IF EXISTS Expertise;
DROP TABLE IF EXISTS MenuItem;
------------------------------------------------
DROP TABLE IF EXISTS DishBonus;
DROP TABLE IF EXISTS MoraleBonus;
DROP TABLE IF EXISTS Tip;
------------------------------------------------
DROP TABLE IF EXISTS CookingStation;
DROP TABLE IF EXISTS Station;
------------------------------------------------
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS Recipe;
------------------------------------------------
DROP TABLE IF EXISTS Dishwasher;
DROP TABLE IF EXISTS MaitreD;
DROP TABLE IF EXISTS Waiter;
------------------------------------------------
DROP TABLE IF EXISTS Manager;
------------------------------------------------
DROP TABLE IF EXISTS LineCook;
DROP TABLE IF EXISTS SousChef;
DROP TABLE IF EXISTS HeadChef;
DROP TABLE IF EXISTS Chef;
------------------------------------------------
DROP TABLE IF EXISTS FullTimeEmployee;
DROP TABLE IF EXISTS PartTimeEmployee;
DROP TABLE IF EXISTS Employee;
------------------------------------------------
-- use this table if you need to debug a trigger
-- just INSERT INTO TriggerDebug(id, tableName, ...) VALUES (variableYouWannaPrint, ...) inside the trigger
-- ex:
-- INSERT INTO TriggerDebug(tableName, rowOrPk, message) VALUES 
--    ('', cast(new.orderID as char), '');
CREATE TABLE TriggerDebug
(
	id INT NOT NULL AUTO_INCREMENT,
    tableName VARCHAR(50) DEFAULT NULL,
    rowOrPK VARCHAR(50) DEFAULT NULL,
    message VARCHAR(255) DEFAULT NULL,
    CONSTRAINT  PK_TriggerDebug 	PRIMARY KEY (id)
);

CREATE TABLE Employee
(
    empID   	INT     		NOT NULL AUTO_INCREMENT,
    firstName 	VARCHAR(30)		NOT NULL,
    lastName    VARCHAR(30)		NOT NULL,
	birthdate   DATE     		NOT NULL,
	hiredDate   DATE     		NOT NULL,
    CONSTRAINT  PK_Employee 	PRIMARY KEY (empID),
    CONSTRAINT 	UC_Employee		UNIQUE (firstName, lastName, birthdate)
);

CREATE TABLE EmployeeOfTheMonth
(
    empID   				INT     		NOT NULL,
    month 					ENUM('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')		NOT NULL,
    year    				SMALLINT		NOT NULL,
	notableAchievement   	VARCHAR(50)     NOT NULL,
    CONSTRAINT  PK_EmployeeOfTheMonth 				PRIMARY KEY (month, year),
	CONSTRAINT  FK_Employee_EmployeeOfTheMonth		FOREIGN KEY (empID) 	REFERENCES Employee (empID)
);

CREATE TABLE FullTimeEmployee
(
    empID   		INT     		NOT NULL,
    weeklySalary 	DECIMAL(9, 2)	NOT NULL,
    CONSTRAINT  PK_FullTimeEmployee 			PRIMARY KEY (empID),
    CONSTRAINT 	FK_Employee_FullTimeEmployee	FOREIGN KEY (empID) 	REFERENCES Employee (empID)
);

CREATE TABLE PartTimeEmployee
(
    empID   	INT     		NOT NULL,
    hourlyRate 	DECIMAL(5, 2)	NOT NULL,
    CONSTRAINT  PK_PartTimeEmployee 			PRIMARY KEY (empID),
    CONSTRAINT 	FK_Employee_PartTimeEmployee	FOREIGN KEY (empID) 	REFERENCES Employee (empID)
);

CREATE TABLE Manager
(
    empID   				INT     		NOT NULL,
    supervisorCredentials 	VARCHAR(100),
    CONSTRAINT  PK_Manager 						PRIMARY KEY (empID),
    CONSTRAINT 	FK_FullTimeEmployee_Manager		FOREIGN KEY (empID) 	REFERENCES FullTimeEmployee (empID)
);

CREATE TABLE Chef
(
    empID   				INT     		NOT NULL,
    favoriteFoodToCook   	VARCHAR(30),
    CONSTRAINT  PK_Chef 					PRIMARY KEY (empID),
    CONSTRAINT 	FK_FullTimeEmployee_Chef	FOREIGN KEY (empID) 	REFERENCES FullTimeEmployee (empID)
);

CREATE TABLE HeadChef
(
    empID   					INT     		NOT NULL,
    headChefHatSize   				ENUM('XS', 'S', 'M', 'L', 'XL'),
    CONSTRAINT  PK_HeadChef 		PRIMARY KEY (empID),
    CONSTRAINT 	FK_Chef_HeadChef	FOREIGN KEY (empID) 	REFERENCES Chef (empID)
);

CREATE TABLE SousChef
(
    empID   		INT     		NOT NULL,
    level   		ENUM('I', 'II', 'III', 'IV'),
    CONSTRAINT  PK_SousChef 		PRIMARY KEY (empID),
    CONSTRAINT 	FK_Chef_SousChef	FOREIGN KEY (empID) 	REFERENCES Chef (empID)
);

CREATE TABLE LineCook
(
    empID   			INT     		NOT NULL,
    CONSTRAINT  PK_LineCook 		PRIMARY KEY (empID),
    CONSTRAINT 	FK_Chef_LineCook	FOREIGN KEY (empID) 	REFERENCES Chef (empID)
);

CREATE TABLE Dishwasher
(
    empID   	INT     		NOT NULL,
    CONSTRAINT  PK_Dishwasher 		PRIMARY KEY (empID),
    CONSTRAINT 	FK_PTE_Dishwasher	FOREIGN KEY (empID) 	REFERENCES PartTimeEmployee (empID)
);

CREATE TABLE MaitreD
(
    empID   	INT     		NOT NULL,
    CONSTRAINT  PK_MaitreD 		PRIMARY KEY (empID),
    CONSTRAINT 	FK_PTE_MaitreD	FOREIGN KEY (empID) 	REFERENCES PartTimeEmployee (empID)
);

CREATE TABLE Waiter
(
    empID   	INT     		NOT NULL,
    CONSTRAINT  PK_Waiter 		PRIMARY KEY (empID),
    CONSTRAINT 	FK_PTE_Waiter	FOREIGN KEY (empID) 	REFERENCES PartTimeEmployee (empID)
);

CREATE TABLE Recipe
(
	recID   		INT     		NOT NULL AUTO_INCREMENT,
	empID   		INT     		NOT NULL,
    recipeName   	VARCHAR(50)     NOT NULL,
    CONSTRAINT  PK_Recipe 			PRIMARY KEY (recID),
	CONSTRAINT 	UC_Recipe			UNIQUE (empID, recipeName),
    CONSTRAINT 	FK_HeadChef_Recipe	FOREIGN KEY (empID) 	REFERENCES HeadChef (empID)
);

CREATE TABLE Ingredients
(
	recID   			INT     		NOT NULL,
	ingredientName   	VARCHAR(50)		NOT NULL,
    quantity   			INT     		NOT NULL,
    CONSTRAINT  PK_Ingredients 			PRIMARY KEY (recID, ingredientName),
    CONSTRAINT 	FK_Recipe_Ingredients	FOREIGN KEY (recID) 	REFERENCES Recipe (recID)
);

CREATE TABLE Station
(
	stationName   			VARCHAR(50)			NOT NULL,
    responsibilityDesc   	VARCHAR(100)     	NOT NULL,
    CONSTRAINT  PK_Station 				PRIMARY KEY (stationName)
);

CREATE TABLE CookingStation
(
	empID   			INT     			NOT NULL,
	stationName   		VARCHAR(50)			NOT NULL,
    dateStationed   	DATE     			NOT NULL,
    CONSTRAINT  PK_CookingStation 			PRIMARY KEY (empID, stationName, dateStationed),
    CONSTRAINT 	FK_LineCook_CookingStation	FOREIGN KEY (empID) 	REFERENCES LineCook (empID),
	CONSTRAINT 	FK_Station_CookingStation	FOREIGN KEY (stationName) 	REFERENCES Station (stationName)
);

CREATE TABLE DishBonus
(
	empID   			INT				NOT NULL,
    dateWorked   		DATE     		NOT NULL,
    dishesWashed 		INT				NOT NULL,
    extraDishMoney		DECIMAL(8, 2) DEFAULT 0, -- dervied attr
    CONSTRAINT  	PK_DishBonus 				PRIMARY KEY (empID, dateWorked),
    CONSTRAINT		FK_Dishwasher_DishBonus 	FOREIGN KEY (empID) 		REFERENCES Dishwasher (empID)
);

CREATE TABLE MoraleBonus
(
	empID   			INT			NOT NULL,
    month   			ENUM('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')     NOT NULL,
    year 				SMALLINT	NOT NULL,
    bonusAmount			DECIMAL(8, 2) DEFAULT 0, -- dervied attr
    CONSTRAINT  	PK_MoraleBonus 			PRIMARY KEY (empID, month, year),
    CONSTRAINT		FK_Waiter_MoraleBonus 	FOREIGN KEY (empID) 	REFERENCES Waiter (empID)
);

CREATE TABLE Tip
(
	empID   			INT				NOT NULL,
    dateOfTip 			DATE			NOT NULL,
    timeOfTip			TIME			NOT NULL,
    tipAmount   		DECIMAL(8, 2)	NOT NULL, 
    CONSTRAINT  	PK_Tip 			PRIMARY KEY (empID, dateOfTip, timeOfTip),
    CONSTRAINT		FK_Waiter_Tip 	FOREIGN KEY (empID) 		REFERENCES Waiter (empID)
);

CREATE TABLE ShiftDetails
(
    shiftType   ENUM('Morning', 'Evening')     	NOT NULL,
    startTime 	TIME            				NOT NULL,
	endTime 	TIME            				NOT NULL,
    CONSTRAINT  PK_ShiftDetails 	PRIMARY KEY (shiftType)
);

CREATE TABLE WorkShift
(
    shiftID   	INT     						NOT NULL AUTO_INCREMENT,
    shiftType   ENUM('Morning', 'Evening')     	NOT NULL,
    dateOfShift DATE            				NOT NULL,
	busyness   	ENUM('High', 'Medium', 'Low')   NOT NULL,
    CONSTRAINT  PK_WorkShift 				PRIMARY KEY (shiftID),
    CONSTRAINT 	UC_Employee					UNIQUE (shiftType, dateOfShift),
    CONSTRAINT  FK_ShiftDetails_WorkShift	FOREIGN KEY (shiftType) 	REFERENCES ShiftDetails (shiftType)
);

CREATE TABLE WorkSchedule
(
    empID     		INT             NOT NULL,
    shiftID   		INT     		NOT NULL,
    hoursWorked  	DECIMAL(4, 2)   DEFAULT 8,
    CONSTRAINT  PK_WorkSchedule 	PRIMARY KEY (empID, shiftID),
    CONSTRAINT  FK_WorkShift_WorkSchedule	FOREIGN KEY (shiftID) 	REFERENCES WorkShift (shiftID),
	CONSTRAINT  FK_Employee_WorkSchedule	FOREIGN KEY (empID) 	REFERENCES Employee (empID)
);

CREATE TABLE SeatingTable
(
	stID			INT			NOT NULL	AUTO_INCREMENT,
	shiftID			INT			NOT NULL,
    tableNum 		TINYINT		NOT NULL,
	empID   		INT			NOT NULL,
    maxOccupancy	TINYINT		NOT NULL,
    CONSTRAINT  	PK_SeatingTable 			PRIMARY KEY (stID),
    CONSTRAINT 		UC_SeatingTable				UNIQUE (shiftID, tableNum),
    CONSTRAINT		FK_Waiter_SeatingTable 		FOREIGN KEY (empID) 	REFERENCES Waiter (empID),
    CONSTRAINT		FK_WorkShift_SeatingTable 	FOREIGN KEY (shiftID) 	REFERENCES WorkShift (shiftID)
);

CREATE TABLE MenuItem
(
    menuItemName   	VARCHAR(30)     										NOT NULL,
    spiciness   	ENUM('Mild', 'Tangy', 'Piquant', 'Hot', 'Oh My God') 	NOT NULL,
    basePrice   	DECIMAL(6, 2)   										NOT NULL DEFAULT 0,
    CONSTRAINT  	PK_MenuItem 			PRIMARY KEY (menuItemName)
);

CREATE TABLE Expertise
(
	empID 			INT				NOT NULL,
    menuItemName   	VARCHAR(30)     NOT NULL,
    CONSTRAINT  	PK_Expertise 			PRIMARY KEY (empID, menuItemName),
    CONSTRAINT		FK_SousChef_Expertise 	FOREIGN KEY (empID) 		REFERENCES SousChef (empID),
    CONSTRAINT		FK_MenuItem_Expertise 	FOREIGN KEY (menuItemName) 	REFERENCES MenuItem (menuItemName)
);

CREATE TABLE Mentorship
(
	studentID 			INT				NOT NULL,
	mentorID   			INT				NOT NULL,
    menuItemName   		VARCHAR(30)     NOT NULL,
    startDate			DATE			NOT NULL,
    endDate   			DATE			NOT NULL, 
    CONSTRAINT  	PK_Mentorship 				PRIMARY KEY (studentID, mentorID, menuItemName, startDate),
    CONSTRAINT		FK_SousChef_Mentorship 		FOREIGN KEY (studentID) 				REFERENCES SousChef (empID),
	CONSTRAINT		FK_Expertise_Mentorship 	FOREIGN KEY (mentorID, menuItemName) 	REFERENCES Expertise (empID, menuItemName)
);
---------------
CREATE TABLE Customer
(
   customerID       INT 			NOT NULL AUTO_INCREMENT, 
   cFirstName       VARCHAR(30)		NOT NULL,
   cLastName		VARCHAR(30) 	NOT NULL,
   cDOB				DATE     		NOT NULL,
   CONSTRAINT       PK_Customer 	PRIMARY KEY (customerID),
   CONSTRAINT 	    UC_Customer		UNIQUE (cFirstName, cLastName, cDOB)
);

CREATE TABLE PrivateCustomer
(
	customerID     INT NOT NULL,
    CONSTRAINT     PK_PrivateCustomer    		PRIMARY KEY(customerID),
    CONSTRAINT	   FK_Customer_PrivateCustomer 	FOREIGN KEY (customerID) 	REFERENCES Customer (customerID)
);

CREATE TABLE CorporateCustomer
(
	customerID     INT NOT NULL,
    orgName	       VARCHAR(30) NOT NULL,
	deptName	   VARCHAR(30) NOT NULL,
    officeAddress  VARCHAR(60) NOT NULL,
    CONSTRAINT     PK_CorporateCustomer 			PRIMARY KEY(customerID),
    CONSTRAINT 	   UC_CorporateCustomer				UNIQUE (orgName, deptName),
    CONSTRAINT     FK_Customer_CorporateCustomer 	FOREIGN KEY (customerID)	REFERENCES Customer (customerID)
);

CREATE TABLE MimingsMoney
(
	customerID     INT NOT NULL,
    creditEarned   INT DEFAULT 0,
    creditSpent    DECIMAL(10, 2) DEFAULT 0,
    currentBalance DECIMAL(10, 2) DEFAULT 0,
    CONSTRAINT     PK_MimingMoney  			PRIMARY KEY(customerID),
    CONSTRAINT     FK_Customer_MimingMoney FOREIGN KEY (customerID)		REFERENCES Customer (customerID)
);

CREATE TABLE ContactInfo
(
	customerID	     INT NOT NULL,
    email 		     VARCHAR(50), 
    snailMailAddress VARCHAR(100),
    phone            VARCHAR(20),
    CONSTRAINT      PK_ContactInfo 				PRIMARY KEY(customerID,email),
    CONSTRAINT      FK_Customer_ContactInfo 	FOREIGN KEY (customerID)		REFERENCES Customer (customerID)
);
-----------------------------------------------------------------------------------------------
create table Menu (
    menuType 					ENUM('Evening','Lunch','Sunday Brunch Buffet','Children') NOT NULL,
    priceModifierPercentage 	DOUBLE 		NOT NULL DEFAULT 0, -- in percentages (ex. 20 means 20% off)
    startTime 					TIME 		NOT NULL,
    endTime 					TIME 		NOT NULL,
    dateCreated 				date 		NOT NULL,
    CONSTRAINT PK_Menu primary key(menuType)
);

create table MenuMenuItem (
    menuType 		ENUM('Evening','Lunch','Sunday Brunch Buffet','Children'),
    menuItemName 	varchar(50) 	NOT NULL,
    portionSize 	varchar(50)		NOT NULL,
    price 			DECIMAL(6, 2) 	DEFAULT 0, -- derived attribute based on a Menu's menuPriceModifier
    CONSTRAINT	PK_MenuMenuItem				primary key (menuType, menuItemName),
    CONSTRAINT	FK_Menu_MenuMenuItem		foreign key (menuType) 		references Menu(menuType),
    CONSTRAINT	FK_MenuItem_MenuMenuItem	foreign key (menuItemName) 	references MenuItem(menuItemName)
);

create table Appetizer (
    menuItemName 	varchar(50),
    CONSTRAINT 	PK_Appetizer			primary key(menuItemName),
    CONSTRAINT	FK_MenuItem_Appetizer	foreign key(menuItemName) references MenuItem(menuItemName)
);

create table Soup (
    menuItemName 	varchar(50),
    broth 			varchar(50), 
    CONSTRAINT	PK_Soup				primary key(menuItemName),
    CONSTRAINT	FK_MenuItem_Soup	foreign key(menuItemName) references MenuItem(menuItemName)
);

create table MeatEntree (
    menuItemName 		varchar(50),
    entreeSelection 	ENUM('Chef Special', 'Pork', 'Chicken', 'Beef', 'Seafood', 'Vegetable'),
    CONSTRAINT	PK_MeatEntrees				primary key (menuItemName),
    CONSTRAINT	FK_MenuItem_MeatEntree		foreign key (menuItemName) references MenuItem(menuItemName)
);

create table ChowMein (
    menuItemName 		varchar(50),
    typeOfNoodles 		varchar(50),
    CONSTRAINT	PK_ChowMein					primary key (menuItemName),
    CONSTRAINT	FK_MenuItem_ChowMein		foreign key (menuItemName) references MenuItem(menuItemName)
);

create table EggFooYoung(
    menuItemName 	varchar(50),
    omeletStyle 	varchar(50),
    CONSTRAINT	PK_EggFooYoung				primary key (menuItemName),
    CONSTRAINT	FK_MenuItem_EggFooYoung	foreign key (menuItemName) references MenuItem(menuItemName)
);

create table ChopSuey(
    menuItemName 	varchar(50),
    typeOfRice 		varchar(50),
    CONSTRAINT	PK_ChopSuey					primary key (menuItemName),
    CONSTRAINT	FK_MenuItem_ChopSuey		foreign key (menuItemName) references MenuItem(menuItemName)
);

-----------------------------------------------------------------------------------------------
CREATE TABLE Orders
(
	customerID 			int 			not null,
	orderID 			INT 			NOT NULL auto_increment,
	orderDate 	 		DATE 			NOT NULL,
	orderTime 			TIME 			NOT NULL,
	happyHourDiscount 	boolean 		DEFAULT false, -- derived attributes
	total 			DECIMAL(8,2) 	DEFAULT 0, -- derived attributes
	CONSTRAINT PK_Orders 			PRIMARY KEY (orderID),
	CONSTRAINT FK_Customer_Orders 	foreign key (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE OrderDetails
(
	menuType 		ENUM('Evening','Lunch','Sunday Brunch Buffet','Children') 	NOT NULL,
    menuItemName 	varchar(50) 													NOT NULL,
	orderID 		INT 															NOT NULL,
	quantity 	 	INT 															NOT NULL,
	CONSTRAINT PK_OrderDetails 					PRIMARY KEY (menuType, menuItemName, orderID),
	CONSTRAINT FK_Orders_OrderDetails 			foreign key (orderID) 					REFERENCES Orders(orderID),
    CONSTRAINT FK_MenuMenuItem_OrderDetails 	foreign key (menuType, menuItemName) 	REFERENCES MenuMenuItem(menuType, menuItemName)
);

create table WebOrder
(
	orderID int not null,
	CONSTRAINT PK_WebOrder 			Primary Key (orderID),
	CONSTRAINT FK_Orders_WebOrder 	foreign key (orderID) REFERENCES Orders (orderID)
);

create table PhoneOrder
(
	orderID int not null,
	CONSTRAINT PK_PhoneOrder 			Primary Key (orderID),
	CONSTRAINT FK_Orders_PhoneOrder 	foreign key (orderID) REFERENCES Orders (orderID)
);

create table EatInOrder
(
	orderID 	int 	not null,
	numGuest 	int 	not null,
	stID		INT		NOT NULL,	
	CONSTRAINT PK_EatInOrder 				primary key(orderID),
	CONSTRAINT FK_Orders_EatInOrder 		foreign key(orderID) 	References Orders (OrderID),
    CONSTRAINT FK_SeatingTable_EatInOrder 	foreign key(stID) 		References SeatingTable (stID)
);

CREATE TABLE Payment
(
	paymentID 			int not null auto_increment,
	orderID			 	int NOT NULL,
	paymentType 		varchar(20) not null,
	paymentDate 		DATE not null,
	CONSTRAINT PK_Payment 			PRIMARY KEY (paymentID),
	CONSTRAINT FK_Orders_Payment 	foreign key (orderID) 		REFERENCES Orders (orderID),
	CONSTRAINT UC_PAYMENT 			UNIQUE(orderID)
);

create table CardPayment
(
	paymentID 			int NOT NULL,
	cardnum 			int NOT NULL,
	expirationDate 		Date not null,
	cvv 				int not null,
	cardtype 			varchar(20),
	CONSTRAINT PK_CardPayment 			PRIMARY KEY (paymentID),
	CONSTRAINT FK_Payment_CardPayment 	foreign key (paymentID) REFERENCES Payment (paymentID)
);

create table Cash
(
	paymentID int NOT NULL,
	CONSTRAINT PK_Cash 				Primary Key (paymentID),
	CONSTRAINT FK_Payment_Cash 		foreign key (paymentID) REFERENCES Payment (paymentID)
);

DELIMITER $$

CREATE TRIGGER INSERT_OrderDetails_ordering_from_valid_menu
BEFORE INSERT ON
OrderDetails FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
	
	DECLARE v_orderdate DATE;
	DECLARE v_ordertime TIME;
    DECLARE v_menustarttime TIME;
    DECLARE v_menuendtime TIME;
    
	SELECT orderDate
    INTO v_orderdate
    FROM Orders
    WHERE orderID = new.orderID;
    
	SELECT orderTime
    INTO v_ordertime
    FROM Orders
    WHERE orderID = new.orderID;
    
    SELECT startTime
    INTO v_menustarttime
    FROM Menu
    WHERE menuType = new.menuType;
    
	SELECT endTime
    INTO v_menuendtime
    FROM Menu
    WHERE menuType = new.menuType;
    
    -- if the orderTime is out of the menuType's range
	IF v_ordertime < v_menustarttime OR v_ordertime > v_menuendtime THEN 
		SET msg = concat('Trouble @ [', cast(new.menuType as char), ', ',  cast(new.menuItemName as char), ', ', cast(new.orderID as char),']: orderTime is out of the menuType\'s range');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF;
    
    IF new.menuType = 'Sunday Brunch Buffet' THEN
		-- if the day of the week of the orderDate is Sunday (1)
		IF NOT dayofweek(v_orderDate) = 1 THEN
			SET msg = concat('Trouble @ [', cast(new.menuType as char), ', ',  cast(new.menuItemName as char), ', ', cast(new.orderID as char), ']: the orderDate is not a Sunday');
			SIGNAL SQLSTATE '45000' SET message_text = msg;
        END IF;
    END IF;
    
END $$

CREATE TRIGGER INSERT_MenuMenuItem_price
BEFORE INSERT ON
MenuMenuItem FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);
	DECLARE v_spiciness VARCHAR(50);
	DECLARE v_pricemodifierpercentage DOUBLE;
	DECLARE v_baseprice DECIMAL(6,2);
    
	SELECT spiciness
    INTO v_spiciness
    FROM MenuItem
    WHERE menuItemName = new.menuItemName;
    
    IF new.menuType = 'Children' AND NOT v_spiciness = 'Mild' THEN
		SET msg = concat('This item is too spicy for the Children Menu: ', cast(new.menuItemName as char));
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF;
    
    SELECT priceModifierPercentage
    INTO v_pricemodifierpercentage
    FROM Menu
    WHERE menuType = new.menuType;
    
	SELECT basePrice
    INTO v_baseprice
    FROM MenuItem
    WHERE menuItemName = new.menuItemName;
	
	SET new.price = v_baseprice * ((100 - v_pricemodifierpercentage)/100);
END $$


CREATE TRIGGER INSERT_OrderDetails_must_update_Orders
AFTER INSERT ON
OrderDetails FOR EACH ROW
BEGIN
	DECLARE newtotal DECIMAL(6,2);
    DECLARE v_happyhourdiscount BOOLEAN;
	DECLARE v_orderDate DATE;
    
    SELECT orderDate
    INTO v_orderDate
    FROM Orders
    WHERE orderID = new.orderID;
    
    IF dayofweek(v_orderDate) = 1 THEN
        UPDATE Orders
		SET Orders.total = 20.99
		WHERE orderID = new.orderID;
    ELSE
    
		-- AFTER the new insert associating a MenuMenuItem with an Order
		-- find the total for that specific Order based on the price of each MenuMenuItem
		SELECT SUM(price)
		INTO newtotal
		FROM MenuMenuItem NATURAL JOIN OrderDetails
		WHERE orderID = new.orderID;
		
		-- find if the specific order has the happyhourdiscount
		SELECT happyHourDiscount
		INTO v_happyhourdiscount
		FROM Orders
		WHERE orderID = new.orderID;
		
		-- apply happy hour discount if available
		IF v_happyhourdiscount = true THEN
			SET newtotal = 0.5 * newtotal;
		END IF;
		
		-- update the Orders table with the correct total
		-- THIS MEANS THAT QUERYING FOR SUM(PRICE) WILL GIVE AN INCORRECT RESULT IF 
		-- THERE IS A HAPPY HOUR DISCOUNT
		UPDATE Orders
		SET Orders.total = newtotal
		WHERE orderID = new.orderID;
    END IF;
    
END $$

create TRIGGER INSERT_happyHourDiscount
BEFORE INSERT ON
Orders FOR EACH ROW
BEGIN
	if new.ordertime>='17:00:00' and new.ordertime <='18:00:00' then
		set new.happyHourDiscount = true;
	end if;
end $$

CREATE TRIGGER UPDATE_Orders_causes_MimingsMoney_Orders
AFTER UPDATE
ON Orders FOR EACH ROW
BEGIN
	DECLARE v_totalspentacrossallorders DOUBLE;
    DECLARE v_creditEarned INT;
	DECLARE v_creditSpent DOUBLE;
    DECLARE v_currentBalance DOUBLE;
    
	SELECT sum(total)
    INTO v_totalspentacrossallorders
    FROM Orders NATURAL JOIN Customer
    WHERE customerID = new.customerID;
    
    SELECT creditSpent
    INTO v_creditSpent
    FROM MimingsMoney
    WHERE customerID = new.customerID;
    
    SET v_creditEarned = v_totalspentacrossallorders * 0.10;
    SET v_currentBalance = v_creditEarned - v_creditSpent;
    
    
	UPDATE MimingsMoney
	SET creditEarned = v_creditEarned 
	WHERE customerID = new.customerID;
    
	UPDATE MimingsMoney
	SET currentBalance = v_currentBalance
	WHERE customerID = new.customerID;

END;

CREATE TRIGGER INSERT_Mentorship_triggers_INSERT_Expertise
AFTER INSERT
ON Mentorship FOR EACH ROW
BEGIN
	-- checks if the startDate and endDate being insert are legitimate dates relative to each other
    -- i.e. the startDate has to be before the endDate
	DECLARE msg VARCHAR(255);
    IF new.startDate > new.endDate THEN
        SET msg = concat('Do you have a time machine? startDate=', cast(new.startDate as char), ' > endDate=', cast(new.endDate as char));
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF;

	-- if the endDate has already passed (so mentionship is complete)
    -- then and only then will the student SousChef be considered an Expert
    IF new.endDate < CURRENT_DATE() THEN
		INSERT INTO Expertise(empID, menuItemName) VALUES (new.studentID, new.menuItemName);
    END IF;
END $$

-- ensures that there exists a waiter with {empID} within the shift that the table is assigned
CREATE TRIGGER INSERT_Waiter_SeatingTable
AFTER INSERT
ON SeatingTable FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
    SELECT COUNT(empID)
    INTO rowcount
    FROM WorkSchedule
    WHERE shiftID = new.shiftID AND empID = new.empID;
    
	IF rowcount = 0 THEN
		SET msg = concat('The waiter w/ empID=', cast(new.empID as char), ' is not scheduled to work the WorkShift w/ shiftID=', cast(new.shiftID as char));
		SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER DERIVED_ATTR_DishBonus
BEFORE INSERT
ON DishBonus FOR EACH ROW
BEGIN
    IF new.dishesWashed > 100 THEN
        SET new.extraDishMoney = new.dishesWashed - 100;
	ELSE
		SET new.extraDishMoney = 0;
    END IF; 
END $$



CREATE TRIGGER DERIVED_ATTR_MoraleBonus
BEFORE INSERT
ON MoraleBonus FOR EACH ROW
BEGIN
    DECLARE totalTipForTheMonth DECIMAL(6,2);
    
    SELECT SUM(tipAmount)
    INTO totalTipForTheMonth
 	FROM Waiter NATURAL JOIN Tip
 	WHERE empID = new.empID AND month(dateOfTip) = new.month AND year(dateOfTip) = new.year;

	IF totalTipForTheMonth IS NOT NULL THEN
        SET new.bonusAmount = totalTipForTheMonth * 0.10;
	ELSE
		SET new.bonusAmount = 0;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_Cash
BEFORE INSERT
ON Cash FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
	SELECT COUNT(paymentID)
    INTO rowcount
    FROM CardPayment
    WHERE paymentID = new.paymentID;

    IF rowcount = 1 THEN
        SET msg = concat('InsertTriggerError: Payment with paymentID=', cast(new.paymentID as char), ' is already a CardPayment.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_CardPayment
BEFORE INSERT
ON CardPayment FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
	SELECT COUNT(paymentID)
    INTO rowcount
    FROM Cash
    WHERE paymentID = new.paymentID;

    IF rowcount = 1 THEN
        SET msg = concat('InsertTriggerError: Payment with paymentID=', cast(new.paymentID as char), ' is already a Cash.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_WebOrder
BEFORE INSERT
ON WebOrder FOR EACH ROW
BEGIN
	DECLARE rowcount_PhoneOrder INT;
    DECLARE rowcount_EatInOrder INT;
    declare msg varchar(128);
    
	SELECT COUNT(orderID)
    INTO rowcount_PhoneOrder
    FROM PhoneOrder
    WHERE orderID = new.orderID;
    
	SELECT COUNT(orderID)
    INTO rowcount_EatInOrder
    FROM EatInOrder
    WHERE orderID = new.orderID;

    IF rowcount_PhoneOrder = 1 THEN
        SET msg = concat('InsertTriggerError: Order with orderID=', cast(new.orderID as char), ' is already a PhoneOrder.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_EatInOrder = 1 THEN
		SET msg = concat('InsertTriggerError: Order with orderID=', cast(new.orderID as char), ' is already a EatInOrder.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_PhoneOrder
BEFORE INSERT
ON PhoneOrder FOR EACH ROW
BEGIN
	DECLARE rowcount_WebOrder INT;
    DECLARE rowcount_EatInOrder INT;
    declare msg varchar(128);
    
	SELECT COUNT(orderID)
    INTO rowcount_WebOrder
    FROM WebOrder
    WHERE orderID = new.orderID;
    
	SELECT COUNT(orderID)
    INTO rowcount_EatInOrder
    FROM EatInOrder
    WHERE orderID = new.orderID;

    IF rowcount_WebOrder = 1 THEN
        SET msg = concat('InsertTriggerError: Order with orderID=', cast(new.orderID as char), ' is already a WebOrder.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_EatInOrder = 1 THEN
		SET msg = concat('InsertTriggerError: Order with orderID=', cast(new.orderID as char), ' is already a EatInOrder.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_EatInOrder
BEFORE INSERT
ON EatInOrder FOR EACH ROW
BEGIN
	DECLARE rowcount_WebOrder INT;
    DECLARE rowcount_PhoneOrder INT;
    declare msg varchar(128);
    
	SELECT COUNT(orderID)
    INTO rowcount_WebOrder
    FROM WebOrder
    WHERE orderID = new.orderID;
    
	SELECT COUNT(orderID)
    INTO rowcount_PhoneOrder
    FROM PhoneOrder
    WHERE orderID = new.orderID;

    IF rowcount_WebOrder = 1 THEN
        SET msg = concat('InsertTriggerError: Order with orderID=', cast(new.orderID as char), ' is already a WebOrder.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_PhoneOrder = 1 THEN
		SET msg = concat('InsertTriggerError: Order with orderID=', cast(new.orderID as char), ' is already a PhoneOrder.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$


CREATE TRIGGER INSERT_DISJOINT_FullTimeEmployee
BEFORE INSERT
ON FullTimeEmployee FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount
    FROM PartTimeEmployee
    WHERE empID = new.empID;

    IF rowcount = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a PartTimeEmployee.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_PartTimeEmployee
BEFORE INSERT
ON PartTimeEmployee FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount
    FROM FullTimeEmployee
    WHERE empID = new.empID;

    IF rowcount = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a FullTimeEmployee.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_Manager
BEFORE INSERT
ON Manager FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount
    FROM Chef
    WHERE empID = new.empID;

    IF rowcount = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a Chef.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_Chef
BEFORE INSERT
ON Chef FOR EACH ROW
BEGIN
	DECLARE rowcount INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount
    FROM Manager
    WHERE empID = new.empID;

    IF rowcount = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a Manager.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_HeadChef
BEFORE INSERT
ON HeadChef FOR EACH ROW
BEGIN
	DECLARE rowcount_SousChef INT;
    DECLARE rowcount_LineCook INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount_SousChef
    FROM SousChef
    WHERE empID = new.empID;
    
	SELECT COUNT(empID)
    INTO rowcount_LineCook
    FROM LineCook
    WHERE empID = new.empID;

    IF rowcount_SousChef = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a SousChef.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_LineCook = 1 THEN
		SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a LineCook.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_SousChef
BEFORE INSERT
ON SousChef FOR EACH ROW
BEGIN
	DECLARE rowcount_HeadChef INT;
    DECLARE rowcount_LineCook INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount_HeadChef
    FROM HeadChef
    WHERE empID = new.empID;
    
	SELECT COUNT(empID)
    INTO rowcount_LineCook
    FROM LineCook
    WHERE empID = new.empID;

    IF rowcount_HeadChef = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a HeadChef.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_LineCook = 1 THEN
		SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a LineCook.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_LineCook
BEFORE INSERT
ON LineCook FOR EACH ROW
BEGIN
	DECLARE rowcount_HeadChef INT;
    DECLARE rowcount_SousChef INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount_HeadChef
    FROM HeadChef
    WHERE empID = new.empID;
    
	SELECT COUNT(empID)
    INTO rowcount_SousChef
    FROM SousChef
    WHERE empID = new.empID;

    IF rowcount_HeadChef = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a HeadChef.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_SousChef = 1 THEN
		SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a SousChef.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_Dishwasher
BEFORE INSERT
ON Dishwasher FOR EACH ROW
BEGIN
	DECLARE rowcount_MaitreD INT;
    DECLARE rowcount_Waiter INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount_MaitreD
    FROM MaitreD
    WHERE empID = new.empID;
    
	SELECT COUNT(empID)
    INTO rowcount_Waiter
    FROM Waiter
    WHERE empID = new.empID;

    IF rowcount_MaitreD = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a MaitreD.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_Waiter = 1 THEN
		SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a Waiter.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_MaitreD
BEFORE INSERT
ON MaitreD FOR EACH ROW
BEGIN
	DECLARE rowcount_Dishwasher INT;
    DECLARE rowcount_Waiter INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount_Dishwasher
    FROM Dishwasher
    WHERE empID = new.empID;
    
	SELECT COUNT(empID)
    INTO rowcount_Waiter
    FROM Waiter
    WHERE empID = new.empID;

    IF rowcount_Dishwasher = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a Dishwasher.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_Waiter = 1 THEN
		SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a Waiter.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

CREATE TRIGGER INSERT_DISJOINT_Waiter
BEFORE INSERT
ON Waiter FOR EACH ROW
BEGIN
	DECLARE rowcount_Dishwasher INT;
    DECLARE rowcount_MaitreD INT;
    declare msg varchar(128);
    
	SELECT COUNT(empID)
    INTO rowcount_Dishwasher
    FROM Dishwasher
    WHERE empID = new.empID;
    
	SELECT COUNT(empID)
    INTO rowcount_MaitreD
    FROM MaitreD
    WHERE empID = new.empID;

    IF rowcount_Dishwasher = 1 THEN
        SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a Dishwasher.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
	ELSEIF rowcount_MaitreD = 1 THEN
		SET msg = concat('InsertTriggerError: Employee with empID=', cast(new.empID as char), ' is already a MaitreD.');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF; 
END $$

DELIMITER ;