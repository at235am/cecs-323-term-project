//still need to do trigger to stop people from paying in card and check
//still need to make a trigger to stop people from ordering from web,phone,eat in at the same time

Order
DROP TABLE IF EXISTS EatInOrder;
DROP TABLE IF EXISTS PhoneOrder;
DROP TABLE IF EXISTS WebOrder;
DROP TABLE IF EXISTS Cash;
DROP TABLE IF EXISTS cardPayment;
DROP TABLE IF EXISTS PAYMENT;
DROP TABLE IF EXISTS Orders;
 
CREATE TABLE Orders
(
customerID int not null,
orderID INT NOT NULL auto_increment,
orderDate  DATE NOT NULL,
orderTime TIME NOT NULL,
happydiscount boolean not null,
total int NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY (orderID),
CONSTRAINT FK_Orders_Customer foreign key (customerID) REFERENCES Customer(customerID)
 
);
	CREATE TABLE PAYMENT
	(
	orderID int NOT NULL,
	paymentID int not null auto_increment,
	paymenttype varchar(20) not null,
	paymentDate DATE not null,
	
	CONSTRAINT PK_payments PRIMARY KEY (paymentID),
	CONSTRAINT FK_payments_orders foreign key (orderID) REFERENCES Orders (orderID),
	CONSTRAINT UC_PAYMENT UNIQUE(paymenttype,paymentDate,orderID)
	);
	
	create table cardPayment
	(
	paymentID int NOT NULL,
	cardnum int NOT NULL,
	expirationDate Date not null,
	cvv int not null,
	cardtype varchar(20),
	
	CONSTRAINT PK_cardPayment PRIMARY KEY (paymentID),
	CONSTRAINT FK_cardpayment_payments foreign key (paymentID) REFERENCES PAYMENT (paymentID)
	);
	
	create table Cash
	(
	paymentID int NOT NULL,
	constraint PK_paymentID Primary Key (paymentID),
	constraint FK_Cash_payments foreign key (paymentID) REFERENCES PAYMENT (paymentID)
	);
	
	create table WebOrder
	(
  	orderID int not null,
  	CONSTRAINT PK_WebOrder Primary Key (orderID),
  	CONSTRAINT FK_WebOrder_Order foreign key (orderID) REFERENCES Orders (orderID)
	
	);
	
	create table PhoneOrder
	(
   	orderID int not null,
  	CONSTRAINT PK_PhoneOrder Primary Key (orderID),
  	CONSTRAINT FK_PhoneOrder_Order foreign key (orderID) REFERENCES Orders (orderID)
	);
	
	create table EatInOrder
	(
 	orderID int not null,
 	numGuest int not null,
 	
 	CONSTRAINT PK_EatInOrder primary key(orderID),
 	Constraint FK_EatInOrder_Order foreign key(orderID) References Orders (OrderID)
	
	);
 
 
	DELIMITER $$
create TRIGGER happycheck
BEFORE INSERT ON
 Orders FOR EACH ROW
 BEGIN
          	if new.ordertime>='18:00:00' and new.ordertime <='19:00:00'
	then
	set new.happydiscount = true;
	if new.happydiscount= true then set new.total=(((new.total*.1)-new.total)*-1);
   end if;
   else
	set new.happydiscount=false;
	end if;
	
	end $$
  
insert statements examples for Order
 
 
INSERT INTO Orders(customerID,orderDate,orderTime,total) VALUES
(1,'2001-02-14','18:30:00',10.00),
(2,'2002-02-14','19:30:00',10.00),
(3,'2003-02-14','18:00:00',10.00),
(4,'2007-05-14', '08:43:12',  21.36),
 (5, '2014-11-21', '07:01:11',  9.53),
 ( 6,'2019-07-02', '02:39:57',  7.61),
 (7, '1986-06-26', '23:52:49',  12.65),
 (8, '1999-07-27', '19:04:43',  7.12),
 (9, '2016-08-02', '17:21:27',  26.14),
 (10,'2017-09-02', '17:25:42', 43.13);
 
 
 INSERT INTO PAYMENT(orderID,paymenttype,paymentDate) VALUES
 (1,'cash','2001-02-14'),
 (2,'card','2001-02-14'),
 (3,'card','2001-03-14'),
 (4,'cash','2002-04-15'),
 (5,'card','2001-08-14'),
 (6,'cash','2002-06-14');
 
 INSERT INTO  cardPayment(paymentID,cardnum,expirationDate,cvv,cardtype)VALUES
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
 
Insert into EatInOrder(orderID,numGuest) values
(1,4),
(6,2);
 


