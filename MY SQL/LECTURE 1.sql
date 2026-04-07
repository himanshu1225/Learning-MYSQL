-- Lecture 1 (Database related)
create database school_db;  -- create the database
show databases;
use school_db;    -- select the database
select database();  -- funciton which tells current database 
drop database school_db;  -- to remove the data base and its internal table.

-- Lecture 2: (Table related)
create database test;
use test;

create table employees (
	employee_id int primary key auto_increment,  -- name data_type constraint
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    hire_date date default (current_date()),
    email varchar(100) unique,
    phone_number varchar(100) unique,
    salary decimal(10,2) check (salary > 0), 
    employment_status enum('active', 'on leave', 'terminated') default 'active',
    created_at TIMESTAMP default current_timestamp,
    updated_at TIMESTAMP default current_timestamp on update current_timestamp
);
-- primary key constraint: this means its value should be unique in table and cannot be null.
-- auto_increment: this is not constraint. It is property, if user not giving unique value than take largest and increment by 1.
-- default: The DEFAULT constraint is used to set a default value for a column. 
-- (current_date()): current_date() is a function and this we have to wrap it inside () as this is expression.
-- CHECK constraint used for data validation
-- unique constraint: this means its value should be unique in table and can contain one null value.
-- decimal (10,2): total number should be 10 and in that 2 decimal numbers (included in 10).
-- Both primary key and unique creates index on column where we are using (searching fast ho jaati index se)
-- current_timestamp: this is also function like current_date() but this need not be in wrapper.

-- on update current_timestamp: when updating row use current_timestamp.

-- insert into table_name (column1, column2, column3) values (value1, value2, value3);

insert into employees (first_name,
						last_name, 
                        hire_date, 
                        email, 
                        phone_number,
                        salary,
                        employment_status) 
                        values (
                        'Himanshu',
                        'Bhati',
                        '2020-08-01',
                        'himanshu12b@gmail.com',
                        '+918764148466',
                         63000.00,
						'active'
                        );
                        
insert into employees (first_name,
						last_name, 
                        email, 
                        phone_number,
                        salary
                        ) 
                        values (
                        'Himanshu',
                        'Bhati',
                        'himanshubhati@gmail.com',
                        '+918764148460',
                         63000.00
                        );
                        
-- Note: employee_id seedha 1 se 4 ho gya: because 2 and 3 ko reserve rkhta kuki do users same time pe insert kr rhe ho tho.

select * from employees;


create table departments (
	department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    created_at TIMESTAMP default current_timestamp,
    updated_at TIMESTAMP default current_timestamp on update current_timestamp
);

insert into departments(department_name, location) values ('IT', 'Building A'), ('HR', 'Building B'), ('SALES', 'Building C');

-- ALTER TABLE table_name action;

-- Add column
ALTER TABLE employees 
add column description text; 

ALTER TABLE employees 
add column description text,
add column description1 text;

-- Rename column name 
ALTER TABLE employees
rename column description to descrip;

-- Drop column name
ALTER TABLE employees 
drop column description1,
drop column description;



select * from employees; -- null values for description 

-- lets add constraint

ALTER TABLE employees 
add column emergency_contact varchar(100) NOT NULL check (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');
-- this will not work as baaki columns me null jayega as unme emergency_contact nahi hai.
-- 2 ways : 1. default value 2. Add column  and then fill those fields accordingly using update and then add constraint on column.


ALTER TABLE employees 
add column emergency_contact varchar(100) ;
-- manually kri abhi values because update abhi nahi padha 

select * from employees;

-- Now lets add constraint and check table

-- Adding check
ALTER TABLE employees 
ADD check (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');

-- Adding constraint / Modifying column 
ALTER TABLE employees 
modify column emergency_contact varchar(100) not null;


-- now we will establish connection between these 2 tables.
-- department_id ko foreign key bana denge in employees table.

Alter table employees add column department_id  INT;
-- humne Not null nahi diya, foreign key can be nullable

-- But hum chate hai ki not null rkhe then

Alter table employees
drop column department_id;

Alter table employees ADD column department_id INT not null;  -- ye chal gya because isne integer ki default value set krdi which is zero. This is wrong
-- Correct way:

Alter table employees drop column department_id;
-- first add column, then add manual values and then add constraint
Alter table employees ADD column department_id INT;
-- update columns 
-- modify column constraint
alter table employees modify column department_id INT not null;
-- now add foreign key
alter table employees add foreign key (department_id) references departments(department_id);

select * from departments;
select * from employees;

insert into employees (first_name,
						last_name, 
                        email, 
                        phone_number,
                        salary,
                        emergency_contact, department_id
                        ) 
                        values (
                        'PARIDHI',
                        'SANKHLA',
                        'pari@gmail.com',
                        '+918764148462',
                         63000.00,
                         'ok: 3294',
                         99
                        );
  -- adding 99 as   department_id but 99 value ka department koi hai hi nahi   departments table me. this is advantage of foreign key      
  
  insert into employees (first_name,
						last_name, 
                        email, 
                        phone_number,
                        salary,
                        emergency_contact, department_id
                        ) 
                        values (
                        'PARIDHI',
                        'SANKHLA',
                        'pari@gmail.com',
                        '+918764148462',
                         63000.00,
                         'ok: 3294',
                         2
                        );
                        
-- foreign key ka constraints me direct create table ke time kr sakta tha like below 
-- create table table_name (
-- 	column_name data_type constraint,
--     column_name data_type constraint,
--     column_name data_type constraint,
--     table_constraints
-- );

-- create table employees (
-- 	employee_id int primary key auto_increment,  -- name data_type constraint
--     first_name varchar(50) not null,
--     last_name varchar(50) not null,
--     hire_date date default (current_date()),
--     email varchar(100) unique,
--     phone_number varchar(100) unique,
--     salary decimal(10,2) check (salary > 0), 
--     employment_status enum('active', 'on leave', 'terminated') default 'active',
--     created_at TIMESTAMP default current_timestamp,
--     updated_at TIMESTAMP default current_timestamp on update current_timestamp,
--     foreign key (department_id) references departments(department_id)
--     primary key (employee_id, first_name)   
-- );

-- primary key ek hi hogi ek table me, but multiple fields ko milake ek ban sakti ek table me


-- Drop tables

-- drop table employees;
-- drop table employees, departments;

drop table departments; -- ispe dependencies hai cannot drop

-- if exists
drop table ok; -- error

drop table if exists ok;  -- error nahi, warning hai