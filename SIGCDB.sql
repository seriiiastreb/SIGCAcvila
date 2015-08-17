-- SQL Manager 2008 for SQL Server 3.3.0.1
-- ---------------------------------------
-- Host      : SQL5013.Smarterasp.net
-- Database  : DB_9CAC4C_sigc
-- Version   : Microsoft SQL Server  11.0.5058.0


CREATE DATABASE [DB_9CAC4C_sigc]
ON PRIMARY
  ( NAME = [DB_9CAC4C_sigc_Data],
    FILENAME = 'H:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DB_9CAC4C_sigc_DATA.mdf',
    SIZE = 4 MB,
    MAXSIZE = 500 MB,
    FILEGROWTH = 10 % )
LOG ON
  ( NAME = [DB_9CAC4C_sigc_Log],
    FILENAME = 'H:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DB_9CAC4C_sigc_Log.LDF',
    SIZE = 3 MB,
    MAXSIZE = 0 MB,
    FILEGROWTH = 10 % )
COLLATE SQL_Latin1_General_CP1_CI_AS
GO

USE [DB_9CAC4C_sigc]
GO

--
-- Definition for table Classifiers : 
--

CREATE TABLE [dbo].[Classifiers] (
  [TypeID] int NOT NULL,
  [Code] int IDENTITY(1, 1) NOT NULL,
  [Name] nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Description] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [GroupCode] int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ClassifierType : 
--

