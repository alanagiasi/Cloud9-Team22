#This script creates MySQL tables, including indexes, sample data etc.
#Notes:
#Based on a MSSQL used in City & Guilds SQL Programming module, adapted for MySQL
#The MySQL syntax for FOREIGN KEY is slightly different to MSSQL
#The MySQL syntax for AUTO_INCREMENT is slightly different to MSSQL
#In MySQL terminate each command with a semicolon ;
#In MySQL the Date format (YYYY-MM-DD) differs to MSSQL (DD MMM YYYY)

Use CCDatabase; #ccdatabase

-- DROP order is important wrt Foreign Keys
DROP TABLE IF EXISTS Job_History;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Countries;
DROP TABLE IF EXISTS Regions;
DROP TABLE IF EXISTS Jobs;


-- CREATE the Tables
Create Table Regions
(Region_ID Int Not Null AUTO_INCREMENT Primary Key,
Region_Name varchar(25));

Create Table Jobs
(Job_ID Varchar(10) Not Null Primary Key,
Job_Title Varchar(35) Not Null,
Min_Salary Int,
Max_Salary Int);

Create Table Countries
(Country_ID char(2) Not Null Primary Key,
Country_Name varchar(40),
Region_ID int,
Foreign Key (Region_ID) REFERENCES Regions(Region_ID));

-- CREATE an Index
Create Index IX_Region_ID On Countries(Region_ID);


Create Table Locations
(Location_ID int Not Null Primary Key,
Street_Address varchar(40),
City varchar(30)Not Null,
Postal_Code varchar(12),
State_Province_County varchar(25),
Country_ID char(2),
Foreign Key (Country_ID) REFERENCES Countries(Country_ID));

-- CREATE some more indexes
Create Index IX_City On Locations(City);
Create Index IX_State_Province_County On Locations(State_Province_County);
Create Index IX_Country_ID On Locations(Country_ID);


Create Table Departments
(Department_No int Not Null Primary Key,
Department_Name varchar(30),
Manager_ID int,
Location_ID int,
Foreign Key (Location_ID) REFERENCES Locations(Location_ID));

Create Index IX_Location On Departments(Location_ID);


Create Table Employees
(Employee_No int Not Null Primary Key,
First_Name varchar(20),
Last_Name varchar(25)Not Null,
Email varchar(25) Not Null,
Phone_Number varchar(20),
#Hire_Date datetime Not Null,
Hire_Date date Not Null,
Job_ID varchar(10),
Foreign Key (JOB_ID) REFERENCES Jobs(Job_ID),
Annual_Salary decimal(8,2),
Commission_Percent decimal(2,2),
Manager_ID int,
Department_No int,
Foreign Key (Department_No) REFERENCES Departments(Department_No));

Create Index IX_Last_Name On Employees(Last_Name);
Create Unique Index IX_Email On Employees(Email);
Create Index IX_Job_ID On Employees(Job_ID);
Create Index IX_Manager_ID On Employees(Manager_ID);
Create Index IX_Department_No On Employees(Department_No);


Create Table Job_History
(Employee_No int Not Null,
Foreign Key (Employee_No) REFERENCES Employees(Employee_No),
Start_Date datetime Not Null,
End_Date datetime Not Null,
Job_ID varchar(10) Not Null,
Department_No int Not Null,
Constraint PK_Emp_Start_Date Primary Key(Employee_No, Start_Date));


-- Populate the Tables with data

Insert into Regions (Region_Name) Values ('Americas');
Insert into Regions (Region_Name) Values ('Europe');
Insert into Regions (Region_Name) Values ('Middle East');
Insert into Regions (Region_Name) Values ('Asia');
-- SELECT * FROM Regions;

