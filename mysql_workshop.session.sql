-- choose the employees database
USE employees;

-- select all from the employees table
SELECT * FROM employees;

-- select all from the departments table
SELECT * FROM departments;

-- select Department Number and Department Name from Department table
SELECT dept_no,
    dept_name 
FROM departments 
WHERE 'd009';

-- retrieve the department ID and name for a specific department (e.d. 'Customer Service')
SELECT dept_no, 'Department Number',
    dept_name 'Department Name'
FROM departments
WHERE dept_name = 'Customer Service';

-- retrieve top 10 records from employees table
SELECT *
FROM employees
LIMIT 10;

-- get the count of employees for each department number
SELECT dept_no,
    COUNT(*)
FROM dept_emp
GROUP BY dept_no;

-- get the count of employees from employees table
SELECT COUNT(*)
FROM employees;

-- retrieve top 5 employee records
SELECT *
FROM employees
LIMIT 5;

-- retrieve top 5 employee first and last names
SELECT first_name,
    last_name
FROM employees
LIMIT 5;

-- retrieve and concatonate the first and last names
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name'
FROM employees
LIMIT 5;

-- store the Full Name in employees table
ALTER TABLE employees
ADD COLUMN full_name VARCHAR(255) AFTER last_name;
UPDATE employees
SET full_name = CONCAT(first_name, ' ', last_name);

-- retrieve the first and last names of employees who have a birthday in the month of December
SELECT first_name,
    last_name
FROM employees
WHERE MONTH(birth_date) = 12;

-- get the first name in upper and last name in lower case
SELECT UPPER(first_name) 'First Name',
    LOWER(last_name) 'Last Name'
FROM employees
LIMIT 5;


-- get 10 sample records from salaries table
SELECT *
FROM salaries
LIMIT 10;

-- get maximum, minimum and average salaries from salaries table
SELECT MAX(salary) 'Maximum Salary',
    MIN(salary) 'Minimum Salary',
    AVG(salary) 'Average Salary'
FROM salaries;

-- get the number of records from titles table
SELECT COUNT(*)
FROM titles;

-- get sample of 5 records from titles table
SELECT *
FROM titles
LIMIT 5;

-- get all titles for a specific employee ID (e.g. 10001)
SELECT *
FROM titles
WHERE emp_no = 10001;

-- get list of existing titles without duplicates from titles list
SELECT DISTINCT title
FROM titles;

-- get the current date and time
SELECT NOW()

-- get the current time, date, and time, date which is 50 years from now
SELECT NOW(),
    DATE(NOW()),
    TIME(NOW()),
    DATE_ADD(NOW(), INTERVAL 50 YEAR);

-- alternative
SELECT EXTRACT(YEAR FROM NOW()) + 50;

-- generate a report with employee number, first name, last name, salary
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    s.salary
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
LIMIT 10;