CREATE TABLE [dbo].[ClassifierType] (
  [TypeID] int IDENTITY(1, 1) NOT NULL,
  [Name] nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [ParentID] int CONSTRAINT [DF_ClassifierType_ParentID] DEFAULT 0 NOT NULL,
  [system] bit NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Client : 
--

CREATE TABLE [dbo].[Client] (
  [clientID] int IDENTITY(1, 1) NOT NULL,
  [gender] int NOT NULL,
  [FirstName] nvarchar(50) COLLATE Romanian_CI_AS NOT NULL,
  [LastName] nvarchar(50) COLLATE Romanian_CI_AS NULL,
  [DateOfBirth] datetime NULL,
  [personalID] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [buletinSeria] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [dataEliberarii] datetime NULL,
  [dataExpirarii] datetime NULL,
  [eliberatDe] nvarchar(100) COLLATE Cyrillic_General_CI_AS NULL,
  [telefonFix] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [telefonMobil] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [viza_country] int NULL,
  [viza_raion] int NULL,
  [viza_localitatea] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [viza_stradaAdresa] nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [email] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [sortGroup] int NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ClientContracts : 
--

CREATE TABLE [dbo].[ClientContracts] (
  [client_id] int NOT NULL,
  [contract_id] int IDENTITY(1, 1) NOT NULL,
  [contract_nr] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [date_from] date NOT NULL,
  [date_to] date NULL,
  [active] bit NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ClientOrders : 
--

CREATE TABLE [dbo].[ClientOrders] (
  [order_id] int IDENTITY(1, 1) NOT NULL,
  [state] int NOT NULL,
  [date] date NOT NULL,
  [client_id] int NOT NULL,
  [nr] int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table InWey : 
--

CREATE TABLE [dbo].[InWey] (
  [product_id] int NOT NULL,
  [week] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [quantity] decimal(10, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Kanban : 
--

CREATE TABLE [dbo].[Kanban] (
  [product_id] int NOT NULL,
  [quantity] decimal(10, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Livrari : 
--

CREATE TABLE [dbo].[Livrari] (
  [product_id] int NOT NULL,
  [week] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [quantity] decimal(10, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table logs : 
--

CREATE TABLE [dbo].[logs] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [eventdate] datetime NOT NULL,
  [eventtype] nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [message] text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [userID] int NOT NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table Orders : 
--

CREATE TABLE [dbo].[Orders] (
  [product_id] int NOT NULL,
  [week] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [quantity] decimal(10, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ProductDetails : 
--

CREATE TABLE [dbo].[ProductDetails] (
  [product_id] int IDENTITY(1, 1) NOT NULL,
  [articol] int NOT NULL,
  [desen] int NOT NULL,
  [tip] int NOT NULL,
  [colorit] int NOT NULL,
  [latime] decimal(18, 2) NOT NULL,
  [lungime] decimal(18, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table st_domains : 
--

CREATE TABLE [dbo].[st_domains] (
  [module_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [domain_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [description] nvarchar(256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table st_modules : 
--

CREATE TABLE [dbo].[st_modules] (
  [module_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [description] nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table st_roles : 
--

CREATE TABLE [dbo].[st_roles] (
  [role_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table st_roles_permissions : 
--

CREATE TABLE [dbo].[st_roles_permissions] (
  [module_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [role_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [domain_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [permissions] int NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table st_users_roles : 
--

CREATE TABLE [dbo].[st_users_roles] (
  [user_id] int NOT NULL,
  [role_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Stok : 
--

CREATE TABLE [dbo].[Stok] (
  [product_id] int NOT NULL,
  [week] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [quantity] decimal(10, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table users : 
--

CREATE TABLE [dbo].[users] (
  [userid] int IDENTITY(1, 1) NOT NULL,
  [Nume] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Prenume] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [login] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [password] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [passwordstatus] int NULL,
  [recordstatus] int NOT NULL,
  [email] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [sysadmin] bit CONSTRAINT [DF__users__sysadmin__3F466844] DEFAULT 0 NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Vinzari : 
--

CREATE TABLE [dbo].[Vinzari] (
  [product_id] int NOT NULL,
  [week] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [quantity] decimal(10, 2) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table weeks : 
--

CREATE TABLE [dbo].[weeks] (
  [week] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for user-defined function MaxVAL : 
--
GO
CREATE FUNCTION [dbo].MaxVAL(@value1 numeric, @value2 numeric)
RETURNS numeric WITH EXECUTE AS CALLER
AS

BEGIN
DECLARE @result int;

RETURN 
(
	SELECT MAX(TempTB.VV) FROM (
		SELECT @value1 as VV
		UNION ALL
		SELECT @value2  as VV) TempTB 
);
END;
GO

--
-- Data for table dbo.Classifiers  (LIMIT 0,50000)
--

SET IDENTITY_INSERT [dbo].[Classifiers] ON
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (0, 0, N'**', N'Nespecificat', NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (5, 1, N'RO', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (5, 2, N'RU', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (5, 3, N'EN', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (2, 6, N'Password Active', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (2, 7, N'Password Need Change', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (6, 8, N'Record Active', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (6, 9, N'Record Blocked', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (6, 10, N'Record Not Activated', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (7, 11, N'Standard', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (7, 12, N'Advanced', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (7, 13, N'Simple', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 14, N'Afganistan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 15, N'Africa de Sud', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 16, N'Albania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 17, N'Algeria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 18, N'Andorra', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 19, N'Angola', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 20, N'Antigua Si Barbuda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 21, N'Arabia Saudita', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 22, N'Argentina', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 23, N'Armenia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 24, N'Australia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 25, N'Austria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 26, N'Azerbaidjan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 27, N'Bahamas', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 28, N'Bahrain', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 29, N'Bangladesh', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 30, N'Barbados', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 31, N'Belarus', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 32, N'Belgia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 33, N'Belize', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 34, N'Benin', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 35, N'Bhutan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 36, N'Birmania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 37, N'Bolivia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 38, N'Bosnia si Hertegovina', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 39, N'Botswana', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 40, N'Brazilia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 41, N'Brunei', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 42, N'Bulgaria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 43, N'Burkina Faso', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 44, N'Burundi', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 45, N'Cambodgia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 46, N'Camerun', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 47, N'Canada', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 48, N'Capul Verde', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 49, N'Cehia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 50, N'Republica Centrafricana', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 51, N'Chile', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 52, N'Republica Populara Chineza', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 53, N'Ciad', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 54, N'Cipru', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 55, N'Columbia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 56, N'Comore', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 57, N'Republica Democrata Congo', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 58, N'Republica Congo', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 59, N'Coreea de Nord', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 60, N'Coreea de Sud', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 61, N'Costa Rica', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 62, N'Cote d''Ivoire', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 63, N'Croatia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 64, N'Cuba', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 65, N'Danemarca', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 66, N'Djibouti', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 67, N'Dominica', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 68, N'Republica Dominicana', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 69, N'Ecuador', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 70, N'Egipt', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 71, N'El Salvador', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 72, N'Elvetia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 73, N'Emiratele Arabe Unite', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 74, N'Eritreea', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 75, N'Estonia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 76, N'Etiopia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 77, N'Fiji', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 78, N'Filipine', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 79, N'Finlanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 80, N'Franta', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 81, N'Gabon', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 82, N'Gambia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 83, N'Georgia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 84, N'Germania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 85, N'Ghana', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 86, N'Grecia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 87, N'Grenada', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 88, N'Guatemala', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 89, N'Guineea', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 90, N'Guineea Bissau', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 91, N'Guineea Ecuatoriala', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 92, N'Guyana', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 93, N'Haiti', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 94, N'Honduras', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 95, N'India', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 96, N'Indonezia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 97, N'Iordania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 98, N'Irak', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 99, N'Iran', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 100, N'Irlanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 101, N'Islanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 102, N'Israel', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 103, N'Italia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 104, N'Jamaica', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 105, N'Japonia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 106, N'Kazahstan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 107, N'Kenya', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 108, N'Kargazstan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 109, N'Kiribati', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 110, N'Kuweit', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 111, N'Laos', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 112, N'Lesotho', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 113, N'Letonia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 114, N'Liban', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 115, N'Liberia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 116, N'Libia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 117, N'Liechtenstein', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 118, N'Lituania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 119, N'Luxemburg', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 120, N'Republica Macedonia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 121, N'Madagascar', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 122, N'Malawi', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 123, N'Malaezia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 124, N'Maldive', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 125, N'Mali', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 126, N'Malta', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 127, N'Maroc', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 128, N'Insulele Marshall', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 129, N'Mauritania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 130, N'Mauritius', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 131, N'Mexic', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 132, N'Statele Federate ale Microneziei', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 133, N'Republica Moldova', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 134, N'Monaco', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 135, N'Mongolia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 136, N'Mozambic', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 137, N'Muntenegru', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 138, N'Namibia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 139, N'Nauru', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 140, N'Nepal', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 141, N'Nicaragua', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 142, N'Niger', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 143, N'Nigeria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 144, N'Norvegia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 145, N'Noua Zeelanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 146, N'Olanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 147, N'Oman', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 148, N'Pakistan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 149, N'Palau', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 150, N'Panama', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 151, N'Papua Noua Guinee', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 152, N'Paraguay', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 153, N'Peru', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 154, N'Polonia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 155, N'Portugalia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 156, N'Qatar', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 157, N'Regatul Unit al Marii Britanii', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 158, N'Romania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 159, N'Rusia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 160, N'Rwanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 161, N'Samoa', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 162, N'San Marino', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 163, N'Sao Tome si Principe', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 164, N'Senegal', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 165, N'Serbia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 166, N'Seychelles', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 167, N'Sfanta Lucia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 168, N'Sfantul Cristofor si Nevis', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 169, N'Sfantul Vincent si Grenadine', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 170, N'Sierra Leone', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 171, N'Singapore', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 172, N'Siria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 173, N'Slovacia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 174, N'Slovenia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 175, N'Insulele Solomon', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 176, N'Somalia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 177, N'Spania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 178, N'Sri Lanka', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 179, N'Statele Unite ale Americii', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 180, N'Sudan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 181, N'Sudanul de Sud', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 182, N'Suedia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 183, N'Surinam', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 184, N'Swaziland', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 185, N'Tadjikistan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 186, N'Tanzania', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 187, N'Thailanda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 188, N'Timorul de Est', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 189, N'Togo', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 190, N'Tonga', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 191, N'Trinidad Tobago', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 192, N'Tunisia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 193, N'Turcia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 194, N'Turkmenistan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 195, N'Tuvalu', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 196, N'Ucraina', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 197, N'Uganda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 198, N'Ungaria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 199, N'Uruguay', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 200, N'Uzbekistan', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 201, N'Vanuatu', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 202, N'Vatican', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 203, N'Venezuela', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 204, N'Vietnam', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 205, N'Yemen', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 206, N'Zambia', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (3, 207, N'Zimbabwe', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (4, 209, N'Persoana fizica', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 210, N'Balti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 211, N'Anenii Noi', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 212, N'Basarabeasca', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 213, N'Briceni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 214, N'Cahul', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 215, N'Cantemir', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 216, N'Calarasi', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 217, N'Causeni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 218, N'Cimislia', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 219, N'Criuleni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 220, N'Donduseni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 221, N'Drochia', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 222, N'Dubasari', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 223, N'Edinet', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 224, N'Falesti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 225, N'Floresti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 226, N'Glodeni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 227, N'Hincesti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 228, N'Ialoveni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 229, N'Leova', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 230, N'Nisporeni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 231, N'Ocnita', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 232, N'Orhei', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 233, N'Rezina', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 234, N'Riscani', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 235, N'Singerei', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 236, N'Soroca', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 237, N'Straseni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 238, N'Soldanesti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 239, N'Stefan Voda', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 240, N'Taraclia', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 241, N'Telenesti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 242, N'Ungheni', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 260, N'Ciadir Lunga', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 261, N'Comrat', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 262, N'Lipcani', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 263, N'Ribnita', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 264, N'Vulcanesti', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 265, N'Tiraspol', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (8, 266, N'Bender', NULL, 133)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (37, 267, N'View', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (37, 268, N'Edit', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (37, 269, N'Deny', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (4, 270, N'Persoana juridica', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 271, N'*High Weave*', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 272, N'Afshar', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 273, N'Angora-I', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 274, N'Aquarelle', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 275, N'Aquarelle 8', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 276, N'Arabesque', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 277, N'Astoria', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 278, N'Bella', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 279, N'Berber', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 280, N'Blues', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (52, 281, N'Solicitat', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (52, 282, N'Confirmat', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (52, 283, N'Executat', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (52, 284, N'Anulat', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 285, N'1', NULL, 1)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 286, N'Covor oval', NULL, 2)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 287, N'Covor cerc', NULL, 3)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 288, N'4', NULL, 4)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 289, N'Covor forma neregulata', NULL, 5)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 290, N'Covor poliedru', NULL, 6)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 291, N'Mostre', NULL, 7)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 292, N'Mocheta', NULL, 8)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 293, N'Traversa nestandarta', NULL, 9)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 294, N'0312', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 295, N'1039', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 296, N'0449', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 297, N'0884', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 298, N'4316', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 299, N'2679', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 300, N'0467', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 301, N'2901', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 302, N'0115', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 303, N'4329', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 304, N'31408', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 305, N'20533', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 306, N'20223', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 307, N'91722', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 308, N'20900', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 309, N'21142', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 310, N'01442', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 311, N'00211', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 312, N'59955', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 313, N'41100', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 314, N'Beige', NULL, 1)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 315, N'Black', NULL, 2)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 316, N'Blue', NULL, 3)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 317, N'Bordo', NULL, 4)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 318, N'Brick', NULL, 5)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 319, N'Brown', NULL, 6)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 320, N'Gold', NULL, 7)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 321, N'Green', NULL, 8)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 322, N'Grey', NULL, 9)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (56, 323, N'Grey', NULL, 10)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 324, N'cu banda textila', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 325, N'Fara feston', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 326, N'franjuri tip 1', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 327, N'franjuri tip 2', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 328, N'lungime', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 329, N'lungime + latime', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 330, N'lungime + protex', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 331, N'pe 3 laturi + protex', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 332, N'piele + franjuri tip 2', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 333, N'termolux', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (57, 334, N'termolux + protex', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (58, 335, N'Covoare stoc rest', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (58, 336, N'Covoare bufer', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (58, 337, N'Covoare defecte', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 338, N'44955', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 339, N'44966', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 340, N'41055', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 341, N'3895', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 342, N'3896', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 343, N'3897', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 344, N'4261', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 345, N'0641', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 348, N'Eco', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 349, N'6451', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 350, N'59944', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 351, N'641', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 352, N'2500', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 353, N'41036', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 354, N'2542', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 355, N'41033', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 356, N'3164', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (53, 357, N'2', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 358, N'6475', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 359, N'8229', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 360, N'41034', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 361, N'8230', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 362, N'6454', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 363, N'6518', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 364, N'255', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 365, N'50635', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 366, N'320', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 367, N'50633', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 368, N'539', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 369, N'50655', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 370, N'2637', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 371, N'50643', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 372, N'235', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 373, N'43255', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 374, N'1597', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 375, N'43254', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 376, N'3130', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 377, N'43235', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 378, N'3972', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 379, N'8222', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 380, N'8225', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 381, N'8287', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 382, N'43251', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 383, N'8288', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 384, N'8308', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 385, N'8289', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 386, N'43244', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 387, N'8299', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 388, N'Jazz', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 389, N'1595', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 390, N'15022', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 391, N'1599', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 392, N'15055', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 393, N'1600', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 394, N'1612', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 395, N'1617', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 396, N'1713', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 397, N'Premium', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 398, N'281', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 399, N'50634', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 400, N'370', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 401, N'384', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 402, N'2518', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 403, N'Rainbow', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 404, N'3695', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 405, N'3877', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 406, N'44988', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 407, N'Relax', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 408, N'1598', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 409, N'1605', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 410, N'1610', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 411, N'1613', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 412, N'1703', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 413, N'6446', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 414, N'15035', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 415, N'8072', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 416, N'15034', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 417, N'Ritm', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 418, N'0312', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 419, N'20221', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 420, N'3583', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 421, N'20222', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 422, N'20433', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 423, N'4203', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 424, N'4266', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 425, N'20444', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 426, N'4629', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 427, N'21422', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 428, N'4656', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 429, N'21433', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 430, N'4662', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 431, N'20224', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 432, N'4672', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 433, N'4719', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 434, N'4783', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 435, N'Shaggy Solo', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 436, N'1033', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 437, N'33148', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 438, N'1037', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 439, N'1038', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 440, N'33117', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 441, N'1050', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 442, N'1051', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 443, N'1053', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 444, N'1055', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 445, N'1090', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 446, N'1182', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 447, N'1337', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 448, N'1342', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 449, N'Super Shaggy', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 450, N'1067', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 451, N'30334', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 452, N'Veranda', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 453, N'4691', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 454, N'23811', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 455, N'4692', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 456, N'4693', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 457, N'4697', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 458, N'3587', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 459, N'41066', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 460, N'801', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 461, N'449', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 462, N'3322', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 463, N'41032', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 464, N'41044', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 465, N'391', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 466, N'Kids', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 467, N'8025', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 468, N'44956', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 469, N'8027', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 470, N'44975', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 471, N'8022', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 472, N'44961', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 473, N'8018', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 474, N'44923', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 475, N'8020', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 476, N'Matrix', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 477, N'1725', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 478, N'1720', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 479, N'15033', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 480, N'Torino', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 481, N'4676', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 482, N'23244', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 483, N'4681', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 484, N'23234', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 485, N'4711', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 486, N'23233', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 487, N'312', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 488, N'103', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 489, N'172', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 490, N'410', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 491, N'41046', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 492, N'2437', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 493, N'41035', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 494, N'3024', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 495, N'3618', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 496, N'3640', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 497, N'44946', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 498, N'3789', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 499, N'43234', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 500, N'3791', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 501, N'3903', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 502, N'3914', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 503, N'43222', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 504, N'6100', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 505, N'6180', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 506, N'43231', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 507, N'8023', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 508, N'8035', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 509, N'8166', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 510, N'44933', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 511, N'8168', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 512, N'8170', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 513, N'8173', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 514, N'43232', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 515, N'8193', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 516, N'44942', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 517, N'8194', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 518, N'8195', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 519, N'8196', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 520, N'44924', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 521, N'8221', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 522, N'8255', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 523, N'2856', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 524, N'53477', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 525, N'6650', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 526, N'53488', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 527, N'6668', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 528, N'53455', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 529, N'6696', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 530, N'50055', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 531, N'6735', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 532, N'6752', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 533, N'6750', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 534, N'20733', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 535, N'4087', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 536, N'4238', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 537, N'4537', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 538, N'4548', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 539, N'4589', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 540, N'4600', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 541, N'4649', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 542, N'4668', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 543, N'4712', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 544, N'21455', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 545, N'4742', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 546, N'Confetti', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 547, N'3091', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 548, N'3613', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 549, N'41054', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 550, N'3912', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 551, N'6644', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 552, N'59933', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 553, N'Elegance', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 554, N'6223', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 555, N'50653', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 556, N'6270', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 557, N'6285', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 558, N'50663', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 559, N'6680', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 560, N'50033', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 561, N'Folk', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 562, N'8087', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 563, N'Lux', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 564, N'6463', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 565, N'41213', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 566, N'8161', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 567, N'41234', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 568, N'8162', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 569, N'41233', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 570, N'8163', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 571, N'1670', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 572, N'15042', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 573, N'1680', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 574, N'15533', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 575, N'1697', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 576, N'15522', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 577, N'1699', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 578, N'1700', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 579, N'1759', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 580, N'1789', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 581, N'2983', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 582, N'50613', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 583, N'6322', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 584, N'6767', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 585, N'50637', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 586, N'6768', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 587, N'6769', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 588, N'6770', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 589, N'Shaggy Lama', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 590, N'33026', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 591, N'33051', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 592, N'33053', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 593, N'33218', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 594, N'33253', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 595, N'33254', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 596, N'33263', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 597, N'33028', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 598, N'Soho', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 599, N'1715', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 600, N'1716', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 601, N'1737', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 602, N'Torino 10', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 603, N'4687', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 604, N'4710', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (51, 605, N'Vivaldi', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 606, N'6672', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 607, N'50423', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 608, N'6673', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 609, N'50433', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 610, N'6675', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 611, N'6676', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (55, 612, N'50477', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (54, 613, N'8215', NULL, NULL)
GO

SET IDENTITY_INSERT [dbo].[Classifiers] OFF
GO

--
-- Data for table dbo.ClassifierType  (LIMIT 0,50000)
--

SET IDENTITY_INSERT [dbo].[ClassifierType] ON
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (0, N'', 0, 1)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (2, N'Password Status', 0, 1)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (3, N'Country', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (4, N'Tip persoana', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (5, N'Language List', 0, 1)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (6, N'System User Record Status', 0, 1)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (7, N'Economic Activity', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (8, N'Province (Raion)', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (37, N'Permissions', 0, 1)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (46, N'Module', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (50, N'Sort Group', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (51, N'Articol', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (52, N'Order State', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (53, N'Tip', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (54, N'Desen', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (55, N'Colorit', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (56, N'Culori', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (57, N'Festonare', 0, 0)
GO

INSERT INTO [dbo].[ClassifierType] ([TypeID], [Name], [ParentID], [system])
VALUES 
  (58, N'Depozite', 0, 0)
GO

SET IDENTITY_INSERT [dbo].[ClassifierType] OFF
GO

--
-- Data for table dbo.Client  (LIMIT 0,50000)
--

SET IDENTITY_INSERT [dbo].[Client] ON
GO

INSERT INTO [dbo].[Client] ([clientID], [gender], [FirstName], [LastName], [DateOfBirth], [personalID], [buletinSeria], [dataEliberarii], [dataExpirarii], [eliberatDe], [telefonFix], [telefonMobil], [viza_country], [viza_raion], [viza_localitatea], [viza_stradaAdresa], [email], [sortGroup])
VALUES 
  (1, 270, N'Sergiu Juridic Test', N'Vasile Cipoi', NULL, N'235464567', N'', NULL, NULL, N'', N'456456', N'4546', 133, 213, N'Chsisinau', N'Chsisinau', N'xcngcn@mail.md', 0)
GO

INSERT INTO [dbo].[Client] ([clientID], [gender], [FirstName], [LastName], [DateOfBirth], [personalID], [buletinSeria], [dataEliberarii], [dataExpirarii], [eliberatDe], [telefonFix], [telefonMobil], [viza_country], [viza_raion], [viza_localitatea], [viza_stradaAdresa], [email], [sortGroup])
VALUES 
  (2, 270, N'Juridica 2', N'22222', NULL, N'222222', N'', NULL, NULL, N'', N'343242342', N'23432432', 0, 0, N'', N'', N'', 0)
GO

INSERT INTO [dbo].[Client] ([clientID], [gender], [FirstName], [LastName], [DateOfBirth], [personalID], [buletinSeria], [dataEliberarii], [dataExpirarii], [eliberatDe], [telefonFix], [telefonMobil], [viza_country], [viza_raion], [viza_localitatea], [viza_stradaAdresa], [email], [sortGroup])
VALUES 
  (3, 270, N'Juridica 3', N'343434dfafrf', NULL, N'33333333', N'', NULL, NULL, N'', N'43545543543', N'43q55356t5', 0, 0, N'', N'', N'', 0)
GO

INSERT INTO [dbo].[Client] ([clientID], [gender], [FirstName], [LastName], [DateOfBirth], [personalID], [buletinSeria], [dataEliberarii], [dataExpirarii], [eliberatDe], [telefonFix], [telefonMobil], [viza_country], [viza_raion], [viza_localitatea], [viza_stradaAdresa], [email], [sortGroup])
VALUES 
  (4, 270, N'lica', N'vasile', NULL, N'4325', N'', NULL, NULL, N'', N'0421492', N'9432108', 134, 0, N'', N'', N'test@test.com', 0)
GO

INSERT INTO [dbo].[Client] ([clientID], [gender], [FirstName], [LastName], [DateOfBirth], [personalID], [buletinSeria], [dataEliberarii], [dataExpirarii], [eliberatDe], [telefonFix], [telefonMobil], [viza_country], [viza_raion], [viza_localitatea], [viza_stradaAdresa], [email], [sortGroup])
VALUES 
  (5, 270, N'dfdsf', N'dgsdfgh', NULL, N'dfdfd', N'', NULL, NULL, N'', N'yjdutju', N'duiud', 0, 0, N'', N'', N'', 0)
GO

SET IDENTITY_INSERT [dbo].[Client] OFF
GO

--
-- Data for table dbo.ClientContracts  (LIMIT 0,50000)
--

SET IDENTITY_INSERT [dbo].[ClientContracts] ON
GO

INSERT INTO [dbo].[ClientContracts] ([client_id], [contract_id], [contract_nr], [date_from], [date_to], [active])
VALUES 
  (0, 1, N'32434', N'2015-06-17', NULL, 1)
GO

INSERT INTO [dbo].[ClientContracts] ([client_id], [contract_id], [contract_nr], [date_from], [date_to], [active])
VALUES 
  (1, 2, N'32434', N'2015-06-04', N'2015-07-11', 0)
GO

INSERT INTO [dbo].[ClientContracts] ([client_id], [contract_id], [contract_nr], [date_from], [date_to], [active])
VALUES 
  (2, 3, N'xxx-1-www', N'2015-06-05', N'2015-06-30', 1)
GO

SET IDENTITY_INSERT [dbo].[ClientContracts] OFF
GO

--
-- Data for table dbo.InWey  (LIMIT 0,50000)
--

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1521', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1529', 30)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1521', 29)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1521', 23)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1529', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1521', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1521', 62)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1529', 26)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1521', 96)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1529', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1521', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1521', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1529', 92)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1529', 41)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1521', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1529', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1521', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1521', 27)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1521', 25)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1521', 21)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1521', 75)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1529', 44)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1521', 46)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1529', 56)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1521', 19)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1521', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1529', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1521', 50)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1521', 83)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1521', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1529', 40)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1521', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1521', 29)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1521', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1521', 17)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1529', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1521', 59)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1529', 50)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1521', 36)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1529', 60)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1529', 26)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1529', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1521', 39)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1521', 131)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1521', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1521', 63)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1521', 54)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1521', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1521', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1521', 59)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1521', 45)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1521', 111)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1521', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1529', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1521', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1521', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1521', 19)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1521', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1529', 50)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1521', 25)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1529', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1521', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1521', 23)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1521', 93)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1529', 46)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1521', 41)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1529', 41)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1521', 23)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1521', 34)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1521', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1521', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1529', 149)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1529', 110)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1529', 36)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1529', 71)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1529', 72)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1175, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1521', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1521', 29)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1521', 78)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1521', 97)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1521', 144)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1529', 84)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1521', 148)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1521', 34)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1529', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1521', 17)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1529', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1521', 21)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1529', 38)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1192, N'1529', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1529', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1529', 40)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1521', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1529', 34)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1521', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1529', 29)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1521', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1529', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1202, N'1529', 63)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1521', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1529', 40)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1521', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1521', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1211, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1521', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1214, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1216, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1228, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1521', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1529', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1529', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1521', 38)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1521', 30)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1521', 40)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1521', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1267, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1270, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1272, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1273, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1273, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1274, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1275, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1276, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1277, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1280, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1282, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1529', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1288, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1291, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1297, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1521', 178)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1529', 94)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1521', 152)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1529', 118)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1521', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1529', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1521', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1529', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1529', 114)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1529', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1305, N'1529', 38)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1306, N'1529', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1521', 34)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1529', 26)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1521', 65)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1521', 19)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1529', 71)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1521', 53)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1521', 80)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1521', 25)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1521', 26)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1521', 68)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1521', 71)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1521', 68)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1521', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1521', 238)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1529', 162)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1521', 194)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1529', 118)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1521', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1529', 46)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1529', 46)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1521', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1529', 40)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1529', 125)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1521', 84)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1529', 106)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1521', 104)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1529', 118)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1521', 67)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1521', 70)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1330, N'1529', 180)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1529', 111)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1332, N'1529', 19)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1334, N'1529', 200)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1335, N'1529', 128)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1521', 55)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1529', 101)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1521', 57)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1529', 128)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1521', 57)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1521', 53)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1521', 65)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1521', 55)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1521', 117)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1529', 66)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1521', 149)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1521', 50)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1529', 46)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1521', 129)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1521', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1521', 30)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1521', 29)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1521', 111)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1529', 64)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1521', 129)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1521', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1521', 25)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1529', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1378, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1379, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1380, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1381, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1382, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1384, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1387, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1393, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1396, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1397, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1398, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1399, N'1529', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1400, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1401, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1402, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1403, N'1529', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1404, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1405, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1406, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1407, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1408, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1409, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1410, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1411, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1412, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1413, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1414, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1415, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1529', 29)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1521', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1521', 17)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1521', 84)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1521', 56)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1422, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1521', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1529', 24)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1521', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1529', 36)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1521', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1529', 38)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1529', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1521', 17)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1521', 30)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1521', 17)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1521', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1521', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1529', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1529', 18)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1521', 37)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1521', 38)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1521', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1521', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1467, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1521', 63)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1529', 40)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1521', 32)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1529', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1521', 17)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1529', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1521', 81)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1521', 111)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1521', 37)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1521', 43)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1484, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1521', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1529', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1493, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1495, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1498, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1500, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1521', 11)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1521', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1529', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1513, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1529', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1520, N'1529', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1521', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1529', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1533, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1521', 23)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1541, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1547, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1549, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1550, N'1529', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1551, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1552, N'1529', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1553, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1557, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1558, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1559, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1561, N'1529', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1562, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1563, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1568, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1529', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1573, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1529', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1529', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1521', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1529', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1521', 14)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1585, N'1529', 39)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1521', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1521', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1521', 62)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1521', 98)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1521', 13)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1521', 20)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1521', 43)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1529', 21)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1529', 28)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1521', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1521', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1529', 46)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1521', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1529', 41)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1521', 2)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1529', 22)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1521', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1529', 21)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1603, N'1529', 10)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1608, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1529', 12)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1611, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1529', 8)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1529', 9)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1529', 7)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1521', 38)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1529', 51)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1521', 31)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1529', 49)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1521', 6)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1529', 19)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1521', 15)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1529', 16)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1626, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1529', 5)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1529', 4)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1529', 3)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1521', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1529', 1)
GO

