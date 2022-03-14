create database analysis;

create table teachers (
    id bigserial,
    first_name varchar(25),
    last_name varchar(50),
    school varchar(50),
    hire_date date,
    salary numeric
);

insert into teachers (first_name, last_name, school, hire_date, salary)
values ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
    ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
    ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
    ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
    ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
    ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);
	
select * from teachers;

select first_name, last_name, school from teachers;

select distinct school from teachers;

select distinct school, salary from teachers;

select first_name, last_name, salary 
from teachers 
order by salary desc;

select last_name, school, hire_date 
from teachers 
order by school asc, hire_date desc;

select last_name, school, hire_date 
from teachers 
where school = 'Myers Middle School';

select first_name, last_name, salary
from teachers
where salary > 50000;

select first_name, last_name, salary
from teachers
where salary between 20000 and 40000;

select *
from teachers
where school = 'Myers Middle School'
and salary < 40000;

select *
from teachers
where last_name = 'Cole'
or last_name = 'Bush';

select *
from teachers
where school = 'F.D. Roosevelt HS'
and (salary < 38000 or salary > 40000);

create table char_data_types (
     varchar_column varchar(10),
     char_column char(10),
     text_column text
);

insert into char_data_types
values('abc', 'abc', 'abc'),
      ('defghi', 'defghi', 'defghi');
	  
copy char_data_types to 'C:\Users\User\Desktop\SQL\Analysis\typetest.txt' with (FORMAT csv, header, delimiter'|');

copy teachers to 'C:\Users\User\Desktop\SQL\Analysis\teacherinfo.txt' with (FORMAT csv, header, delimiter'|');

create table number_data_types (
     numeric_column numeric(20,5),
     real_column real,
     double_column double precision
);

insert into number_data_types
values(.7, .7, .7),
      (2.13579, 2.13579, 2.13579),
      (2.1357987654, 2.1357987654, 2.1357987654);
	  
select * from number_data_types;

select numeric_column * 10000000 as "Fixed",
real_column * 10000000 as "Float"
from number_data_types
where numeric_column = .7;

create table date_time_types (
     timestamp_column timestamp with time zone,
     interval_column interval
);

insert into date_time_types
values ('2018-12-31 01:00 EST','2 days'),
       ('2018-12-31 01:00 -8','1 month'),
       ('2018-12-31 01:00 Australia/Melbourne','1 century'),
       (now(),'1 week');
	   
select * from date_time_types;

select
timestamp_column,
interval_column,
timestamp_column - interval_column as new_date
from date_time_types;

select timestamp_column, cast(timestamp_column as varchar(10))
from date_time_types;

select numeric_column,
cast(numeric_column as integer),
cast(numeric_column as varchar(6))
from number_data_types;

-- Cant change letters into integers
-- select cast(char_column as integer) from char_data_types;

-- Chapter 4
create table us_counties_2010 (
    geo_name varchar(90),                    -- Name of the geography
    state_us_abbreviation varchar(2),        -- State/U.S. abbreviation
    summary_level varchar(3),                -- Summary Level
    region smallint,                         -- Region
    division smallint,                       -- Division
    state_fips varchar(2),                   -- State FIPS code
    county_fips varchar(3),                  -- County code
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                        -- Area (Water) in square meters
    population_count_100_percent integer,    -- Population count (100%)
    housing_unit_count_100_percent integer,  -- Housing Unit count (100%)
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)

    -- This section is referred to as P1. Race:
    p0010001 integer,   -- Total population
    p0010002 integer,   -- Population of one race:
    p0010003 integer,       -- White Alone
    p0010004 integer,       -- Black or African American alone
    p0010005 integer,       -- American Indian and Alaska Native alone
    p0010006 integer,       -- Asian alone
    p0010007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0010008 integer,       -- Some Other Race alone
    p0010009 integer,   -- Population of two or more races
    p0010010 integer,   -- Population of two races:
    p0010011 integer,       -- White; Black or African American
    p0010012 integer,       -- White; American Indian and Alaska Native
    p0010013 integer,       -- White; Asian
    p0010014 integer,       -- White; Native Hawaiian and Other Pacific Islander
    p0010015 integer,       -- White; Some Other Race
    p0010016 integer,       -- Black or African American; American Indian and Alaska Native
    p0010017 integer,       -- Black or African American; Asian
    p0010018 integer,       -- Black or African American; Native Hawaiian and Other Pacific Islander
    p0010019 integer,       -- Black or African American; Some Other Race
    p0010020 integer,       -- American Indian and Alaska Native; Asian
    p0010021 integer,       -- American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
    p0010022 integer,       -- American Indian and Alaska Native; Some Other Race
    p0010023 integer,       -- Asian; Native Hawaiian and Other Pacific Islander
    p0010024 integer,       -- Asian; Some Other Race
    p0010025 integer,       -- Native Hawaiian and Other Pacific Islander; Some Other Race
    p0010026 integer,   -- Population of three races
    p0010047 integer,   -- Population of four races
    p0010063 integer,   -- Population of five races
    p0010070 integer,   -- Population of six races

    -- This section is referred to as P2. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    p0020001 integer,   -- Total
    p0020002 integer,   -- Hispanic or Latino
    p0020003 integer,   -- Not Hispanic or Latino:
    p0020004 integer,   -- Population of one race:
    p0020005 integer,       -- White Alone
    p0020006 integer,       -- Black or African American alone
    p0020007 integer,       -- American Indian and Alaska Native alone
    p0020008 integer,       -- Asian alone
    p0020009 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0020010 integer,       -- Some Other Race alone
    p0020011 integer,   -- Two or More Races
    p0020012 integer,   -- Population of two races
    p0020028 integer,   -- Population of three races
    p0020049 integer,   -- Population of four races
    p0020065 integer,   -- Population of five races
    p0020072 integer,   -- Population of six races

    -- This section is referred to as P3. RACE FOR THE POPULATION 18 YEARS AND OVER
    p0030001 integer,   -- Total
    p0030002 integer,   -- Population of one race:
    p0030003 integer,       -- White alone
    p0030004 integer,       -- Black or African American alone
    p0030005 integer,       -- American Indian and Alaska Native alone
    p0030006 integer,       -- Asian alone
    p0030007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0030008 integer,       -- Some Other Race alone
    p0030009 integer,   -- Two or More Races
    p0030010 integer,   -- Population of two races
    p0030026 integer,   -- Population of three races
    p0030047 integer,   -- Population of four races
    p0030063 integer,   -- Population of five races
    p0030070 integer,   -- Population of six races

    -- This section is referred to as P4. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    -- FOR THE POPULATION 18 YEARS AND OVER
    p0040001 integer,   -- Total
    p0040002 integer,   -- Hispanic or Latino
    p0040003 integer,   -- Not Hispanic or Latino:
    p0040004 integer,   -- Population of one race:
    p0040005 integer,   -- White alone
    p0040006 integer,   -- Black or African American alone
    p0040007 integer,   -- American Indian and Alaska Native alone
    p0040008 integer,   -- Asian alone
    p0040009 integer,   -- Native Hawaiian and Other Pacific Islander alone
    p0040010 integer,   -- Some Other Race alone
    p0040011 integer,   -- Two or More Races
    p0040012 integer,   -- Population of two races
    p0040028 integer,   -- Population of three races
    p0040049 integer,   -- Population of four races
    p0040065 integer,   -- Population of five races
    p0040072 integer,   -- Population of six races

    -- This section is referred to as H1. OCCUPANCY STATUS
    h0010001 integer,   -- Total housing units
    h0010002 integer,   -- Occupied
    h0010003 integer    -- Vacant
);

