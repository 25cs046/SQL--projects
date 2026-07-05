-- ================================================
-- PROJECT 1: LIBRARY MANAGEMENT DATABASE
-- Author: Your Name
-- Description: A library database to manage books,
--              members and borrowing records
-- ================================================

-- DROP existing tables
DROP TABLE IF EXISTS borrows;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS books;

-- ================================================
-- CREATE TABLES
-- ================================================

CREATE TABLE books (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    title   TEXT NOT NULL,
    author  TEXT NOT NULL,
    genre   TEXT,
    year    INTEGER,
    price   REAL
);

CREATE TABLE members (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT NOT NULL,
    email   TEXT,
    phone   TEXT
);

CREATE TABLE borrows (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id   INTEGER,
    book_id     INTEGER,
    borrow_date TEXT,
    return_date TEXT
);

-- ================================================
-- INSERT SAMPLE DATA
-- ================================================

INSERT INTO books (title, author, genre, year, price) VALUES 
    ('Harry Potter', 'J.K. Rowling', 'Fantasy', 1997, 9.99),
    ('The Alchemist', 'Paulo Coelho', 'Fiction', 1988, 7.99),
    ('To Kill a Mockingbird', 'Harper Lee', 'Drama', 1960, 6.99),
    ('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 5.99),
    ('A Brief History of Time', 'Stephen Hawking', 'Science', 1988, 12.99);

INSERT INTO members (name, email, phone) VALUES
    ('Ravi Kumar', 'ravi@gmail.com', '9876543210'),
    ('Priya Sharma', 'priya@gmail.com', '9123456789'),
    ('Kiran Raj', 'kiran@gmail.com', '9999988888');

INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
    (1, 1, '2024-01-10', '2024-01-20'),
    (2, 3, '2024-01-12', '2024-01-25'),
    (3, 2, '2024-01-15', NULL);

-- ================================================
-- FEATURE 1: Available Books
-- ================================================

SELECT books.title, books.author, books.genre
FROM books
WHERE books.id NOT IN (
    SELECT book_id FROM borrows WHERE return_date IS NULL
);

-- ================================================
-- FEATURE 2: Who Borrowed What
-- ================================================

SELECT 
    members.name AS member_name,
    books.title AS book_title,
    borrows.borrow_date,
    COALESCE(borrows.return_date, 'Not Returned Yet') AS return_status
FROM borrows
JOIN members ON borrows.member_id = members.id
JOIN books ON borrows.book_id = books.id;

-- ================================================
-- FEATURE 3: Overdue Books
-- ================================================

SELECT 
    members.name AS member_name,
    books.title AS book_title,
    borrows.borrow_date,
    JULIANDAY('now') - JULIANDAY(borrows.borrow_date) AS days_borrowed
FROM borrows
JOIN members ON borrows.member_id = members.id
JOIN books ON borrows.book_id = books.id
WHERE borrows.return_date IS NULL
AND JULIANDAY('now') - JULIANDAY(borrows.borrow_date) > 14;

-- ================================================
-- FEATURE 4: Most Popular Books
-- ================================================

SELECT 
    books.title AS book_title,
    books.author,
    COUNT(borrows.id) AS times_borrowed
FROM books
JOIN borrows ON books.id = borrows.book_id
GROUP BY books.id, books.title, books.author
ORDER BY times_borrowed DESC;

-- ================================================
-- FEATURE 5: Member Borrowing History
-- ================================================

SELECT 
    members.name AS member_name,
    books.title AS book_title,
    books.genre,
    borrows.borrow_date,
    COALESCE(borrows.return_date, 'Not Returned Yet') AS return_status
FROM borrows
JOIN members ON borrows.member_id = members.id
JOIN books ON borrows.book_id = books.id
WHERE members.name = 'Ravi Kumar'
ORDER BY borrows.borrow_date DESC;