INSERT INTO [dbo].[InWey] ([product_id], [week], [quantity])
VALUES 
  (1659, N'1529', 1)
GO

--
-- Data for table dbo.Kanban  (LIMIT 0,50000)
--

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1075, 65)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1076, 50)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1077, 26)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1078, 30)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1079, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1080, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1081, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1082, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1083, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1084, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1085, 70)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1086, 44)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1087, 21)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1088, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1089, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1090, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1091, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1092, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1093, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1094, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1095, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1096, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1097, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1098, 84)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1099, 77)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1100, 32)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1101, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1102, 29)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1103, 42)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1104, 50)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1105, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1106, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1107, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1108, 80)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1109, 44)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1110, 26)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1111, 18)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1112, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1113, 75)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1114, 75)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1115, 26)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1116, 28)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1117, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1118, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1119, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1120, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1121, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1122, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1123, 23)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1124, 22)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1125, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1126, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1127, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1128, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1129, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1130, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1131, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1132, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1133, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1134, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1135, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1136, 39)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1137, 53)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1138, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1139, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1140, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1141, 27)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1142, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1143, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1144, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1145, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1146, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1147, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1148, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1149, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1150, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1151, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1152, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1153, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1154, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1155, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1156, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1157, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1158, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1159, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1160, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1161, 29)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1162, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1163, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1164, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1165, 65)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1166, 31)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1167, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1168, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1169, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1170, 102)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1171, 83)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1172, 31)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1173, 43)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1174, 20)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1175, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1176, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1177, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1178, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1179, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1180, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1181, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1182, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1183, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1184, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1185, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1186, 87)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1187, 41)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1188, 28)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1189, 28)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1190, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1191, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1192, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1193, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1194, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1195, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1196, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1197, 33)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1198, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1199, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1200, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1201, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1202, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1203, 20)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1204, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1205, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1206, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1207, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1208, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1209, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1210, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1211, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1212, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1213, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1214, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1215, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1216, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1217, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1218, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1219, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1220, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1221, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1222, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1223, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1224, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1225, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1226, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1227, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1228, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1229, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1230, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1231, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1232, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1233, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1234, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1235, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1236, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1237, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1238, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1239, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1240, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1241, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1242, 27)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1243, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1244, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1245, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1246, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1247, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1248, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1249, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1250, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1251, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1252, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1253, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1254, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1255, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1256, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1257, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1258, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1259, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1260, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1261, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1262, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1263, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1264, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1265, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1266, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1267, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1268, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1269, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1270, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1271, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1272, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1273, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1274, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1275, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1276, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1277, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1278, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1279, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1280, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1281, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1282, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1283, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1284, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1285, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1286, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1287, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1288, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1289, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1290, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1291, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1292, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1293, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1294, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1295, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1296, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1297, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1298, 94)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1299, 99)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1300, 24)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1301, 22)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1302, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1303, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1304, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1305, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1306, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1307, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1308, 18)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1309, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1310, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1311, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1312, 21)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1313, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1314, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1315, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1316, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1317, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1318, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1319, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1320, 143)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1321, 137)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1322, 30)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1323, 25)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1324, 33)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1325, 22)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1326, 79)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1327, 73)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1328, 28)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1329, 29)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1330, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1331, 18)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1332, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1333, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1334, 30)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1335, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1336, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1337, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1338, 43)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1339, 29)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1340, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1341, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1342, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1343, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1344, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1345, 66)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1346, 66)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1347, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1348, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1349, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1350, 47)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1351, 38)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1352, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1353, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1354, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1355, 70)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1356, 38)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1357, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1358, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1359, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1360, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1361, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1362, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1363, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1364, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1365, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1366, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1367, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1368, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1369, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1370, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1371, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1372, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1373, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1374, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1375, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1376, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1377, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1378, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1379, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1380, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1381, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1382, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1383, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1384, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1385, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1386, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1387, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1388, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1389, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1390, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1391, 26)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1392, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1393, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1394, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1395, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1396, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1397, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1398, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1399, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1400, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1401, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1402, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1403, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1404, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1405, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1406, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1407, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1408, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1409, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1410, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1411, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1412, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1413, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1414, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1415, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1416, 20)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1417, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1418, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1419, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1420, 23)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1421, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1422, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1423, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1424, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1425, 23)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1426, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1427, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1428, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1429, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1430, 37)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1431, 20)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1432, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1433, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1434, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1435, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1436, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1437, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1438, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1439, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1440, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1441, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1442, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1443, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1444, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1445, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1446, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1447, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1448, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1449, 18)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1450, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1451, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1452, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1453, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1454, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1455, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1456, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1457, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1458, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1459, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1460, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1461, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1462, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1463, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1464, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1465, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1466, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1467, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1468, 35)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1469, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1470, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1471, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1472, 18)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1473, 20)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1474, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1475, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1476, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1477, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1478, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1479, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1480, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1481, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1482, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1483, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1484, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1485, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1486, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1487, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1488, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1489, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1490, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1491, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1492, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1493, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1494, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1495, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1496, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1497, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1498, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1499, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1500, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1501, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1502, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1503, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1504, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1505, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1506, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1507, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1508, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1509, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1510, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1511, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1512, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1513, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1514, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1515, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1516, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1517, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1518, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1519, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1520, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1521, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1522, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1523, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1524, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1525, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1526, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1527, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1528, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1529, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1530, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1531, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1532, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1533, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1534, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1535, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1536, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1537, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1538, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1539, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1540, 19)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1541, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1542, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1543, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1544, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1545, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1546, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1547, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1548, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1549, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1550, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1551, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1552, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1553, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1554, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1555, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1556, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1557, 1)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1558, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1559, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1560, 27)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1561, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1562, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1563, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1564, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1565, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1566, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1567, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1568, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1569, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1570, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1571, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1572, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1573, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1574, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1575, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1576, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1577, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1578, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1579, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1580, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1581, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1582, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1583, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1584, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1585, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1586, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1587, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1588, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1589, 16)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1590, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1591, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1592, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1593, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1594, 23)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1595, 28)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1596, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1597, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1598, 15)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1599, 21)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1600, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1601, 12)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1602, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1603, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1604, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1605, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1606, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1607, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1608, 11)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1609, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1610, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1611, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1612, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1613, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1614, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1615, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1616, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1617, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1618, 29)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1619, 14)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1620, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1621, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1622, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1623, 17)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1624, 13)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1625, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1626, 6)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1627, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1628, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1629, 9)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1630, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1631, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1632, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1633, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1634, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1635, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1636, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1637, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1638, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1639, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1640, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1641, 10)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1642, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1643, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1644, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1645, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1646, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1647, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1648, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1649, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1650, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1651, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1652, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1653, 4)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1654, 3)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1655, 8)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1656, 7)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1657, 2)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1658, 5)
GO

