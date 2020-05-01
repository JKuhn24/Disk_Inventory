/**************************************************

	Jeffrey Kuhn		2/28/20

	Modification Log: 

	2/28/20: SQL File created

	3/2/20: Added go to after CREATE DATABASE disk_inventoryJK, added Artist_Type_ID as a FK to Artist, Added NULL to Returned date to allow NULLs

	3/5/20: Added code to insert data into the tables.

	3/12/2020: Added SQL statments under Project 4

	4/8/2020: Added Statments for Project 5. Changed tables to auto increment when needed.

	5/1/2020: Changed stored procedures to match project better.

**************************************************/

use master;

go



--Drop Database in case it already exists

DROP DATABASE IF EXISTS disk_inventoryJK;

GO

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

	CD_ID			INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	CD_name			VARCHAR(60) NOT NULL,

	Release_Date	DATE NOT NULL,

	Type_ID			INT NOT NULL REFERENCES CD_Type(Type_ID),

	Status_ID		INT NOT NULL REFERENCES Status(Status_ID),

	Genre_ID		INT NOT NULL REFERENCES Genre(Genre_ID));



--Create Artist type table

CREATE TABLE Artist_Type (

	Artist_Type_ID	INT NOT NULL PRIMARY KEY,

	Description		VARCHAR(60) NOT NULL);



--Create Artist table

CREATE TABLE Artist (

	Artist_ID		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	Artist_Name		VARCHAR(60) NOT NULL,

	Artist_Type_ID	INT NOT NULL REFERENCES Artist_Type(Artist_Type_ID));



--Create CD_Artists table

CREATE TABLE CD_Artists (

	Artist_ID		INT NOT NULL REFERENCES Artist(Artist_ID),

	CD_ID			INT NOT NULL REFERENCES CD(CD_ID));



--Create Borrowed table

CREATE TABLE Borrowed (

	Borrower_ID		INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

	Borrower_FName	VARCHAR(60) NOT NULL,

	Borrower_LName	VARCHAR(60) NOT NULL,

	Borrower_Phone	VARCHAR(60) NOT NULL);



--Create CD_Borrowed table

CREATE TABLE CD_Borrowed (

	Borrowed_date	DATE NOT NULL PRIMARY KEY,

	CD_ID			INT NOT NULL REFERENCES CD(CD_ID),

	Borrower_ID		INT NOT NULL REFERENCES Borrowed(Borrower_ID),

	Returned_Date	DATE NULL);





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

	(Artist_Name, Artist_Type_ID)

VALUES

	( 'Ozzy Osborne', 1),

	( 'Taylor Swift', 1),

	( 'Alanis Morrisette', 1),

	( 'Chris Daughtry', 1),

	( 'The Cars', 2),

	( 'Black Sabbath', 2),

	( 'The Eagles', 2),

	( 'Patsy Cline', 1),

	( 'Pearl Jam', 2),

	( 'Shinedown', 2),

	( 'Collective Soul', 2),

	( 'Five Finger Death Punch', 2),

	( 'Disturbed', 2),

	( 'Stone Temple Pilots', 2),

	( 'Breaking Benjamin', 2),

	( 'Seether', 2),

	( 'Sudioslave', 2),

	( 'Temple of the Dog', 2),

	( 'Alice in Chains', 2),

	( 'Willie Nelson', 1);



--Insert into the CD table

INSERT INTO CD 

	(CD_name, Release_Date, Genre_ID, Status_ID, Type_ID)

VALUES

('Crazy Train', '1/1/1995', 1, 1, 1),

('No More Tears', '11/21/1995', 1, 1, 1),

('Red', '11/13/2000', 2, 2, 1),

('Jagged Little Pill', '1/15/1995', 1, 2, 1),

('Candy-O', '10/10/1992', 1, 2, 2),

('Hotel California', '11/10/1977', 1, 2, 2),

('One of These Nights', '4/1/1975', 1, 2, 2),

('Hints, Allegations and Things Left Unsaid', '1/21/1999', 4, 2, 1),

('Blender', '1/29/2000', 4, 1, 2),

