/**************************************************
	Jeffrey Kuhn		2/28/20
	Modification Log: 
	2/28/20: SQL File created
	3/2/20: Added go to after CREATE DATABASE disk_inventoryJK, added Artist_Type_ID as a FK to Artist, Added NULL to Returned date to allow NULLs
	3/5/20: Added code to insert data into the tables.
**************************************************/
use master;
go

--Drop Database in case it already exists
DROP DATABASE IF EXISTS disk_inventoryJK;

--Create the database
CREATE DATABASE disk_inventoryJK;
go

--Set all SQL statments to create data in disk_inventoryJK
USE disk_inventoryJK;
go

--Create Status table
CREATE TABLE Status (
	Status_ID		INT NOT NULL PRIMARY KEY,
	Description		VARCHAR(60) NOT NULL);

--Create Genre table
CREATE TABLE Genre (
	Genre_ID		INT NOT NULL PRIMARY KEY,
	Description		VARCHAR(60) NOT NULL);

--Create CD_Type table
CREATE TABLE CD_Type (
	Type_ID			INT NOT NULL PRIMARY KEY,
	Description		VARCHAR(60) NOT NULL);

--Create CD table
CREATE TABLE CD (
	CD_ID			INT NOT NULL PRIMARY KEY,
	CD_name			VARCHAR(60) NOT NULL,
	Release_Date	DATETIME NOT NULL,
	Type_ID			INT NOT NULL REFERENCES CD_Type(Type_ID),
	Status_ID		INT NOT NULL REFERENCES Status(Status_ID),
	Genre_ID		INT NOT NULL REFERENCES Genre(Genre_ID));

--Create Artist type table
CREATE TABLE Artist_Type (
	Artist_Type_ID	INT NOT NULL PRIMARY KEY,
	Description		VARCHAR(60) NOT NULL);

--Create Artist table
CREATE TABLE Artist (
	Artist_ID		INT NOT NULL PRIMARY KEY,
	Artist_Name		VARCHAR(60) NOT NULL,
	Artist_Type_ID	INT NOT NULL REFERENCES Artist_Type(Artist_Type_ID));

--Create CD_Artists table
CREATE TABLE CD_Artists (
	Artist_ID		INT NOT NULL REFERENCES Artist(Artist_ID),
	CD_ID			INT NOT NULL REFERENCES CD(CD_ID));

--Create Borrowed table
CREATE TABLE Borrowed (
	Borrower_ID		INT NOT NULL PRIMARY KEY,
	Borrower_FName	VARCHAR(60) NOT NULL,
	Borrower_LName	VARCHAR(60) NOT NULL,
	Borrower_Phone	VARCHAR(60) NOT NULL);

--Create CD_Borrowed table
CREATE TABLE CD_Borrowed (
	Borrowed_date	DATETIME NOT NULL PRIMARY KEY,
	CD_ID			INT NOT NULL REFERENCES CD(CD_ID),
	Borrower_ID		INT NOT NULL REFERENCES Borrowed(Borrower_ID),
	Returned_Date	DATETIME NULL);


--Create new user diskUserXX
IF SUSER_ID('diskUserJK') is null
	CREATE LOGIN diskUserJK WITH PASSWORD ='Pa$$w0rd',
		DEFAULT_DATABASE = disk_inventoryJK;

DROP USER IF EXISTS diskUserJK;

CREATE USER diskUserJK FOR LOGIN diskUserJK;

--Alter server role to allow to read
ALTER ROLE db_datareader ADD MEMBER diskUserJK;

-- Insert data into the Status table
INSERT INTO Status 
	(Status_ID, Description)
Values 
	(1, 'Available'),
	(2, 'Borrowed'),
	(3, 'Damaged'),
	(4, 'Missing');

-- Insert data into the Genre table
INSERT INTO Genre 
	(Genre_ID, Description)
VALUES
	(1, 'Classic Rock'),
	(2, 'Country'),
	(3, 'Jazz'),
	(4, 'AltRock'),
	(5, 'Metal');

-- Insert data into the CD_Type table
INSERT INTO CD_Type
	(Type_ID, Description)
VALUES
	(1, 'CD'),
	(2, 'Vinyl'),
	(3, 'BTrack'),
	(4, 'Cassette'),
	(5, 'DVD');

--Insert data into the Artist_Type table
INSERT INTO Artist_Type 
	(Artist_Type_ID, Description)
VALUES
	(1, 'Solo'),
	(2, 'Group');

--Insert data into the Artist table
INSERT INTO Artist
	(Artist_ID, Artist_Name, Artist_Type_ID)
VALUES
	(1, 'Ozzy Osborne', 1),
	(2, 'Taylor Swift', 1),
	(3, 'Alanis Morrisette', 1),
	(4, 'Chris Daughtry', 1),
	(5, 'The Cars', 2),
	(6, 'Black Sabbath', 2),
	(7, 'The Eagles', 2),
	(8, 'Patsy Cline', 1),
	(9, 'Pearl Jam', 2),
	(10, 'Shinedown', 2),
	(11, 'Collective Soul', 2),
	(12, 'Five Finger Death Punch', 2),
	(13, 'Disturbed', 2),
	(14, 'Stone Temple Pilots', 2),
	(15, 'Breaking Benjamin', 2),
	(16, 'Seether', 2),
	(17, 'Sudioslave', 2),
	(18, 'Temple of the Dog', 2),
	(19, 'Alice in Chains', 2),
	(20, 'Willie Nelson', 1);

