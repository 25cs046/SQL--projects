## SQL--project for library management
SQL projects for internship
Name:Deivanai K
Intern ID:CITS4176


## Project Overview
A relational database system to manage a library's books, members, and borrowing records.

## Tables
- **books** — stores book details (title, author, genre, availability)
- **members** — stores member information
- **borrows** — tracks which member borrowed which book and when

## Features
1. View all available books using subquery
2. View who borrowed which book (JOIN across 3 tables)
3. Detect overdue books using JULIANDAY date calculation
4. Most popular books by borrow count (GROUP BY + COUNT)
5. Complete borrowing history per member

## Concepts Used
- PRIMARY KEY, FOREIGN KEY, AUTOINCREMENT
- JOIN, multiple JOINs
- Subqueries
- JULIANDAY (date calculations)
- GROUP BY, COUNT, ORDER BY
- COALESCE (handle NULL values)

## Tool Used
SQLite
