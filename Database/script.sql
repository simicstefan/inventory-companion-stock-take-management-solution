USE [master]
GO
/****** Object:  Database [Popis]    Script Date: 09.12.2022 08:42:31 ******/
CREATE DATABASE [Popis]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_A56285_popis_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DB_A56285_popis_DATA.mdf' , SIZE = 25408KB , MAXSIZE = 1024000KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'DB_A56285_popis_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DB_A56285_popis_Log.LDF' , SIZE = 164544KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Popis] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Popis].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Popis] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Popis] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Popis] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Popis] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Popis] SET ARITHABORT OFF 
GO
ALTER DATABASE [Popis] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Popis] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Popis] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Popis] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Popis] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Popis] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Popis] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Popis] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Popis] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Popis] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Popis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Popis] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Popis] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Popis] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Popis] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Popis] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Popis] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Popis] SET RECOVERY FULL 
GO
ALTER DATABASE [Popis] SET  MULTI_USER 
GO
ALTER DATABASE [Popis] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Popis] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Popis] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Popis] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Popis] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Popis', N'ON'
GO
ALTER DATABASE [Popis] SET QUERY_STORE = OFF
GO
USE [Popis]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDateTimePopis]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDateTimePopis]
(
	-- Add the parameters for the function here
	
)
RETURNS DateTime
AS
BEGIN
	DECLARE @DatumVreme datetime
	SET @DatumVreme	 = DATEADD(HOUR, 8, GETDATE())
	-- Return the result of the function
	RETURN @DatumVreme