--Insert into the CD table
INSERT INTO CD 
	(CD_ID, CD_name, Release_Date, Genre_ID, Status_ID, Type_ID)
VALUES
(1, 'Crazy Train', '1/1/1995', 1, 1, 1),
(2, 'No More Tears', '11/21/1995', 1, 1, 1),
(3, 'Red', '11/13/2000', 2, 2, 1),
(4, 'Jagged Little Pill', '1/15/1995', 1, 2, 1),
(5, 'Candy-O', '10/10/1992', 1, 2, 2),
(6, 'Hotel California', '11/10/1977', 1, 2, 2),
(7, 'One of These Nights', '4/1/1975', 1, 2, 2),
(8, 'Hints, Allegations and Things Left Unsaid', '1/21/1999', 4, 2, 1),
(9, 'Blender', '1/29/2000', 4, 1, 2),
(10, 'Dirt', '1/27/1992', 1, 2, 3),
(11, 'Unplugged', '5/23/2000', 4, 1, 2),
(12, 'Facelift', '1/1/2000', 4, 2, 2),
(13, 'Black Gives Way to Blue', '11/21/2009', 4, 1, 2),
(14, 'Live', '11/11/2009', 4, 1, 2),
(15, 'Ten', '12/1/1991', 4, 1, 2),
(16, 'Vitalogy', '3/22/1994', 4, 1, 2),
(17, 'No Code', '4/2/1996', 4, 1, 2),
(18, 'Home', '1/19/1995', 1, 2, 1),
(19, 'Backspacer', '5/21/2000', 4, 1, 2),
(20, 'Disagree', '1/29/2008', 4, 1, 1);

--Update the CD table to adjust release date
UPDATE CD
	SET release_date = '11/11/2011'
	WHERE CD_ID = 20;
GO

--Insert into the CD_Artists table
INSERT INTO CD_Artists
	(CD_ID, Artist_ID)
VALUES
	(1,1),
	(2,1),
	(3,3),
	(4,4),
	(5,6),
	(6,8),
	(7,8),
	(8,8),
	(8,6),
	(8,7),
	(9,12),
	(10,12),
	(11,18),
	(12,16),
	(13,15),
	(14,15),
	(15,1),
	(18,1),
	(19,1),
	(20,1);

--Insert data into the CD Borrowed Table
INSERT INTO Borrowed
	(Borrower_ID, Borrower_FName, Borrower_LName, Borrower_Phone)
 VALUES
(1, 'John', 'Smith', '(208) 523-7852'),
(2, 'Jacob', 'Mathews', '(208) 423-5235'),
(3, 'Steve', 'Williams', '(208) 785-8523'),
(4, 'Phillip', 'Stevens', '(208) 314-1592'),
(5, 'Karen', 'Stevens', '(208) 653-4856'),
(6, 'Martin', 'Martinez', '(208) 795-3587'),
(7, 'Sally', 'Clark', '(208) 347-8462'),
(8, 'John', 'Baker', '(208) 258-3214'),
(9, 'John', 'Nelson', '(208) 123-4567'),
(10, 'Eric', 'Adams', '(208) 891-0111'),
(11, 'Troy', 'Scott', '(208) 212-2562'),
(12, 'Jaime', 'Rodriguez', '(208) 647-6258'),
(13, 'Jeff', 'Hill', '(208) 475-6952'),
(14, 'Laura', 'Taylor', '(208) 368-6541'),
(15, 'Steven', 'Lee', '(208) 321-6543'),
(16, 'Kat', 'Davis', '(208) 987-6543'),
(17, 'David', 'Jones', '(208) 210-3654'),
(18, 'Jackson', 'Moore', '(208) 945-2543'),
(19, 'Emilia', 'Walker', '(208) 478-7852'),
(20, 'Nathan', 'Young', '(208) 752-6547');
GO

--Delete the 20th line of the Borrowed table
DELETE Borrowed
WHERE Borrower_ID = 20;

--Insert data into the CD_Borrowed Table
INSERT INTO CD_Borrowed
	(Borrowed_date, Borrower_ID, CD_ID, Returned_Date) 
VALUES
('1/2/2019', 2, 4, '2/20/2019'),
('11/13/2019', 3, 5, '12/15/2019'),
('12/12/2019', 3, 6, '12/23/2019'),
('6/27/2019', 2, 7, '8/1/2019'),
('1/15/2019', 5, 2, '2/28/2019'),
('8/11/2019', 5, 7, '9/27/2019'),
('7/26/2019', 5, 7, '8/5/2019'),
('8/3/2019', 5, 8, '9/30/2019'),
('9/16/2019', 2, 4, '12/15/2019'),
('8/21/2019', 11, 14, NULL),
('6/25/2019', 6, 7, '8/1/2019'),
('5/5/2019', 1, 19, '7/1/2019'),
('3/4/2019', 7, 1, NULL),
('5/27/2019', 12, 15, '9/1/2019'),
('2/28/2019', 12, 14, '3/1/2019'),
('8/15/2019', 16, 6, '9/16/2019'),
('6/4/2019', 4, 7, '7/1/2019'),
('4/1/2019', 5, 6, '4/2/2019'),
('2/1/2019', 7, 8, '3/23/2019'),
('10/1/2019', 9, 10, '10/7/2019');
GO


--List teh Disks that have not been returned
SELECT Borrower_ID, CD_ID, Borrowed_date, Returned_Date
FROM CD_Borrowed
WHERE Returned_Date IS NULL