-- See table structure
select * from us_counties_2010;

-- Run this line of code in the SQL shell
copy us_counties_2010 from 'C:\Users\User\Desktop\SQL\Analysis\us_counties_2010.csv' with (FORMAT csv, header);

-- See table with contents
select * from us_counties_2010;

select geo_name, state_us_abbreviation, area_land
from us_counties_2010
order by area_land desc
limit 3;

select geo_name, state_us_abbreviation, internal_point_lon
from us_counties_2010
order by internal_point_lon desc
limit 5;

create table supervisor_salaries (
    town varchar(30),
    county varchar(30),
    supervisor varchar(30),
    start_date date,
    salary money,
    benefits money
);

-- See table structure
select * from supervisor_salaries;

-- Run this line of code in the SQL shell
copy supervisor_salaries (town, supervisor, salary) from 'C:\Users\User\Desktop\SQL\Analysis\supervisor_salaries.csv' with (FORMAT csv, header);

-- See table with contents
select * from supervisor_salaries;

-- Clears all the data in the table
delete from supervisor_salaries;

-- Create a temporary table that is the same collums as the supervisors_salaries table
create temporary table supervisor_salaries_temp (like supervisor_salaries);

-- Copy all the information of the salaries file into the temporary table and run in SQL shell
copy supervisor_salaries_temp (town, supervisor, salary) from 'C:\Users\User\Desktop\SQL\Analysis\supervisor_salaries.csv' with (FORMAT csv, header);

-- See the temp table with all the same data
select * from supervisor_salaries_temp;

-- Insert a new town into the supervisor_salaries and getting the data from the temp table
insert into supervisor_salaries (town, county, supervisor, salary)
select town, 'Some County', supervisor, salary
from supervisor_salaries_temp;

-- Remove the temp table
drop table supervisor_salaries_temp;

-- See table with new contents from the temp table
select * from supervisor_salaries;

-- Create a temporary table that is the same collums as the supervisors_salaries table
create temporary table supervisor_salaries_temp (like supervisor_salaries);

-- Copy all the information of the salaries file into the temporary table and run in SQL shell
copy supervisor_salaries_temp (town, supervisor, salary) from 'C:\Users\User\Desktop\SQL\Analysis\supervisor_salaries.csv' with (FORMAT csv, header);

-- See the temp table with all the same data
select * from supervisor_salaries_temp;

-- Insert a start date into the supervisor_salaries
insert into supervisor_salaries (town, county, supervisor, start_date, salary, benefits)
select town, 'Some County', supervisor, '2022/03/08', salary, '$1000'
from supervisor_salaries_temp;

-- See table with new contents from the temp table
select * from supervisor_salaries;

-- Export an entire to county export table with COPY
copy us_counties_2010
to 'C:\Users\User\Desktop\SQL\Analysis\us_counties_export.txt'
with (FORMAT csv, header, delimiter '|');

