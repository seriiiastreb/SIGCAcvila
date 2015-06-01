-- SQL Manager 2008 for SQL Server 3.3.0.1
-- ---------------------------------------
-- Host      : SERGIUDB\SQLEXPRESS
-- Database  : sigc
-- Version   : Microsoft SQL Server  10.50.1600.1


CREATE DATABASE [sigc]
ON PRIMARY
  ( NAME = [sigc],
    FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\sigc.mdf',
    SIZE = 2 MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1 MB )
LOG ON
  ( NAME = [sigc_log],
    FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\sigc_log.ldf',
    SIZE = 1 MB,
    MAXSIZE = 0 MB,
    FILEGROWTH = 10 % )
COLLATE SQL_Latin1_General_CP1_CI_AS
GO

USE [sigc]
GO

--
-- Definition for user dbuser : 
--

CREATE USER [dbuser]
  WITHOUT LOGIN 
  WITH DEFAULT_SCHEMA = [dbo]
GO

--
-- Definition for user sigc : 
--

CREATE USER [sigc]
  FOR LOGIN  [sigc]
  WITH DEFAULT_SCHEMA = [dbo]
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
-- Definition for table st_domains : 
--

CREATE TABLE [dbo].[st_domains] (
  [module_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [domain_id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [description] nvarchar(256) COLLATE Cyrillic_General_CI_AS NOT NULL
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
  (4, 208, N'Masculin', NULL, NULL)
GO

INSERT INTO [dbo].[Classifiers] ([TypeID], [Code], [Name], [Description], [GroupCode])
VALUES 
  (4, 209, N'Feminin', NULL, NULL)
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
  (4, N'Gender', 0, 0)
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

SET IDENTITY_INSERT [dbo].[ClassifierType] OFF
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

SET IDENTITY_INSERT [dbo].[users] OFF
GO

--
-- Definition for indices : 
--

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

