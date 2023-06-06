-- Generate test data for Addresses table
INSERT INTO Addresses (AddressLine1, AddressLine2, PostalCode, City, Country)
VALUES
    ('123 Main St', 'Apt 4', '12345', 'City1', 'Country1'),
    ('456 Elm St', 'Suite 10', '67890', 'City2', 'Country2'),
    ('789 Oak St', 'Unit B', '54321', 'City3', 'Country3');

-- Generate test data for Libraries table
INSERT INTO Libraries ([Name], AddressId)
VALUES
    ('Library 1', 1),
    ('Library 2', 2),
    ('Library 3', 3);

-- Generate test data for ItemTypes table
INSERT INTO ItemTypes (Id, [Type])
VALUES
    (1, 'Type1'),
    (2, 'Type2'),
    (3, 'Type3');

-- Generate test data for Items table
INSERT INTO Items (Isbn, Title, [Description], TypeId, LibraryId)
VALUES
    ('ISBN1', 'Book 1', 'Description 1', 1, 1),
    ('ISBN2', 'Book 2', 'Description 2', 2, 2),
    ('ISBN3', 'Book 3', 'Description 3', 3, 3);

-- Generate test data for Authors table
INSERT INTO Authors (FirstName, LastName)
VALUES
    ('Author1', 'LastName1'),
    ('Author2', 'LastName2'),
    ('Author3', 'LastName3');

-- Generate test data for AuthorItems table
INSERT INTO AuthorItems (AuthorId, ItemId)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Generate test data for DesiredItems table
INSERT INTO DesiredItems (Id, Reason)
VALUES
    (1, 'Reason 1'),
    (2, 'Reason 2'),
    (3, 'Reason 3');

-- Generate test data for Persons table
INSERT INTO Persons (Ssn, Email, PhoneNumber)
VALUES
    ('123456789', 'person1@example.com', '123-456-7890'),
    ('987654321', 'person2@example.com', '987-654-3210'),
    ('456789123', 'person3@example.com', '456-789-1230');

-- Generate test data for EmployeePositions table
INSERT INTO EmployeePositions ([Name])
VALUES
    ('Position 1'),
    ('Position 2'),
    ('Position 3');

-- Generate test data for Employees table
INSERT INTO Employees (Ssn, AddressId, EmployeePositionId)
VALUES
    ('123456789', 1, 1),
    ('987654321', 2, 2),
    ('456789123', 3, 3);

-- Generate test data for Campuses table
INSERT INTO Campuses ([Name], AddressId)
VALUES
    ('Campus 1', 1),
    ('Campus 2', 2),
    ('Campus 3', 3);

-- Generate test data for Members table
INSERT INTO Members (Ssn, CardValidity, CampusId)
VALUES
    ('123456789', GETDATE(), 1),
    ('987654321', GETDATE(), 2),
    ('456789123', GETDATE(), 3);



	SET IDENTITY_INSERT Books ON;

-- Generate test data for Books table
INSERT INTO Books (Id, IsLeased)
VALUES
    (1, 0),
    (2, 1),
    (3, 0);

SET IDENTITY_INSERT Books OFF;

-- Generate test data for Leases table
INSERT INTO Leases (DateOfIssue, DateOfReturn, DateReturned, MemberSsn, BookId)
VALUES
    (GETDATE(), GETDATE(), NULL, '123456789', 1),
    (GETDATE(), GETDATE(), NULL, '987654321', 2),
    (GETDATE(), GETDATE(), NULL, '456789123', 3);

