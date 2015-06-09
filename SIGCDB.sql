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
  [nr] int NULL,
  [articol] int NULL,
  [desen] int NULL,
  [tip] int NULL,
  [colorit] int NULL,
  [latime] decimal(18, 2) NULL,
  [lungime] decimal(18, 2) NULL,
  [metraj] decimal(18, 2) NOT NULL,
  [bucati] int NOT NULL,
  [festonare] int NULL,
  [ean13] nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
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
-- Definition for table OrdersDelivery : 
--

CREATE TABLE [dbo].[OrdersDelivery] (
  [delivery_id] int IDENTITY(1, 1) NOT NULL,
  [date] date NOT NULL,
  [order_id] int NOT NULL,
  [quantity] int NOT NULL,
  [delivery_doc] text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
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
-- Data for table dbo.Classifiers  (LIMIT 0,5000)
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
  (53, 285, N'Covor', NULL, 1)
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
  (53, 288, N'Traversa', NULL, 4)
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

SET IDENTITY_INSERT [dbo].[Classifiers] OFF
GO

--
-- Data for table dbo.ClassifierType  (LIMIT 0,5000)
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
-- Data for table dbo.Client  (LIMIT 0,5000)
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
-- Data for table dbo.ClientContracts  (LIMIT 0,5000)
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
-- Data for table dbo.ClientOrders  (LIMIT 0,5000)
--

SET IDENTITY_INSERT [dbo].[ClientOrders] ON
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (1, 281, N'2015-06-12', 1, 777, 274, 0, 286, 308, 0, 0, 100, 122, 324, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (2, 281, N'2015-06-09', 1, 454, 271, 0, 285, 311, 2, 3, 345, 65, 324, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (3, 282, N'2015-06-26', 1, 74856, 271, 0, 285, 311, 0, 0, 787, 55, 324, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (4, 281, N'2015-07-11', 1, 56535, 271, 0, 285, 311, 1, 2, 23, 10, 324, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (6, 281, N'2015-06-08', 4, 0, 0, 0, 0, 0, 0, 0, 400, 40, 0, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (7, 281, N'2015-06-08', 0, 0, 271, 0, 285, 311, 0, 0, 400, 40, 324, N'45214367678879009-')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (8, 281, N'2015-06-08', 0, 0, 271, 0, 285, 311, 0, 0, 400, 40, 324, N'45214367678879009-')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (9, 281, N'2015-06-08', 0, 0, 271, 0, 285, 311, 0, 0, 400, 40, 324, N'45214367678879009')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (10, 282, N'2015-06-08', 3, 0, 271, 0, 285, 311, 0, 0, 200, 20, 324, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (11, 282, N'2015-06-08', 0, 0, 271, 0, 285, 311, 0, 0, 200, 20, 324, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (12, 281, N'2015-06-13', 3, 0, 0, 0, 0, 0, 0, 0, 67, 7, 0, N'')
GO

INSERT INTO [dbo].[ClientOrders] ([order_id], [state], [date], [client_id], [nr], [articol], [desen], [tip], [colorit], [latime], [lungime], [metraj], [bucati], [festonare], [ean13])
VALUES 
  (13, 281, N'2015-06-18', 1, 0, 0, 0, 0, 0, 0, 0, 5656, 565, 0, N'')
GO

SET IDENTITY_INSERT [dbo].[ClientOrders] OFF
GO

--
-- Data for table dbo.OrdersDelivery  (LIMIT 0,5000)
--

SET IDENTITY_INSERT [dbo].[OrdersDelivery] ON
GO

INSERT INTO [dbo].[OrdersDelivery] ([delivery_id], [date], [order_id], [quantity], [delivery_doc])
VALUES 
  (2, N'1981-01-20', 1, 5, N'sdvfbgf')
GO

INSERT INTO [dbo].[OrdersDelivery] ([delivery_id], [date], [order_id], [quantity], [delivery_doc])
VALUES 
  (3, N'2017-01-20', 1, 2, N'666666')
GO

INSERT INTO [dbo].[OrdersDelivery] ([delivery_id], [date], [order_id], [quantity], [delivery_doc])
VALUES 
  (6, N'2015-06-01', 1, 2, N'3')
GO

SET IDENTITY_INSERT [dbo].[OrdersDelivery] OFF
GO

--
-- Data for table dbo.st_modules  (LIMIT 0,5000)
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
-- Data for table dbo.st_roles  (LIMIT 0,5000)
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
-- Data for table dbo.st_users_roles  (LIMIT 0,5000)
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
-- Data for table dbo.users  (LIMIT 0,5000)
--

SET IDENTITY_INSERT [dbo].[users] ON
GO

INSERT INTO [dbo].[users] ([userid], [Nume], [Prenume], [login], [password], [passwordstatus], [recordstatus], [email], [sysadmin])
VALUES 
  (1, N'Iastrebov', N'Sergiu', N'seriiiastreb', N'T8grJq7LR9KGjE7741gXMqPny8xsLvsyBiwIFwoF7rg=', 6, 8, N'iastrebov.sergiu@mail.md', 1)
GO

INSERT INTO [dbo].[users] ([userid], [Nume], [Prenume], [login], [password], [passwordstatus], [recordstatus], [email], [sysadmin])
VALUES 
  (5, N'test', N'user22', N'test', N'sVVt6jLp0M2/7QOP13hydXdepAk5wUamTiBbyzSa0C8=', NULL, 8, N'email@mail.md', 0)
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

ALTER TABLE [dbo].[OrdersDelivery]
ADD CONSTRAINT [PK__OrdersDe__1C5CF4F5D49E98C9] 
PRIMARY KEY CLUSTERED ([delivery_id])
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

--
-- Definition for foreign keys : 
--

ALTER TABLE [dbo].[Classifiers]
ADD CONSTRAINT [Classifiers_typeID_fk] FOREIGN KEY ([TypeID]) 
  REFERENCES [dbo].[ClassifierType] ([TypeID]) 
  ON UPDATE CASCADE
  ON DELETE CASCADE
GO

