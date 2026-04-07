CREATE DATABASE company;
USE company;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('John', 'Doe', 'HR', 60000.00, '2022-05-10'),
('Jane', 'Smith', 'IT', 75000.00, '2021-08-15'),
('Alice', 'Johnson', 'Finance', 82000.00, '2019-03-20'),
('Bob', 'Williams', 'IT', 72000.00, '2020-11-25'),
('Charlie', 'Brown', 'Marketing', 65000.00, '2023-01-05');


SELECT * FROM employees;

-- AS keyword
select first_name as 'FIRST NAME', last_name, department from employees;

-- sort using order by (by default asc)
SELECT * FROM employees where department="IT" ORDER BY salary desc;

select * from employees limit 1;

-- highest salary 
SELECT * FROM employees where department="IT" ORDER BY salary desc limit 1;

-- distinct 
select distinct department from employees;

-- Math operations: 10 percent salary increment:
select first_name, last_name, salary*1.1  AS 'SALARY AFTER RAISE' from employees;

-- Functions (will study later as well)
select concat(first_name, ' ', last_name) as 'Full Name', year(hire_date), round(salary, 1) from employees where salary > 70000;

-- find employees whose salary is greater than average salary: 
select avg(salary) from employees; -- 70800.000000
select * from employees where salary > 70800.000000;
-- subqueries

select * from employees where salary > (select avg(salary) from employees);

-- union
SELECT first_name, last_name FROM employees WHERE department = 'IT' UNION
SELECT first_name, last_name FROM employees WHERE department = 'HR';

-- group by

select * from employees group by department; -- error group krke krna kya hai wo btana hoga

-- let say count krke le aaye (aggregrate function)
select count(*), department from employees group by department; 

-- You can evaluate expression using select

select 2*3;

select NOW() as time;

select 5 > 3;

select length('hello');


