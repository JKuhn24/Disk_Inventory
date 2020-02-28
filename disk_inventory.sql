/**************************************************
	Jeffrey Kuhn		2/28/20
	Modification Log: 
	2/28/20: SQL File created
**************************************************/
use master;
go

--Drop Database in case it already exists
DROP DATABASE IF EXISTS disk_inventoryJK;

--Create the database
CREATE DATABASE disk_inventoryJK;

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

--Create Artist table
CREATE TABLE Artist (
	Artist_ID		INT NOT NULL PRIMARY KEY,
	Artist_Name		VARCHAR(60) NOT NULL);

--Create Artist type table
CREATE TABLE Artist_Type (
	Artist_Type_ID	INT NOT NULL PRIMARY KEY,
	Artist_ID		INT NOT NULL REFERENCES Artist(Artist_ID),
	Description		VARCHAR(60) NOT NULL);

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
	Returned_Date	DATETIME NOT NULL);


--Create new user diskUserXX
IF SUSER_ID('diskUserJK') is null
	CREATE LOGIN diskUserJK WITH PASSWORD ='Pa$$w0rd',
		DEFAULT_DATABASE = disk_inventoryJK;

DROP USER IF EXISTS diskUserJK;

CREATE USER diskUserJK FOR LOGIN diskUserJK;

--Alter server role to allow to read
ALTER ROLE db_datareader ADD MEMBER diskUserJK;