-- Exporting selected columns from a table to county export with COPY
copy us_counties_2010 (geo_name, internal_point_lat, internal_point_lon)
to 'C:\Users\User\Desktop\SQL\Analysis\us_counties_export.txt'
with (FORMAT csv, header, delimiter '|');

-- Exporting query results to county export with COPY
copy (
    select geo_name, state_us_abbreviation
    from us_counties_2010
    where geo_name ilike '%mill%'
     )
to 'C:\Users\User\Desktop\SQL\Analysis\us_counties_mill_export.txt'
with (FORMAT csv, header, delimiter '|');

-- Export an entire table to salaries export with COPY
copy supervisor_salaries
to 'C:\Users\User\Desktop\SQL\Analysis\supervisor_salaries_export.txt'
with (FORMAT csv, header, delimiter '|');

-- Chapter 5

-- Basic addition, subtraction and multiplication with SQL
select 2 + 2;    -- addition
select 9 - 1;    -- subtraction
select 3 * 4;    -- multiplication

-- Integer and decimal division with SQL
select 11 / 6;   -- integer division
select 11 % 6;   -- modulo division
select 11.0 / 6; -- decimal division
select cast(11 as numeric(3,1)) / 6;

-- Exponents, roots and factorials with SQL
select 3 ^ 4;         -- exponentiation
select |/ 10;         -- square root (operator)
select sqrt(10);      -- square root (function)
select ||/ 10;        -- cube root
-- select 4 !;           -- factorial (operator; PostgreSQL 13 and earlier only)
select factorial(4);  -- factorial (function)

-- Order of operations
select 7 + 8 * 9; 	-- answer: 79
select (7 + 8) * 9;	-- answer: 135
select 3 ^ 3 - 1;   -- answer: 26
select 3 ^ (3 - 1); -- answer: 9

-- Selecting Census population columns by race with aliases
select geo_name,
       state_us_abbreviation as "st",
       p0010001 as "Total Population",
       p0010003 as "White Alone",
       p0010004 as "Black or African American Alone",
       p0010005 as "Am Indian/Alaska Native Alone",
       p0010006 as "Asian Alone",
       p0010007 as "Native Hawaiian and Other Pacific Islander Alone",
       p0010008 as "Some Other Race Alone",
       p0010009 as "Two or More Races"
from us_counties_2010;

-- Adding two columns in us_counties_2010
select geo_name,
       state_us_abbreviation as "st",
       p0010003 as "White Alone",
       p0010004 as "Black Alone",
       p0010003 + p0010004 as "Total White and Black"
from us_counties_2010;

-- Checking Census data totals
select geo_name,
       state_us_abbreviation as "st",
       p0010001 as "Total",
       p0010003 + p0010004 + p0010005 + p0010006 + p0010007
           + p0010008 + p0010009 as "All Races",
       (p0010003 + p0010004 + p0010005 + p0010006 + p0010007
           + p0010008 + p0010009) - p0010001 as "Difference"
from us_counties_2010
order by "Difference" desc;

-- Calculating the percent of the population that is 
-- Asian by county (percent of the whole)
select geo_name,
       state_us_abbreviation as "st",
       (cast(p0010006 as numeric(8,1)) / p0010001) * 100 as "pct_asian"
from us_counties_2010
order by "pct_asian" desc;

-- Calculating percent change
create table percent_change (
    department varchar(20),
    spend_2014 numeric(10,2),
    spend_2017 numeric(10,2)
);

insert into percent_change
values
    ('Building', 250000, 289000),
    ('Assessor', 178556, 179500),
    ('Library', 87777, 90001),
    ('Clerk', 451980, 650000),
    ('Police', 250000, 223000),
    ('Recreation', 199000, 195000);
	
select department,
       spend_2014,
       spend_2017,
       round( (spend_2017 - spend_2014) /
                    spend_2014 * 100, 1 ) as "pct_change"
from percent_change;

-- Using sum() and avg() aggregate functions
select sum(p0010001) as "County Sum",
       round(avg(p0010001), 0) as "County Average"
from us_counties_2010;

-- Testing SQL percentile functions
create table percentile_test (
    numbers integer
);

insert into percentile_test (numbers) values
    (1), (2), (3), (4), (5), (6);
	
select
    percentile_cont(.5)
    within group (order by numbers),
    percentile_disc(.5)
    within group (order by numbers)
from percentile_test;

-- Using sum(), avg(), and percentile_cont() aggregate functions
select sum(p0010001) as "County Sum",
       round(avg(p0010001), 0) as "County Average",
       percentile_cont(.5)
       within group (order by p0010001) as "County Median"
from us_counties_2010;

-- Using sum(), avg(), and percentile_cont() aggregate functions
select sum(p0010001) as "County Sum",
       round(avg(p0010001), 0) as "County Average",
       percentile_cont(.5)
       within group (order by p0010001) as "County Median"
from us_counties_2010;

-- Listing 5-12: Passing an array of values to percentile_cont()
-- quartiles
select percentile_cont(array[.25,.5,.75])
       within group (order by p0010001) as "quartiles"
from us_counties_2010;
-- Extra:
-- quintiles
select percentile_cont(.25)
       within group (order by p0010001) as "First quintile",
	   percentile_cont(.5)
	   within group (order by p0010001) as "Second quintile",
	   percentile_cont(.75)
	   within group (order by p0010001) as "Third quintile"
