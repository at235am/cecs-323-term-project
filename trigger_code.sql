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
		SELECT SUM(price * quantity)
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

CREATE TRIGGER INSERT_WorkSchedule_employee_cannot_work_both_shifts_per_day
BEFORE INSERT ON
WorkSchedule FOR EACH ROW
BEGIN
	DECLARE v_dateOfShift DATE;
    DECLARE v_shiftType VARCHAR(50);
	DECLARE v_rowcount INT;
    DECLARE msg varchar(255);
    
	SELECT shiftType
    INTO v_shiftType
    FROM WorkShift
    WHERE shiftID = new.shiftID;
    
    SELECT dateOfShift
    INTO v_dateOfShift
    FROM WorkShift
    WHERE shiftID = new.shiftID;
	
	SELECT count(dateOfShift)
    INTO v_rowcount
    FROM WorkShift NATURAL JOIN WorkSchedule
    WHERE empID = new.empID AND dateOfShift = v_dateOfShift;
    
    IF v_rowcount = 1 THEN
		SET msg = concat('Employee with empID=', cast(new.empID as char), ' is already scheduled on ', cast(v_dateOfShift as char), ' for the ', cast(v_shiftType as char), ' shift');
        SIGNAL SQLSTATE '45000' SET message_text = msg;
    END IF;
END $$

CREATE TRIGGER INSERT_happyHourDiscount
BEFORE INSERT ON
Orders FOR EACH ROW
BEGIN
	if new.ordertime>='17:00:00' and new.ordertime <='18:00:00' then
		set new.happyHourDiscount = true;
	end if;
END $$

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