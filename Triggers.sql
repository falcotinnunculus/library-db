USE bib;

GO
IF OBJECT_ID('DeleteBorrowing', 'TR') IS NOT NULL
DROP TRIGGER DeleteBorrowing;
GO
CREATE TRIGGER DeleteBorrowing
ON Borrowings
INSTEAD OF DELETE
AS
	DELETE FROM Fines
	WHERE BorrowDate IN (SELECT BorrowDate FROM DELETED)
	AND UserID IN (SELECT UserID FROM DELETED)
	AND ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Borrowings
	WHERE BorrowDate IN (SELECT BorrowDate FROM DELETED)
	AND UserID IN (SELECT UserID FROM DELETED)
	AND ItemID IN (SELECT ItemID FROM DELETED)
GO

--SELECT * FROM Borrowings
--SELECT * FROM Fines

--DELETE FROM Borrowings
--WHERE BorrowDate = '2022-11-13'

--SELECT * FROM Borrowings
--SELECT * FROM Fines

GO
IF OBJECT_ID('DeleteUser', 'TR') IS NOT NULL
DROP TRIGGER DeleteUser;
GO
CREATE TRIGGER DeleteUser
ON Users
INSTEAD OF DELETE
AS
	DELETE FROM Borrowings
	WHERE UserID IN (SELECT UserID FROM DELETED)

	DELETE FROM Users
	WHERE UserID IN (SELECT UserID FROM DELETED)
GO

--SELECT * FROM Borrowings
--SELECT * FROM Fines
--SELECT * FROM Users

--DELETE FROM Users WHERE UserID = 2

--SELECT * FROM Borrowings
--SELECT * FROM Fines
--SELECT * FROM Users

GO
IF OBJECT_ID('DeleteBook', 'TR') IS NOT NULL
DROP TRIGGER DeleteBook;
GO
CREATE TRIGGER DeleteBook
ON Books
INSTEAD OF DELETE
AS
	DELETE FROM Authors
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Redactors
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Categories
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Borrowings
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Books
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

GO

GO
IF OBJECT_ID('DeleteOther', 'TR') IS NOT NULL
DROP TRIGGER DeleteOther;
GO
CREATE TRIGGER DeleteOther
ON Other
INSTEAD OF DELETE
AS
	DELETE FROM Categories
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Borrowings
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Books
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

GO


GO
IF OBJECT_ID('DeleteItem', 'TR') IS NOT NULL
DROP TRIGGER DeleteItem;
GO
CREATE TRIGGER DeleteItem
ON Items
INSTEAD OF DELETE
AS
	DELETE FROM Books
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Other
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

	DELETE FROM Items
	WHERE ItemID IN (SELECT ItemID FROM DELETED)

GO