from us_counties_2010;
-- deciles
select percentile_cont(array[.1,.2,.3,.4,.5,.6,.7,.8,.9])
       within group (order by p0010001) as "deciles"
from us_counties_2010;

-- Using unnest() to turn an array into rows
select unnest(
            percentile_cont(array[.25,.5,.75])
            within group (order by p0010001)
            ) as "quartiles"
from us_counties_2010;

-- Chapter 6

-- Creating the departments and employees tables
create table departments (
    dept_id bigserial,
    dept varchar(100),
    city varchar(100),
    constraint dept_key primary key (dept_id),
    constraint dept_city_unique unique (dept, city)
);

create table employees (
    emp_id bigserial,
    first_name varchar(100),
    last_name varchar(100),
    salary integer,
    dept_id integer references departments (dept_id), -- foreign key collum
    constraint emp_key primary key (emp_id),
    constraint emp_dept_unique unique (emp_id, dept_id)
);

insert into departments (dept, city)
values
    ('Tax', 'Atlanta'),
    ('IT', 'Boston');

insert into employees (first_name, last_name, salary, dept_id)
values
    ('Nancy', 'Jones', 62500, 1),
    ('Lee', 'Smith', 59300, 1),
    ('Soo', 'Nguyen', 83000, 2),
    ('Janet', 'King', 95000, 2);
	
-- See if all values were added into the tables
select * from departments;
select * from employees;

-- Joining the employees and departments tables
select *
from employees join departments
on employees.dept_id = departments.dept_id;

-- Creating two tables to explore JOIN types
create table schools_left (
    id integer constraint left_id_key primary key,
    left_school varchar(30)
);

create table schools_right (
    id integer constraint right_id_key primary key,
    right_school varchar(30)
);

insert into schools_left (id, left_school) values
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Washington Middle School'),
    (6, 'Jefferson High School');
	
insert into schools_right (id, right_school) values
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Jefferson High School');

-- See if all values were added into the tables
select * from schools_left;
select * from schools_right;

-- Using JOIN
select *
from schools_left join schools_right
on schools_left.id = schools_right.id;

-- Using inner JOIN
select *
from schools_left inner join schools_right
on schools_left.id = schools_right.id;

-- Using LEFT JOIN
select *
from schools_left left join schools_right
on schools_left.id = schools_right.id;

-- Using RIGHT JOIN
select *
from schools_left right join schools_right
on schools_left.id = schools_right.id;

-- Using FULL OUTER JOIN
select *
from schools_left full outer join schools_right
on schools_left.id = schools_right.id;

-- Using CROSS JOIN
select *
from schools_left cross join schools_right;

-- Filtering to show missing values with IS NULL
select *
from schools_left right join schools_right
on schools_left.id = schools_right.id
where schools_left.id is null;

-- Querying specific columns in a join
select schools_left.id,
       schools_left.left_school,
       schools_right.right_school
from schools_left left join schools_right
on schools_left.id = schools_right.id;

-- Simplifying code with table aliases
select lt.id,
       lt.left_school,
       rt.right_school
from schools_left as lt left join schools_right as rt
on lt.id = rt.id;

-- Joining multiple tables
create table schools_enrollment (
    id integer,
    enrollment integer
);

create table schools_grades (
    id integer,
    grades varchar(10)
);

insert into schools_enrollment (id, enrollment)
values
    (1, 360),
    (2, 1001),
    (5, 450),
    (6, 927);

insert into schools_grades (id, grades)
values
    (1, 'K-3'),
    (2, '9-12'),
    (5, '6-8'),
    (6, '9-12');

select lt.id, lt.left_school, en.enrollment, gr.grades
from schools_left as lt left join schools_enrollment as en
    on lt.id = en.id
left join schools_grades as gr
    on lt.id = gr.id;

-- Performing math on joined Census tables
-- Decennial Census 2000. Full data dictionary at https://www.census.gov/prod/cen2000/doc/pl94-171.pdf
-- Note: Some non-number columns have been given more descriptive names
create table us_counties_2000 (
    geo_name varchar(90),              -- County/state name,
    state_us_abbreviation varchar(2),  -- State/U.S. abbreviation
    state_fips varchar(2),             -- State FIPS code
    county_fips varchar(3),            -- County code
    p0010001 integer,                  -- Total population
    p0010002 integer,                  -- Population of one race:
    p0010003 integer,                      -- White Alone
    p0010004 integer,                      -- Black or African American alone
    p0010005 integer,                      -- American Indian and Alaska Native alone
    p0010006 integer,                      -- Asian alone
    p0010007 integer,                      -- Native Hawaiian and Other Pacific Islander alone
    p0010008 integer,                      -- Some Other Race alone
    p0010009 integer,                  -- Population of two or more races
    p0010010 integer,                  -- Population of two races
    p0020002 integer,                  -- Hispanic or Latino
    p0020003 integer                   -- Not Hispanic or Latino:
);

copy us_counties_2000
from 'C:\Users\User\Desktop\SQL\Analysis\us_counties_2000.csv'
with (FORMAT csv, header);