END
GO
/****** Object:  UserDefinedFunction [dbo].[NadjiIDMaterijalaPrekoOznake]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[NadjiIDMaterijalaPrekoOznake]
(
	-- Add the parameters for the function here
	@OznakaMaterijala nvarchar(50)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @IDMaterijal int

	-- Add the T-SQL statements to compute the return value here
	IF EXISTS (SELECT IDMaterijal FROM Materijal WHERE OznakaMaterijala = @OznakaMaterijala)
	BEGIN
		SET @IDMaterijal = (SELECT IDMaterijal FROM Materijal WHERE OznakaMaterijala = @OznakaMaterijala)
	END
	ELSE
	BEGIN
		SET @IDMaterijal = 0
	END

	-- Return the result of the function
	RETURN @IDMaterijal

END
GO
/****** Object:  Table [dbo].[Zona]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zona](
	[IDZona] [int] IDENTITY(1,1) NOT NULL,
	[NazivZone] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Zona] PRIMARY KEY CLUSTERED 
(
	[IDZona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projekat]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projekat](
	[IDProjekat] [int] IDENTITY(1,1) NOT NULL,
	[NazivProjekta] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Projekat] PRIMARY KEY CLUSTERED 
(
	[IDProjekat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProjekatZona]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProjekatZona]
AS
SELECT        TOP (100) PERCENT p.NazivProjekta, z.NazivZone
FROM            dbo.Projekat AS p INNER JOIN
                         dbo.ZonaProjekat AS zp ON zp.IDProjekat = p.IDProjekat INNER JOIN
                         dbo.Zona AS z ON zp.IDZona = z.IDZona
ORDER BY p.NazivProjekta
GO
/****** Object:  Table [dbo].[Materijal]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materijal](
	[IDMaterijal] [int] IDENTITY(1,1) NOT NULL,
	[OznakaMaterijala] [nvarchar](50) NOT NULL,
	[OpisMaterijala] [nvarchar](250) NULL,
 CONSTRAINT [PK_Materijal2] PRIMARY KEY CLUSTERED 
(
	[IDMaterijal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Korisnik]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Korisnik](
	[IDKorisnik] [int] IDENTITY(1,1) NOT NULL,
	[IDKartica] [int] NOT NULL,
	[Ime] [nvarchar](50) NULL,
	[Prezime] [nvarchar](50) NULL,
 CONSTRAINT [PK_Korisnik] PRIMARY KEY CLUSTERED 
(
	[IDKorisnik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Skeniranje]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skeniranje](
	[IDSkeniranje] [int] IDENTITY(1,1) NOT NULL,
	[IDKorisnik] [int] NOT NULL,
	[IDMaterijal] [int] NOT NULL,
	[Kolicina] [int] NOT NULL,
	[DatumVremeSkeniranje] [datetime] NOT NULL,
	[Komentar] [nvarchar](250) NULL,
	[Neaktivan] [int] NOT NULL,
	[DatumVremeUpdate] [datetime] NOT NULL,
	[IDProjekat] [int] NOT NULL,
	[IDZona] [int] NOT NULL,
 CONSTRAINT [PK_Skeniranje] PRIMARY KEY CLUSTERED 
(
	[IDSkeniranje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SkeniranjeView]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SkeniranjeView]
AS
SELECT        k.IDKartica, m.IDMaterijal, m.OznakaMaterijala, s.Kolicina, s.Komentar, s.DatumVremeSkeniranje
FROM            dbo.Skeniranje AS s INNER JOIN
                         dbo.Materijal AS m ON s.IDMaterijal = m.IDMaterijal INNER JOIN
                         dbo.Korisnik AS k ON k.IDKorisnik = s.IDKorisnik
GO
/****** Object:  Table [dbo].[IstorijaPrijave]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IstorijaPrijave](
	[IDIstorijaPrijave] [int] IDENTITY(1,1) NOT NULL,
	[IDKartica] [int] NOT NULL,
	[DatumVreme] [datetime] NOT NULL,
 CONSTRAINT [PK_IstorijaPrijave] PRIMARY KEY CLUSTERED 
(
	[IDIstorijaPrijave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[IstorijaPrijave] ON 

INSERT [dbo].[IstorijaPrijave] ([IDIstorijaPrijave], [IDKartica], [DatumVreme]) VALUES (1, 10029, CAST(N'2020-04-08T06:09:31.997' AS DateTime))
SET IDENTITY_INSERT [dbo].[IstorijaPrijave] OFF
SET IDENTITY_INSERT [dbo].[Korisnik] ON 

INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (1, 10001, N'Bogdan', N'Avramović')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3040, 10002, N'Boško', N'Aničić')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3041, 10003, N'Branko', N'Bajkić')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3042, 10004, N'Branislav', N'Bosnić')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3043, 10005, N'Darko', N'Vesic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3044, 10006, N'Dobrivoje', N'Gagic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3045, 10007, N'Dragoljub', N'Gajic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3046, 10008, N'Danijela', N'Geric')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3047, 10009, N'Divna', N'Gacic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3048, 10010, N'Dubravka', N'Demic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3049, 10011, N'Eva', N'Ðekic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3050, 10012, N'Živanko', N'Ðurišic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3051, 10013, N'Željka', N'Elcic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3052, 10014, N'Zlatiborka', N'Egaric')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3053, 10015, N'Isak', N'Žabic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3054, 10016, N'Janko', N'Žutic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3055, 10017, N'Jugoslav', N'Zaric')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3056, 10018, N'Jelisava', N'Ibric')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3057, 10019, N'Luka', N'Ivic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3058, 10020, N'Leonora', N'Ijacic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3059, 10021, N'Ljiljan', N'Janic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3060, 10022, N'Ljubosava', N'Janketic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3061, 10023, N'Marko', N'Jovic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3062, 10024, N'Milašin', N'Kandic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3063, 10025, N'Milovan', N'Kocic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3064, 10026, N'Miodrag', N'Kanaric')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3065, 10027, N'Maja', N'Krstic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3066, 10028, N'Monika', N'Milacic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3067, 10029, N'Nemanja', N'Njegic')
INSERT [dbo].[Korisnik] ([IDKorisnik], [IDKartica], [Ime], [Prezime]) VALUES (3068, 10030, N'Natalija', N'Ojdanic')
SET IDENTITY_INSERT [dbo].[Korisnik] OFF
SET IDENTITY_INSERT [dbo].[Materijal] ON 

INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240195, N'LM4458923', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240196, N'LM4458924', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240197, N'LM4458921', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240198, N'LM4458925', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240199, N'LM4458926', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240200, N'LM4458929', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240201, N'LM4458928', N'Triplex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240202, N'LM4458922', N'Tripex')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240203, N'MF5763981', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240204, N'MF5763982', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240205, N'MF5763983', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240206, N'MF5763984', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240207, N'MF5763985', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240208, N'MF5763986', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240209, N'MF5763987', N'Main-feeder')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240210, N'PF73419301', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240211, N'PF73419302', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240212, N'PF73419303', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240213, N'PF73419304', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240214, N'PF73419305', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240215, N'PF73419306', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240216, N'PF73419307', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240217, N'PF73419308', N'Panel-feed')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240218, N'SS09838471', N'Single-strand')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240219, N'SS09838472', N'Single-strand')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240221, N'SS09838473', N'Single-strand')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240222, N'SS09838474', N'Single-strand')
INSERT [dbo].[Materijal] ([IDMaterijal], [OznakaMaterijala], [OpisMaterijala]) VALUES (240223, N'SS09838475', N'Single-strand')
SET IDENTITY_INSERT [dbo].[Materijal] OFF
SET IDENTITY_INSERT [dbo].[Projekat] ON 

INSERT [dbo].[Projekat] ([IDProjekat], [NazivProjekta]) VALUES (1, N'Chassis')
INSERT [dbo].[Projekat] ([IDProjekat], [NazivProjekta]) VALUES (2, N'Cockpit')
INSERT [dbo].[Projekat] ([IDProjekat], [NazivProjekta]) VALUES (3, N'Passenger cars')
INSERT [dbo].[Projekat] ([IDProjekat], [NazivProjekta]) VALUES (4, N'Brake system')
SET IDENTITY_INSERT [dbo].[Projekat] OFF
SET IDENTITY_INSERT [dbo].[Skeniranje] ON 

INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (218, 3068, 240196, 50, CAST(N'2020-03-31T03:21:40.883' AS DateTime), NULL, 0, CAST(N'2020-03-31T03:21:40.883' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (219, 3068, 240199, 25, CAST(N'2020-03-31T03:21:48.437' AS DateTime), NULL, 0, CAST(N'2020-03-31T03:21:48.437' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (220, 3068, 240207, 100, CAST(N'2020-03-31T03:21:52.930' AS DateTime), NULL, 0, CAST(N'2020-03-31T03:21:52.930' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (221, 3068, 240213, 75, CAST(N'2020-03-31T03:21:57.443' AS DateTime), NULL, 0, CAST(N'2020-03-31T03:21:57.443' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (222, 3068, 240213, 75, CAST(N'2020-03-31T03:22:03.177' AS DateTime), NULL, 0, CAST(N'2020-03-31T03:22:03.177' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (223, 3068, 240213, 100, CAST(N'2020-03-31T03:22:08.873' AS DateTime), NULL, 1, CAST(N'2020-03-31T17:45:01.470' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (224, 3068, 240213, 500, CAST(N'2020-03-31T17:45:18.580' AS DateTime), NULL, 0, CAST(N'2020-03-31T17:45:18.580' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (225, 3068, 240214, 25, CAST(N'2020-04-02T05:48:26.653' AS DateTime), N'commentaire', 0, CAST(N'2020-04-02T05:48:26.653' AS DateTime), 3, 38)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (231, 3067, 240198, 25, CAST(N'2020-04-06T03:47:29.467' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:47:29.467' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (232, 3067, 240199, 50, CAST(N'2020-04-06T03:47:39.460' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:47:39.460' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (233, 3067, 240203, 50, CAST(N'2020-04-06T03:47:44.593' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:47:44.593' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (234, 3067, 240205, 50, CAST(N'2020-04-06T03:47:49.337' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:47:49.337' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (235, 3067, 240207, 75, CAST(N'2020-04-06T03:47:55.510' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:47:55.510' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (236, 3067, 240207, 150, CAST(N'2020-04-06T03:47:58.177' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:47:58.177' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (237, 3067, 240207, 250, CAST(N'2020-04-06T03:48:00.847' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:48:00.847' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (238, 3067, 240213, 25, CAST(N'2020-04-06T03:48:04.320' AS DateTime), NULL, 0, CAST(N'2020-04-06T03:48:04.320' AS DateTime), 1, 1)
INSERT [dbo].[Skeniranje] ([IDSkeniranje], [IDKorisnik], [IDMaterijal], [Kolicina], [DatumVremeSkeniranje], [Komentar], [Neaktivan], [DatumVremeUpdate], [IDProjekat], [IDZona]) VALUES (239, 3067, 240195, 25, CAST(N'2020-04-08T05:06:14.750' AS DateTime), NULL, 0, CAST(N'2020-04-08T05:06:14.750' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Skeniranje] OFF
SET IDENTITY_INSERT [dbo].[Zona] ON 

INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (1, N'Line 1')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (37, N'Line 2')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (38, N'Line 3')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (39, N'Line 4')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (40, N'Line 5')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (41, N'Line 6')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (42, N'Pre-assembly')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (43, N'Cutting')
INSERT [dbo].[Zona] ([IDZona], [NazivZone]) VALUES (44, N'Rework')
SET IDENTITY_INSERT [dbo].[Zona] OFF
/****** Object:  StoredProcedure [dbo].[sp_DajSveProjekteZaCmb]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DajSveProjekteZaCmb]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Projekat
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DajSveSkenirano]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DajSveSkenirano]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Skeniranje
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DajSveSkeniranoZaKorisnika]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DajSveSkeniranoZaKorisnika]
	-- Add the parameters for the stored procedure here
	@IDKorisnik int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT sk.IDKorisnik, sk.IDMaterijal, sk.IDSkeniranje, m.OpisMaterijala, m.OznakaMaterijala, sk.Kolicina, sk.Komentar ,sk.DatumVremeSkeniranje FROM Skeniranje AS sk
		INNER JOIN Materijal AS m ON sk.IDMaterijal = m.IDMaterijal
	WHERE IDKorisnik = @IDKorisnik AND Neaktivan = 0
	ORDER BY sk.DatumVremeSkeniranje DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DajSveZoneZaCmb]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DajSveZoneZaCmb]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Zona
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DajSveZoneZaCmbPremaProjektu]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DajSveZoneZaCmbPremaProjektu]
	-- Add the parameters for the stored procedure here
	@IDProjekat int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT z.IDZona, z.NazivZone FROM ZonaProjekat AS zp
	INNER JOIN Projekat AS p ON p.IDProjekat = zp.IDProjekat
	INNER JOIN Zona AS z ON z.IDZona = zp.IDZona
	WHERE zp.IDProjekat = @IDProjekat
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DodajSkeniranje]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DodajSkeniranje]
	-- Add the parameters for the stored procedure here
	@IDKorisnik int,
	@OznakaMaterijala nvarchar(50),
	@Kolicina int,
	@Komentar nvarchar(250) = NULL,
	@IDProjekat int,
	@IDZona int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @IDMaterijal int
	SET @IDMaterijal = [dbo].[NadjiIDMaterijalaPrekoOznake](@OznakaMaterijala)
	IF @IDMaterijal = 0
	BEGIN
		RAISERROR ('Materijal pod tom oznakom ne postoji.', 11, 1) 
	END

	INSERT INTO dbo.Skeniranje
	(
	    --IDSkeniranje - column value is auto-generated
	    IDKorisnik,
	    IDMaterijal,
	    Kolicina,
	    DatumVremeSkeniranje,
	    Komentar,
	    Neaktivan,
	    DatumVremeUpdate,
		IDProjekat,
		IDZona
	)
	VALUES
	(
	    -- IDSkeniranje - int
	    @IDKorisnik, -- IDKorisnik - int
	    @IDMaterijal, -- IDMaterijal - int
	    @Kolicina, -- Kolicina - int
	    dbo.GetDateTimePopis(), -- DatumVremeSkeniranje - datetime
	    @Komentar, -- Komentar - nvarchar
	    0, -- Neaktivan - int
	    dbo.GetDateTimePopis(), -- DatumVremeUpdate - datetime
		@IDProjekat,
		@IDZona
	)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Izvestaj]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Izvestaj]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT MIN(m.OznakaMaterijala) AS OznakaMaterijala, SUM(Kolicina) AS Kolicina FROM Skeniranje AS s
	INNER JOIN Materijal AS m ON s.IDMaterijal = m.IDMaterijal
	WHERE s.Neaktivan = 0
	GROUP BY s.IDMaterijal
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObrisiSkeniranje]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ObrisiSkeniranje]
	-- Add the parameters for the stored procedure here
	@IDSkeniranje int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Skeniranje
	SET Neaktivan = 1, DatumVremeUpdate = dbo.GetDateTimePopis()
	WHERE IDSkeniranje = @IDSkeniranje
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PrijavaKorisnika]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_PrijavaKorisnika]
	-- Add the parameters for the stored procedure here
	@IDKartica int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Korisnik
	WHERE IDKartica = @IDKartica

	INSERT INTO dbo.IstorijaPrijave
	(
	    IDKartica,
	    DatumVreme
	)
	VALUES
	(   @IDKartica,        -- IDKorisnik - int
	    DATEADD(HOUR, 9, GETDATE()) -- DatumVreme - datetime
	    )
END
GO
/****** Object:  StoredProcedure [dbo].[sp_VratiPodatke]    Script Date: 09.12.2022 08:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_VratiPodatke]
	-- Add the parameters for the stored procedure here
	@IDProjekat int,
	@IDZona int,
	@IDKorisnik int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Projekat AS P
	WHERE p.IDProjekat = @IDProjekat;

	SELECT * FROM Zona As z
	WHERE z.IDZona = @IDZona;

	SELECT Ime + ' ' + Prezime AS Ime FROM Korisnik AS k
	WHERE k.IDKorisnik = @IDKorisnik;
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "zp"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "z"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 102
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProjekatZona'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProjekatZona'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 289
               Bottom = 102
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 6
               Left = 507
               Bottom = 102
               Right = 677
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SkeniranjeView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SkeniranjeView'
GO
USE [master]
GO
ALTER DATABASE [Popis] SET  READ_WRITE 
GO
