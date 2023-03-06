USE bib;


--CountByCategory
IF OBJECT_ID('CountByCategory', 'V') IS NOT NULL
DROP VIEW CountByCategory;
GO
CREATE VIEW CountByCategory AS
	WITH CategoryCount AS(
		SELECT DISTINCT I.Title, CS.Category1 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
		) CS ON I.ItemID = CS.ItemID
		WHERE Category1 IS NOT NULL
		UNION
		SELECT DISTINCT I.Title, CS.Category2 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
		) CS ON I.ItemID = CS.ItemID
		WHERE Category2 IS NOT NULL
		UNION
		SELECT DISTINCT I.Title, CS.Category3 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
		) CS ON I.ItemID = CS.ItemID
		WHERE Category3 IS NOT NULL
	) SELECT Category, COUNT(Title) AS Count FROM CategoryCount
	GROUP BY Category
GO

--CurrentlyBorrowedBooks
IF OBJECT_ID('CurrentlyBorrowedBooks', 'V') IS NOT NULL
DROP VIEW CurrentlyBorrowedBooks;
GO
CREATE VIEW CurrentlyBorrowedBooks AS
SELECT U.Name,I.Title,B.BorrowDate, DATEADD(day,60,B.BorrowDate) ExpectedReturnDate FROM
Users U JOIN Borrowings B
ON U.UserID = B.UserID
JOIN Items I
ON B.ItemID = I.ItemID
WHERE B.ReturnDate IS NULL
GO

IF OBJECT_ID('AllBooks', 'V') IS NOT NULL
DROP VIEW AllBooks;
GO
CREATE VIEW AllBooks AS
	SELECT I.Title, B.Publisher, I.IssueYear, B.PlaceOfIssue, I.Edition, B.ISBN FROM
	Items I JOIN Books B
	ON I.ItemID = B.ItemID
	ORDER BY I.Title OFFSET 0 ROWS
GO

IF OBJECT_ID('AllOther', 'V') IS NOT NULL
DROP VIEW AllOther;
GO
CREATE VIEW AllOther AS
	SELECT I.Title, I.IssueYear, O.ProductionYear, O.Duration, O.FormatType FROM
	Items I JOIN Other O
	ON I.ItemID = O.ItemID
	ORDER BY I.Title OFFSET 0 ROWS
GO

IF OBJECT_ID('AllUsers', 'V') IS NOT NULL
DROP VIEW AllUsers;
GO
CREATE VIEW AllUsers AS
	SELECT U.*, T.BorrowCount, T.ReturnCount FROM
	(SELECT U.UserID, COUNT(B.BorrowDate) BorrowCount, COUNT(B.ReturnDate) ReturnCount  FROM
	Users U LEFT JOIN Borrowings B
	ON U.UserID = B.UserID
	GROUP BY U.UserID) T
	JOIN Users U
	ON U.UserID = T.UserID
GO

IF OBJECT_ID('AllFines', 'V') IS NOT NULL
DROP VIEW AllFines;
GO
CREATE VIEW AllFines AS
	SELECT F.Fine, B.*, U.Name, I.Title FROM 
	Fines F JOIN Borrowings B
	ON F.UserID = B.UserID AND F.ItemID = B.ItemID AND F.BorrowDate = B.BorrowDate
	JOIN Users U
	ON U.UserID = F.UserID
	JOIN Items I
	ON I.ItemID = F.ItemID
GO

IF OBJECT_ID('CountByAuthor', 'V') IS NOT NULL
DROP VIEW CountByAuthor;
GO
CREATE VIEW CountByAuthor AS
	SELECT AuthorName, COUNT(ItemID) AuthorCount FROM Authors
	GROUP BY AuthorName
	ORDER BY AuthorCount DESC OFFSET 0 ROWS 
GO

IF OBJECT_ID('CountByDecade', 'V') IS NOT NULL
DROP VIEW CountByDecade;
GO
CREATE VIEW CountByDecade AS
	SELECT  ROUND(IssueYear,-1,1) IssueDecade, COUNT(ItemID) ItemCount FROM Items
	GROUP BY ROUND(IssueYear,-1,1)
	ORDER BY IssueDecade DESC OFFSET 0 ROWS 
GO

IF OBJECT_ID('CountUncompleteBooks', 'V') IS NOT NULL
DROP VIEW CountUncompleteBooks;
GO
CREATE VIEW CountUncompleteBooks AS
	SELECT COUNT(*)-COUNT(I.ItemID) NullItemID, COUNT(*)-COUNT(I.Title) NullTitle, COUNT(*)-COUNT(I.IssueYear) NullIssueYear,
	 COUNT(*)-COUNT(I. Edition) NullEdition, COUNT(*)-COUNT(B.Publisher) NullPublisher,
	 COUNT(*)-COUNT(B.PlaceOfIssue) NullPlaceOfIssue, COUNT(*)-COUNT(B.ISBN) NullISBN FROM
	Items I JOIN Books B
	ON I.ItemID = B.ItemID 
GO

IF OBJECT_ID('ItemsBorrowingStats', 'V') IS NOT NULL
DROP VIEW ItemsBorrowingStats;
GO
CREATE VIEW ItemsBorrowingStats AS
	SELECT I.Title, T.* FROM (
	SELECT I.ItemID, COUNT(B.BorrowDate) BorrowCount, COUNT(B.ReturnDate) ReturnCount,
	 IIF(COUNT(B.BorrowDate)-COUNT(B.ReturnDate)>0,'YES','NO') IsBorrowed FROM
	Items I LEFT JOIN Borrowings B
	ON I.ItemID = B.ItemID
	GROUP BY I.ItemID
	) T JOIN Items I
	ON T.ItemID = I.ItemID
GO


SELECT * FROM AllBooks
SELECT * FROM AllOther
SELECT * FROM AllUsers
SELECT * FROM AllFines
SELECT * FROM CountByAuthor
SELECT * FROM CountByCategory
SELECT * FROM CountByDecade
SELECT * FROM CountUncompleteBooks
SELECT * FROM CurrentlyBorrowedBooks
SELECT * FROM ItemsBorrowingStats