select c2010.geo_name,
       c2010.state_us_abbreviation as state,
       c2010.p0010001 as pop_2010,
       c2000.p0010001 as pop_2000,
       c2010.p0010001 - c2000.p0010001 as raw_change,
       round((cast(c2010.p0010001 as numeric) - c2000.p0010001)
           / c2000.p0010001 * 100, 1 ) as pct_change
from us_counties_2010 c2010 inner join us_counties_2000 c2000
on c2010.state_fips = c2000.state_fips
   and c2010.county_fips = c2000.county_fips
   and c2010.p0010001 <> c2000.p0010001
order by pct_change desc;

-- Chapter 7

-- Declaring a single-column natural key as primary key
-- As a column constraint
create table natural_key_example (
    license_id varchar(10) constraint license_key primary key,
    first_name varchar(50),
    last_name varchar(50)
);

-- Drop the table before trying again
drop table natural_key_example;

-- As a table constraint
create table natural_key_example (
    license_id varchar(10),
    first_name varchar(50),
    last_name varchar(50),
    constraint license_key primary key (license_id)
);

-- Example of a primary key violation
insert into natural_key_example (license_id, first_name, last_name)
values ('T229901', 'Lynn', 'Malero');

-- Will not work because there is all ready one of the license id and you cannot have two
-- insert into natural_key_example (license_id, first_name, last_name)
-- values ('T229901', 'Sam', 'Tracy');

-- Declaring a composite primary key as a natural key
create table natural_key_composite_example (
    student_id varchar(10),
    school_day date,
    present boolean,
    constraint student_key primary key (student_id, school_day)
);

-- Example of a composite primary key violation
insert into natural_key_composite_example (student_id, school_day, present)
values(775, '1/22/2017', 'Y');

insert into natural_key_composite_example (student_id, school_day, present)
values(775, '1/23/2017', 'Y');

-- Will not work because the date is the same and you cant be present and 
-- not present on the same day
-- insert into natural_key_composite_example (student_id, school_day, present)
-- values(775, '1/23/2017', 'N');

-- Declaring a bigserial column as a surrogate key
create table surrogate_key_example (
    order_number bigserial,
    product_name varchar(50),
    order_date date,
    constraint order_key primary key (order_number)
);

insert into surrogate_key_example (product_name, order_date)
values ('Beachball Polish', '2015-03-17'),
       ('Wrinkle De-Atomizer', '2017-05-22'),
       ('Flux Capacitor', '1985-10-26');

select * from surrogate_key_example;

-- A foreign key example
create table licenses (
    license_id varchar(10),
    first_name varchar(50),
    last_name varchar(50),
    constraint licenses_key primary key (license_id)
);

create table registrations (
    registration_id varchar(10),
    registration_date date,
    license_id varchar(10) references licenses (license_id),
    constraint registration_key primary key (registration_id, license_id)
);

insert into licenses (license_id, first_name, last_name)
values ('T229901', 'Lynn', 'Malero');

insert into registrations (registration_id, registration_date, license_id)
values ('A203391', '3/17/2017', 'T229901');

-- The lisence ID does not show in the primary key
-- insert into registrations (registration_id, registration_date, license_id)
-- values ('A75772', '3/17/2017', 'T000001');

-- CHECK constraint examples
create table check_constraint_example (
    user_id bigserial,
    user_role varchar(50),
    salary integer,
    constraint user_id_key primary key (user_id),
    constraint check_role_in_list check (user_role in('Admin', 'Staff')),
    constraint check_salary_not_zero check (salary > 0)
);

-- Both of these will fail:
-- will not work because it is case sensitive
-- insert into check_constraint_example (user_role)
-- values ('admin');

-- The salary cannot be set to 0
-- insert into check_constraint_example (salary)
-- values (0);

-- UNIQUE constraint example
create table unique_constraint_example (
    contact_id bigserial constraint contact_id_key primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(200),
    constraint email_unique unique (email)
);

insert into unique_constraint_example (first_name, last_name, email)
values ('Samantha', 'Lee', 'slee@example.org');

insert into unique_constraint_example (first_name, last_name, email)
values ('Betty', 'Diaz', 'bdiaz@example.org');

-- The email alrady exists so it will not work
-- insert into unique_constraint_example (first_name, last_name, email)
-- values ('Sasha', 'Lee', 'slee@example.org');

--NOT NULL constraint example
create table not_null_example (
    student_id bigserial,
    first_name varchar(50) not NULL,
    last_name varchar(50) not NULL,
    constraint student_id_key primary key (student_id)
);

-- Dropping and adding a primary key and a NOT NULL constraint

-- Droping constraint from the table
alter table not_null_example drop constraint student_id_key;

-- Adding constraint to the table
alter table not_null_example add constraint student_id_key primary key (student_id);

-- Droping constraint in one collum
alter table not_null_example alter column first_name drop not NULL;

-- Adding constraint into one collum
alter table not_null_example alter column first_name set not NULL;

-- Importing New York City address data
create table new_york_addresses (
    longitude numeric(9,6),
    latitude numeric(9,6),
    street_number varchar(10),
    street varchar(32),
    unit varchar(7),
    postcode varchar(5),
    id integer constraint new_york_key primary key
);

copy new_york_addresses
from 'C:\Users\User\Desktop\SQL\Analysis\city_of_new_york.csv'
with (FORMAT csv, header);

-- Benchmark queries for index performance
explain analyze select * from new_york_addresses
where street = 'BROADWAY';

