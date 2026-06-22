CREATE DATABASE IF NOT EXISTS quangduy_db;
USE quangduy_db;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1,'IT'),
(2,'HR'),
(3,'Marketing'),
(4,'Finance');

CREATE TABLE employees(
    employee_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    salary DECIMAL(10,2),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees VALUES
(1,'Nguyen Van An','Male',15000000,'2024-03-15',1),
(2,'Tran Thi Binh','Female',12000000,'2023-08-10',2),
(3,'Le Van Cuong','Male',18000000,'2025-01-20',1),
(4,'Pham Thi Dung','Female',14000000,'2022-11-01',3),
(5,'Hoang Van Em','Male',10000000,'2024-06-15',1),
(6,'Nguyen Thi Giang','Female',16000000,'2025-03-10',2),
(7,'Do Van Hung','Male',9000000,'2024-01-10',4),
(8,'Le Thi Hoa','Female',22000000,'2023-12-01',3),
(9,'Tran Van Khoa','Male',17000000,'2025-04-20',1),
(10,'Pham Thi Lan','Female',11000000,'2024-08-15',2);

SELECT employee_id AS 'Employee ID',
       full_name AS 'Employee Name',
       salary AS 'Monthly Salary'
FROM employees;

SELECT full_name,
       salary * 12 AS 'Annual Salary'
FROM employees;

SELECT full_name AS 'Name',
       hire_date AS 'Start Date'
FROM employees;

SELECT COUNT(*) AS total_employee
FROM employees;

SELECT SUM(salary) AS total_salary
FROM employees;

SELECT AVG(salary) AS average_salary
FROM employees;

SELECT MAX(salary) AS highest_salary
FROM employees;

SELECT MIN(salary) AS lowest_salary
FROM employees;

SELECT COUNT(*) AS total_employee,
       SUM(salary) AS total_salary,
       AVG(salary) AS average_salary,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary
FROM employees;

SELECT department_id,
       COUNT(*) AS total_employee
FROM employees
GROUP BY department_id;

SELECT department_id,
       SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

SELECT department_id,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

SELECT department_id,
       MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id;

SELECT department_id,
       MIN(salary) AS lowest_salary
FROM employees
GROUP BY department_id;

SELECT department_id,
       COUNT(*) AS total_employee
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 3;

SELECT department_id,
       SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 35000000;

SELECT department_id,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 14000000;

SELECT department_id,
       COUNT(*) AS total_employee,
       SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2
   AND SUM(salary) > 30000000;

SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary < (
    SELECT AVG(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE full_name = 'Nguyen Van An'
);

SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

SELECT e.full_name,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

SELECT e.full_name,
       e.gender,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

SELECT e.full_name,
       e.salary,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;

SELECT d.department_name,
       COUNT(e.employee_id) AS total_employee
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

SELECT *
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

SELECT d.department_id,
       d.department_name,
       AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) >
(
    SELECT AVG(salary)
    FROM employees
);