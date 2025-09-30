-- Library Management System Database Schema
-- Created for Data Tools Final Project using Supabase (PostgreSQL)

-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create books table
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    genre VARCHAR(50),
    publication_year INTEGER,
    total_copies INTEGER NOT NULL DEFAULT 1,
    available_copies INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create borrow_records table (with foreign key relationships)
CREATE TABLE borrow_records (
    record_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    book_id INTEGER NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    borrow_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    is_returned BOOLEAN NOT NULL DEFAULT FALSE,
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into students table
INSERT INTO students (first_name, last_name, email, phone, enrollment_date) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '2024-01-15'),
('Jane', 'Doe', 'jane.doe@email.com', '555-0102', '2024-01-20'),
('Mike', 'Johnson', 'mike.johnson@email.com', '555-0103', '2024-02-01'),
('Sarah', 'Wilson', 'sarah.wilson@email.com', '555-0104', '2024-02-10'),
('David', 'Brown', 'david.brown@email.com', '555-0105', '2024-02-15');

-- Insert sample data into books table
INSERT INTO books (title, author, isbn, genre, publication_year, total_copies, available_copies) VALUES
('To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4', 'Fiction', 1960, 3, 2),
('1984', 'George Orwell', '978-0-452-28423-4', 'Science Fiction', 1949, 2, 1),
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0-7432-7356-5', 'Fiction', 1925, 4, 3),
('Pride and Prejudice', 'Jane Austen', '978-0-14-143951-8', 'Romance', 1813, 2, 2),
('The Catcher in the Rye', 'J.D. Salinger', '978-0-316-76948-0', 'Fiction', 1951, 3, 1);

-- Insert sample data into borrow_records table
INSERT INTO borrow_records (student_id, book_id, borrow_date, due_date, return_date, is_returned, fine_amount) VALUES
(1, 1, '2024-03-01', '2024-03-15', '2024-03-14', TRUE, 0.00),
(2, 2, '2024-03-05', '2024-03-19', NULL, FALSE, 0.00),
(3, 3, '2024-03-10', '2024-03-24', '2024-03-22', TRUE, 0.00),
(4, 4, '2024-03-12', '2024-03-26', NULL, FALSE, 0.00),
(1, 5, '2024-03-15', '2024-03-29', NULL, FALSE, 0.00);

-- Create indexes for better performance
CREATE INDEX idx_students_email ON students(email);
CREATE INDEX idx_books_isbn ON books(isbn);
CREATE INDEX idx_borrow_records_student_id ON borrow_records(student_id);
CREATE INDEX idx_borrow_records_book_id ON borrow_records(book_id);
CREATE INDEX idx_borrow_records_due_date ON borrow_records(due_date);

-- Create a view for currently borrowed books
CREATE VIEW current_borrows AS
SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    s.email,
    b.title,
    b.author,
    br.borrow_date,
    br.due_date,
    CASE 
        WHEN br.due_date < CURRENT_DATE THEN 'Overdue'
        ELSE 'On Time'
    END AS status
FROM borrow_records br
JOIN students s ON br.student_id = s.student_id
JOIN books b ON br.book_id = b.book_id
WHERE br.is_returned = FALSE;

-- Example queries for testing

-- Query 1: Find all books currently borrowed by a specific student
-- SELECT b.title, b.author, br.borrow_date, br.due_date
-- FROM borrow_records br
-- JOIN books b ON br.book_id = b.book_id
-- WHERE br.student_id = 1 AND br.is_returned = FALSE;

-- Query 2: Find all overdue books
-- SELECT s.first_name, s.last_name, b.title, br.due_date
-- FROM borrow_records br
-- JOIN students s ON br.student_id = s.student_id
-- JOIN books b ON br.book_id = b.book_id
-- WHERE br.is_returned = FALSE AND br.due_date < CURRENT_DATE;

-- Query 3: Get book availability summary
-- SELECT title, author, total_copies, available_copies,
--        (total_copies - available_copies) AS borrowed_copies
-- FROM books
-- ORDER BY title;