explain analyze select * from new_york_addresses
WHERE street = '52 STREET';

explain analyze select * from new_york_addresses
where street = 'ZWICKY AVENUE';

-- Creating a B-Tree index on the new_york_addresses table
-- Decreases the time it takes to get the infromation from analysis
create index street_idx on new_york_addresses (street);

-- Deletes the index
drop index street_idx;

-- Chapter 8

-- Creating and filling the 2014 Public Libraries Survey table
create table pls_fy2014_pupld14a (
    stabr varchar(2) not NULL,
    fscskey varchar(6) constraint fscskey2014_key primary key,
    libid varchar(20) not NULL,
    libname varchar(100) not NULL,
    obereg varchar(2) not NULL,
    rstatus integer not NULL,
    statstru varchar(2) not NULL,
    statname varchar(2) not NULL,
    stataddr varchar(2) not NULL,
    longitud numeric(10,7) not NULL,
    latitude numeric(10,7) not NULL,
    fipsst varchar(2) not NULL,
    fipsco varchar(3) not NULL,
    address varchar(35) not NULL,
    city varchar(20) not NULL,
    zip varchar(5) not NULL,
    zip4 varchar(4) not NULL,
    cnty varchar(20) not NULL,
    phone varchar(10) not NULL,
    c_relatn varchar(2) not NULL,
    c_legbas varchar(2) not NULL,
    c_admin varchar(2) not NULL,
    geocode varchar(3) not NULL,
    lsabound varchar(1) not NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer not NULL,
    centlib integer not NULL,
    branlib integer not NULL,
    bkmob integer not NULL,
    master numeric(8,2) not NULL,
    libraria numeric(8,2) not NULL,
    totstaff numeric(8,2) not NULL,
    locgvt integer not NULL,
    stgvt integer not NULL,
    fedgvt integer not NULL,
    totincm integer not NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer not NULL,
    elmatexp integer not NULL,
    totexpco integer not NULL,
    totopexp integer not NULL,
    lcap_rev integer not NULL,
    scap_rev integer not NULL,
    fcap_rev integer not NULL,
    cap_rev integer not NULL,
    capital integer not NULL,
    bkvol integer not NULL,
    ebook integer not NULL,
    audio_ph integer not NULL,
    audio_dl float not NULL,
    video_ph integer not NULL,
    video_dl float not NULL,
    databases integer not NULL,
    subscrip integer not NULL,
    hrs_open integer not NULL,
    visits integer not NULL,
    referenc integer not NULL,
    regbor integer not NULL,
    totcir integer not NULL,
    kidcircl integer not NULL,
    elmatcir integer not NULL,
    loanto integer not NULL,
    loanfm integer not NULL,
    totpro integer not NULL,
    totatten integer not NULL,
    gpterms integer not NULL,
    pitusr integer not NULL,
    wifisess integer not NULL,
    yr_sub integer not NULL
);

create index libname2014_idx on pls_fy2014_pupld14a (libname);
create index stabr2014_idx on pls_fy2014_pupld14a (stabr);
create index city2014_idx on pls_fy2014_pupld14a (city);
create index visits2014_idx on pls_fy2014_pupld14a (visits);

copy pls_fy2014_pupld14a from 'C:\Users\User\Desktop\SQL\Analysis\pls_fy2014_pupld14a.csv' with (FORMAT csv, header);

-- Check the contents of the table
select * from pls_fy2014_pupld14a;

-- Creating and filling the 2009 Public Libraries Survey table
create table pls_fy2009_pupld09a (
    stabr varchar(2) not NULL,
    fscskey varchar(6) constraint fscskey2009_key primary key,
    libid varchar(20) not NULL,
    libname varchar(100) not NULL,
    address varchar(35) not NULL,
    city varchar(20) not NULL,
    zip varchar(5) not NULL,
    zip4 varchar(4) not NULL,
    cnty varchar(20) not NULL,
    phone varchar(10) not NULL,
    c_relatn varchar(2) not NULL,
    c_legbas varchar(2) not NULL,
    c_admin varchar(2) not NULL,
    geocode varchar(3) not NULL,
    lsabound varchar(1) not NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer not NULL,
    centlib integer not NULL,
    branlib integer not NULL,
    bkmob integer not NULL,
    master numeric(8,2) not NULL,
    libraria numeric(8,2) not NULL,
    totstaff numeric(8,2) not NULL,
    locgvt integer not NULL,
    stgvt integer not NULL,
    fedgvt integer not NULL,
    totincm integer not NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer not NULL,
    elmatexp integer not NULL,
    totexpco integer not NULL,
    totopexp integer not NULL,
    lcap_rev integer not NULL,
    scap_rev integer not NULL,
    fcap_rev integer not NULL,
    cap_rev integer not NULL,
    capital integer not NULL,
    bkvol integer not NULL,
    ebook integer not NULL,
    audio integer not NULL,
    video integer not NULL,
    databases integer not NULL,
    subscrip integer not NULL,
    hrs_open integer not NULL,
    visits integer not NULL,
    referenc integer not NULL,
    regbor integer not NULL,
    totcir integer not NULL,
    kidcircl integer not NULL,
    loanto integer not NULL,
    loanfm integer not NULL,
    totpro integer not NULL,
    totatten integer not NULL,
    gpterms integer not NULL,
    pitusr integer not NULL,
    yr_sub integer not NULL,
    obereg varchar(2) not NULL,
    rstatus integer not NULL,
    statstru varchar(2) not NULL,
    statname varchar(2) not NULL,
    stataddr varchar(2) not NULL,
    longitud numeric(10,7) not NULL,
    latitude numeric(10,7) not NULL,
    fipsst varchar(2) not NULL,
    fipsco varchar(3) not NULL
);