('Dirt', '1/27/1992', 1, 2, 3),

('Unplugged', '5/23/2000', 4, 1, 2),

('Facelift', '1/1/2000', 4, 2, 2),

('Black Gives Way to Blue', '11/21/2009', 4, 1, 2),

('Live', '11/11/2009', 4, 1, 2),

('Ten', '12/1/1991', 4, 1, 2),

('Vitalogy', '3/22/1994', 4, 1, 2),

('No Code', '4/2/1996', 4, 1, 2),

('Home', '1/19/1995', 1, 2, 1),

('Backspacer', '5/21/2000', 4, 1, 2),

('Disagree', '1/29/2008', 4, 1, 1);



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

	(Borrower_FName, Borrower_LName, Borrower_Phone)

 VALUES

('John', 'Smith', '(208) 523-7852'),

('Jacob', 'Mathews', '(208) 423-5235'),

('Steve', 'Williams', '(208) 785-8523'),

('Phillip', 'Stevens', '(208) 314-1592'),

('Karen', 'Stevens', '(208) 653-4856'),

('Martin', 'Martinez', '(208) 795-3587'),

('Sally', 'Clark', '(208) 347-8462'),

('John', 'Baker', '(208) 258-3214'),

('John', 'Nelson', '(208) 123-4567'),

('Eric', 'Adams', '(208) 891-0111'),

('Troy', 'Scott', '(208) 212-2562'),

('Jaime', 'Rodriguez', '(208) 647-6258'),

('Jeff', 'Hill', '(208) 475-6952'),

('Laura', 'Taylor', '(208) 368-6541'),

('Steven', 'Lee', '(208) 321-6543'),

('Kat', 'Davis', '(208) 987-6543'),

('David', 'Jones', '(208) 210-3654'),

('Jackson', 'Moore', '(208) 945-2543'),

('Emilia', 'Walker', '(208) 478-7852'),

('Nathan', 'Young', '(208) 752-6547');

GO



--Delete the 20th line of the Borrowed table

--DELETE Borrowed

--WHERE Borrower_ID = 20;



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



/***************************************

			PROJECT 4

***************************************/





--3. Display the disk name, the release date and the artist name of disks with only indiviual artists

SELECT CD_name AS 'Disk Name', Release_Date AS 'Release Date', SUBSTRING(Artist_Name, 1, CHARINDEX(' ', Artist_Name)) AS 'Artist First Name',

	SUBSTRING(Artist_Name, CHARINDEX(' ', Artist_Name) + 1, 10) AS 'Artist Last Name'

FROM CD JOIN CD_Artists

	ON CD.CD_ID = CD_Artists.CD_ID

	JOIN Artist ON CD_Artists.Artist_ID = Artist.Artist_ID

WHERE Artist.Artist_Type_ID = 1

ORDER BY [Artist First Name];

GO



--4. Create a View and display the artist names. Include the Artist ID in the View, but don't display it

DROP VIEW IF EXISTS View_Individual_Artist;

GO



CREATE VIEW View_Individual_Artist

AS

	SELECT Artist_ID, Artist_Name, Artist_Type_ID

	FROM Artist

	WHERE Artist_Type_ID = 1;

GO



SELECT SUBSTRING(Artist_Name, 1, CHARINDEX(' ', Artist_Name)) AS FirstName, 

	SUBSTRING(Artist_Name, CHARINDEX(' ', Artist_Name) + 1, 10) AS LastName

FROM View_Individual_Artist

ORDER BY FirstName, LastName;

GO



--5. Display Disk Name, Release Date and the Group Name of the disks that involve a group. Use View_Individual_Artist view.

SELECT CD_name AS 'Disk Name', Release_Date AS 'Release Date', Artist_Name AS 'Group Name'

FROM CD JOIN CD_Artists

	ON CD.CD_ID = CD_Artists.CD_ID

	JOIN Artist ON CD_Artists.Artist_ID = Artist.Artist_ID

WHERE Artist.Artist_ID NOT IN (SELECT Artist_ID FROM View_Individual_Artist)

ORDER BY [Group Name];

GO



--6. Show the name of borrower, the disk and the borrowed/returned dates of borrowed disks

