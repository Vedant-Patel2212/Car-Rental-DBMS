
-- 3. Customers Table
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

-- 4. Employees Table
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL
);

-- 5. Branches Table
CREATE TABLE Branches (
    Branch_ID INT PRIMARY KEY ,
    Branch_Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) NOT NULL
);

-- 6. Vehicle_Types Table
CREATE TABLE Vehicle_Types (
    Type_ID INT PRIMARY KEY,
    Type_Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    Daily_Rate DECIMAL(10,2) NOT NULL,
    Weekly_Rate DECIMAL(10,2) NOT NULL,
    Monthly_Rate DECIMAL(10,2) NOT NULL
);

-- 7. Vehicles Table
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

-- 8. Vehicle_Status Table
CREATE TABLE Vehicle_Status (
    Status_ID INT PRIMARY KEY AUTO_INCREMENT,
    Vehicle_ID INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Last_Updated TIMESTAMP ,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID)
);

-- 9. Vehicle_Maintenance Table
CREATE TABLE Vehicle_Maintenance (
    Maintenance_ID INT PRIMARY KEY ,
    Vehicle_ID INT NOT NULL,
    Maintenance_Date DATE NOT NULL,
    Description VARCHAR(255) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

-- 10. Rentals Table
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

-- 11. Rental_Details Table
CREATE TABLE Rental_Details (
    Detail_ID INT PRIMARY KEY ,
    Rental_ID INT NOT NULL,
    Daily_Rate DECIMAL(10,2) NOT NULL,
    Weekly_Rate DECIMAL(10,2),
    Monthly_Rate DECIMAL(10,2),
    Total_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Rental_ID) REFERENCES Rentals(Rental_ID)
);

-- 12. Payments Table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Rental_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Method VARCHAR(50) NOT NULL, 
    FOREIGN KEY (Rental_ID) REFERENCES Rentals(Rental_ID)
);

