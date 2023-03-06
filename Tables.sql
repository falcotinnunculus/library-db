--IF EXISTS(select * from sys.databases where name='bib')
--	DROP DATABASE bib
--CREATE DATABASE bib
USE bib;

DROP TABLE Fines, Borrowings, Categories, CategoryTree, Authors, Redactors, Books, Other, Users, Items



IF OBJECT_ID('Items', 'U') IS NOT NULL
DROP TABLE Items

CREATE TABLE [Items] 
(
    ItemID	INT PRIMARY KEY,
    Title	NVARCHAR(512) NOT NULL,
    IssueYear	INT,
    Edition	NVARCHAR(512)
);

INSERT INTO [Items] VALUES
	(0, 'Rachunek r�niczkowy i ca�kowy. Tom I', 1972, 'V'),
	(1, 'Rachunek r�niczkowy i ca�kowy. Tom II', 1966, 'IV'),
	(2, 'Geometria analityczna', 1956, 'II'),
	(3, 'Analiza matematyczna w zadaniach', 2010, 'XXVII'),
	(4, 'Algebra abstrakcyjna w zadaniach', 2002, NULL),
	(5, 'O twierdzeniach i hipotezach. Matematyka wed�ug Delty', 2005, 'I'),
	(6, 'Metody arytmetyki przedzia�owej w badaniach uk�ad�w nieliniowych', 2003, NULL),
	(7, 'Metody arytmetyki przedzia�owej w badaniach uk�ad�w nieliniowych', 2004, NULL),
	(8, 'S�ownik szkolny. Matematyka', 1996, NULL),
	(9, 'R�wnania r�niczkowe zwyczajne', 1967, 'II'),
	(10, 'Wst�p do topologii. Przestrzenie metryczne', 1975, NULL),
	(11, 'Matematyka dla przyrodnik�w', 1971, NULL),
	(12, 'Ksi�ga liczb', 1999, NULL),
	(13, 'Metody rozwi�zywania zada� z analizy matematycznej', 1973, NULL),
	(14, 'Teoria grup i jej zastosowania w fizyce', 1961, NULL),
	(15, 'Tablice fizyczno-astronomiczne', 2005, 'IV'),
	(16, 'Pracownia fizyczna', 1975, 'II'),
	(17, 'Pracownia fizyczna', 1980, 'V'),
	(18, 'Selected Scientific Works', 2020, 'I'),
	(19, 'Mechanika og�lna', 1975, 'V'),
	(20, 'Podstawy elektroniki i uk�ady elektroniczne', 1975, 'I'),
	(21, 'Masery i lasery: nowe zdobycze elektroniki', 1965, 'I'),
	(22, 'Exploring the Mystery of Matter: The ATLAS Experiment', 2008, 'I'),
	(23, 'Promieniowanie synchrotronowe w spektroskopii i badaniach strukturalnych. Wybrane zagadnienia', 2011, NULL),
	(24, 'Fizyka do�wiadczalna. Cz�� III: elektryczno�� i magnetyzm', 1972, 'IV'),
	(25, 'Radiacyjne zjawiska w p�przewodnikach', 1971, 'I'),
	(26, 'Optyka kryszta��w', 1971, 'I'),
	(27, 'Prowadzenie fal elektromagnetycznych', 1966, 'I'),
	(28, 'Wst�p do spektroskopii atomowej', 1970, 'II'),
	(29, 'Fizyczne podstawy emisyjnej analizy widmowej', 1973, NULL),
	(30, 'Wilbur chce si� zabi�', 2007, NULL),
	(31, 'Dzie� weselny', 2006, NULL),
	(32, 'Opowie�ci o zwyczajnym szale�stwie', 2007, NULL),
	(33, 'Nieustaj�ce wakacje', 2006, NULL),
	(34, 'Poza prawem', 2006, NULL)
	
IF OBJECT_ID('Books', 'U') IS NOT NULL
DROP TABLE Books

