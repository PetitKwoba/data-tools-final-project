# Entity Relationship Diagram (ERD)
## Library Management System

### Text-Based ERD Description

```
STUDENTS ||--o{ BORROW_RECORDS }o--|| BOOKS

STUDENTS:
- student_id (PK)
- first_name
- last_name
- email (UNIQUE)
- phone
- enrollment_date
- is_active
- created_at

BOOKS:
- book_id (PK)
- title
- author
- isbn (UNIQUE)
- genre
- publication_year
- total_copies
- available_copies
- created_at

BORROW_RECORDS:
- record_id (PK)
- student_id (FK → students.student_id)
- book_id (FK → books.book_id)
- borrow_date
- due_date
- return_date
- is_returned
- fine_amount
- created_at
```

### ASCII Diagram

```
┌─────────────────┐                ┌─────────────────┐                ┌─────────────────┐
│    STUDENTS     │                │ BORROW_RECORDS  │                │     BOOKS       │
├─────────────────┤                ├─────────────────┤                ├─────────────────┤
│ student_id (PK) │◄───────────────┤ record_id (PK)  │───────────────►│ book_id (PK)    │
│ first_name      │                │ student_id (FK) │                │ title           │
│ last_name       │                │ book_id (FK)    │                │ author          │
│ email (UQ)      │                │ borrow_date     │                │ isbn (UQ)       │
│ phone           │                │ due_date        │                │ genre           │
│ enrollment_date │                │ return_date     │                │ publication_year│
│ is_active       │                │ is_returned     │                │ total_copies    │
│ created_at      │                │ fine_amount     │                │ available_copies│
└─────────────────┘                │ created_at      │                │ created_at      │
                                   └─────────────────┘                └─────────────────┘
```

### Relationship Details

**1. Students to Borrow Records (One-to-Many)**
- **Cardinality:** 1:N
- **Description:** One student can have multiple borrow records
- **Foreign Key:** borrow_records.student_id → students.student_id
- **Delete Rule:** CASCADE

**2. Books to Borrow Records (One-to-Many)**
- **Cardinality:** 1:N  
- **Description:** One book can have multiple borrow records
- **Foreign Key:** borrow_records.book_id → books.book_id
- **Delete Rule:** CASCADE

### Business Rules

1. **Students** must have unique email addresses
2. **Books** must have unique ISBN numbers (when provided)
3. **Borrow Records** cannot exist without valid student and book references
4. Available copies in **Books** should be updated when books are borrowed/returned
5. Due dates must be after borrow dates
6. Fine amounts are calculated based on overdue days

### Views and Derived Data

**current_borrows View:**
- Joins all three tables to show active borrowings
- Calculates overdue status based on current date
- Provides complete borrower and book information

This ERD demonstrates:
- ✅ **3 tables minimum** (students, books, borrow_records)
- ✅ **Foreign key relationships** (student_id, book_id in borrow_records)
- ✅ **5+ rows per table** (sample data included)
- ✅ **Proper normalization** and referential integrity