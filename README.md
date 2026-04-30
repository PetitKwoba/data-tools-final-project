# Library Management System - Data Tools Final Project

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [❓ FAQ (OPTIONAL)](#faq)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 Library Management System <a name="about-project"></a>

> A comprehensive database solution for managing library operations including student enrollment, book inventory, and borrowing records.

**Library Management System** is a Supabase-powered database application that tracks students, books, and borrowing activities in a library environment. It demonstrates proper database design with foreign key relationships, data integrity, and real-world library operations.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

> Describe the tech stack and include only the relevant sections that apply to your project e.g SQL.

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://reactjs.org/">Supabase</a></li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://expressjs.com/">SQL</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

> Core features of the Library Management System database.

- **Student Management** - Track student enrollment and contact information
- **Book Inventory** - Manage book catalog with availability tracking  
- **Borrowing System** - Record book loans with due dates and return tracking

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LIVE DEMO -->

## 🚀 Live Demo <a name="live-demo"></a>

> This project is designed to be deployed on Supabase.

- Database Schema: Available in `schema.sql`
- Documentation: See `data_dictionary.md` and `docs/ERD.md`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

> Follow these steps to set up the Library Management System in your Supabase project.

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

- A Supabase account (free tier available)
- Basic knowledge of SQL
- PostgreSQL database access

### Setup

1. Create a new Supabase project at [supabase.com](https://supabase.com)
2. Clone this repository to your local machine:

```sh
git clone https://github.com/PetitKwoba/data-tools-final-project.git
cd data-tools-final-project
```

### Install

1. Open your Supabase project dashboard
2. Navigate to the SQL Editor
3. Copy and paste the contents of `schema.sql` 
4. Execute the SQL to create tables, insert sample data, and set up relationships

### Usage

To run example queries, use the Supabase SQL editor:

```sql
-- Find all books currently borrowed by a specific student
SELECT b.title, b.author, br.borrow_date, br.due_date
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
WHERE br.student_id = 1 AND br.is_returned = FALSE;

-- Find all overdue books
SELECT s.first_name, s.last_name, b.title, br.due_date
FROM borrow_records br
JOIN students s ON br.student_id = s.student_id
JOIN books b ON br.book_id = b.book_id
WHERE br.is_returned = FALSE AND br.due_date < CURRENT_DATE;

-- Get book availability summary
SELECT title, author, total_copies, available_copies,
       (total_copies - available_copies) AS borrowed_copies
FROM books
ORDER BY title;
```

### Database Schema

The database consists of three main tables:
- **students**: Student information and enrollment data
- **books**: Book catalog with inventory tracking
- **borrow_records**: Borrowing history and current loans

See `data_dictionary.md` for detailed table schemas and `docs/ERD.md` for relationship diagrams.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

> Data Tools Final Project - Supabase Implementation

👤 **Project Developer**

- GitHub: [@PetitKwoba](https://github.com/PetitKwoba)
- Project: [Library Management System](https://github.com/PetitKwoba/data-tools-final-project)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

> Planned enhancements for the Library Management System.

- [ ] **Fine Calculation System** - Automatic fine calculation for overdue books
- [ ] **Book Reservation System** - Allow students to reserve books that are currently borrowed  
- [ ] **Library Statistics Dashboard** - Analytics on borrowing patterns and popular books

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

> Support this educational database project!

If you like this Library Management System project, please give it a ⭐️ on GitHub! This project demonstrates:

- Proper database design principles
- Foreign key relationships and data integrity
- Real-world library management scenarios
- Clean SQL practices with Supabase/PostgreSQL

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

> Credits and inspiration for this project.

I would like to thank:

- **Supabase** for providing an excellent PostgreSQL database platform
- **The Data Tools Course** for the comprehensive database fundamentals curriculum
- **PostgreSQL Community** for maintaining robust open-source database technology

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional) -->

## ❓ FAQ (OPTIONAL) <a name="faq"></a>

> Common questions about the Library Management System.

- **How do I modify the schema for my own library?**

  - Edit the `schema.sql` file to add/remove columns or tables as needed. Update the sample data to match your library's books and students.

- **Can this be extended to handle multiple libraries?**

  - Yes! You could add a `libraries` table and reference it from the other tables to support a multi-library system.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.



<p align="right">(<a href="#readme-top">back to top</a>)</p>
