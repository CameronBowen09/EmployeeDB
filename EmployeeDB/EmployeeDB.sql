create database EmployeeDB;

-- Create a employees table
create table employees(
	emp_id bigserial constraint emp_id_key primary key,
	first_name varchar(50),
	surname varchar(50),
	gender varchar(10),
	address varchar(200),
	email varchar(200) constraint email_unique unique,
	depart_id integer references department (depart_id),
	role_id integer references roles (role_id),
	salary_id integer references salary (salary_id),
	overtime_id integer references overtime (overtime_id)
);

-- Create a department table
create table department(
	depart_id bigserial constraint depart_id_key primary key,
	depart_name varchar(50),
	depart_city varchar(50)
);

-- Create a roles table
create table roles(
	role_id bigserial constraint role_id_key primary key,
	role varchar(50)
);

-- Create a salary table
create table salary(
	salary_id bigserial constraint salary_id_key primary key,
	salary_pa integer
);

-- Create a over time table
create table overtime(
	overtime_id bigserial constraint overtime_id_key primary key,
	overtime_hours integer
);

-- Insert into the employees table
insert into employees (first_name, surname, gender, address, email, depart_id, 
					   role_id, salary_id, overtime_id)
values ('Cameron', 'Bowen', 'Male', '123 somewhere street', 'Cameronbowen075@gmail.com', 1, 2, 3, 4),
       ('Vanessa', 'Wright', 'Female', '782 middle street', 'Vanessawright@gmail.com', 2, 3, 4, 5),
	   ('Kyle', 'Lush', 'Male', '431 seven street', 'Kylelush@gmail.com', 3, 4, 5, 1),
	   ('Nikita', 'Soman', 'Female', '568 ninth street', 'Nikitasoman@gmail.com', 4, 5, 1, 2),
	   ('Mathew', 'Tomaz', 'Male', '934 elephent street', 'Mathewtomaz@gmail.com', 5, 1, 2, 3);
	   
-- Insert into department table
insert into department (depart_name, depart_city)
values ('Tax', 'Johannusburg'),
       ('IT', 'Johannusburg'),
	   ('Accounting', 'Cape Town'),
	   ('Statistics', 'Durban'),
	   ('Marketing', 'Cape Town');
	   
-- Insert into roles table
insert into roles (role)
values ('Manager'),
       ('Intern'),
	   ('Junior'),
	   ('Senior'),
	   ('Manager');

-- Insert into salary table
insert into salary (salary_pa)
values (20000),
       (50000),
	   (15000),
	   (35000),
	   (55000);
	   
-- Insert into overtime table
insert into overtime (overtime_hours)
values (5),
       (10),
	   (3),
	   (7),
	   (1);

-- Check if the values are stored correctly
select * from employees;

-- Left join the department name, job role, salary figure and overtime hours
select employees.first_name, employees.surname, employees.gender, employees.address, employees.email,
department.depart_name, roles.role, salary.salary_pa, overtime.overtime_hours
from employees left join department
on employees.depart_id = department.depart_id
left join roles
on employees.role_id = roles.role_id
left join salary
on employees.salary_id = salary.salary_id
left join overtime
on employees.overtime_id = overtime.overtime_id;

