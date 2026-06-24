CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Accounts VALUES
(101,1,'Savings',10000),
(102,2,'Savings',8000),
(103,3,'Savings',15000),
(104,4,'Current',12000);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1,'Amit','IT',50000),
(2,'Neha','HR',45000),
(3,'Rahul','IT',60000),
(4,'Priya','Finance',55000);


-- (Scenario 1:) 
DELIMITER $$

CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN

    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

END$$

DELIMITER ;

SELECT * FROM Accounts;

CALL ProcessMonthlyInterest();

SELECT * FROM Accounts;

SELECT * FROM Employees;

-- (Scenario 2:)
DELIMITER $$

CREATE PROCEDURE UpdateEmployeeBonus(
    IN dept VARCHAR(50),
    IN bonusPercent DECIMAL(5,2)
)
BEGIN

    UPDATE Employees
    SET Salary = Salary + (Salary * bonusPercent / 100)
    WHERE Department = dept;

END$$

DELIMITER ;

CALL UpdateEmployeeBonus('IT', 10);

SELECT * FROM Employees;


SELECT * FROM Accounts;


-- (Scenario 3:)
DELIMITER $$

CREATE PROCEDURE TransferFunds(
    IN sourceAcc INT,
    IN destAcc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE sourceBalance DECIMAL(10,2);

    -- Get source account balance
    SELECT Balance
    INTO sourceBalance
    FROM Accounts
    WHERE AccountID = sourceAcc;

    
    IF sourceBalance >= amount THEN

        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = sourceAcc;

        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = destAcc;

        SELECT 'Transfer Successful' AS Message;

    ELSE

        SELECT 'Insufficient Balance' AS Message;

    END IF;

END$$

DELIMITER ;

CALL TransferFunds(101,102,2000);

SELECT * FROM Accounts;



CALL TransferFunds(101,103,50000);