INSERT INTO [dbo].[Kanban] ([product_id], [quantity])
VALUES 
  (1659, 3)
GO

--
-- Data for table dbo.Orders  (LIMIT 0,50000)
--

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1520', 33)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1520', 25)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1520', 35)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1520', 22)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1520', 11)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1520', 42)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1520', 39)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1520', 16)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1520', 21)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1520', 25)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1520', 40)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1520', 22)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1520', 38)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1520', 38)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1520', 12)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1520', 11)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1520', 20)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1520', 27)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1520', 33)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1520', 16)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1520', 51)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1520', 44)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1520', 21)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1520', 17)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1273, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1273, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1521', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1520', 47)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1520', 50)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1520', 12)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1520', 11)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1520', 11)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1520', 72)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1520', 69)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1520', 13)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1520', 17)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1520', 40)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1520', 37)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1520', 22)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1520', 33)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1520', 33)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1520', 24)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1520', 19)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1520', 35)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1520', 19)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1520', 9)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1379, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1520', 12)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1520', 19)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1520', 18)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1521', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1520', 10)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1521', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1520', 2)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1520', 8)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1520', 4)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1520', 12)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1520', 14)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1520', 11)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1520', 6)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1520', 3)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1520', 15)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1520', 5)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1520', 7)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1521', 0)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1520', 1)
GO

INSERT INTO [dbo].[Orders] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1521', 0)
GO

--
-- Data for table dbo.ProductDetails  (LIMIT 0,50000)
--

