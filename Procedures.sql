USE bib;

IF OBJECT_ID('ItemAllInformations', 'P') IS NOT NULL
DROP PROCEDURE ItemAllInformations;
GO
CREATE PROCEDURE ItemAllInformations (@SearchTitle NVARCHAR(255)) AS 

	SELECT I.Title, B.Publisher, I.IssueYear, B.PlaceOfIssue, I.Edition, B.ISBN FROM
	Items I LEFT JOIN Books B
	ON I.ItemID = B.ItemID
	LEFT JOIN Other O
	ON I.ItemID = O.ItemID
	WHERE I.Title LIKE @SearchTitle

GO

EXEC ItemAllInformations N'%selected%';

GO

IF OBJECT_ID('UserBorrowingHistory', 'P') IS NOT NULL
DROP PROCEDURE UserBorrowingHistory;
GO
CREATE PROCEDURE UserBorrowingHistory (@SearchUser NVARCHAR(255)) AS 
	SELECT U.Name,I.Title,I.ItemID,B.BorrowDate,B.ReturnDate, DATEADD(day,60,B.BorrowDate) ExpectedReturnDate, F.Fine FROM
	Users U JOIN Borrowings B
	ON U.UserID = B.UserID
	JOIN Items I
	ON B.ItemID = I.ItemID
	LEFT JOIN Fines F
	ON B.ItemID = F.ItemID AND B.BorrowDate = F.BorrowDate AND B.UserID = F.UserID
	WHERE U.Name LIKE @SearchUser
GO

EXEC UserBorrowingHistory N'Andrzej Abacki'

GO


--SearchByAuthor
IF OBJECT_ID('SearchByAuthor', 'P') IS NOT NULL
DROP PROCEDURE SearchByAuthor;
GO
CREATE PROCEDURE SearchByAuthor (@SearchAuthor NVARCHAR(255)) AS 
	SELECT A.AuthorName, I.Title FROM
	Authors A INNER JOIN Books B
	ON A.ItemID = B.ItemID
	INNER JOIN Items I
	ON B.ItemID = I.ItemID
	WHERE A.AuthorName LIKE @SearchAuthor
GO

EXEC SearchByAuthor N'%Fichtenholz%'

--BookCategories
GO
IF OBJECT_ID('BookCategories', 'P') IS NOT NULL
DROP PROCEDURE BookCategories;
GO
CREATE PROCEDURE BookCategories (@SearchTitle NVARCHAR(255)) AS 
		SELECT DISTINCT I.Title, CS.Category1 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
			) CS ON I.ItemID = CS.ItemID
		WHERE Title LIKE @SearchTitle AND Category1 IS NOT NULL
	UNION 
		SELECT DISTINCT I.Title, CS.Category2 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
			) CS ON I.ItemID = CS.ItemID
		WHERE Title LIKE @SearchTitle AND Category2 IS NOT NULL
	UNION 
		SELECT DISTINCT I.Title, CS.Category3 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
			) CS ON I.ItemID = CS.ItemID
		WHERE Title LIKE @SearchTitle AND Category3 IS NOT NULL
GO

EXEC BookCategories N'%selected%'

GO
--SearchByCategory
IF OBJECT_ID('SearchByCategory', 'P') IS NOT NULL
DROP PROCEDURE SearchByCategory;
GO
CREATE PROCEDURE SearchByCategory (@SearchCategory NVARCHAR(255)) AS 
		SELECT DISTINCT I.Title, CS.Category1 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
		) CS ON I.ItemID = CS.ItemID
		WHERE Category1 LIKE @SearchCategory
	UNION
		SELECT DISTINCT I.Title, CS.Category2 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
		) CS ON I.ItemID = CS.ItemID
		WHERE Category2 LIKE @SearchCategory
	UNION
		SELECT DISTINCT I.Title, CS.Category3 Category FROM
		Items I  LEFT JOIN (
			SELECT C.ItemID, C.Category Category1, CT.[ParentCategory] Category2, CT2.[ParentCategory] Category3 FROM
			Categories C LEFT JOIN CategoryTree CT
			ON C.Category = CT.[ChildCategory]
			LEFT JOIN CategoryTree CT2
			ON CT.[ParentCategory] = CT2.[ChildCategory]
		) CS ON I.ItemID = CS.ItemID
		WHERE Category3 LIKE @SearchCategory 
	ORDER BY Title;
GO

EXEC SearchByCategory N'fizyka'