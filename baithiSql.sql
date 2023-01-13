CREATE DATABASE EmployeeDB
GO
USE EmployeeDB
GO 
CREATE TABLE Department(
	DepartID INT PRIMARY KEY,
	DepartName VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL
)

CREATE TABLE Employee(
	EmpCode CHAR(6) PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	BirthDay SMALLDATETIME NOT NULL,
	Gender BIT DEFAULT 1,
	Address VARCHAR(100),
	DepartID INT ,
	Salary MONEY,
	FOREIGN KEY(DepartID) REFERENCES Department(DepartID)
)
INSERT INTO Department(DepartId, DepartName, Description)
VALUES (1,'IT','CNTT')
INSERT INTO Department(DepartID,DepartName,Description)
VALUES (2,'HR','TuyenNV')
INSERT INTO Department(DepartID,DepartName,Description)
VALUES (3,'Finance','TaiChinh')

INSERT INTO Employee(EmpCode, FirstName, LastName, BirthDay, Gender, Address, DepartID, Salary)
VALUES('E001', 'Phuc', 'Nguyen', '1990-01-01', 1, '123 Main St', 1, 50000)
INSERT INTO Employee(EmpCode, FirstName, LastName, BirthDay, Gender, Address, DepartID, Salary)
VALUES('E002', 'Tien', 'Anh', '1992-03-15', 0, '456 Park Ave', 2, 55000)
INSERT INTO Employee(EmpCode, FirstName, LastName, BirthDay, Gender, Address, DepartID, Salary)
VALUES('E003', 'Duc', 'Hoy', '1995-05-20', 1, '789 Elm St', 3, 60000)

-- Tang salary cho nhan vien len 10%
UPDATE Employee SET Salary = Salary * 1.1;

-- Them rang buoc cho luong cua nhan vien luon > 0
ALTER TABLE Employee ADD CHECK (Salary > 0);

-- GIA TRI COLUMN BIRTHDAY > 23
CREATE TRIGGER tg_chkBirthday 
ON Employee
AFTER INSERT, UPDATE 
AS
BEGIN
	IF EXISTS (SELECT 1 FROM inserted WHERE BirthDay <= 23)  
	BEGIN
		RAISERROR ('Value of',16,1);
		ROllBACK TRANSACTION;
	END
END


-- TAO CHI MUC
CREATE UNIQUE INDEX IX_DepartmentName
ON Department(DepartName)

-- VIEW 
SELECT Employee.EmpCode , Employee.FirstName , Employee.LastName , Employee.Gender
FROM Employee  INNER JOIN Department 
ON Employee.DepartID = Department.DepartID;

-- 7
CREATE PROCEDURE sp_getAllEmp (IN DepartmentID INT )
BEGIN
	SELECT * FROM Employee
	WHERE DepartID = DepartmentID ;
END;


--8
create proc sp_delDept @EmpCode char(6)
as
BEGIN
DELETE FROM Employee 
WHERE EmpCode=@EmpCode
end

exec sp_getAllEmp 03

