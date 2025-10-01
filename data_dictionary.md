# Data Dictionary - Library Management System

## Overview
This data dictionary describes all tables, columns, and relationships in the Library Management System database built using Supabase (PostgreSQL).

---

## Tables

### 1. students
**Purpose:** Stores information about library members/students who can borrow books.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| student_id | SERIAL | PRIMARY KEY | Unique identifier for each student |
| first_name | VARCHAR(50) | NOT NULL | Student's first name |
| last_name | VARCHAR(50) | NOT NULL | Student's last name |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Student's email address (unique) |
| phone | VARCHAR(20) | - | Student's phone number |
| enrollment_date | DATE | NOT NULL, DEFAULT CURRENT_DATE | Date when student registered |
| is_active | BOOLEAN | NOT NULL, DEFAULT TRUE | Whether student account is active |
| created_at | TIMESTAMP WITH TIME ZONE | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

---

### 2. books
**Purpose:** Stores information about books available in the library.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| book_id | SERIAL | PRIMARY KEY | Unique identifier for each book |
| title | VARCHAR(200) | NOT NULL | Book title |
| author | VARCHAR(100) | NOT NULL | Book author |
| isbn | VARCHAR(20) | UNIQUE | ISBN number (unique) |
| genre | VARCHAR(50) | - | Book genre/category |
| publication_year | INTEGER | - | Year the book was published |
| total_copies | INTEGER | NOT NULL, DEFAULT 1 | Total number of copies owned |
| available_copies | INTEGER | NOT NULL, DEFAULT 1 | Number of copies currently available |
| created_at | TIMESTAMP WITH TIME ZONE | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

---

### 3. borrow_records
**Purpose:** Tracks borrowing history and current loans between students and books.

| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| record_id | SERIAL | PRIMARY KEY | Unique identifier for each borrow record |
| student_id | INTEGER | NOT NULL, FOREIGN KEY → students(student_id) | References the borrowing student |
| book_id | INTEGER | NOT NULL, FOREIGN KEY → books(book_id) | References the borrowed book |
| borrow_date | DATE | NOT NULL, DEFAULT CURRENT_DATE | Date when book was borrowed |
| due_date | DATE | NOT NULL | Date when book should be returned |
| return_date | DATE | - | Actual return date (NULL if not returned) |
| is_returned | BOOLEAN | NOT NULL, DEFAULT FALSE | Whether book has been returned |
| fine_amount | DECIMAL(10,2) | DEFAULT 0.00 | Fine amount for late returns |
| created_at | TIMESTAMP WITH TIME ZONE | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

---

## Relationships

### Foreign Key Relationships
1. **borrow_records.student_id** → **students.student_id**
   - **Type:** Many-to-One
   - **Description:** One student can have many borrow records
   - **Action:** ON DELETE CASCADE (if student is deleted, their borrow records are deleted)

2. **borrow_records.book_id** → **books.book_id**
   - **Type:** Many-to-One  
   - **Description:** One book can have many borrow records
   - **Action:** ON DELETE CASCADE (if book is deleted, its borrow records are deleted)

---

## Views

### current_borrows
**Purpose:** Shows all currently borrowed books with borrower information and status.

| Column | Description |
|--------|-------------|
| student_name | Full name of the borrower |
| email | Student's email address |
| title | Book title |
| author | Book author |
| borrow_date | When book was borrowed |
| due_date | When book is due |
| status | 'Overdue' or 'On Time' |

---

## Indexes

### Performance Indexes
- `idx_students_email` - Index on students.email for faster lookups
- `idx_books_isbn` - Index on books.isbn for faster ISBN searches
- `idx_borrow_records_student_id` - Index on borrow_records.student_id for faster joins
- `idx_borrow_records_book_id` - Index on borrow_records.book_id for faster joins
- `idx_borrow_records_due_date` - Index on borrow_records.due_date for overdue queries

---

## Sample Data Summary

### Students: 5 records
- John Smith, Jane Doe, Mike Johnson, Sarah Wilson, David Brown
- All with unique email addresses and phone numbers
- Enrollment dates in early 2024

### Books: 5 records
- Classic literature including "To Kill a Mockingbird", "1984", "The Great Gatsby"
- Various genres: Fiction, Science Fiction, Romance
- Multiple copies available for some titles

### Borrow Records: 5 records
- Mix of returned and currently borrowed books
- Some books overdue, some returned on time
- Demonstrates various borrowing scenarios