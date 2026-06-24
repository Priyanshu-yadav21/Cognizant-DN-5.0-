CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Balance DECIMAL(10,2),
    IsVIP BOOLEAN DEFAULT FALSE
);
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    InterestRate DECIMAL(5,2),
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Customers VALUES
(1,'Rahul',65,12000,FALSE),
(2,'Priya',45,8000,FALSE),
(3,'Amit',70,25000,FALSE),
(4,'Neha',30,15000,FALSE);
 
 INSERT INTO Loans VALUES
(101,1,9.50,'2026-07-05'),
(102,2,10.00,'2026-08-15'),
(103,3,8.75,'2026-07-10'),
(104,4,11.25,'2026-06-30');

SELECT * FROM customers;

SELECT * FROM loans;

DELIMITER $$

CREATE PROCEDURE ApplySeniorDiscount()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_age INT;

    DECLARE cur CURSOR FOR
        SELECT CustomerID, Age
        FROM Customers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO c_id, c_age;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF c_age > 60 THEN

            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = c_id;

        END IF;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

CALL ApplySeniorDiscount();

SELECT * FROM Loans;


DELIMITER $$

CREATE PROCEDURE PromoteVIP()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_balance DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT CustomerID, Balance
        FROM Customers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur;

    vip_loop: LOOP

        FETCH cur INTO c_id, c_balance;

        IF done THEN
            LEAVE vip_loop;
        END IF;

        IF c_balance > 10000 THEN

            UPDATE Customers
            SET IsVIP = TRUE
            WHERE CustomerID = c_id;

        END IF;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

CALL PromoteVIP();

SELECT * FROM Customers;


DELIMITER $$

CREATE PROCEDURE LoanReminder()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE cust_name VARCHAR(100);
    DECLARE due_date DATE;

    DECLARE cur CURSOR FOR

        SELECT c.Name, l.DueDate
        FROM Customers c
        JOIN Loans l
        ON c.CustomerID = l.CustomerID
        WHERE l.DueDate BETWEEN CURDATE()
                            AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur;

    reminder_loop: LOOP

        FETCH cur INTO cust_name, due_date;

        IF done THEN
            LEAVE reminder_loop;
        END IF;

        SELECT CONCAT(
            'Reminder: ',
            cust_name,
            ', your loan is due on ',
            due_date
        ) AS Message;

    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;

CALL LoanReminder();