SET IDENTITY_INSERT [dbo].[ProductDetails] ON
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1075, 274, 488, 357, 360, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1076, 274, 488, 357, 360, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1077, 274, 488, 357, 360, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1078, 274, 488, 357, 360, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1079, 274, 488, 357, 360, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1080, 274, 489, 285, 340, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1081, 274, 489, 285, 340, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1082, 274, 489, 285, 340, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1083, 274, 489, 285, 340, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1084, 274, 489, 285, 340, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1085, 274, 364, 285, 360, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1086, 274, 364, 285, 360, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1087, 274, 364, 285, 360, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1088, 274, 364, 285, 360, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1089, 274, 364, 285, 360, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1090, 274, 364, 357, 360, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1091, 274, 364, 357, 360, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1092, 274, 364, 357, 360, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1093, 274, 364, 357, 360, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1094, 274, 490, 285, 491, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1095, 274, 490, 285, 491, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1096, 274, 490, 285, 491, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1097, 274, 490, 285, 491, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1098, 274, 490, 285, 340, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1099, 274, 490, 285, 340, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1100, 274, 490, 285, 340, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1101, 274, 490, 285, 340, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1102, 274, 490, 285, 340, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1103, 274, 374, 285, 375, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1104, 274, 374, 285, 375, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1105, 274, 374, 285, 375, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1106, 274, 374, 285, 375, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1107, 274, 374, 285, 375, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1108, 274, 492, 285, 493, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1109, 274, 492, 285, 493, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1110, 274, 492, 285, 493, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1111, 274, 492, 285, 493, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1112, 274, 492, 285, 493, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1113, 274, 494, 285, 355, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1114, 274, 494, 285, 355, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1115, 274, 494, 285, 355, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1116, 274, 494, 285, 355, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1117, 274, 494, 285, 355, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1118, 274, 494, 285, 340, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1119, 274, 494, 285, 340, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1120, 274, 494, 285, 340, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1121, 274, 494, 285, 340, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1122, 274, 494, 285, 340, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1123, 274, 494, 357, 355, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1124, 274, 494, 357, 355, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1125, 274, 494, 357, 355, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1126, 274, 494, 357, 355, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1127, 274, 494, 357, 340, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1128, 274, 494, 357, 340, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1129, 274, 494, 357, 340, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1130, 274, 494, 357, 340, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1131, 274, 376, 285, 377, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1132, 274, 376, 285, 377, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1133, 274, 376, 285, 377, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1134, 274, 376, 285, 377, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1135, 274, 376, 285, 377, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1136, 274, 495, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1137, 274, 495, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1138, 274, 495, 285, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1139, 274, 495, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1140, 274, 495, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1141, 274, 496, 285, 497, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1142, 274, 404, 285, 339, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1143, 274, 404, 285, 339, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1144, 274, 498, 285, 499, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1145, 274, 498, 285, 499, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1146, 274, 498, 285, 499, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1147, 274, 498, 285, 499, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1148, 274, 500, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1149, 274, 500, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1150, 274, 500, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1151, 274, 500, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1152, 274, 405, 285, 406, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1153, 274, 405, 285, 406, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1154, 274, 341, 285, 338, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1155, 274, 341, 285, 338, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1156, 274, 341, 285, 338, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1157, 274, 343, 285, 339, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1158, 274, 343, 285, 339, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1159, 274, 343, 285, 339, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1160, 274, 343, 285, 339, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1161, 274, 501, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1162, 274, 501, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1163, 274, 501, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1164, 274, 501, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1165, 274, 502, 285, 503, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1166, 274, 502, 285, 503, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1167, 274, 502, 285, 503, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1168, 274, 502, 285, 503, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1169, 274, 502, 285, 503, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1170, 274, 378, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1171, 274, 378, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1172, 274, 378, 285, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1173, 274, 378, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1174, 274, 378, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1175, 274, 378, 357, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1176, 274, 378, 357, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1177, 274, 378, 357, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1178, 274, 378, 357, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1179, 274, 378, 357, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1180, 274, 344, 285, 338, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1181, 274, 344, 285, 338, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1182, 274, 504, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1183, 274, 504, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1184, 274, 504, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1185, 274, 504, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1186, 274, 505, 285, 506, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1187, 274, 505, 285, 506, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1188, 274, 505, 285, 506, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1189, 274, 505, 285, 506, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1190, 274, 505, 285, 506, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1191, 274, 475, 285, 339, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1192, 274, 475, 285, 339, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1193, 274, 475, 285, 339, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1194, 274, 507, 285, 338, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1195, 274, 507, 285, 338, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1196, 274, 507, 285, 338, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1197, 274, 467, 285, 468, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1198, 274, 467, 285, 468, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1199, 274, 467, 285, 468, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1200, 274, 508, 285, 355, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1201, 274, 508, 285, 355, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1202, 274, 508, 285, 340, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1203, 274, 508, 285, 340, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1204, 274, 508, 285, 340, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1205, 274, 508, 285, 340, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1206, 274, 509, 285, 510, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1207, 274, 509, 285, 510, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1208, 274, 511, 285, 470, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1209, 274, 511, 285, 470, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1210, 274, 511, 285, 470, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1211, 274, 511, 285, 470, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1212, 274, 512, 285, 497, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1213, 274, 512, 285, 497, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1214, 274, 512, 285, 497, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1215, 274, 512, 285, 497, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1216, 274, 513, 285, 514, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1217, 274, 513, 285, 514, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1218, 274, 513, 285, 514, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1219, 274, 513, 285, 514, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1220, 274, 513, 285, 514, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1221, 274, 515, 285, 516, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1222, 274, 515, 285, 516, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1223, 274, 515, 285, 516, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1224, 274, 515, 285, 516, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1225, 274, 517, 285, 339, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1226, 274, 517, 285, 339, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1227, 274, 517, 285, 339, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1228, 274, 517, 285, 339, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1229, 274, 518, 285, 510, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1230, 274, 518, 285, 510, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1231, 274, 518, 285, 510, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1232, 274, 518, 285, 510, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1233, 274, 519, 285, 520, 0.82, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1234, 274, 519, 285, 520, 1.37, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1235, 274, 519, 285, 520, 1.63, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1236, 274, 519, 285, 520, 2.05, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1237, 274, 521, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1238, 274, 521, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1239, 274, 521, 285, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1240, 274, 521, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1241, 274, 521, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1242, 274, 521, 357, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1243, 274, 521, 357, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1244, 274, 521, 357, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1245, 274, 521, 357, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1246, 274, 521, 357, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1247, 274, 380, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1248, 274, 380, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1249, 274, 380, 285, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1250, 274, 380, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1251, 274, 380, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1252, 274, 380, 357, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1253, 274, 380, 357, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1254, 274, 380, 357, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1255, 274, 380, 357, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1256, 274, 380, 357, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1257, 274, 522, 285, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1258, 274, 522, 285, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1259, 274, 522, 285, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1260, 274, 522, 285, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1261, 274, 522, 285, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1262, 274, 522, 357, 373, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1263, 274, 522, 357, 373, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1264, 274, 522, 357, 373, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1265, 274, 522, 357, 373, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1266, 274, 522, 357, 373, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1267, 277, 523, 285, 524, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1268, 277, 523, 285, 524, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1269, 277, 523, 285, 524, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1270, 278, 525, 285, 526, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1271, 278, 525, 285, 526, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1272, 278, 525, 285, 526, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1273, 278, 525, 285, 526, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1274, 278, 527, 285, 528, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1275, 278, 527, 285, 528, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1276, 278, 527, 285, 528, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1277, 278, 527, 285, 528, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1278, 278, 529, 285, 530, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1279, 278, 529, 285, 530, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1280, 278, 529, 285, 530, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1281, 278, 529, 285, 530, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1282, 278, 529, 285, 530, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1283, 278, 531, 357, 365, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1284, 278, 531, 357, 365, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1285, 278, 531, 357, 365, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1286, 278, 531, 357, 365, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1287, 278, 531, 357, 365, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1288, 278, 532, 285, 367, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1289, 278, 532, 285, 367, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1290, 278, 532, 285, 367, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1291, 278, 532, 285, 367, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1292, 278, 532, 285, 367, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1293, 278, 533, 285, 530, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1294, 278, 533, 285, 530, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1295, 278, 533, 285, 530, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1296, 278, 533, 285, 530, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1297, 278, 533, 285, 530, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1298, 279, 461, 285, 306, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1299, 279, 461, 285, 306, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1300, 279, 461, 285, 306, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1301, 279, 461, 285, 306, 1.5, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1302, 279, 461, 285, 306, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1303, 279, 460, 285, 534, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1304, 279, 460, 285, 534, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1305, 279, 460, 285, 534, 1.4, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1306, 279, 460, 285, 534, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1307, 279, 535, 285, 306, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1308, 279, 535, 285, 306, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1309, 279, 535, 285, 306, 1.5, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1310, 279, 535, 285, 306, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1311, 279, 536, 357, 306, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1312, 279, 537, 285, 421, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1313, 279, 537, 285, 421, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1314, 279, 537, 285, 421, 1.5, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1315, 279, 537, 285, 421, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1316, 279, 538, 285, 427, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1317, 279, 538, 285, 427, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1318, 279, 538, 285, 427, 1.5, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1319, 279, 538, 285, 427, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1320, 279, 539, 285, 421, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1321, 279, 539, 285, 421, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1322, 279, 539, 285, 421, 1.4, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1323, 279, 539, 285, 421, 1.5, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1324, 279, 539, 285, 421, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1325, 279, 540, 357, 421, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1326, 279, 426, 285, 427, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1327, 279, 426, 285, 427, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1328, 279, 426, 285, 427, 1.4, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1329, 279, 426, 285, 427, 1.8, 2.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1330, 279, 541, 285, 431, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1331, 279, 541, 285, 431, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1332, 279, 541, 285, 431, 1.4, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1333, 279, 541, 285, 431, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1334, 279, 542, 285, 306, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1335, 279, 542, 285, 306, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1336, 279, 542, 285, 306, 1.4, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1337, 279, 542, 285, 306, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1338, 279, 543, 285, 544, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1339, 279, 543, 285, 544, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1340, 279, 543, 285, 544, 1.5, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1341, 279, 543, 285, 544, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1342, 279, 545, 285, 427, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1343, 279, 545, 285, 427, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1344, 279, 545, 285, 427, 1.5, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1345, 546, 547, 285, 355, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1346, 546, 547, 285, 355, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1347, 546, 547, 285, 355, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1348, 546, 547, 285, 355, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1349, 546, 547, 285, 355, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1350, 546, 548, 285, 549, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1351, 546, 548, 285, 549, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1352, 546, 548, 285, 549, 1.33, 2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1353, 546, 548, 285, 549, 1.6, 2.4)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1354, 546, 548, 285, 549, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1355, 546, 550, 285, 493, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1356, 546, 550, 285, 493, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1357, 546, 550, 285, 493, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1358, 546, 550, 285, 493, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1359, 546, 550, 285, 493, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1360, 348, 349, 285, 350, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1361, 348, 349, 285, 350, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1362, 348, 349, 285, 350, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1363, 348, 349, 285, 350, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1364, 348, 362, 285, 350, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1365, 348, 362, 285, 350, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1366, 348, 362, 285, 350, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1367, 348, 362, 285, 350, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1368, 348, 551, 285, 552, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1369, 348, 551, 285, 552, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1370, 348, 551, 285, 552, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1371, 348, 551, 285, 552, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1372, 553, 554, 285, 555, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1373, 553, 554, 285, 555, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1374, 553, 554, 285, 555, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1375, 553, 554, 285, 555, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1376, 553, 556, 285, 399, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1377, 553, 556, 285, 399, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1378, 553, 556, 285, 399, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1379, 553, 557, 285, 558, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1380, 553, 557, 285, 558, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1381, 553, 557, 285, 558, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1382, 553, 557, 285, 558, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1383, 278, 559, 285, 560, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1384, 278, 559, 285, 560, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1385, 278, 559, 285, 560, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1386, 278, 559, 285, 560, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1387, 278, 559, 285, 560, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1388, 561, 562, 285, 386, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1389, 561, 562, 285, 386, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1390, 561, 562, 285, 386, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1391, 563, 564, 285, 565, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1392, 563, 564, 285, 565, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1393, 563, 564, 285, 565, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1394, 563, 564, 285, 565, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1395, 563, 564, 285, 565, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1396, 563, 566, 285, 567, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1397, 563, 566, 285, 567, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1398, 563, 566, 285, 567, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1399, 563, 566, 285, 567, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1400, 563, 566, 285, 567, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1401, 563, 568, 285, 569, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1402, 563, 568, 285, 569, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1403, 563, 568, 285, 569, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1404, 563, 568, 285, 569, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1405, 563, 568, 285, 569, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1406, 563, 570, 285, 567, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1407, 563, 570, 285, 567, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1408, 563, 570, 285, 567, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1409, 563, 570, 285, 567, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1410, 563, 570, 285, 567, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1411, 563, 509, 285, 569, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1412, 563, 509, 285, 569, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1413, 563, 509, 285, 569, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1414, 563, 509, 285, 569, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1415, 563, 509, 285, 569, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1416, 476, 408, 285, 390, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1417, 476, 408, 285, 390, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1418, 476, 408, 285, 390, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1419, 476, 408, 285, 390, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1420, 476, 409, 285, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1421, 476, 409, 285, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1422, 476, 409, 285, 392, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1423, 476, 409, 285, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1424, 476, 409, 285, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1425, 476, 411, 285, 390, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1426, 476, 411, 285, 390, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1427, 476, 411, 285, 390, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1428, 476, 411, 285, 390, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1429, 476, 411, 285, 390, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1430, 476, 571, 285, 572, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1431, 476, 571, 285, 572, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1432, 476, 571, 285, 572, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1433, 476, 571, 285, 572, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1434, 476, 571, 285, 572, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1435, 476, 571, 357, 572, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1436, 476, 571, 357, 572, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1437, 476, 571, 357, 572, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1438, 476, 571, 357, 572, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1439, 476, 571, 357, 572, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1440, 476, 573, 285, 574, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1441, 476, 573, 285, 574, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1442, 476, 573, 285, 574, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1443, 476, 573, 285, 574, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1444, 476, 573, 285, 574, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1445, 476, 575, 285, 576, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1446, 476, 575, 285, 576, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1447, 476, 575, 285, 576, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1448, 476, 575, 285, 576, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1449, 476, 577, 285, 414, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1450, 476, 577, 285, 414, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1451, 476, 577, 285, 414, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1452, 476, 577, 285, 414, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1453, 476, 577, 285, 414, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1454, 476, 577, 357, 414, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1455, 476, 577, 357, 414, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1456, 476, 577, 357, 414, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1457, 476, 577, 357, 414, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1458, 476, 577, 357, 414, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1459, 476, 578, 285, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1460, 476, 578, 285, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1461, 476, 578, 285, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1462, 476, 578, 285, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1463, 476, 478, 285, 479, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1464, 476, 478, 285, 479, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1465, 476, 478, 285, 479, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1466, 476, 478, 285, 479, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1467, 476, 478, 285, 479, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1468, 476, 579, 285, 576, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1469, 476, 579, 285, 576, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1470, 476, 579, 285, 576, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1471, 476, 579, 285, 576, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1472, 476, 580, 285, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1473, 476, 580, 285, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1474, 476, 580, 285, 392, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1475, 476, 580, 285, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1476, 476, 580, 285, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1477, 476, 415, 285, 416, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1478, 476, 415, 285, 416, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1479, 476, 415, 285, 416, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1480, 476, 415, 285, 416, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1481, 476, 415, 285, 416, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1482, 397, 398, 285, 365, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1483, 397, 398, 285, 365, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1484, 397, 398, 285, 365, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1485, 397, 398, 285, 365, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1486, 397, 398, 285, 365, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1487, 397, 398, 357, 365, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1488, 397, 398, 357, 365, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1489, 397, 398, 357, 365, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1490, 397, 398, 357, 365, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1491, 397, 402, 285, 371, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1492, 397, 402, 285, 371, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1493, 397, 402, 285, 371, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1494, 397, 402, 285, 371, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1495, 397, 402, 285, 371, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1496, 397, 402, 357, 371, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1497, 397, 402, 357, 371, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1498, 397, 402, 357, 371, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1499, 397, 402, 357, 371, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1500, 397, 402, 357, 371, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1501, 397, 581, 285, 582, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1502, 397, 581, 285, 582, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1503, 397, 581, 285, 582, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1504, 397, 581, 285, 582, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1505, 397, 583, 285, 369, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1506, 397, 583, 285, 369, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1507, 397, 583, 285, 369, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1508, 397, 583, 285, 369, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1509, 397, 584, 285, 585, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1510, 397, 584, 285, 585, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1511, 397, 584, 285, 585, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1512, 397, 584, 285, 585, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1513, 397, 584, 285, 585, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1514, 397, 584, 357, 585, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1515, 397, 584, 357, 585, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1516, 397, 584, 357, 585, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1517, 397, 584, 357, 585, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1518, 397, 584, 357, 585, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1519, 397, 586, 285, 367, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1520, 397, 586, 285, 367, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1521, 397, 586, 285, 367, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1522, 397, 586, 285, 367, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1523, 397, 586, 285, 367, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1524, 397, 587, 285, 369, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1525, 397, 587, 285, 369, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1526, 397, 587, 285, 369, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1527, 397, 587, 285, 369, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1528, 397, 587, 285, 369, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1529, 397, 588, 285, 367, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1530, 397, 588, 285, 367, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1531, 397, 588, 285, 367, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1532, 397, 588, 285, 367, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1533, 397, 588, 285, 367, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1534, 589, 295, 285, 590, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1535, 589, 295, 285, 590, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1536, 589, 295, 285, 590, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1537, 589, 295, 285, 590, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1538, 589, 295, 285, 590, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1539, 589, 295, 285, 591, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1540, 589, 295, 285, 591, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1541, 589, 295, 285, 591, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1542, 589, 295, 285, 591, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1543, 589, 295, 285, 591, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1544, 589, 295, 285, 592, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1545, 589, 295, 285, 592, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1546, 589, 295, 285, 592, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1547, 589, 295, 285, 592, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1548, 589, 295, 285, 592, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1549, 589, 295, 285, 593, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1550, 589, 295, 285, 593, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1551, 589, 295, 285, 593, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1552, 589, 295, 285, 593, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1553, 589, 295, 285, 593, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1554, 589, 295, 285, 594, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1555, 589, 295, 285, 594, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1556, 589, 295, 285, 594, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1557, 589, 295, 285, 594, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1558, 589, 295, 285, 594, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1559, 589, 295, 285, 595, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1560, 589, 295, 285, 595, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1561, 589, 295, 285, 595, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1562, 589, 295, 285, 595, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1563, 589, 295, 285, 595, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1564, 589, 295, 285, 596, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1565, 589, 295, 285, 596, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1566, 589, 295, 357, 590, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1567, 589, 295, 357, 590, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1568, 589, 295, 357, 590, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1569, 589, 295, 357, 590, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1570, 589, 295, 357, 590, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1571, 589, 295, 357, 591, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1572, 589, 295, 357, 591, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1573, 589, 295, 357, 591, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1574, 589, 295, 357, 591, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1575, 589, 295, 357, 591, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1576, 589, 295, 357, 592, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1577, 589, 295, 357, 592, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1578, 589, 295, 357, 592, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1579, 589, 295, 357, 592, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1580, 589, 295, 357, 592, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1581, 589, 442, 357, 590, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1582, 589, 442, 357, 590, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1583, 589, 442, 357, 590, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1584, 589, 442, 357, 590, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1585, 589, 443, 285, 597, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1586, 589, 443, 285, 597, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1587, 589, 443, 285, 597, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1588, 589, 443, 285, 597, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1589, 598, 389, 285, 390, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1590, 598, 389, 285, 390, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1591, 598, 389, 285, 390, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1592, 598, 389, 285, 390, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1593, 598, 389, 285, 390, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1594, 598, 389, 357, 390, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1595, 598, 389, 357, 390, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1596, 598, 389, 357, 390, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1597, 598, 389, 357, 390, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1598, 598, 391, 285, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1599, 598, 391, 285, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1600, 598, 391, 285, 392, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1601, 598, 391, 285, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1602, 598, 391, 285, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1603, 598, 391, 357, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1604, 598, 391, 357, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1605, 598, 391, 357, 392, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1606, 598, 391, 357, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1607, 598, 391, 357, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1608, 598, 396, 285, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1609, 598, 396, 285, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1610, 598, 396, 285, 392, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1611, 598, 396, 285, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1612, 598, 396, 285, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1613, 598, 599, 285, 392, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1614, 598, 599, 285, 392, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1615, 598, 599, 285, 392, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1616, 598, 599, 285, 392, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1617, 598, 599, 285, 392, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1618, 598, 600, 285, 574, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1619, 598, 600, 285, 574, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1620, 598, 600, 285, 574, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1621, 598, 600, 285, 574, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1622, 598, 600, 285, 574, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1623, 598, 601, 285, 574, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1624, 598, 601, 285, 574, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1625, 598, 601, 285, 574, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1626, 598, 601, 285, 574, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1627, 598, 601, 285, 574, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1628, 602, 603, 285, 484, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1629, 602, 603, 285, 484, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1630, 602, 603, 285, 484, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1631, 602, 604, 285, 482, 0.6, 1.1)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1632, 602, 604, 285, 482, 0.8, 1.5)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1633, 602, 604, 285, 482, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1634, 602, 604, 285, 482, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1635, 602, 604, 285, 482, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1636, 605, 606, 285, 607, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1637, 605, 606, 285, 607, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1638, 605, 606, 285, 607, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1639, 605, 606, 285, 607, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1640, 605, 606, 285, 607, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1641, 605, 608, 285, 609, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1642, 605, 608, 285, 609, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1643, 605, 608, 285, 609, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1644, 605, 608, 285, 609, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1645, 605, 610, 285, 609, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1646, 605, 610, 285, 609, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1647, 605, 610, 285, 609, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1648, 605, 610, 285, 609, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1649, 605, 610, 285, 609, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1650, 605, 611, 285, 612, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1651, 605, 611, 285, 612, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1652, 605, 611, 285, 612, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1653, 605, 611, 285, 612, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1654, 605, 611, 285, 612, 2, 3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1655, 605, 613, 285, 609, 0.6, 1.2)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1656, 605, 613, 285, 609, 0.8, 1.6)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1657, 605, 613, 285, 609, 1.2, 1.7)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1658, 605, 613, 285, 609, 1.6, 2.3)
GO

