CREATE DATABASE Library

GO 

USE Library

GO

CREATE TABLE Authors(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50),
	Surname NVARCHAR(50)
)

CREATE TABLE Books(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100),
	PageCount INT,
	AuthorId INT FOREIGN KEY(AuthorId) REFERENCES Authors(Id)
)
GO
INSERT INTO Authors
VALUES
('Victor','Hugo'),
('Fyodor','Dostoyevski'),
('Alexandre','Duma'),
('Lev','Tolstoy')
GO
INSERT INTO Books
VALUES
('Notre-Dame de Paris',600,1),
('Sefiller',800,1),
('Yer Altindan Qeydler',300,2),
('Dayinin Yuxusu',250,2),
('3 Musketeers',550,3),
('Qraf Monte Kristo',400,3),
('Herb ve Sulh',750,4),
('Anna Karenina',650,4)

GO

CREATE VIEW VW_BOOKSINFO
AS
SELECT B.Id,B.Name AS 'BookName',B.PageCount AS 'PageCount',A.Name+' '+A.Surname AS 'AuthorFullName' FROM Books AS B
JOIN Authors AS A
ON B.AuthorId=A.Id;

GO

SELECT * FROM VW_BOOKSINFO

GO


 CREATE PROCEDURE USP_SEARCHBOOKS @Name NVARCHAR(100)
 AS
 SELECT * FROM VW_BOOKSINFO
 WHERE VW_BOOKSINFO.BookName LIKE '%'+@Name+'%' 
 OR VW_BOOKSINFO.AuthorFullName LIKE '%'+@Name+'%'

 GO

CREATE VIEW VW_AUTHORSINFO
AS
SELECT A.Id AS 'AuthorID',A.Name +' '+A.Surname AS 'AuthorsFullName', COUNT(B.Name) AS 'Booknumber',MAX(B.PageCount) AS 'MAX Page COUNT' FROM Books AS B
JOIN Authors AS A
ON A.Id=B.AuthorId
GROUP BY A.Name +' '+A.Surname,A.Id

GO

SELECT * FROM VW_AUTHORSINFO


EXEC USP_SEARCHBOOKS SEF