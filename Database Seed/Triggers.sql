-- Create a view
CREATE VIEW GetTotalUnreturnedBooksPerMember
AS
SELECT M.Ssn, COUNT(L.BookId) AS TotalBooksUnreturned
FROM Members M
INNER JOIN Leases L
ON M.Ssn = L.MemberSsn
WHERE L.DateReturned IS NULL
GROUP BY M.Ssn

-- Create a trigger to keep track of the amount of borrowed books
CREATE TRIGGER EnsureNoMoreThanFiveLeases
    ON Leases
    FOR INSERT
    AS
    BEGIN
        DECLARE @countOfUnreturnedBooks INT
        DECLARE @memberSsn VARCHAR(50)
        SET @memberSsn = (
            SELECT MemberSsn FROM inserted
        )
        SET @countOfUnreturnedBooks = (
            SELECT IIF(COUNT(1) > 0, TotalBooksUnreturned, 0)
            FROM GetTotalUnreturnedBooksPerMember
            WHERE Ssn = @memberSsn
            group by TotalBooksUnreturned)
        IF @countOfUnreturnedBooks > 5
        BEGIN
            THROW 50001, 'A member cannot have more than 5 leases at a time.', 1;
        END
    END

-- Create trigger for ensuring idempotency of book lending
CREATE TRIGGER UpdateBookLending
    ON Leases
    FOR INSERT
    AS
    BEGIN
        DECLARE @bookId INT
        DECLARE @isAlreadyLeased BIT

        SET @bookId = (
            SELECT BookId FROM inserted
        )
        SET @isAlreadyLeased = (
            SELECT IsLeased FROM Books WHERE Id = @bookId
        );

        IF @isAlreadyLeased = 1
        BEGIN
            THROW 50001, 'You cannot lend a book that is already being leased.', 1;
        END

        UPDATE Books SET IsLeased = 1 WHERE Id = @bookId
    END