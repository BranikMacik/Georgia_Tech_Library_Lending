--Creating indexes.
CREATE INDEX idx_AuthorItems_AuthorId_ItemId ON AuthorItems (AuthorId, ItemId);
CREATE INDEX idx_Authors_FirstName_LastName ON Authors (FirstName, LastName);

--Find all members who have not returned their leased books on time.
SELECT M.Ssn, COUNT(L.BookId) AS BooksOverdue
FROM Members M
INNER JOIN Leases L
ON M.Ssn = L.MemberSsn
WHERE L.DateOfReturn < GETDATE() AND L.DateReturned IS NULL
GROUP BY M.Ssn

--List all books that are currently not leased.
SELECT I.Title
FROM Items I
INNER JOIN Books B
ON I.Id = B.Id
WHERE B.IsLeased = 0

--Find all authors who have books in desired items.
SELECT DISTINCT Au.FirstName, Au.LastName
FROM Authors Au
INNER JOIN AuthorItems AI
ON Au.Id = AI.AuthorId
INNER JOIN DesiredItems DI
ON AI.ItemId = DI.Id

--List all libraries in a given city (City1).
SELECT L.[Name]
FROM Libraries L
INNER JOIN Addresses A
ON L.AddressId = A.Id
WHERE A.City = 'City1'

--Find the total number of books leased per member.
SELECT M.Ssn, COUNT(L.BookId) AS TotalBooksLeased
FROM Members M
INNER JOIN Leases L
ON M.Ssn = L.MemberSsn
GROUP BY M.Ssn



--RELATIONAL ALGEBRA IMPLEMENTATIONS OF THE QUERIES ABOVE:
--Let's denote '⨝' as join, 'π' as project, 'σ' as select, 'γ' as group by, 'ρ' as rename, '∪' as union, '∩' as intersection, '-' as difference, and '÷' as division.

--Find all members who have not returned their leased books on time.
--γ M.Ssn->Ssn, COUNT(L.BookId)->BooksOverdue ((σ DateOfReturn<Now AND DateReturned IS NULL (L Leases)) ⨝_MemberSsn (M Members))

--List all books that are currently not leased.
--π I.Title (σ IsLeased=0 (I Items) ⨝_Id (B Books))

--Find all authors who have books in desired items.
--π Au.FirstName, Au.LastName (((Au Authors) ⨝_Id (AI AuthorItems)) ⨝_ItemId (DI DesiredItems))

--List all libraries in a given city (City1).
--π L.Name ((σ City='City1' (A Addresses)) ⨝_AddressId L.Libraries)

--Find the total number of books leased per member.
--γ M.Ssn->Ssn, COUNT(L.BookId)->TotalBooksLeased ((M Members) ⨝_Ssn (L Leases))