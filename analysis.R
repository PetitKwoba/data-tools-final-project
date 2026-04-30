# analysis.R
# Library Management System – Data Tools Final Project

library(DBI)
library(RPostgres)
library(dplyr)
library(ggplot2)

# 1. Connect to Supabase Postgres
con <- dbConnect(
  RPostgres::Postgres(),
  host     = "db.vmjfeqphpklkyyrzqaff.supabase.co",
  port     = 5432,
  dbname   = "postgres",
  user     = "postgres",
  password = "Mumbua@1212!",   # consider moving to env var for security
  sslmode  = "require"
)

# Quick connection checks
print(con)
stopifnot(DBI::dbIsValid(con))

DBI::dbGetQuery(con, "SELECT NOW() AS server_time;")

DBI::dbListTables(con)

# 2. Load data from your library tables
students <- dbGetQuery(con, "SELECT * FROM students;")
books    <- dbGetQuery(con, "SELECT * FROM books;")
borrows  <- dbGetQuery(con, "SELECT * FROM borrow_records;")

# 3. Example analyses and ggplot visuals

# 3.1 Number of students enrolled per year
students_year <- students |>
  mutate(year = format(as.Date(enrollment_date), "%Y")) |>
  count(year)

gg_students_year <- ggplot(students_year, aes(x = year, y = n)) +
  geom_col(fill = "steelblue") +
  theme_minimal() +
  labs(
    title = "Number of Students Enrolled per Year",
    x = "Year",
    y = "Number of Students"
  )

print(gg_students_year)

# 3.2 Books by genre
books_genre <- books |>
  count(genre, name = "book_count") |>
  arrange(desc(book_count))

gg_books_genre <- ggplot(books_genre, aes(x = reorder(genre, -book_count), y = book_count)) +
  geom_col(fill = "darkorange") +
  theme_minimal() +
  labs(
    title = "Number of Books by Genre",
    x = "Genre",
    y = "Number of Books"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(gg_books_genre)

# 3.3 Book availability: total vs available copies
gg_book_availability <- ggplot(books, aes(x = title)) +
  geom_col(aes(y = total_copies, fill = "Total copies"), position = "dodge") +
  geom_col(aes(y = available_copies, fill = "Available copies"), position = "dodge") +
  theme_minimal() +
  labs(
    title = "Book Availability",
    x = "Book Title",
    y = "Number of Copies",
    fill = "Legend"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(gg_book_availability)

# 3.4 Borrow status: returned vs not returned
borrow_status <- borrows |>
  count(is_returned) |>
  mutate(
    status = ifelse(is_returned, "Returned", "Not Returned")
  )

gg_borrow_status <- ggplot(borrow_status, aes(x = status, y = n, fill = status)) +
  geom_col() +
  theme_minimal() +
  labs(
    title = "Borrow Records by Return Status",
    x = "Status",
    y = "Number of Records"
  ) +
  guides(fill = "none")

print(gg_borrow_status)

# 4. Disconnect when done
dbDisconnect(con)