CREATE TABLE Books 
(
    ItemID	INT PRIMARY KEY,
    Publisher NVARCHAR(512),
    PlaceOfIssue NVARCHAR(512),
    ISBN NVARCHAR(512),
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

INSERT INTO Books (ItemID, Publisher, PlaceOfIssue, ISBN) VALUES
	(0, 'PWN', 'Warszawa', NULL),
	(1, 'PWN', 'Warszawa', NULL),
	(2, 'PWN', 'Warszawa', NULL),
	(3, 'PWN', 'Warszawa', '978-83-01-14296-4'),
	(4, 'PWN', 'Warszawa', '83-01-13198-5'),
	(5, 'Wydawnictwa Uniwersytetu Warszawskiego ', 'Warszawa', '83-235-0047-9'),
	(6, 'Uczelniane Wydawnictwa Naukowo-Dydaktyczne AGH', 'Krak�w', '0867-6631'),
	(7, 'Uczelniane Wydawnictwa Naukowo-Dydaktyczne AGH', 'Krak�w', '0867-6632'),
	(8, 'WSiP', 'Warszawa', '83-02-06162-X'),
	(9, 'PWN', 'Warszawa', NULL),
	(10, 'Wydawnictwo Politechniki Wroc�awskiej', 'Wroc�aw', NULL),
	(11, 'PWN', 'Warszawa', NULL),
	(12, 'Wydawnictwa Naukowo-Techniczne', 'Warszawa', '83-204-2366-X'),
	(13, 'Wydawnictwa Naukowo-Techniczne', 'Warszawa', NULL),
	(14, 'PWN', 'Warszawa', NULL),
	(15, 'Adamantan', 'Warszawa', '83-7350-065-0'),
	(16, 'PWN', 'Warszawa', NULL),
	(17, 'PWN', 'Warszawa', NULL),
	(18, 'Wydawnictwa Uniwersytetu Warszawskiego ', 'Warszawa', '978-83-235-2883-8'),
	(19, 'PWN', 'Warszawa', NULL),
	(20, 'WSiP', 'Warszawa', NULL),
	(21, 'Wydawnictwo Ministerstwa Obrony Narodowej', 'Warszawa', NULL),
	(22, 'Papadakis Publisher', 'Kimber, Winterbourne', NULL),
	(23, 'Polskie Towarzystwo Promieniowania Synchrotronowego', 'Warszawa', NULL),
	(24, 'PWN', 'Warszawa', NULL),
	(25, 'PWN', 'Warszawa', NULL),
	(26, 'PWN', 'Warszawa', NULL),
	(27, 'Wydawnictwa Naukowo-Techniczne', 'Warszawa', NULL),
	(28, 'PWN', 'Warszawa', NULL),
	(29, 'PWN', 'Warszawa', NULL);


IF OBJECT_ID('Other', 'U') IS NOT NULL
DROP TABLE Other

CREATE TABLE Other 
(
    ItemID	INT PRIMARY KEY,
    ProductionYear	INT,
    Duration	INT,
    FormatType	NVARCHAR(512),
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

INSERT INTO Other (ItemID, ProductionYear, Duration, FormatType) VALUES
	(30, NULL, NULL, 'DVD '),
	(31, 1978, 120, 'DVD '),
	(32, NULL, NULL, 'DVD '),
	(33, 1980, 75, 'DVD '),
	(34, 1986, 107, 'DVD ');

IF OBJECT_ID('Authors', 'U') IS NOT NULL
DROP TABLE Authors

CREATE TABLE Authors 
(
    ItemID	INT,
    AuthorName NVARCHAR(448),
	PRIMARY KEY (ItemID, AuthorName),
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

INSERT INTO Authors VALUES
	(0, 'G. M. Fichtenholz'),
	(1, 'G. M. Fichtenholz'),
	(2, 'Franciszek Leja'),
	(3, 'W�odzimierz Krysicki'),
	(4, 'Jerzy Rutkowski'),
	(6, 'Zbigniew Galias'),
	(7, 'Zbigniew Galias'),
	(8, 'Zofia Muzyczka'),
	(9, 'I. G. Pietrowski'),
	(10, 'Stanis�aw G�adysz'),
	(11, 'Zbigniew Marian S�p'),
	(12, 'John H. Conway'),
	(13, 'G. I. Zaporo�ec'),
	(14, 'G. J. Lubarski'),
	(16, 'Henryk Szyd�owski'),
	(17, 'Henryk Szyd�owski'),
	(18, 'Marian Smoluchowski'),
	(19, 'Arkadiusz Piekara'),
	(20, 'Bogdan Kowalski'),
	(21, 'Henryk Klejman'),
	(22, 'Claudia Marcelloni'),
	(24, 'Szczepan Szczeniowski'),
	(25, 'W. S. Wawi�ow'),
	(26, 'Tadeusz Penkala'),
	(27, 'Robert E. Collin'),
	(28, 'Zofia Le�'),
	(29, 'Danuta Kunisz'),
	(3, 'Lech W�odarski'),
	(8, 'Marek Kordos'),
	(12, 'Richard K. Guy'),
	(20, 'Tadeusz Masewicz'),
	(22, 'Kerry-Jane Lowery'),
	(25, 'N. A. Uchin');

IF OBJECT_ID('Redactors', 'U') IS NOT NULL
DROP TABLE Redactors

CREATE TABLE Redactors 
(
    ItemID	INT,
    RedactorName NVARCHAR(448),
	PRIMARY KEY (ItemID, RedactorName),
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

INSERT INTO Redactors VALUES
	(5, 'Wiktor Bartol'),
	(15, 'Witold Mizerski'),
	(18, 'Bogdan Cichocki'),
	(22, 'Kenway Smith'),
	(23, 'Bogdan Kowalski'),
	(5, 'Witold Sadowski'),
	(23, 'Wojciech Paszkowski'),
	(23, 'Edward A. G�rlich');

IF OBJECT_ID('Categories', 'U') IS NOT NULL
DROP TABLE Categories

CREATE TABLE Categories 
(
    ItemID	INT,
    Category NVARCHAR(448),
	PRIMARY KEY (ItemID, Category),
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

INSERT INTO Categories (ItemID, Category) VALUES
	(0, 'analiza matematyczna'),
	(1, 'analiza matematyczna'),
	(2, 'analiza matematyczna'),
	(3, 'analiza matematyczna'),
	(4, 'algebra'),
	(5, 'popularnonaukowe'),
	(6, 'metody numeryczne'),
	(7, 'metody numeryczne'),
	(8, 'matematyka'),
	(9, 'analiza matematyczna'),
	(10, 'topologia'),
	(11, 'analiza matematyczna'),
	(12, 'teoria liczb'),
	(13, 'analiza matematyczna'),
	(14, 'teoria grup'),
	(15, 'fizyka'),
	(16, 'pracownia fizyczna'),
	(17, 'pracownia fizyczna'),
	(18, 'historia UJ'),
	(19, 'mechanika newtonowska'),
	(20, 'elektronika'),
	(21, 'elektronika'),
	(22, 'album'),
	(23, 'fizyka j�drowa'),
	(24, 'fizyka do�wiadczalna'),
	(25, 'elektronika'),
	(26, 'optyka'),
	(27, 'elektronika'),
	(28, 'fizyka atomowa'),
	(29, 'fizyka atomowa'),
	(2, 'geometria'),
	(5, 'matematyka'),
	(8, 's�ownik'),
	(11, 'algebra'),
	(12, 'popularnonaukowe'),
	(14, 'fizyka matematyczna'),
	(15, 'astronomia'),
	(18, 'historia fizyki'),
	(21, 'optyka wsp�czesna'),
	(22, 'fizyka cz�stek'),
	(23, 'fizyka cz�stek'),
	(24, 'elektryczno�� i magnetyzm'),
	(25, 'fizyka j�drowa'),
	(26, 'krystalografia'),
	(27, 'elektryczno�� i magnetyzm'),
	(28, 'spektroskopia'),
	(29, 'optyka wsp�czesna'),
	(11, 'rachunek prawdopodobie�stwa'),
	(15, 'tablice'),
	(18, 'fizyka statystyczna'),
	(23, 'spektroskopia');

IF OBJECT_ID('CategoryTree', 'U') IS NOT NULL
DROP TABLE CategoryTree

CREATE TABLE CategoryTree 
(
    ChildCategory	NVARCHAR(225),
    ParentCategory	NVARCHAR(225),
	PRIMARY KEY (ChildCategory,ParentCategory)

);

INSERT INTO CategoryTree (ChildCategory, ParentCategory) VALUES
	('analiza matematyczna', 'matematyka'),
	('algebra', 'matematyka'),
	('teoria grup', 'algebra'),
	('historia UJ', 'historia'),
	('pracownia fizyczna', 'fizyka do�wiadczalna'),
	('optyka wsp�czesna', 'optyka'),
	('optyka', 'fizyka'),
	('elektronika', 'fizyka'),
	('mechanika newtonowska', 'mechanika'),
	('mechanika klasyczna', 'mechanika'),
	('mechanika kwantowa', 'mechanika'),
	('mechanika', 'fizyka'),
	('geometria', 'matematyka'),
	('topologia', 'matematyka'),
	('rachunek prawdopodobie�stwa', 'matematyka'),
	('teoria liczb', 'matematyka'),
	('fizyka matematyczna', 'matematyka'),
	('fizyka matematyczna', 'fizyka'),
	('fizyka cz�stek', 'fizyka'),
	('fizyka j�drowa', 'fizyka'),
	('chemia fizyczna', 'chemia'),
	('fizyka do�wiadczalna', 'fizyka'),
	('historia fizyki', 'fizyka'),
	('historia fizyki', 'historia'),
	('fizyka statystyczna', 'fizyka'),
	('krystalografia', 'chemia fizyczna'),
	('krystalografia', 'fizyka cia�a sta�ego'),
	('fizyka cia�a sta�ego', 'fizyka'),
	('fizyka atomowa', 'fizyka'),
	('spektroskopia', 'chemia fizyczna'),
	('elektryczno�� i magnetyzm', 'fizyka'),
	('metody numeryczne', 'fizyka matematyczna');

IF OBJECT_ID('Users', 'U') IS NOT NULL
DROP TABLE Users

CREATE TABLE Users(
UserID int PRIMARY KEY,
Name nvarchar(255) NOT NULL,
SignInDate date NOT NULL
)

INSERT INTO Users VALUES
(0,	'Andrzej Abacki',   '2022-10-10'),
(1,	'Bo�ydar Babacki',	'2022-11-12'),
(2,	'Celina Cabacka',	'2022-12-25'),
(3,	'Dobromi� Dabacki',	'2022-12-26'),
(4,	'El�bieta Ebacka',	'2023-01-02')

IF OBJECT_ID('Borrowings', 'U') IS NOT NULL
DROP TABLE Borrowings

CREATE TABLE Borrowings(
UserID int,
ItemID int,
BorrowDate date,
ReturnDate date,
PRIMARY KEY (UserID, ItemID, BorrowDate),
FOREIGN KEY (UserID) REFERENCES Users(UserID),
FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)

INSERT INTO Borrowings VALUES
(0,4,'2022-11-11','2022-12-03'),
(1,7,'2022-11-12','2022-11-30'),
(2,20,'2022-11-13','2023-01-24'),
(1,11,'2023-01-12',NULL),
(3,25,'2023-01-13',NULL),
(3,7,'2023-01-14','2023-01-22')

IF OBJECT_ID('Fines', 'U') IS NOT NULL
DROP TABLE Fines

CREATE TABLE Fines(
UserID int,
ItemID int,
BorrowDate date,
Fine money,
PRIMARY KEY (UserID, ItemID, BorrowDate),
FOREIGN KEY (UserID, ItemID, BorrowDate) REFERENCES Borrowings(UserID, ItemID, BorrowDate)
)

INSERT INTO Fines VALUES
(2,20,'2022-11-13',2.2)