create index libname2009_idx on pls_fy2009_pupld09a (libname);
create index stabr2009_idx on pls_fy2009_pupld09a (stabr);
create index city2009_idx on pls_fy2009_pupld09a (city);
create index visits2009_idx on pls_fy2009_pupld09a (visits);

copy pls_fy2009_pupld09a from 'C:\Users\User\Desktop\SQL\Analysis\pls_fy2009_pupld09a.csv' with (FORMAT csv, header);

-- Check the contents of the table
select * from pls_fy2009_pupld09a;

-- Using count() for table row counts
select count(*)
from pls_fy2014_pupld14a;

select count(*)
from pls_fy2009_pupld09a;

-- Using count() for the number of values in a column
select count(salaries)
from pls_fy2014_pupld14a;

-- Using count() for the number of distinct values in a column
select count(libname)
from pls_fy2014_pupld14a;

-- Does not count duplicates
select count(distinct libname)
from pls_fy2014_pupld14a;

-- Find duplicate libnames
select libname, count(libname)
from pls_fy2014_pupld14a
group by libname
order by count(libname) desc;

-- See location of every Oxford Public Library
select libname, city, stabr
from pls_fy2014_pupld14a
where libname = 'OXFORD PUBLIC LIBRARY';

-- Finding the most and fewest visits using max() and min()
select max(visits), min(visits)
from pls_fy2014_pupld14a;

-- Using GROUP BY on the stabr column
-- There are 56 in 2014.
select stabr
from pls_fy2014_pupld14a
group by stabr
order by stabr;

-- There are 55 in 2009 and shows which state shows up the most in the tables
select stabr, count(stabr)
from pls_fy2009_pupld09a
group by stabr
order by count(stabr) desc;

-- Using GROUP BY on the city and stabr columns
select city, stabr
from pls_fy2014_pupld14a
group by city, stabr
order by city, stabr;

-- We can count some of the combos
select city, stabr, count(*)
from pls_fy2014_pupld14a
group by city, stabr
order by count(*) desc;

-- GROUP BY with count() on the stabr column
select stabr, count(*)
from pls_fy2014_pupld14a
group by stabr
order by count(*) desc;

-- GROUP BY with count() on the stabr and stataddr columns
select stabr, stataddr, count(*)
from pls_fy2014_pupld14a
group by stabr, stataddr
order by stabr asc, count(*) desc;

-- Using the sum() aggregate function to total visits to
-- libraries in 2014 and 2009
-- 2014
select sum(visits) as visits_2014
from pls_fy2014_pupld14a
where visits >= 0;

-- 2009
select sum(visits) as visits_2009
from pls_fy2009_pupld09a
where visits >= 0;

-- Using sum() to total visits on joined 2014 and 2009 library tables and show the difference
select sum(pls14.visits) as visits_2014,
       sum(pls09.visits) as visits_2009,
	   (sum(pls14.visits) - sum(pls09.visits)) as differance
from pls_fy2014_pupld14a as pls14 join pls_fy2009_pupld09a as pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0 and pls09.visits >= 0;