INSERT INTO [dbo].[ProductDetails] ([product_id], [articol], [desen], [tip], [colorit], [latime], [lungime])
VALUES 
  (1659, 605, 613, 285, 609, 2, 3)
GO

SET IDENTITY_INSERT [dbo].[ProductDetails] OFF
GO

--
-- Data for table dbo.st_modules  (LIMIT 0,50000)
--

INSERT INTO [dbo].[st_modules] ([module_id], [description])
VALUES 
  (N'Module Customers', N'Processing data customer related (Personal Data; Orders)')
GO

INSERT INTO [dbo].[st_modules] ([module_id], [description])
VALUES 
  (N'Module Main', N'Basic data operation (Classifiers)')
GO

INSERT INTO [dbo].[st_modules] ([module_id], [description])
VALUES 
  (N'Module Security', N'Creating And Processing Security Functions (Users and Groups)')
GO

--
-- Data for table dbo.st_roles  (LIMIT 0,50000)
--

INSERT INTO [dbo].[st_roles] ([role_id])
VALUES 
  (N'Contabili')
GO

INSERT INTO [dbo].[st_roles] ([role_id])
VALUES 
  (N'Sef Directie')
GO

INSERT INTO [dbo].[st_roles] ([role_id])
VALUES 
  (N'Vinzatori')
GO

--
-- Data for table dbo.st_users_roles  (LIMIT 0,50000)
--

INSERT INTO [dbo].[st_users_roles] ([user_id], [role_id])
VALUES 
  (5, N'Contabili')
GO

INSERT INTO [dbo].[st_users_roles] ([user_id], [role_id])
VALUES 
  (5, N'Vinzatori')
GO

INSERT INTO [dbo].[st_users_roles] ([user_id], [role_id])
VALUES 
  (6, N'Contabili')
GO

INSERT INTO [dbo].[st_users_roles] ([user_id], [role_id])
VALUES 
  (7, N'Vinzatori')
GO

--
-- Data for table dbo.Stok  (LIMIT 0,50000)
--

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1520', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1523', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1524', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1529', 60)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1520', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1521', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1523', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1529', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1520', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1522', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1523', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1525', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1526', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1523', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1529', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1521', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1522', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1523', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1525', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1526', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1520', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1521', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1522', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1525', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1526', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1527', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1528', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1523', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1525', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1526', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1527', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1520', 62)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1521', 51)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1522', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1523', 49)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1524', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1525', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1526', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1529', 61)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1520', 96)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1521', 88)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1522', 74)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1523', 69)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1524', 62)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1525', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1526', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1527', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1528', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1529', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1520', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1522', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1523', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1529', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1520', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1521', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1522', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1522', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1525', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1526', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1527', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1526', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1521', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1522', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1529', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1529', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1520', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1520', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1520', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1521', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1523', 54)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1524', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1525', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1529', 98)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1520', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1521', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1523', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1529', 121)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1520', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1522', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1523', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1529', 47)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1521', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1522', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1529', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1523', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1529', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1520', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1521', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1522', 66)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1523', 52)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1524', 44)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1525', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1526', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1520', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1521', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1522', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1523', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1520', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1521', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1522', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1525', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1526', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1520', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1521', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1520', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1521', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1522', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1523', 76)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1524', 64)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1525', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1526', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1527', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1528', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1529', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1520', 83)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1521', 84)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1522', 84)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1523', 74)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1524', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1525', 62)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1526', 61)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1527', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1528', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1529', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1529', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1521', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1523', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1524', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1521', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1520', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1523', 71)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1524', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1529', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1520', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1523', 51)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1529', 96)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1520', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1521', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1522', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1523', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1529', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1520', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1529', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1520', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1529', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1522', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1523', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1524', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1525', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1526', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1523', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1524', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1525', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1526', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1523', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1526', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1520', 59)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1521', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1522', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1523', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1520', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1522', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1520', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1521', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1522', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1523', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1524', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1529', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1520', 131)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1521', 133)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1522', 129)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1523', 128)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1524', 127)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1525', 127)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1526', 123)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1527', 121)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1528', 122)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1529', 120)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1520', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1522', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1520', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1521', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1522', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1523', 59)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1524', 56)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1525', 47)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1526', 44)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1527', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1528', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1529', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1520', 54)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1521', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1522', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1523', 51)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1524', 47)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1525', 45)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1526', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1527', 44)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1528', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1529', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1520', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1522', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1520', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1521', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1520', 59)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1521', 57)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1522', 49)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1523', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1524', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1525', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1526', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1527', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1528', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1529', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1520', 45)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1521', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1522', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1523', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1524', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1525', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1526', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1527', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1528', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1529', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1520', 111)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1521', 110)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1522', 112)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1523', 106)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1524', 101)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1525', 101)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1526', 99)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1527', 99)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1528', 99)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1529', 97)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1526', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1528', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1520', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1521', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1522', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1526', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1527', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1528', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1529', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1520', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1521', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1522', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1529', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1520', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1520', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1521', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1522', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1523', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1526', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1520', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1522', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1520', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1521', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1522', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1523', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1520', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1528', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1520', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1521', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1522', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1523', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1524', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1525', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1526', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1527', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1528', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1529', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1520', 93)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1521', 91)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1522', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1523', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1524', 61)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1525', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1526', 52)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1527', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1528', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1529', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1520', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1522', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1520', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1520', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1521', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1523', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1524', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1525', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1526', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1527', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1529', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1520', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1521', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1522', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1523', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1520', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1523', 67)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1524', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1523', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1523', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1175, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1175, N'1528', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1175, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1178, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1178, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1178, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1520', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1522', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1524', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1520', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1521', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1522', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1523', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1524', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1525', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1526', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1527', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1528', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1529', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1520', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1521', 73)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1522', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1523', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1524', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1525', 70)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1526', 66)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1527', 66)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1528', 66)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1529', 59)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1520', 97)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1521', 92)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1522', 94)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1523', 93)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1524', 91)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1525', 91)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1526', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1527', 82)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1528', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1529', 77)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1522', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1520', 144)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1521', 141)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1522', 120)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1526', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1527', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1520', 148)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1521', 130)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1522', 125)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1526', 110)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1527', 91)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1528', 88)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1529', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1520', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1526', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1527', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1520', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1521', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1522', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1520', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1521', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1522', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1527', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1192, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1192, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1192, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1521', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1520', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1521', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1522', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1520', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1522', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1523', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1520', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1521', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1525', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1527', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1202, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1202, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1202, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1202, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1520', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1523', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1520', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1520', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1209, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1209, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1209, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1211, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1211, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1211, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1520', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1524', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1214, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1214, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1214, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1215, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1215, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1215, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1216, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1216, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1217, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1217, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1217, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1219, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1219, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1219, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1525', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1526', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1527', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1528', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1222, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1222, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1222, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1527', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1528', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1228, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1228, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1228, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1525', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1230, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1230, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1230, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1230, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1525', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1526', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1527', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1528', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1236, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1236, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1236, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1521', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1522', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1524', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1525', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1526', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1527', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1522', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1523', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1526', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1527', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1528', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1520', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1521', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1520', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1521', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1522', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1523', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1524', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1525', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1526', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1527', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1528', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1522', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1520', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1521', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1523', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1527', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1520', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1521', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1522', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1523', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1524', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1525', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1526', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1527', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1522', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1520', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1267, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1270, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1272, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1273, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1273, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1274, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1275, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1276, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1277, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1278, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1278, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1279, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1279, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1280, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1281, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1281, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1282, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1524', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1525', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1521', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1522', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1288, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1291, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1526', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1297, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1520', 178)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1521', 160)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1522', 149)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1523', 132)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1524', 116)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1525', 99)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1526', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1527', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1520', 152)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1521', 135)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1522', 125)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1523', 95)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1524', 72)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1525', 51)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1526', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1521', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1524', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1525', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1526', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1520', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1521', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1526', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1520', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1521', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1522', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1523', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1529', 120)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1524', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1529', 60)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1305, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1305, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1305, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1306, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1306, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1520', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1521', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1522', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1523', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1527', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1520', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1521', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1522', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1523', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1524', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1525', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1526', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1527', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1528', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1529', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1522', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1523', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1524', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1525', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1526', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1527', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1528', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1529', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1520', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1522', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1523', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1520', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1521', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1522', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1523', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1524', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1525', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1526', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1527', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1528', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1529', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1520', 80)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1521', 82)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1522', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1523', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1524', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1525', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1526', 73)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1527', 79)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1528', 76)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1529', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1520', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1521', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1522', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1523', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1524', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1525', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1526', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1527', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1528', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1529', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1520', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1521', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1522', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1524', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1525', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1526', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1527', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1528', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1529', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1520', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1521', 57)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1522', 54)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1523', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1524', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1525', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1526', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1527', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1528', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1529', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1520', 71)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1521', 69)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1522', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1523', 67)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1524', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1525', 61)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1526', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1527', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1528', 51)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1529', 45)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1520', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1521', 67)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1522', 67)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1523', 67)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1524', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1525', 62)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1526', 61)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1527', 62)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1528', 61)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1529', 60)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1520', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1521', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1522', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1525', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1526', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1527', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1528', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1529', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1520', 238)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1521', 230)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1522', 195)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1523', 172)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1524', 125)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1525', 94)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1526', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1527', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1520', 194)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1521', 184)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1522', 182)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1523', 162)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1524', 143)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1525', 113)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1526', 103)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1527', 71)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1528', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1529', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1520', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1521', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1522', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1520', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1520', 84)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1521', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1522', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1523', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1524', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1520', 104)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1521', 93)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1522', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1523', 51)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1524', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1520', 67)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1521', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1522', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1523', 56)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1524', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1525', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1526', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1527', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1520', 70)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1521', 66)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1522', 59)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1523', 59)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1524', 49)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1525', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1526', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1527', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1528', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1330, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1330, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1332, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1332, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1332, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1334, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1334, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1335, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1335, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1335, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1520', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1521', 52)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1522', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1523', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1524', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1520', 57)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1521', 54)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1522', 44)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1523', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1524', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1520', 57)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1521', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1522', 49)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1523', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1524', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1525', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1526', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1527', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1526', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1520', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1521', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1522', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1523', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1524', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1525', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1526', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1527', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1528', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1529', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1520', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1521', 54)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1522', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1523', 52)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1524', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1525', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1526', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1527', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1528', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1529', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1520', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1521', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1522', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1523', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1524', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1525', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1526', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1527', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1528', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1529', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1520', 117)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1521', 106)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1522', 95)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1523', 79)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1524', 77)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1525', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1520', 149)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1521', 143)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1522', 139)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1523', 130)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1524', 120)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1525', 116)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1526', 112)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1527', 83)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1528', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1529', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1523', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1522', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1520', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1521', 47)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1522', 44)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1523', 64)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1524', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1525', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1526', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1520', 129)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1521', 129)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1522', 119)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1523', 114)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1524', 112)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1525', 112)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1526', 103)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1527', 95)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1528', 70)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1529', 70)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1520', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1521', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1522', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1523', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1520', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1521', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1523', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1524', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1525', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1526', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1527', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1520', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1521', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1523', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1524', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1525', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1526', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1527', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1528', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1520', 111)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1521', 104)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1522', 86)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1523', 80)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1524', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1525', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1526', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1527', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1520', 129)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1521', 126)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1522', 123)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1523', 117)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1524', 109)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1525', 100)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1526', 94)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1527', 85)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1528', 72)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1529', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1520', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1521', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1522', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1523', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1520', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1521', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1522', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1522', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1523', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1361, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1361, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1361, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1362, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1362, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1362, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1528', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1365, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1365, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1365, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1366, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1366, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1366, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1367, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1367, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1367, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1374, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1378, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1379, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1379, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1380, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1381, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1382, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1383, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1383, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1384, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1384, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1386, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1386, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1386, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1387, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1387, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1388, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1388, N'1528', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1388, N'1529', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1389, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1389, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1389, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1390, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1390, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1390, N'1529', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1522', 83)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1523', 82)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1524', 80)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1525', 77)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1526', 74)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1527', 71)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1528', 70)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1529', 65)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1522', 79)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1523', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1524', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1525', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1526', 74)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1527', 72)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1528', 92)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1529', 87)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1393, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1522', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1523', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1524', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1525', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1526', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1527', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1528', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1529', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1522', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1523', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1524', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1525', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1529', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1411, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1523', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1523', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1520', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1523', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1520', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1521', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1522', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1520', 84)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1521', 77)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1522', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1523', 73)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1524', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1525', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1526', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1527', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1520', 56)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1521', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1524', 47)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1525', 47)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1526', 46)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1527', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1528', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1529', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1422, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1422, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1422, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1520', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1521', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1521', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1523', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1524', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1523', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1524', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1525', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1526', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1527', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1528', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1529', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1520', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1523', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1524', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1520', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1521', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1522', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1523', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1527', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1529', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1520', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1521', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1523', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1520', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1521', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1522', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1523', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1524', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1525', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1526', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1527', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1529', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1523', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1528', 45)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1529', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1528', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1529', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1520', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1521', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1522', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1524', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1528', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1521', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1522', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1523', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1524', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1525', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1526', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1527', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1520', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1521', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1522', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1520', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1525', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1526', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1527', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1528', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1524', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1523', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1524', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1525', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1526', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1520', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1522', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1524', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1525', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1526', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1527', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1528', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1529', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1520', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1521', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1522', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1523', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1524', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1525', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1526', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1527', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1528', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1529', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1520', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1521', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1522', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1520', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1521', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1522', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1523', 30)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1524', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1467, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1467, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1467, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1520', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1521', 63)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1522', 56)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1523', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1524', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1527', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1520', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1521', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1522', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1523', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1524', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1525', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1526', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1527', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1528', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1520', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1522', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1523', 55)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1524', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1523', 60)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1524', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1525', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1526', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1527', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1529', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1523', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1523', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1523', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1526', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1520', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1521', 82)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1522', 84)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1523', 84)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1524', 130)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1525', 124)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1526', 124)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1527', 126)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1528', 125)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1529', 122)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1520', 111)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1521', 114)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1522', 116)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1523', 116)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1524', 115)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1525', 115)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1526', 115)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1527', 118)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1528', 116)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1529', 114)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1520', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1521', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1522', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1523', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1524', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1525', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1526', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1527', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1528', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1529', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1520', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1521', 42)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1522', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1523', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1524', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1525', 39)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1526', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1527', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1528', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1529', 37)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1521', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1521', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1522', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1523', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1524', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1525', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1526', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1527', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1528', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1529', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1484, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1520', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1522', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1521', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1493, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1495, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1497, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1498, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1500, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1500, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1520', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1521', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1522', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1523', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1527', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1529', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1520', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1522', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1523', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1523', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1523', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1513, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1523', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1520, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1520, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1520, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1527', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1520', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1533, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1529', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1523', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1520', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1521', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1522', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1524', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1527', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1541, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1541, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1541, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1521', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1544, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1544, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1544, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1521', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1522', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1523', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1524', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1527', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1547, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1547, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1549, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1549, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1549, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1550, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1551, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1551, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1551, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1552, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1552, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1552, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1553, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1553, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1553, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1557, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1558, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1558, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1558, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1559, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1559, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1559, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1523', 105)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1524', 87)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1525', 68)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1526', 60)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1527', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1528', 58)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1529', 57)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1561, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1561, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1562, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1563, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1523', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1524', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1527', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1523', 71)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1524', 66)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1525', 54)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1526', 50)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1527', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1528', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1529', 48)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1524', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1568, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1568, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1568, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1524', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1573, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1573, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1573, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1525', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1526', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1526', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1527', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1520', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1522', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1523', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1520', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1522', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1524', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1525', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1526', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1527', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1528', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1585, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1585, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1522', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1523', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1520', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1521', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1522', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1520', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1520', 62)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1521', 60)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1522', 56)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1523', 53)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1524', 52)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1525', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1526', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1527', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1528', 36)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1529', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1520', 98)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1521', 95)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1522', 88)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1523', 88)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1524', 81)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1525', 78)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1526', 75)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1527', 74)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1528', 73)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1529', 70)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1520', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1521', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1522', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1524', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1520', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1521', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1522', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1524', 18)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1525', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1527', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1529', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1520', 43)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1522', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1523', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1524', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1525', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1526', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1527', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1528', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1521', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1522', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1523', 41)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1524', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1525', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1526', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1527', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1520', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1521', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1526', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1520', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1521', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1522', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1523', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1524', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1525', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1523', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1520', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1524', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1520', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1521', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1522', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1523', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1520', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1522', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1603, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1603, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1603, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1525', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1526', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1608, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1608, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1608, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1526', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1527', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1524', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1611, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1611, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1611, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1524', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1524', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1525', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1523', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1523', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1524', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1523', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1524', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1525', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1520', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1521', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1522', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1525', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1527', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1528', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1520', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1521', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1522', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1523', 27)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1524', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1525', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1526', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1527', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1528', 24)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1529', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1528', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1520', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1521', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1522', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1523', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1524', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1525', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1520', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1521', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1522', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1523', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1526', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1527', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1529', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1524', 25)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1528', 32)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1529', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1525', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1529', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1524', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1526', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1527', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1528', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1529', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1626, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1626, N'1528', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1626, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1524', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1525', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1524', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1525', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1526', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1523', 15)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1524', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1526', 8)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1527', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1529', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1523', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1524', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1525', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1526', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1527', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1523', 40)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1524', 38)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1525', 34)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1526', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1527', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1528', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1529', 23)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1523', 35)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1524', 33)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1525', 29)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1526', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1527', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1528', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1529', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1523', 20)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1524', 19)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1525', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1523', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1524', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1525', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1526', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1527', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1529', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1523', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1524', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1525', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1526', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1527', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1636, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1636, N'1528', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1636, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1637, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1637, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1637, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1638, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1638, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1638, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1639, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1639, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1639, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1520', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1641, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1641, N'1528', 28)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1641, N'1529', 22)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1642, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1642, N'1528', 31)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1642, N'1529', 26)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1643, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1643, N'1528', 14)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1643, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1644, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1644, N'1528', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1644, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1645, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1645, N'1528', 11)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1645, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1646, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1646, N'1528', 6)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1646, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1647, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1647, N'1528', 3)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1648, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1648, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1648, N'1529', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1649, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1649, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1649, N'1529', 2)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1650, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1650, N'1528', 16)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1650, N'1529', 12)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1651, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1651, N'1528', 21)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1651, N'1529', 17)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1652, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1652, N'1528', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1652, N'1529', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1653, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1653, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1653, N'1529', 10)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1654, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1654, N'1528', 13)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1654, N'1529', 9)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1655, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1655, N'1528', 5)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1656, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1656, N'1528', 7)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1657, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1657, N'1528', 4)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1658, N'1527', 0)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1658, N'1528', 1)
GO