Insert into Countries (Country_ID,Country_Name,Region_ID) Values ('CA','Canada',1);
Insert into Countries (Country_ID,Country_Name,Region_ID) Values ('FR','France',2);
Insert into Countries (Country_ID,Country_Name,Region_ID) Values ('GE','Germany',2);
Insert into Countries (Country_ID,Country_Name,Region_ID) Values ('UK','United Kingdom',2);
Insert into Countries (Country_ID,Country_Name,Region_ID) Values ('US','United States of America',1);
-- SELECT * FROM Countries;

Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('AC_ACCOUNT','Accountant',8500,25000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('AC_CLERK','Accounts Clerk',5000,11500);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('AC_MGR','Accounts Manager',10000,25000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('AD_ASST','Administration Assistant',4500,15000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('AD_CLERK','Administration Clerk',4500,12000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('AD_MGR','Administration Manager',20000,30000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('CO_CHAIR','Company Chairman',100000,200000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('CO_DIR','Company Director',30000,100000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('FN_CLERK','Finance Clerk',6000,11000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('FN_MGR','Finance Manager',13000,25000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('HR_CLERK','Human Resources Clerk',10000,15000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('HR_MGR','Human Resources Manager',30000,50000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('IT_MGR','IT Manager',40000,60000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('IT_PROG','Programmer',15000,25000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('MK_MGR','Marketing Manager',10500,17500);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('MK_REP','Marketing Representative',4490,11000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('PC_CLERK','Purchase Clerk',4000,8000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('PC_MGR','Purchase Manager',4600,15000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('SA_MGR','Sales Manager',10000,20000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('SA_REP','Sales Representative',4000,13000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('SH_CLERK','Shipping Clerk',8000,12500);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('SH_MGR','Shipping Manager',20000,25000);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('ST_CLERK','Stock Clerk',4400,10500);
Insert into Jobs (Job_ID,Job_Title,Min_Salary, Max_Salary) Values ('ST_MGR','Stock Manager',6900,12000);
-- SELECT * FROM Jobs;

Insert Into Locations (Location_ID,Street_Address,City,Postal_Code,State_Province_County,Country_ID) Values (1100,'245 The Fleet','Toronto','ON M3F 4GA','Ontario','CA');
Insert Into Locations (Location_ID,Street_Address,City,Postal_Code,State_Province_County,Country_ID) Values (1200,'155 South Street','Gloucester','GL5 2DD','Gloucestershire','UK');
Insert Into Locations (Location_ID,Street_Address,City,Postal_Code,State_Province_County,Country_ID) Values (1700,'560 Kings Road','San Francisco','66432','California','US');
Insert Into Locations (Location_ID,Street_Address,City,Postal_Code,State_Province_County,Country_ID) Values (1900,'1010 Rodeo Drive','San Antone','45294','Texas','US');
Insert Into Locations (Location_ID,Street_Address,City,Postal_Code,State_Province_County,Country_ID) Values (2000,'19 Church Road','Brighton','BN2 5SF','East Sussex','UK');
-- SELECT * FROM Locations;

Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (10,'Marketing',100,1200);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (20,'Administration',200,1700);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (30,'Accounting',110,1700);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (50,'IT',107,2000);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (60,'Sales',150,1900);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (70,'Shipping',250,1100);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (80,'Finance',125,1700);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (90,'Management',130,1700);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (110,'Human Resources',122,1700);
Insert Into Departments(Department_No, Department_Name, Manager_ID, Location_ID) Values (190,'Manufacturing',160,1100);
-- SELECT * FROM Departments;

Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (100,'David','Polanski','DPOLANSKI','555 324 190','1999-11-16','MK_MGR',17000,Null,100,10);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (102,'Richard','Molavi','RMOLAVI','215 665 245','1992-06-02','CO_DIR',45000,Null,130,90);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (107,'Megan','Williams','MWILLIAMS','111 987 245','1993-03-13','IT_MGR',45000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (110,'William','Clifford','WCLIFFORD','222 456 666','1996-05-12','AC_MGR',20000,Null,110,30);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (112,'Robert','Meadows','RMEADOWS','555 324 162','1998-08-26','MK_REP',8000,Null,100,10);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (115,'James','Marsh','JMARSH','222 456 133','1999-04-16','AC_CLERK',7250,Null,110,30);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (119,'James','Miles','JMILES','444 232 090','1990-05-16','SA_REP',10000,0.25,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (120,'Joseph','Sanders','JSANDERS','222 456 266','1997-08-12','AC_CLERK',10750,Null,110,30);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (122,'Julie','Whittaker','JWHITTAKER','532 555 160','1986-11-10','HR_MGR',35000,Null,122,110);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (123,'Adrian','Davis','ADAVIS','444 232 222','1990-01-19','SA_REP',9000,0.2,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (125,'Linda','Yorke','LYORKE','888 666 111','1986-02-19','FN_MGR',24500,Null,125,80);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (126,'Fiona','Kelso','FKELSO','345 222 266','1997-07-03','ST_CLERK',8200,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (130,'Adrian','Marsh','AMARSH','555 555 511','1988-03-01','CO_CHAIR',150000,Null,Null,90);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (131,'Martyn','Holmes','MHOLMES','345 222 111','1998-04-25','ST_CLERK',8000,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (132,'Marie-Lisa','Johannsson','MJOHANSSON','345 222 142','1997-03-19','ST_CLERK',8200,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (133,'Nelson','Hadlow','NHADLOW','111 987 110','1991-05-21','IT_PROG',16500,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (135,'John','Lugini','JLUGINI','345 222 192','1996-05-04','ST_CLERK',7800,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (138,'Ramirez','Damatos','RDAMATOS','345 222 233','1998-09-28','ST_CLERK',9500,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (139,'Kelly','Wight','KWIGHT','345 222 335','1999-02-02','ST_CLERK',7500,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (141,'George','Diamond','GDIAMOND','345 222 121','1997-11-15','ST_CLERK',8000,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (142,'Joanna','Neilson','JNEILSON','444 232 115','1998-03-24','SA_REP',7000,0.10,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (143,'Joshua','Bitton','JBITTON','444 232 129','1999-02-06','SA_REP',8400,0.15,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (145,'Jayne','Berry','JBERRY','444 232 120','1998-05-29','SA_REP',10200,0.30,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (146,'Everton','Miles','EMILES','444 232 130','1999-05-29','SA_REP',9100,0.20,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (147,'Colin','Weston','CWESTON','444 232 132','1999-07-05','SA_REP',12000,0.30,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (148,'Jennifer','Wilmott','JWILMOTT','444 232 134','1997-12-15','SA_REP',11500,0.25,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (149,'Roberto','Mace','RMACE','111 987 124','1996-02-06','IT_PROG',22000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (150,'Wayne','Hartmore','WHARTMORE','444 232 135','1998-03-16','SA_MGR',10000,0.35,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (152,'Graeme','Davis','GDAVIS','444 232 136','1996-09-14','SA_REP',9500,0.25,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (154,'Patrick','Connor','PCONNOR','444 232 138','1997-11-08','SA_REP',8900,0.20,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (155,'Peter','Court','PCOURT','111 987 130','1989-04-01','IT_PROG',17950,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (156,'Natalie','French','NFRENCH','444 232 140','1997-02-19','SA_REP',8100,0.15,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (159,'Josephine','Trotter','JTROTTER','111 987 132','1995-10-19','IT_PROG',18000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (160,'Trevor','Mills','TMILLS','345 222 255','1986-01-01','ST_MGR',11000,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (166,'Joanna','Repetto','JREPETTO','111 987 128','1990-09-30','IT_PROG',16000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (169,'Michelle','Caprice','MCAPRICE','444 232 142','1997-04-16','SA_REP',7100,0.10,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (170,'Jackie','Matthews','JMATTHEWS','111 987 120','1997-08-05','IT_PROG',24000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (172,'Lucy','Acreman','LACREMAN','111 987 125','1991-04-16','IT_PROG',18000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (174,'Justin','Monroe','JMONROE','111 987 126','1990-04-02','IT_PROG',17500,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (175,'Jose','Martinez','JMARTINEZ','111 987 134','1997-11-06','IT_PROG',16000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (177,'Kelvin','Betteridge','KBETTERIDGE','111 987 136','1998-12-05','IT_PROG',17500,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (179,'Rosa','Dambridge','RDAMBRIDGE','215 665 130','1998-11-15','CO_DIR',50000,Null,130,90);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (180,'Germaine','Nicholls','GNICHOLLS','665 239 155','1999-12-07','AD_CLERK',6500,Null,200,20);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (182,'Florence','Wilkins','FWILKINS','222 456 190','1987-11-30','AC_ACCOUNT',23000,Null,110,30);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (185,'Ben','Nolan','BNOLAN','444 232 125','1998-10-01','SA_REP',9500,0.20,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (195,'Marion','Weiss','MWEISS','345 222 165','1998-08-26','ST_CLERK',6500,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (196,'Joan','Sharma','JSHARMA','555 324 155','1993-10-24','MK_REP',9500,Null,100,10);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (198,'Elaine','Cotton','ECOTTON','532 555 190','1986-04-21','HR_CLERK',14990,Null,122,110);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (200,'Loraine','Merton','LMERTON','665 239 989','1987-09-16','AD_MGR',25000,Null,200,20);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (202,'Abigail','Wise','AWISE','665 239 275','1991-09-27','AD_ASST',14200,Null,200,20);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (204,'Gregory','Lambert','GLAMBERT','888 666 250','1992-01-05','FN_CLERK',10200,Null,125,80);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (205,'Rachel','Christy','RCHRISTY','222 456 188','1994-10-17','PC_CLERK',7500,Null,110,30);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (206,'Edward','Laslo','ELASLO','333 111 435','1987-12-09','SH_CLERK',11800,Null,250,70);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (208,'Frances','Goodwin','FGOODWIN','345 222 200','1988-09-21','ST_CLERK',10000,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (210,'Stuart','Macffrey','SMACFFREY','345 222 220','1989-05-03','ST_CLERK',9800,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (212,'James','Watson','JWATSON','345 222 224','1993-02-16','ST_CLERK',10000,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (214,'Nancy','Watts','NWATTS','111 987 495','1999-05-12','IT_PROG',22000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (220,'Margaret','Tetbury','MTETBURY','111 987 888','1998-01-24','IT_PROG',21000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (222,'Peter','Bown','PBOWN','111 987 777','1997-05-05','IT_PROG',19000,Null,107,50);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (224,'John','Pench','JPENCH','444 232 190','1999-07-12','SA_REP',13000,0.15,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (236,'William','Avery','WAVERY','444 232 135','1994-01-31','SA_REP',9000,0.20,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (240,'Byron','Elliott','BELLIOTT','345 222 333','1990-10-18','ST_CLERK',9800,Null,160,190);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (245,'Gillian','Barnes','GBARNES','444 232 215','1992-09-03','SA_REP',9800,0.25,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (246,'Janet','Reismaster','JREISMASTER','444 232 220','1989-10-08','SA_REP',10500,0.25,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (250,'Tony','Luigi','TLUIGI','333 111 120','1985-12-02','SH_MGR',25000,Null,250,70);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (255,'Tracey','Hart','THART','444 232 200','1990-05-14','SA_REP',12000,0.30,150,60);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (260,'Jessica','Flowers','JFLOWERS','555 324 120','1992-02-06','MK_REP',10500,Null,100,10);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (266,'Pamela','Rogers','PROGERS','532 555 200','1989-04-17','HR_CLERK',15000,Null,122,110);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (267,'Thomas','Klein','TKLEIN','532 555 121','1991-11-15','HR_CLERK',14200,Null,122,110);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (274,'Ian','Holland','IHOLLAND','888 666 260','1991-06-06','FN_CLERK',8500,Null,125,80);
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (275,'Melissa','Powers','MPOWERS','555 324 222','1989-06-18','MK_REP',10900,Null,100,10);
-- SELECT * FROM Employees;


Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (100,'1999-11-16','2000-09-20','MK_REP',10);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (102,'1992-06-02','1996-07-15','FN_MGR',80);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (107,'1993-03-13','1999-01-29','IT-PROG',50);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (110,'1996-05-12','1998-12-06','FN_CLERK',80);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (122,'1986-11-10','1989-07-31','HR_CLERK',110);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (125,'1986-02-19','1998-05-12','FN_CLERK',80);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (130,'1988-03-01','1996-12-04','FN_MGR',80);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (130,'1996-12-04','1999-06-23','CO_DIR',90);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (150,'1998-03-16','1998-01-25','SA_REP',60);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (160,'1986-01-01','1993-03-25','ST_CLERK',190);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (200,'1987-09-16','1996-10-29','AD_CLERK',20);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (200,'1996-10-29','1999-04-12','AD_ASST',20);
Insert Into Job_History (Employee_No, Start_Date, End_Date, Job_ID, Department_No) Values (250,'1985-12-02','1990-01-29','SH_CLERK',70);
-- SELECT * FROM Job_History;