-- Using GROUP BY to track percent change in library visits by state
select pls14.stabr,
       sum(pls14.visits) as visits_2014,
       sum(pls09.visits) as visits_2009,
       round( (cast(sum(pls14.visits) as decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) as pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0 and pls09.visits >= 0
group by pls14.stabr
order by pct_change desc;

-- Using HAVING to filter the results of an aggregate query
select pls14.stabr,
       sum(pls14.visits) as visits_2014,
       sum(pls09.visits) as visits_2009,
       round( (cast(sum(pls14.visits) as decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) AS pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0 and pls09.visits >= 0
group by pls14.stabr
having sum(pls14.visits) > 50000000
order by pct_change desc;

-- Chapter 9
-- Importing the FSIS Meat, Poultry, and Egg Inspection Directory
-- https://catalog.data.gov/dataset/meat-poultry-and-egg-inspection-directory-by-establishment-name
create table meat_poultry_egg_inspect (
    est_number varchar(50) constraint est_number_key primary key,
    company varchar(100),
    street varchar(100),
    city varchar(30),
    st varchar(2),
    zip varchar(5),
    phone varchar(14),
    grant_date date,
    activities text,
    dbas text
);

copy meat_poultry_egg_inspect
from 'C:\Users\User\Desktop\SQL\Analysis\MPI_Directory_by_Establishment_Name.csv'
with (FORMAT csv, header, delimiter ',');

create index company_idx on meat_poultry_egg_inspect (company);

-- Count the rows imported:
select count(*) from meat_poultry_egg_inspect;

-- Finding multiple companies at the same address
select company,
       street,
       city,
       st,
       count(*) as address_count
from meat_poultry_egg_inspect
group by company, street, city, st
having count(*) > 1
order by company, street, city, st;

-- Grouping and counting states
select st, 
       count(*) as st_count
from meat_poultry_egg_inspect
group by st
order by st;

-- Using IS NULL to find missing values in the st column
select est_number,
       company,
       city,
       st,
       zip
from meat_poultry_egg_inspect
where st is NULL;

-- Using GROUP BY and count() to find inconsistent company names
select company,
       count(*) as company_count
from meat_poultry_egg_inspect
group by company
order by company asc;

-- Using length() and count() to test the zip column
select length(zip),
       count(*) as length_count
from meat_poultry_egg_inspect
group by length(zip)
order by length(zip) asc;

-- Filtering with length() to find short zip values
select st,
       count(*) as st_count
from meat_poultry_egg_inspect
where length(zip) < 5
group by st
order by st asc;

-- Backing up a table
create table meat_poultry_egg_inspect_backup as
select * from meat_poultry_egg_inspect;

-- Check number of records:
select 
    (select count(*) from meat_poultry_egg_inspect) as original,
    (select count(*) from meat_poultry_egg_inspect_backup) as backup;
	
-- Creating and filling the st_copy column with ALTER TABLE and UPDATE
alter table meat_poultry_egg_inspect add column st_copy varchar(2);

update meat_poultry_egg_inspect
set st_copy = st;

-- Checking values in the st and st_copy columns
select st,
       st_copy
from meat_poultry_egg_inspect
order by st;

-- Updating the st column for three establishments
update meat_poultry_egg_inspect
set st = 'MN'
where est_number = 'V18677A';

update meat_poultry_egg_inspect
set st = 'AL'
where est_number = 'M45319+P45319';

update meat_poultry_egg_inspect
set st = 'WI'
where est_number = 'M263A+P263A+V263A';

-- Restoring original st column values
-- Restoring from the column backup
update meat_poultry_egg_inspect
set st = st_copy;

-- Restoring from the table backup
update meat_poultry_egg_inspect original
set st = backup.st
from meat_poultry_egg_inspect_backup backup
where original.est_number = backup.est_number;

-- Creating and filling the company_standard column
alter table meat_poultry_egg_inspect add column company_standard varchar(100);

update meat_poultry_egg_inspect
set company_standard = company;

-- Use UPDATE to modify field values that match a string
update meat_poultry_egg_inspect
set company_standard = 'Armour-Eckrich Meats'
where company like 'Armour%';

select company, company_standard
from meat_poultry_egg_inspect
where company like 'Armour%';

-- Creating and filling the zip_copy column
alter table meat_poultry_egg_inspect add column zip_copy varchar(5);

update meat_poultry_egg_inspect
set zip_copy = zip;

-- Modify codes in the zip column missing two leading zeros
update meat_poultry_egg_inspect
set zip = '00' || zip
where st in('PR','VI') and length(zip) = 3;

-- Modify codes in the zip column missing one leading zero
update meat_poultry_egg_inspect
set zip = '0' || zip
where st in('CT','MA','ME','NH','NJ','RI','VT') and length(zip) = 4;

-- Creating and filling a state_regions table
create table state_regions (
    st varchar(2) constraint st_key primary key,
    region varchar(20) not NULL
);

copy state_regions
from 'C:\Users\User\Desktop\SQL\Analysis\state_regions.csv'
with (FORMAT csv, header, delimiter ',');

-- Adding and updating an inspection_date column
alter table meat_poultry_egg_inspect add column inspection_date date;

update meat_poultry_egg_inspect inspect
set inspection_date = '2019-12-01'
where exists (select state_regions.region
              from state_regions
              where inspect.st = state_regions.st 
                    and state_regions.region = 'New England');
					
-- Viewing updated inspection_date values
select st, inspection_date
from meat_poultry_egg_inspect
group by st, inspection_date
order by st;

-- Delete rows matching an expression
delete from meat_poultry_egg_inspect
where st in('PR','VI');

-- Remove a column from a table using DROP
alter table meat_poultry_egg_inspect drop column zip_copy;

-- Remove a table from a database using DROP
drop table meat_poultry_egg_inspect_backup;

-- Demonstrating a transaction block
-- Start transaction and perform update
start transaction;

update meat_poultry_egg_inspect
set company = 'AGRO Merchantss Oakland LLC'
where company = 'AGRO Merchants Oakland, LLC';

-- view changes
select company
from meat_poultry_egg_inspect
where company like 'AGRO%'
order by company;

-- Revert changes
ROLLBACK;

-- See restored state
select company
from meat_poultry_egg_inspect
where company like 'AGRO%'
order by company;

-- Alternately, commit changes at the end:
start transaction;

update meat_poultry_egg_inspect
set company = 'AGRO Merchants Oakland LLC'
where company = 'AGRO Merchants Oakland, LLC';

commit;

-- Backing up a table while adding and filling a new column
create table meat_poultry_egg_inspect_backup as
select *,
       '2018-02-07'::date as reviewed_date
from meat_poultry_egg_inspect;

-- Swapping table names using ALTER TABLE
alter table meat_poultry_egg_inspect rename to meat_poultry_egg_inspect_temp;
alter table meat_poultry_egg_inspect_backup rename to meat_poultry_egg_inspect;
alter table meat_poultry_egg_inspect_temp rename to meat_poultry_egg_inspect_backup;