INSERT INTO [dbo].[Stok] ([product_id], [week], [quantity])
VALUES 
  (1659, N'1527', 0)
GO

--
-- Data for table dbo.users  (LIMIT 0,50000)
--

SET IDENTITY_INSERT [dbo].[users] ON
GO

INSERT INTO [dbo].[users] ([userid], [Nume], [Prenume], [login], [password], [passwordstatus], [recordstatus], [email], [sysadmin])
VALUES 
  (1, N'Iastrebov', N'Sergiu', N'seriiiastreb', N'T8grJq7LR9KGjE7741gXMqPny8xsLvsyBiwIFwoF7rg=', 6, 8, N'iastrebov.sergiu@mail.md', 1)
GO

INSERT INTO [dbo].[users] ([userid], [Nume], [Prenume], [login], [password], [passwordstatus], [recordstatus], [email], [sysadmin])
VALUES 
  (5, N'test', N'user22', N'test', N'n4bQgYhMfWWaL+qgxVrQFaO/TxsrC4Is0V1sFbDwCgg=', NULL, 8, N'email@mail.md', 0)
GO

INSERT INTO [dbo].[users] ([userid], [Nume], [Prenume], [login], [password], [passwordstatus], [recordstatus], [email], [sysadmin])
VALUES 
  (6, N'dima', N'tkacenko', N'dtkacenko', N'MRISyxHTT8K+nwsP6sZefcNTl7UHtJ+0vt1jpuyIh7k=', NULL, 8, N'dtkacenko@yahoo.com', 1)
GO

INSERT INTO [dbo].[users] ([userid], [Nume], [Prenume], [login], [password], [passwordstatus], [recordstatus], [email], [sysadmin])
VALUES 
  (7, N'test1', N'tester', N'test1', N'G08OmFGXGZjnMgeFRMlrNsPQHO33yqMyNZ1vHYNWcBQ=', NULL, 8, N'dtkacenko@yahoo.com', 0)
GO

SET IDENTITY_INSERT [dbo].[users] OFF
GO