SELECT Borrower_FName AS 'First Name', Borrower_LName AS 'Last Name', CD_name AS 'CD Name', Borrowed_date AS 'Borrowed Date', Returned_Date AS 'Returned Date'

FROM Borrowed JOIN CD_Borrowed

	ON Borrowed.Borrower_ID = CD_Borrowed.Borrower_ID

	JOIN CD ON CD_Borrowed.CD_ID = CD.CD_ID

ORDER BY CD_name, Borrower_LName, Borrower_FName, Borrowed_date, Returned_Date;

GO



--7. Show the number of times each disk has been borrowed

SELECT CD.CD_ID AS 'CD ID', CD_name AS 'CD Name', COUNT(*) AS 'Times borrowed'

FROM CD JOIN CD_Borrowed

	ON CD_Borrowed.CD_ID = CD.CD_ID

	JOIN Borrowed ON Borrowed.Borrower_ID = CD_Borrowed.Borrower_ID

GROUP BY CD.CD_ID, CD_name

ORDER BY CD.CD_ID;

GO



--8. Show the disks that have yet to be returned

SELECT CD_name AS 'CD Name', Borrowed_date AS 'Borrowed Date', Returned_date AS 'Returned Date', Borrower_LName AS'Last Name'

FROM CD JOIN CD_Borrowed

	ON CD_Borrowed.CD_ID = CD.CD_ID

	JOIN Borrowed ON Borrowed.Borrower_ID = CD_Borrowed.Borrower_ID

WHERE Returned_Date IS NULL;

GO





/***************************************

			PROJECT 5

***************************************/



--2.

USE [disk_inventoryJK]

GO



-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_insert_artist;

GO



--Create procedure to insert data into Artist

CREATE PROCEDURE sp_insert_artist

@Artist_Name varchar(60), @Artist_Type_ID int

AS

BEGIN TRY

	INSERT INTO [dbo].[Artist]

			   ([Artist_Name]

			   ,[Artist_Type_ID])

		 VALUES

			   ( @Artist_Name

			   , @Artist_Type_ID)

END TRY

BEGIN CATCH

	PRINT 'There was an error';

	PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_insert_artist TO diskUserJK;

GO				  



--Execute the stored procedure

EXEC sp_insert_artist 'name', 2;

GO

				  

-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_update_artist

GO



--Create procedure to update Artist

CREATE PROCEDURE sp_update_artist

	@Artist_ID int, @Artist_Name varchar(60), @Artist_Type_ID int

AS

	BEGIN TRY

	UPDATE [dbo].[Artist]

			 SET	[Artist_Name] = @Artist_Name

					,[Artist_Type_ID] = @Artist_Type_ID

			WHERE Artist_ID = @Artist_ID

	END TRY

	BEGIN CATCH

		PRINT 'There was an error';

		PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

	END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_update_artist TO diskUserJK;

GO

					  

--Execute the stored procedure

EXEC sp_update_artist 21, 'updated', 2;

GO



-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_delete_artist

GO



-- Create procedure to delete column from Artist

CREATE PROCEDURE sp_delete_artist

	@Artist_ID int

AS

	BEGIN TRY

		DELETE FROM [dbo].[Artist]

			WHERE Artist_ID = @Artist_ID

	END TRY

	BEGIN CATCH

		PRINT 'There was an error';

		PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

	END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_delete_artist TO diskUserJK;

GO

					  

--Execute the stored procedure

EXEC sp_delete_artist 21;

GO





--3.



-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_insert_borrower;

GO





-- Create procedure to insert data into Borrowed

CREATE PROCEDURE sp_insert_borrower

@Borrower_FName varchar(60), @Borrower_LName VARCHAR(60), @Borrower_Phone VARCHAR(60)

AS

BEGIN TRY

	INSERT INTO [dbo].[Borrowed]

			   (Borrower_FName

			   ,Borrower_LName

			   ,Borrower_Phone)

		 VALUES

			   ( @Borrower_FName

			   , @Borrower_LName

			   , @Borrower_Phone)

END TRY

