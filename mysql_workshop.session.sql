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

-- get the schema of employees table
DESCRIBE employees;

-- instert new record into titles table
INSERT INTO titles (emp_no, title, from_date)
VALUES (
    10001,'AI Specialist','2023-06-26'
  );

-- create a stored procedure to insert data into titles table with continueing employee numbers
DELIMITER $$
CREATE PROCEDURE insert_title(
    IN p_emp_no INTEGER,
    IN p_title VARCHAR(50),
    IN p_from_date DATE
)
BEGIN
  insert into titles (emp_no, title, from_date)   VALUES (p_emp_no, p_title, p_from_date);
END;


-- using above stored procedure, insert data into table
CALL insert_title(10012, 'Senior AI Specialist22', '2023-06-26');
CALL insert_title(10013, 'Senior AI Specialist33', '2023-06-26');
CALL insert_title(10014, 'Senior AI Specialist44', '2023-06-26');
CALL insert_title(10015, 'Senior AI Specialist55', '2023-06-26');
CALL insert_title(10016, 'Senior AI Specialist66', '2023-06-26');

-- get the list of titles from the titles table with titles like 'AI'
SELECT *
FROM titles
WHERE title LIKE '%AI%';

-- get all employees names from 'Finance' department
SELECT e.first_name,
    e.last_name, d.dept_name
FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Finance';


-- get the list of records with following departments: Marketing, Production, Finance
SELECT * FROM departments
WHERE
dept_name IN ('Marketing','Production','Finance');

-- get the list of records other than the following departments Marketing, Production, Finance
SELECT * FROM departments
WHERE
dept_name NOT IN ('Marketing', 'Production', 'Finance');

-- this gets the same results as IN (line164)
SELECT * FROM departments
WHERE
dept_name = 'Marketing'
OR dept_name = 'Production'
OR dept_name = 'Finance';('Marketing','Production','Finance');

-- with AND you get the records that include ALL that is specified
SELECT * FROM departments
WHERE
dept_name = 'Marketing'
AND dept_name = 'Production'
AND dept_name = 'Finance';('Marketing','Production','Finance');

-- get the list of salary records with salary less than average salary
SELECT *
FROM salaries
WHERE salary <
    (SELECT AVG(salary)
     FROM salaries);

     -- Retrieve the salary records with salary lesser than average salary
SELECT count(*) FROM salaries
WHERE salary < 63811;

-- Retrieve the salary records with salary more than average salary
SELECT count(*) FROM salaries
WHERE salary > 63811;

-- Get all the salary records with salary in the range of 40000 and 60000
SELECT * FROM salaries
WHERE salary BETWEEN 40000 AND 60000;

-- Get all the salary records with salary not in the range of 40000 and 60000
SELECT * FROM salaries
WHERE salary NOT BETWEEN 40000 AND 60000;

-- Get the records with salary equal to 158220
SELECT * FROM salaries
WHERE salary = 158220;

select * from employees
where emp_no=43624;

-- get the record with emp_no 43624
SELECT * FROM employees
WHERE emp_no = 43624;

-- get the record with emp_no 43624 from salaries
SELECT * FROM salaries
WHERE emp_no = 43624;


INSERT INTO employees (
    emp_no,
    first_name,
    last_name,
    gender,
    hire_date
)
VALUES (
    9945221,
    'John',
    'Doe',
    'M',
    '1990-11-21'
);

SELECT * FROM employees
WHERE emp_no = 9945221;

/*
test comment block
*/

-- get data from employees and salaries table for employee with emp_no 9945221 using INNER JOIN
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    s.from_date,
    s.to_date
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = 9945221;

-- result -> no data found


-- get data from employees and salaries table for employee with emp_no 9945221 using LEFT JOIN
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    s.from_date,
    s.to_date
FROM employees e
    LEFT JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = 9945221;

-- result -> data from table employees (nothing added to salaries for this employee)


-- get data from employees and salaries table for employee with emp_no 9945221 using RIGHT JOIN

SELECT e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    s.from_date,
    s.to_date
FROM employees e
    RIGHT JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = 9945221;

-- result -> no data


-- 
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    s.from_date,
    s.to_date
FROM employees e
    RIGHT JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = 9945221;


select  s.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    s.from_date,
    s.to_date
from emp_temp e
    right join salaries_temp s ON e.emp_no = s.emp_no
where s.emp_no = 889988112222;


select  *
from emp_temp e
right join salaries_temp s 
on e.emp_no = s.emp_no;


-- join emp_temp and  salaries_temp tables using FULL OUTER JOIN and retrieve all records
-- in MySQL FULL OUTER JOIN is not supported, so we use LEFT JOIN and RIGHT JOIN

select s.emp_no, e.birth_date, e.first_name, e.last_name, s.salary, s.from_date, s.to_date  from emp_temp e
left join salaries_temp s
on e.emp_no = s.emp_no
union
select s.emp_no, e.birth_date, e.first_name, e.last_name, s.salary, s.from_date, s.to_date  from emp_temp e
right join salaries_temp s
on e.emp_no = s.emp_no


-- sorting

select * from departments
order by dept_no DESC;

select dept_no from departments
where dept_name in ('Marketing', 'Human Resources', 'Finance');

select emp_no from 

-- subquery / inner query

select 
    * 
from 
    dept_emp
where 
    dept_no 
        in  (select dept_no from departments
        where dept_name in ('Marketing', 'Human Resources', 'Finance'));


select count(distinct emp_no) from employees;

-- get number of employees in each department
select count(*) from employees;



-- get number of employees in Marketing department using subqueries
select count(emp_no)
from employees
where emp_no in
    (select emp_no
    from dept_emp
    where dept_no =
        (select dept_no
        from departments
        where dept_name = 'Marketing'));

-- getting info from employees table (-> emp_no) than get the info from dept_emp table (-> emp-no of specific dept_no) than get info form departments table (-> dept_no of specific dept_name)


-- get number of employees in Marketing departments using join
select count(e.emp_no)
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
where d.dept_name = 'Marketing';