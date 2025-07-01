SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

-- project Task
-- CURD operation
-- Task 1. Create a new book record - "978-1-60129-456-2",'To-kill a Mockingbird','classic',6.90,'yes','Harper Lee','J.B. Lippincot & co.'
INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES(978-1-60129-456-2,'To-kill a Mockingbird','classic',6.90,'yes','Harper Lee','J.B. Lippincot & co.')

--Task 2. Updating an existing memebrs's address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

--Task 3. Delete a record from the issued status table of id 'IS107'
DELETE FROM issued_status
WHERE issued_id = 'IS121';
SELECT * FROM issued_status;

--Task 4. Retrive all books issued by a specific employee
SELECT issued_book_name FROM issued_status
WHERE issued_emp_id = 'E101';

--Task 5. List members who have issued more than one book 
SELECT 
     issued_emp_id,
	 COUNT(issued_id) AS total_book_issued
FROM issued_status
GROUP BY 1
HAVING COUNT(issued_id) > 1

-- Task 6. Create summary tables : used CTAS to generate new tables
CREATE TABLE book_cnts
AS
SELECT 
     b.isbn,
	 b.book_title,
	 COUNT(ist.issued_id) as no_issued
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1,2

SELECT * FROM book_cnts;

--Task 7. Retrive all books in a specific category
SELECT * FROM books
WHERE category = 'Classic';

-- Task 8. Find Total Rental Income by category
SELECT b.category,
     SUM(b.rental_price) 
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1;

--Task 9. List members who registered in the last 100 days
SELECT * FROM members
--WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'

--Task 10. List employees with their branch manager'name and their branch detail
SELECT 
      e1.*,
	  e2.emp_name as manager,
	  b.manager_id
FROM employees as e1
JOIN
branch as b 
ON e1.branch_id = b.branch_id
JOIN 
employees as e2
ON b.manager_id = e2.emp_id

--Task 11. create a table of books with rental price above a certain threshold  7usd
CREATE TABLE books_Price_greater_than_7
AS
SELECT * FROM books
WHERE rental_price > 7

SELECT * FROM books_price_greater_than_7;

-- Task 12. Retrive the list of books Not yet returned
SELECT 
      DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;

-- Task 13. Identify the memebrs with overdue books .
SELECT
     m.member_name,
	 b.book_title,
	 ist.issued_date,
     CURRENT_DATE - ist.issued_date - 30 as days_overdue
FROM issued_status as ist
JOIN
members as m
ON ist.issued_member_id= m.member_id
JOIN
books as b
ON ist.issued_book_isbn= b.isbn
WHERE
     CURRENT_DATE - ist.issued_date > 30;

-- Task 14. Upadte Book status on Return
UPDATE books
SET status = 'available'
WHERE isbn IN(
SELECT ist.issued_book_isbn
FROM issued_status as ist
JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NOT NULL
)
SELECT * FROM books;

-- Task 15. performance table 
SELECT 
    br.branch_address,
    COUNT(DISTINCT ist.issued_id) AS books_issued,
    COUNT(DISTINCT rs.return_id) AS books_returned,
    SUM(b.rental_price) AS total_revenue
FROM issued_status AS ist
JOIN employees AS e ON ist.issued_emp_id = e.emp_id
JOIN branch AS br ON e.branch_id = br.branch_id
JOIN books AS b ON ist.issued_book_isbn = b.isbn
LEFT JOIN return_status AS rs ON ist.issued_id = rs.issued_id
GROUP BY br.branch_address
ORDER BY total_revenue DESC;