--
-- Data for table dbo.Vinzari  (LIMIT 0,50000)
--

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1525', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1075, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1525', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1076, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1527', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1077, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1078, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1527', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1079, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1527', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1080, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1081, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1082, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1083, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1084, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1527', 25)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1528', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1085, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1522', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1527', 18)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1528', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1086, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1522', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1087, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1088, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1520', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1089, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1090, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1527', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1091, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1092, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1093, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1523', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1094, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1095, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1096, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1097, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1523', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1524', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1098, N'1527', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1520', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1521', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1099, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1100, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1101, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1520', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1102, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1523', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1525', 17)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1527', 19)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1103, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1520', 18)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1104, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1105, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1106, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1107, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1522', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1523', 0)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1525', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1527', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1528', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1108, N'1529', 23)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1527', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1528', 21)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1109, N'1529', 29)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1110, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1527', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1111, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1112, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1525', 25)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1526', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1113, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1525', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1114, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1115, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1116, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1117, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1118, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1119, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1120, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1121, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1122, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1527', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1123, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1527', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1124, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1125, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1126, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1127, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1128, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1129, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1130, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1131, N'1528', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1132, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1520', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1133, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1134, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1135, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1520', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1521', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1522', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1136, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1528', 20)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1137, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1138, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1528', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1139, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1140, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1141, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1142, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1143, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1144, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1520', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1145, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1146, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1524', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1147, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1148, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1520', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1149, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1520', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1150, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1151, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1523', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1152, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1153, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1154, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1520', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1155, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1156, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1157, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1158, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1159, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1160, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1524', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1528', 18)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1161, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1524', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1162, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1163, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1164, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1520', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1521', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1524', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1527', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1528', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1165, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1521', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1166, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1167, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1168, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1169, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1525', 35)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1170, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1520', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1171, N'1528', 90)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1172, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1173, N'1528', 30)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1525', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1174, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1175, N'1528', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1175, N'1529', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1176, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1177, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1178, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1178, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1178, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1179, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1180, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1181, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1520', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1182, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1526', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1183, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1184, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1185, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1522', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1523', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1524', 22)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1525', 29)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1527', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1528', 39)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1186, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1522', 17)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1524', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1527', 21)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1187, N'1529', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1522', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1523', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1188, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1521', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1523', 0)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1189, N'1528', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1190, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1191, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1192, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1193, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1194, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1195, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1196, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1197, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1522', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1198, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1199, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1523', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1200, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1523', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1201, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1202, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1521', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1203, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1204, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1205, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1206, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1207, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1522', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1208, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1209, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1209, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1210, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1211, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1526', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1212, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1213, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1214, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1214, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1215, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1216, N'1528', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1217, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1217, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1218, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1219, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1219, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1219, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1220, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1221, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1222, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1222, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1223, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1224, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1225, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1226, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1227, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1228, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1228, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1229, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1230, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1230, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1231, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1232, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1233, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1234, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1235, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1236, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1236, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1237, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1238, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1239, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1520', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1240, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1241, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1242, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1243, N'1529', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1244, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1245, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1246, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1528', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1247, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1248, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1526', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1249, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1250, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1251, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1252, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1253, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1254, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1255, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1256, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1257, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1258, N'1529', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1259, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1260, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1261, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1262, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1263, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1264, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1265, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1266, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1268, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1269, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1271, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1278, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1278, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1279, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1279, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1281, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1281, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1283, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1284, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1285, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1286, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1287, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1289, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1290, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1292, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1293, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1294, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1295, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1296, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1523', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1525', 17)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1527', 23)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1528', 36)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1298, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1525', 21)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1299, N'1527', 24)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1527', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1300, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1301, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1302, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1524', 35)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1303, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1304, N'1525', 17)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1305, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1305, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1306, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1523', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1307, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1526', 23)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1308, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1309, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1310, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1311, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1526', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1312, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1526', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1313, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1314, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1315, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1521', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1316, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1520', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1317, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1318, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1319, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1522', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1525', 31)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1527', 31)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1320, N'1528', 35)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1520', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1521', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1523', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1525', 30)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1527', 34)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1528', 25)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1321, N'1529', 24)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1322, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1323, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1324, N'1527', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1524', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1325, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1525', 18)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1326, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1525', 22)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1327, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1527', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1328, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1527', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1329, N'1529', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1330, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1331, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1332, N'1524', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1332, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1333, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1334, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1335, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1335, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1336, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1337, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1520', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1523', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1524', 33)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1338, N'1525', 23)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1523', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1339, N'1525', 32)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1340, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1341, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1342, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1520', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1343, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1344, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1520', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1525', 48)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1345, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1527', 35)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1528', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1346, N'1529', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1524', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1347, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1348, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1349, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1522', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1527', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1350, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1523', 0)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1527', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1351, N'1528', 25)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1527', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1352, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1353, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1527', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1354, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1527', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1355, N'1529', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1527', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1528', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1356, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1357, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1358, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1527', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1359, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1360, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1361, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1361, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1362, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1362, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1363, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1364, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1365, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1365, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1366, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1366, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1367, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1367, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1368, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1369, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1370, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1371, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1372, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1373, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1375, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1376, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1377, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1378, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1378, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1383, N'1528', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1383, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1384, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1385, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1386, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1386, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1387, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1388, N'1528', 22)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1388, N'1529', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1389, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1389, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1390, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1390, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1391, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1392, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1394, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1395, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1399, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1399, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1399, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1400, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1400, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1400, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1401, N'1520', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1401, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1401, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1402, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1402, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1403, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1405, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1409, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1410, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1411, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1412, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1413, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1413, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1413, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1414, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1415, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1415, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1524', 18)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1416, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1417, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1418, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1523', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1419, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1523', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1420, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1526', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1421, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1422, N'1524', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1422, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1520', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1423, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1424, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1524', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1425, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1426, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1427, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1524', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1428, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1429, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1525', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1526', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1430, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1431, N'1528', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1432, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1433, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1523', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1434, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1435, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1436, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1437, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1438, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1439, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1528', 22)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1440, N'1529', 22)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1528', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1441, N'1529', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1528', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1442, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1443, N'1528', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1444, N'1528', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1520', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1445, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1521', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1446, N'1529', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1447, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1521', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1448, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1524', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1449, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1450, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1524', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1451, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1452, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1453, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1454, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1455, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1456, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1457, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1458, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1522', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1459, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1460, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1523', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1461, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1462, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1525', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1463, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1464, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1524', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1465, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1466, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1467, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1467, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1523', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1525', 20)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1468, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1469, N'1529', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1470, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1471, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1472, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1524', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1473, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1474, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1475, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1476, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1477, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1478, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1479, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1480, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1521', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1522', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1481, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1482, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1483, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1485, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1486, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1487, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1488, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1489, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1490, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1491, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1492, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1494, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1496, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1499, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1501, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1502, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1503, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1504, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1505, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1506, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1507, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1508, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1509, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1510, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1511, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1512, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1520', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1514, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1520', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1527', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1515, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1516, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1526', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1517, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1518, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1519, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1520, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1520, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1521, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1522, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1523, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1524, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1525, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1526, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1527, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1528, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1529, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1530, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1531, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1532, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1533, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1534, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1535, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1536, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1537, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1538, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1525', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1539, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1523', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1540, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1541, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1541, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1542, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1543, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1544, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1544, N'1529', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1524', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1545, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1546, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1547, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1548, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1549, N'1525', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1549, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1551, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1551, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1552, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1553, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1553, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1525', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1554, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1525', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1555, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1556, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1558, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1558, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1559, N'1525', 19)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1525', 19)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1526', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1560, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1561, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1525', 19)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1564, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1525', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1565, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1566, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1567, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1568, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1568, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1569, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1570, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1571, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1572, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1573, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1573, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1574, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1575, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1576, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1577, N'1529', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1578, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1579, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1580, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1581, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1525', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1527', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1582, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1583, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1584, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1585, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1585, N'1524', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1586, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1527', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1587, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1588, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1522', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1589, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1522', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1590, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1591, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1592, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1593, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1528', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1594, N'1529', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1527', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1528', 17)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1595, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1596, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1597, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1525', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1598, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1521', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1599, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1600, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1523', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1601, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1602, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1603, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1603, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1604, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1605, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1606, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1607, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1608, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1608, N'1525', 12)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1524', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1609, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1610, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1611, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1611, N'1525', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1612, N'1526', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1525', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1613, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1614, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1524', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1615, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1524', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1616, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1617, N'1528', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1520', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1522', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1528', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1618, N'1529', 26)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1522', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1525', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1619, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1620, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1525', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1621, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1521', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1622, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1525', 21)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1623, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1525', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1624, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1520', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1625, N'1529', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1626, N'1528', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1626, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1627, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1628, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1526', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1527', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1629, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1525', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1630, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1631, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1524', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1525', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1526', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1527', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1632, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1525', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1633, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1526', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1634, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1524', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1525', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1527', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1635, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1636, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1636, N'1529', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1637, N'1528', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1637, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1638, N'1528', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1638, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1639, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1639, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1521', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1528', 2)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1640, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1641, N'1528', 19)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1641, N'1529', 10)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1642, N'1528', 16)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1642, N'1529', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1643, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1644, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1645, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1645, N'1529', 11)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1646, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1646, N'1529', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1647, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1647, N'1529', 3)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1648, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1648, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1649, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1649, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1650, N'1528', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1650, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1651, N'1528', 14)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1651, N'1529', 8)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1652, N'1528', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1652, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1653, N'1528', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1653, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1654, N'1528', 6)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1655, N'1528', 15)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1655, N'1529', 5)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1656, N'1528', 13)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1656, N'1529', 7)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1657, N'1528', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1657, N'1529', 4)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1658, N'1528', 9)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1658, N'1529', 1)
GO

INSERT INTO [dbo].[Vinzari] ([product_id], [week], [quantity])
VALUES 
  (1659, N'1528', 6)
GO

--
-- Data for table dbo.weeks  (LIMIT 0,50000)
--

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1501')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1502')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1503')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1504')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1505')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1506')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1507')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1508')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1509')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1510')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1511')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1512')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1513')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1514')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1515')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1516')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1517')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1518')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1519')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1520')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1521')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1522')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1523')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1524')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1525')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1526')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1527')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1528')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1529')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1530')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1531')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1532')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1533')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1534')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1535')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1536')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1537')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1538')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1539')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1540')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1541')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1542')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1543')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1544')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1545')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1546')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1547')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1548')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1549')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1550')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1551')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1552')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1553')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1554')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1601')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1602')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1603')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1604')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1605')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1606')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1607')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1608')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1609')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1610')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1611')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1612')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1613')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1614')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1615')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1616')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1617')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1618')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1619')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1620')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1621')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1622')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1623')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1624')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1625')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1626')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1627')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1628')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1629')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1630')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1631')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1632')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1633')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1634')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1635')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1636')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1637')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1638')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1639')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1640')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1641')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1642')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1643')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1644')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1645')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1646')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1647')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1648')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1649')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1650')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1651')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1652')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1653')
GO

INSERT INTO [dbo].[weeks] ([week])
VALUES 
  (N'1654')
GO

--
-- Definition for indices : 
--

ALTER TABLE [dbo].[Classifiers]
ADD CONSTRAINT [Classifiers_pk] 
PRIMARY KEY CLUSTERED ([Code])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClassifierType]
ADD CONSTRAINT [ClassifierType_pk] 
PRIMARY KEY CLUSTERED ([TypeID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Client]
ADD CONSTRAINT [Client_pk] 
PRIMARY KEY CLUSTERED ([clientID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClientContracts]
ADD CONSTRAINT [PK__ClientCo__90ACC2661273C1CD] 
PRIMARY KEY CLUSTERED ([client_id], [contract_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClientOrders]
ADD CONSTRAINT [PK__ClientOr__46596229164452B1] 
PRIMARY KEY CLUSTERED ([order_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[InWey]
ADD CONSTRAINT [PK__InWey__36137E88F60FC415] 
PRIMARY KEY CLUSTERED ([product_id], [week])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Kanban]
ADD CONSTRAINT [PK__Kanban__47027DF5D1F1C488] 
PRIMARY KEY CLUSTERED ([product_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Livrari]
ADD CONSTRAINT [PK__Livrari__36137E88DBD1C137] 
PRIMARY KEY CLUSTERED ([product_id], [week])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[logs]
ADD CONSTRAINT [PK__logs__3213E83F08EA5793] 
PRIMARY KEY CLUSTERED ([id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK__Orders__36137E88DAB689D1] 
PRIMARY KEY CLUSTERED ([product_id], [week])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProductDetails]
ADD CONSTRAINT [PK__ProductD__47027DF5AD19ACC3] 
PRIMARY KEY CLUSTERED ([product_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[st_domains]
ADD CONSTRAINT [PK__st_domai__645FBA25E25B2FF5] 
PRIMARY KEY CLUSTERED ([module_id], [domain_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[st_modules]
ADD CONSTRAINT [st_modules_pk] 
PRIMARY KEY CLUSTERED ([module_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[st_roles]
ADD CONSTRAINT [st_roles_pk] 
PRIMARY KEY CLUSTERED ([role_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[st_roles_permissions]
ADD CONSTRAINT [PK__st_roles__6085B4526FB0EDAB] 
PRIMARY KEY CLUSTERED ([module_id], [role_id], [domain_id], [permissions])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[st_users_roles]
ADD CONSTRAINT [PK__st_users__6EDEA1530CBAE877] 
PRIMARY KEY CLUSTERED ([user_id], [role_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Stok]
ADD CONSTRAINT [PK__Stok__4A8504C7E002C390] 
PRIMARY KEY CLUSTERED ([product_id], [week])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[users]
ADD CONSTRAINT [users_pk] 
PRIMARY KEY CLUSTERED ([userid])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Vinzari]
ADD CONSTRAINT [PK__Vinzari__36137E884230EE95] 
PRIMARY KEY CLUSTERED ([product_id], [week])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[weeks]
ADD CONSTRAINT [PK__weeks__111037D6A2172BF4] 
PRIMARY KEY CLUSTERED ([week])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

--
-- Definition for foreign keys : 
--

ALTER TABLE [dbo].[Classifiers]
ADD CONSTRAINT [Classifiers_typeID_fk] FOREIGN KEY ([TypeID]) 
  REFERENCES [dbo].[ClassifierType] ([TypeID]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[InWey]
ADD FOREIGN KEY ([product_id]) 
  REFERENCES [dbo].[ProductDetails] ([product_id]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[InWey]
ADD CONSTRAINT [InWey_weeks_fk] FOREIGN KEY ([week]) 
  REFERENCES [dbo].[weeks] ([week]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Kanban]
ADD FOREIGN KEY ([product_id]) 
  REFERENCES [dbo].[ProductDetails] ([product_id]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Livrari]
ADD FOREIGN KEY ([product_id]) 
  REFERENCES [dbo].[ProductDetails] ([product_id]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Livrari]
ADD CONSTRAINT [Livrari_weeks_fk] FOREIGN KEY ([week]) 
  REFERENCES [dbo].[weeks] ([week]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Orders]
ADD FOREIGN KEY ([product_id]) 
  REFERENCES [dbo].[ProductDetails] ([product_id]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [Orders_weeks_fk] FOREIGN KEY ([week]) 
  REFERENCES [dbo].[weeks] ([week]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Stok]
ADD CONSTRAINT [Stok_Produs_fk] FOREIGN KEY ([product_id]) 
  REFERENCES [dbo].[ProductDetails] ([product_id]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Stok]
ADD CONSTRAINT [Stok_weeks_fk] FOREIGN KEY ([week]) 
  REFERENCES [dbo].[weeks] ([week]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Vinzari]
ADD FOREIGN KEY ([product_id]) 
  REFERENCES [dbo].[ProductDetails] ([product_id]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Vinzari]
ADD CONSTRAINT [Vinzari_weeks_fk] FOREIGN KEY ([week]) 
  REFERENCES [dbo].[weeks] ([week]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

