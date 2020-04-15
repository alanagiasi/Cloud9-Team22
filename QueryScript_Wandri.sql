-- This script contains queries used by frontend(

Use ccdatabase; #CCDatabase;

-- Query for adding a new Sales Representative
INSERT INTO Employees (Employee_No,First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) VALUES (280,'Kevin', 'Myers','KMYERS', '532 555 161','1999-11-14' , 'SA_REP',1000,0.25,150,60);

-- Query for removing an employee
DELETE FROM Employees WHERE Employee_No=280;

-- Query for showing highest paid employee 
SELECT First_Name, Last_Name, Annual_Salary from Employees WHERE Annual_Salary = (SELECT MAX(Annual_Salary) from Employees);

-- Query to show department name of department an employee is working in
SELECT Department_Name FROM Departments WHERE Department_No = (SELECT Department_No from Employees WHERE Employee_No=139);

-- Query to show in which City an employee is based
SELECT City FROM Locations WHERE Location_ID = (SELECT Location_ID from Departments WHERE Department_No = (SELECT Department_No from Employees WHERE Employee_No=139));

-- Query to show the total salaries of all employees
SELECT SUM(Annual_Salary) SalaryTotal FROM Employees;


/* Function to add a new employee
DELIMITER // ;
CREATE FUNCTION sales_insert (E_No int, first_Name varchar(20), last_Name varchar(25), email varchar(25), phone_Number varchar(20), hire_Date date, job_ID varchar(10), annual_Salary decimal(8,2), commission_Percent decimal(2,2), manager_ID int, department_No int)
RETURNS int
DETERMINISTIC
BEGIN
Insert Into Employees (Employee_No, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Annual_Salary, Commission_Percent, Manager_ID, Department_No) Values (E_No, first_Name, last_Name, email, phone_Number, hire_Date, job_ID,annual_Salary, commission_Percent,manager_ID,department_No);
RETURN 1;
END //
*/