BEGIN CATCH

	PRINT 'There was an error';

	PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_insert_borrower TO diskUserJK;

GO



--Execute the stored procedure

EXEC sp_insert_borrower 'fname', 'lname', 'number';

GO



-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_update_borrower

GO



--Create procedure to update data in Borrowed

CREATE PROCEDURE sp_update_borrower

	@Borrower_ID int, @Borrower_FName varchar(60), @Borrower_LName VARCHAR(60), @Borrower_Phone VARCHAR(60)

AS

	BEGIN TRY

	UPDATE [dbo].[Borrowed]

			 SET	Borrower_FName = @Borrower_FName

					,Borrower_LName = @Borrower_LName

					,Borrower_Phone = @Borrower_Phone

			WHERE Borrower_ID = @Borrower_ID

	END TRY

	BEGIN CATCH

		PRINT 'There was an error';

		PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

	END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_update_borrower TO diskUserJK;

GO



--Execute the stored procedure

EXEC sp_update_borrower 21, 'updatedfname', 'updatedlname', 'updatednumber';

GO





-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_delete_borrower

GO



--Create procedure to delete data from borrowed

CREATE PROCEDURE sp_delete_borrower

	@Borrower_ID int

AS

	BEGIN TRY

		DELETE FROM [dbo].[Borrowed]

			WHERE Borrower_ID = @Borrower_ID

	END TRY

	BEGIN CATCH

		PRINT 'There was an error';

		PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

	END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_delete_borrower TO diskUserJK;

GO



--Execute the stored procedure

EXEC sp_delete_borrower 21;

GO

EXEC sp_delete_borrower 2;

GO



--4.



-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_insert_CD;

GO



--Create procedure to insert data into CD

CREATE PROCEDURE sp_insert_CD

@CD_name varchar(60), @Release_Date date, @Type_ID int, @Status_ID int, @Genre_ID int

AS

BEGIN TRY

	INSERT INTO [dbo].[CD]

			   (CD_name

			   ,Release_Date

			   ,Type_ID

			   ,Status_ID

			   , Genre_ID)

		 VALUES

			   ( @CD_name

			   , @Release_Date

			   , @Type_ID

			   , @Status_ID

			   , @Genre_ID)

END TRY

BEGIN CATCH

	PRINT 'There was an error';

	PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

END CATCH

GO



--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_insert_CD TO diskUserJK;

GO

				  

EXEC sp_insert_CD 'name', '2/2/2020', 2, 2, 2;

GO

				  

-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_update_CD

GO



--Create Procedure to update data in CD

CREATE PROCEDURE sp_update_CD

	@CD_ID int, @CD_name varchar(60), @Release_Date date, @Type_ID int, @Status_ID int, @Genre_ID int

AS

	BEGIN TRY

	UPDATE [dbo].[CD]

			SET CD_name = @CD_name

			   ,Release_Date = @Release_Date

			   ,Type_ID = @Type_ID

			   ,Status_ID = @Status_ID

			   , Genre_ID = @Genre_ID

			WHERE CD_ID = @CD_ID

	END TRY

	BEGIN CATCH

		PRINT 'There was an error';

		PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

	END CATCH

GO





--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_update_CD TO diskUserJK;



--Execute the stored procedure

EXEC sp_update_CD 21, 'name', '2/2/2020', 2, 2, 2;





-- Drop the stored procedure if it already exists

DROP PROCEDURE IF EXISTS sp_delete_CD

GO



--Create procedure to delete data in CD

CREATE PROCEDURE sp_delete_CD

	@CD_ID int

AS

	BEGIN TRY

		DELETE FROM [dbo].[CD]

			WHERE CD_ID = @CD_ID

	END TRY

	BEGIN CATCH

		PRINT 'There was an error';

		PRINT 'Message' + CONVERT(VARCHAR(200), ERROR_MESSAGE());

	END CATCH

GO





--Give permission to execute stored procedure to user

GRANT EXECUTE ON sp_delete_CD TO diskUserJK;

GO

					  

--Execute the stored procedure

EXEC sp_delete_CD 21;

GO					  

EXEC sp_delete_CD 2;

GO	