Customers
#----------------------------------------------------
DROP TABLE IF EXISTS PrivateCustomer;
DROP TABLE IF EXISTS CorporateCustomer;
DROP TABLE IF EXISTS MimingsMoney;
DROP TABLE IF EXISTS ContactInfo;
DROP TABLE IF EXISTS Customer;
#-----------------------------------------------------

 
#THIS IS THE PART OF MY CODE FOR THE CUSTOMERS ONE 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
CREATE TABLE Customer
(
   customerID       INT NOT NULL AUTO_INCREMENT, 
   cFirstName       VARCHAR(30)	NOT NULL,
   cLastName		VARCHAR(30) NOT NULL,
   cDOB				DATE     	NOT NULL,
   CONSTRAINT       PK_Customer PRIMARY KEY (customerID),
   CONSTRAINT 	    UC_Customer	UNIQUE (cFirstName, cLastName, cDOB)
);

CREATE TABLE PrivateCustomer
(
	customerID     INT NOT NULL,
    
    CONSTRAINT     PK_PrivateCustomer    PRIMARY KEY(customerID),
    CONSTRAINT	   FK_Customer_PrivateCustomer FOREIGN KEY (customerID) 
				   REFERENCES Customer (customerID)
);

CREATE TABLE CorporateCustomer
(
	customerID     INT NOT NULL,
    orgName	       VARCHAR(30) NOT NULL,
	deptName	   VARCHAR(30) NOT NULL,
    officeAddress  VARCHAR(60) NOT NULL,
    
    CONSTRAINT     PK_CorporateCustomer PRIMARY KEY(customerID),
    CONSTRAINT 	   UC_CorporateCustomer	UNIQUE (orgName, deptName),
    CONSTRAINT     FK_Customer_CorporateCustomer FOREIGN KEY (customerID)
				   REFERENCES Customer (customerID)
);

CREATE TABLE MimingsMoney
(
	customerID     INT NOT NULL,
    creditEarned   FLOAT NOT NULL,
    creditSpent    FLOAT NOT NULL,
    currentBalance FLOAT NOT NULL,
    
    CONSTRAINT     PK_MimingMoney  PRIMARY KEY(customerID),
    CONSTRAINT     FK_Customer_MimingMoney FOREIGN KEY (customerID)
				   REFERENCES Customer (customerID)
);

CREATE TABLE ContactInfo
(
	customerID	     INT NOT NULL,
    email 		     VARCHAR(50), 
    snailMailAddress VARCHAR(50),
    phone            VARCHAR(20),
    
    CONSTRAINT      PK_ContactInfo PRIMARY KEY(customerID,email),
    CONSTRAINT      FK_Customer_ContactInfo FOREIGN KEY (customerID)
					REFERENCES Customer (customerID)
);
#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------

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



#--------------------------------------------------------------------------------------
-- Menu


create table Menu (
    MenuType ENUM('evening','lunch','sunday brunch',''),
    DateCreated date,
    PriceModifier double,
    primary key(MenuType)
);

INSERT Menu () values
('cool menu', 'randomdate', '2%');

-- Menu Item
create table MenuItem (
    MenuItemName varchar(255),
    Spiciness ENUM(''),
    BasePrice double,
    primary key(MenuItemName)
);

-- Appetizer
create table Appetizer (
    MenuItemName varchar(255),
    primary key(MenuItemName),
    foreign key(MenuItemName) references MenuItem(MenuItemName)
);

-- Soup
create table Soup (
    MenuItemName varchar(255),
    Broth varchar(255), 
    primary key(MenuItemName),
    foreign key(MenuItemName) references MenuItem(MenuItemName)
);

-- MeatEntrees
create table MeatEntrees (
    MenuItemName varchar(255),
    EntreeSelection varchar(255),
    primary key (MenuItemName),
    foreign key (MenuItemName) references MenuItem(MenuItemName)
);
-- ChowMein
create table ChowMein (
    MenuItemName varchar(255),
    TypeOfNoodles varchar(255),
    primary key (MenuItemName),
    foreign key (MenuItemName) references MeatEntrees(MenuItemName)
);


-- EggFooYoung
create table EggFooYoung(
    MenuItemName varchar(255),
    OmeletStyle varchar(255),
    primary key (MenuItemName),
    foreign key (MenuItemName) references MeatEntrees(MenuItemName)
);


-- ChopSuey
create table ChopSuey(
    MenuItemName varchar(255),
    TypeOfRice varchar(255),
    primary key (MenuItemName),
    foreign key (MenuItemName) references MeatEntrees(MenuItemName)
);

-- MenuMenuItem
create table MenuMenuItem (
    MenuType varchar(255),
    MenuItemName varchar(255),
    PortionSize varchar(255),
    Price double,
    primary key (MenuType, menuItemName),
    foreign key (MenuType) references Menu(MenuType),
    foreign key (MenuItemName) references MenuItem(MenuItemName)
);

