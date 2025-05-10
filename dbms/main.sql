use vedanta;

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Full_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    License_Number VARCHAR(20) UNIQUE NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Age INT NOT NULL
);


CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(59) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL
);

CREATE TABLE Branches (
    Branch_ID INT PRIMARY KEY ,
    Branch_Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) NOT NULL
);
CREATE TABLE Vehicle_Types (
    Type_ID INT PRIMARY KEY,
    Type_Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    Daily_Rate DECIMAL(10,2) NOT NULL,
    Weekly_Rate DECIMAL(10,2) NOT NULL,
    Monthly_Rate DECIMAL(10,2) NOT NULL
);

CREATE TABLE Vehicles (
    Vehicle_ID INT PRIMARY KEY ,
    Type_ID INT NOT NULL,
    Manufacturar VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    License_Plate VARCHAR(20) UNIQUE NOT NULL,
    Color VARCHAR(20) NOT NULL,
    Current_Mileage INT NOT NULL,
    Branch_ID INT NOT NULL,
    FOREIGN KEY (Type_ID) REFERENCES Vehicle_Types(Type_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);

CREATE TABLE Vehicle_Status (
    Status_ID INT PRIMARY KEY,
    Vehicle_ID INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Last_Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID)
);

CREATE TABLE Vehicle_Maintenance (
    Maintenance_ID INT PRIMARY KEY ,
    Vehicle_ID INT NOT NULL,
    Maintenance_Date DATE NOT NULL,
    Description VARCHAR(255) ,
    Cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID)
);

CREATE TABLE Rentals (
    Rental_ID INT PRIMARY KEY ,
    Customer_ID INT NOT NULL,
    Vehicle_ID INT NOT NULL,
    Employee_ID INT NOT NULL, 
    Rental_Start_Date DATE NOT NULL,
    Rental_End_Date DATE NOT NULL,
    Actual_Return_Date DATE,
    Pickup_Branch_ID INT NOT NULL,
    Dropoff_Branch_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Pickup_Branch_ID) REFERENCES Branches(Branch_ID),
    FOREIGN KEY (Dropoff_Branch_ID) REFERENCES Branches(Branch_ID)
);

CREATE TABLE Rental_Details (
    Detail_ID INT PRIMARY KEY ,
    Rental_ID INT NOT NULL,
    Daily_Rate DECIMAL(10,2) NOT NULL,
    Weekly_Rate DECIMAL(10,2),
    Monthly_Rate DECIMAL(10,2),
    Total_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Rental_ID) REFERENCES Rentals(Rental_ID)
);

CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Rental_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Method VARCHAR(50) NOT NULL, 
    FOREIGN KEY (Rental_ID) REFERENCES Rentals(Rental_ID)
);

SET SQL_SAFE_UPDATES = 0;

-- Q1
select * from Employees;
-- Q2
select First_Name,Last_Name from employees;
-- Q3
SELECT DISTINCT Full_Name FROM Customers;
-- Q4
SELECT * FROM Customers WHERE Age > 33;
-- Q5
SELECT * FROM Rentals ORDER BY Vehicle_ID DESC;
-- Q6
SELECT Branch_ID, COUNT(Vehicle_ID) AS Total_Vehicles
FROM Vehicles
GROUP BY Branch_ID;
-- Q7
SELECT Branch_ID, COUNT(Vehicle_ID) AS Vehicle_Count 
FROM Vehicles 
GROUP BY Branch_ID
HAVING MIN(Current_Mileage) > 8000;
-- Q8
UPDATE Vehicles SET Current_Mileage = 25000 
WHERE Vehicle_ID = 5;
-- Q9
DELETE FROM Rentals WHERE Rental_ID = 10;
-- Q10
ALTER TABLE Employees ADD (Salary DECIMAL(10, 2));
-- Q11
SELECT COUNT(Age) FROM Customers;
-- Q12
SELECT AVG(Cost) FROM Vehicle_Maintenance;
-- Q13
SELECT Customers.Full_Name, Rentals.Rental_Start_Date 
FROM Rentals 
INNER JOIN Customers ON Rentals.Customer_ID = Customers.Customer_ID;
-- Q14
SELECT * FROM Customers WHERE Full_Name LIKE 'H%';
-- Q15
SELECT Customers.Customer_ID, Rentals.Rental_ID 
FROM Customers 
INNER JOIN Rentals ON Customers.Customer_ID = Rentals.Customer_ID;
-- Q16
SELECT Rental_ID From rental_details WHERE Monthly_Rate=(select max(Monthly_Rate) from rental_details);
-- Q17
SELECT Employee_ID,first_Name FROM Employees;
-- Q18
SELECT Employee_ID, CONCAT(First_Name, ' ', Last_Name) AS FullName 
FROM Employees; -- SELECT Employee_ID, First_Name || ' ' || Last_Name AS FullName FROM Employees;
-- Q19
CREATE TABLE Persons ( 
ID int NOT NULL, 
LastName varchar(255) NOT NULL, 
FirstName varchar(255), 
Age int, 
CHECK (Age>=18) ); 
-- Q20
SELECT CURRENT_DATE; -- select sysdate from dual
-- Q21
SELECT SUBSTRING(Last_Name, 1, 4) FROM Employees;
-- Q22
drop table New_Employees;
CREATE TABLE New_Employees AS SELECT * FROM Employees;
select * from New_Employees;
-- Q23
SELECT * FROM rental_details WHERE Total_Amount BETWEEN '500' AND '100';
-- Q24
SELECT * FROM Employees WHERE First_Name LIKE '_____a';
-- Q25
SELECT Rental_ID from rental_details WHERE Daily_Rate=(select max(Daily_Rate) FROM rental_details WHERE 
Daily_Rate!=(SELECT max(Daily_Rate) FROM rental_details)); 
-- Q26
SELECT Type_Name, MAX(Monthly_Rate) AS Max_Rate
FROM Vehicle_Types
GROUP BY Type_Name;