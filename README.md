# 📚 Library Management System – SQL Project

This is a mini **Library Management System** project implemented using **PostgreSQL**. It covers core SQL concepts like `CREATE`, `INSERT`, `UPDATE`, `DELETE`, `JOIN`, `AGGREGATE`, `GROUP BY`, and `CTAS`, along with practical reporting use cases.

---

## 🛠️ Tech Stack

- **Database**: PostgreSQL
- **Tools Used**: pgAdmin / psql
- **Language**: SQL

---

## 📂 Database Tables & Structure

1. **`books`**  
   `(isbn, book_title, category, rental_price, status, author, publisher)`

2. **`branch`**  
   `(branch_id, manager_id, branch_address, contact_no)`

3. **`employees`**  
   `(emp_id, emp_name, branch_id, ...)`

4. **`members`**  
   `(member_id, member_name, member_address, reg_date, ...)`

5. **`issued_status`**  
   `(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)`

6. **`return_status`**  
   `(return_id, issued_id, return_date)`

---
