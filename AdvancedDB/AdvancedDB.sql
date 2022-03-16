create database AdvancedDB;

-- 1) Checking Profession duplications
select prof_id, count(prof_id)
from my_contacts
group by prof_id
having count(prof_id)> 1
order by prof_id;

-- 2) Delete duplicate intrest rows in table
delete from intrests
where intrest in
(select intrest
from
(select intrest,
row_number() over(partition by intrest
order by intrests) as row_num
from intrests) t
where t.row_num > 1);

-- 3) Create commands that set up tables 
create table my_contacts (
    contact_id bigserial constraint contact_id_key primary key,
    last_name varchar(20) not null,
    first_name varchar(100) not null,
    phone varchar(15) not null,
    email varchar(50) not null constraint email_constraint unique,
    gender varchar(50) not null, 
    birthday varchar(100) not null,
    prof_id integer not null references profession (prof_id),
    zip_code integer not null references zip_code (zip_code),
    status_id integer not null references status (status_id)
);

create table profession (
    prof_id bigserial constraint prof_id_key primary key,
    profession varchar(25) not null,
	constraint unique_profession unique (profession)
);

create table zip_code (
    zip_code integer constraint zip_code_key primary key,
    city varchar(25) not null,
    province varchar(25) not null,
	constraint check_zip_code check (length(zip_code::varchar(100)) < 5)
);

create table status (
    status_id bigserial constraint status_id_key primary key,
    status varchar(25) not null
);

create table contact_intrest (
    contact_id bigserial references my_contacts (contact_id),
    intrest_id integer references intrests (intrest_id)
);

create table contact_seeking (
    contact_id bigserial references my_contacts (contact_id),
    seeking_id integer references seeking (seeking_id)
);

create table intrests (
    intrest_id bigserial constraint intrest_id_key primary key,
    intrest varchar(250) not null
);

create table seeking (
    seeking_id bigserial constraint seeking_id_key primary key,
    seeking varchar(250) not null
);

-- 4) Insert data into the created tables
insert into profession (profession)
values 	
        ('Engineer'),
		('Accountant'),
		('Professor'),
		('Docter'),
		('Mechanic'),
		('Cleric'),
		('Office-assistant'),
		('Studing'),
		('Farmer'),
		('Scientist');
		
insert into zip_code (zip_code, city, province)
values 	
        (0011, 'Pretoria', 'Guateng'),
		(2019, 'Johannesburg', 'Guateng'),
		(7103, 'Cape-Town', 'Western-Cape'),
		(6529, 'George', 'Western-Cape'),
		(8460, 'Kuruman', 'Northern-Cape'),
		(8300, 'Kimberley', 'Northern-Cape'),
		(5207, 'East-London', 'Eastern-Cape'),
		(4930, 'Stutterheim', 'Eastern-Cape'),
		(9307, 'Bloemfontein', 'Freestate'),
		(9700, 'Bethlehem', 'Freestate'),
		(2680, 'Christiana', 'North-West'),
		(2660, 'Bloemhof', 'North-West'),
		(0700, 'Polokwane', 'Limpopo'),
		(0900, 'Musina', 'Limpopo'),
		(1201, 'Mbombela', 'Mpumalanga'),
		(1100, 'Belfast', 'Mpumalanga'),
		(4000, 'Durban', 'KwaZulu-Natal'),
		(2940, 'Newcastle', 'KwaZulu-Natal');
		
insert into status (status)
values 	
        ('Matched'),
		('Searching'),
		('Stopped'),
		('Suspended'),
		('Inactive');
		
insert into my_contacts (last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id)
values
        ('Alford','Destiny','025-595-5549','congue.elit@protonmail.com','Male','Feb 1, 2009',8,7103,3),
        ('Simpson','Kitra','036-571-8723','neque.sed@yahoo.org','Female','Sep 12, 2004',8,4000,3),
        ('Wheeler','Quintessa','066-821-4276','dapibus.quam@aol.couk','Male','Dec 11, 2005',1,1201,5),
        ('Briggs','Haley','032-558-5438','nulla.cras.eu@aol.couk','Male','May 12, 2006',8,0900,4),
        ('Castaneda','Ciaran','015-287-6728','facilisis@outlook.ca','Female','Oct 11, 2006',5,6529,5),
        ('Cook','Joel','048-193-1136','erat.eget@icloud.couk','Female','Feb 11, 2005',2,2940,3),
        ('David','Plato','025-521-4829','ornare@hotmail.com','Female','Aug 2, 2005',8,2680,1),
        ('Dickerson','Branden','078-965-8009','nulla.facilisi@aol.ca','Female','Aug 16, 2009',2,0700,2),
        ('Watson','Fuller','034-655-8078','risus.quisque@protonmail.couk','Male','Feb 16, 2007',7,1100,4),
        ('House','Joel','056-857-8369','a.arcu@icloud.net','Female','Sep 26, 2007',8,9700,2),
        ('Pate','Kelly','086-114-1987','purus.maecenas@hotmail.org','Female','Sep 2, 2006',2,1201,1),
        ('Buckley','David','031-001-6511','libero.morbi@google.com','Male','Feb 7, 2007',8,6529,1),
        ('Spencer','Natalie','098-117-5716','sollicitudin.adipiscing@protonmail.edu','Female','Dec 27, 2007',6,0700,4),
        ('Donaldson','Tad','070-428-5758','nam.ac@protonmail.edu','Female','Jun 8, 2006',9,0011,4),
        ('Reese','Kasper','025-323-5239','ornare.tortor@hotmail.com','Male','Sep 3, 2007',6,7103,1),
        ('Griffin','Aladdin','088-861-9030','felis@aol.com','Female','Oct 23, 2008',1,6529,5),
        ('Boyer','Dane','076-273-4842','at.auctor.ullamcorper@aol.couk','Male','Sep 5, 2006',2,2940,5),
        ('Beach','Hollee','064-546-1537','iaculis.quis@google.couk','Female','Nov 4, 2009',6,8300,2),
        ('Schultz','Louis','011-346-1132','lorem.auctor.quis@aol.org','Female','Jan 26, 2006',6,9700,2),
        ('Mueller','Beck','076-742-1338','proin.eget@google.net','Male','Dec 16, 2004',7,0011,1),
        ('Pittman','Mufutau','032-184-2483','vitae@google.edu','Female','Jun 4, 2009',5,9700,4),
        ('Durham','Uma','072-041-6225','ornare@aol.com','Male','Feb 4, 2006',5,4000,2),
        ('Mccormick','Vance','061-866-4145','dolor.sit@google.ca','Female','Mar 9, 2005',1,5207,3),
        ('Harrington','Stacey','094-944-4583','sit@protonmail.ca','Male','Oct 20, 2007',2,5207,1),
        ('Hooper','Willow','013-875-3231','egestas@icloud.edu','Male','Nov 29, 2009',2,2019,4),
        ('Alexander','Heather','064-283-8386','in.ornare@protonmail.edu','Male','Oct 1, 2009',3,8460,1),
        ('Pate','Abraham','097-442-6358','turpis@yahoo.net','Female','Jun 13, 2005',10,0900,1),
        ('Oneil','Marcia','003-200-6649','curabitur.egestas@outlook.net','Male','May 10, 2005',1,6529,4),
        ('Marshall','Meredith','021-778-8505','nec@protonmail.couk','Female','Sep 22, 2004',3,2940,5),
        ('Merrill','Willow','045-768-7374','nec@hotmail.org','Male','Mar 15, 2005',10,7103,2),
        ('Stanley','Hop','056-417-5094','quis.pede.praesent@aol.net','Male','Feb 13, 2008',8,0700,1),
        ('Hawkins','Pearl','004-333-7465','quisque.fringilla@yahoo.couk','Male','Apr 20, 2005',2,9307,1),
        ('Burks','Dana','061-340-2107','a@yahoo.ca','Male','Aug 20, 2006',10,1201,5),
        ('Montgomery','Teegan','057-244-1276','tincidunt@google.couk','Male','May 13, 2009',5,4930,4),
        ('Hines','Walter','061-056-2477','mauris.vestibulum.neque@google.net','Female','Jul 9, 2005',9,9700,3),
        ('Castillo','Francis','083-858-2055','sociis.natoque.penatibus@outlook.edu','Female','Oct 8, 2006',5,2019,2),
        ('Blake','Zachery','030-414-5410','maecenas.libero.est@aol.net','Female','Jan 19, 2009',3,8460,3),
        ('Mendez','Flynn','077-511-5535','metus.urna@google.net','Female','Mar 8, 2009',10,6529,1),
        ('Gill','Zia','024-386-2138','pharetra.sed@hotmail.com','Female','Apr 22, 2009',5,8460,5),
        ('Hobbs','Caldwell','073-184-0514','proin@protonmail.edu','Female','Jan 21, 2007',7,2940,5),
        ('Ward','Nita','073-317-7111','imperdiet.nec@aol.couk','Female','Jun 26, 2009',2,1201,1),
        ('Lang','Drew','038-114-7133','nec.mollis@icloud.edu','Male','Oct 11, 2008',7,4930,4),
        ('Henry','Brian','077-477-5195','rhoncus.id.mollis@hotmail.couk','Female','Mar 17, 2004',1,8300,5),
        ('Conner','Stephen','003-162-1111','velit.dui.semper@aol.com','Female','Jul 3, 2005',10,5207,4),
        ('Garza','Desiree','013-592-5770','nec.urna.suscipit@aol.net','Female','Oct 3, 2007',5,0900,2),
        ('Hart','Josephine','073-428-1794','ligula@google.edu','Female','Nov 6, 2007',7,2019,4),
        ('Williams','Kyra','033-163-1231','consectetuer.adipiscing@yahoo.ca','Male','Feb 4, 2006',3,9700,2),
        ('Herring','Inez','007-292-8471','cras@protonmail.net','Male','Feb 28, 2007',7,2019,3),
        ('Murphy','Flavia','082-286-6147','sed.est@google.ca','Female','Dec 9, 2007',2,2019,3),
        ('Gordon','Moana','051-421-2263','dolor.vitae@protonmail.edu','Male','Nov 30, 2009',10,4930,2);

insert into intrests (intrest)
values	
        ('Alcohol, Hiking, Gaming, Fishing'),
		('Fishing, Drugs, Gaming, Alcohol'),
		('Art, Fishing, Alcohol, Drugs, Exercise'),
		('Gaming, Art, Fishing, Nature'),
		('Art, Animals, Hiking, Drugs, Nature'),
		('Alcohol, Nature'),
		('Reading, Drugs, Hiking'),
		('Fishing, Nature'),
		('Animals, Alcohol, Nature'),
		('Fishing, Alcohol, Art'),
		('Reading, Nature'),
		('Art, Gaming, Exercise'),
		('Fishing, Nature, Alcohol, Gaming'),
		('Reading, Drugs, Exercise'),
		('Music, Reading, Drugs'),
		('Music, Animals, Gaming, Alcohol'),
		('Animals, Reading, Fishing'),
		('Music, Nature, Reading'),
		('Exercise, Music, Drugs, Reading'),
		('Gaming, Reading, Exercise, Nature'),
		('Art, Exercise, Nature'),
		('Fishing, Art'),
		('Exercise, Nature, Art'),
		('Alcohol, Drugs, Art, Gaming, Animals'),
		('Reading, Music, Nature, Art'),
		('Reading, Alcohol, Nature, Exercise'),
		('Music, Nature, Hiking'),
		('Gaming, Nature, Music, Art'),
		('Music, Reading, Gaming'),
		('Fishing, Alcohol, Animals'),
		('Music, Exercise, Alcohol'),
		('Gaming, Fishing, Music'),
		('Drugs, Fishing, Nature, Alcohol'),
		('Nature, Art, Hiking, Music, Alcohol'),
		('Drugs, Nature, Music, Exercise'),
		('Art, Nature, Music, Hiking, Reading'),
		('Fishing, Nature, Music, Animals'),
		('Reading, Exercise, Alcohol, Hiking'),
		('Exercise, Art, Hiking'),
		('Drugs, Animals'),
		('Nature, Fishing, Animals, Art'),
		('Exercise, Fishing, Hiking'),
		('Fishing, Hiking, Gaming, Alcohol'),
		('Drugs, Animals, Nature'),
		('Nature, Fishing, Drugs, Reading, Art'),
		('Exercise, Hiking'),
		('Nature, Gaming, Animals'),
		('Animals, Hiking, Alcohol'),
		('Art, Hiking, Drugs'),
		('Gaming, Alcohol, Art, Music, Nature');
		
insert into contact_intrest (intrest_id)
values 	
        (1),
		(2),
		(3),
		(4),
		(5),
		(6),
		(7),
		(8),
		(9),
		(10),
		(11),
		(12),
		(13),
		(14),
		(15),
		(16),
		(17),
		(18),
		(19),
		(20),
		(21),
		(22),
		(23),
		(24),
		(25),
		(26),
		(27),
		(28),
		(29),
		(30),
		(31),
		(32),
		(33),
		(34),
		(35),
		(36),
		(37),
		(38),
		(39),
		(40),
		(41),
		(42),
		(43),
		(44),
		(45),
		(46),
		(47),
		(48),
		(49),
		(50);
		
insert into seeking (seeking)
values 	
        ('Long term relationship'),
		('Some fun'),
		('Friendship'),
		('Someone with same intrests');
		
insert into contact_seeking (seeking_id)
values 	
        (1),
        (2),
        (3),
        (3),
        (2),
        (4),
        (3),
        (4),
        (1),
        (2),
        (1),
        (1),
        (4),
        (4),
        (1),
        (3),
        (3),
        (1),
        (3),
        (3),
        (2),
        (3),
        (3),
        (2),
        (2),
        (2),
        (1),
        (1),
        (2),
        (1),
        (3),
        (2),
        (3),
        (2),
        (2),
        (1),
        (4),
        (3),
        (3),
        (2),
        (3),
        (1),
        (1),
        (1),
        (3),
        (2),
        (1),
        (2),
        (3),
        (3);
		
-- 5) Using recursive queries with the created tables
with recursive contacts as (
select contact_id, status_id, first_name
from my_contacts
where contact_id = 2
union
select e.contact_id, e.status_id, e.first_name
from my_contacts e
inner join contacts s on s.contact_id = e.status_id)
select *
from contacts;

-- 6) Using fetch command to limit query results
select contact_id, zip_code
from my_contacts
order by contact_id
fetch first row only;
		
-- 7) Expert inner join query
select status_id, first_name
from my_contacts
inner join my_contacts on status.status_id =
my_contacts.status_id
order by my_contacts.status_id;

-- 8) Advanced self-join query and alies
select c1.first_name, c2.last_name, c1.birthday
from my_contacts c1
inner join my_contacts c2 on c1.birthday <>
c2.last_name
and c1.first_name = c2.last_name;

-- 9) Full outer join query
select e.first_name, e.birthday
from my_contacts e
full outer join my_contacts d on d.birthday =
e.birthday;

-- 10) Advanced where clause in full outer join query
select e.first_name, e.birthday
from my_contacts e
full outer join my_contacts d on d.birthday =
e.birthday
where
e.first_name is  NULL;

-- 11) Advanced query using the left join clause
select my_contacts.first_name, my_contacts.last_name, profession.prof_id, profession.profession
FROM
my_contacts
LEFT JOIN profession ON my_contacts.prof_id =
profession.prof_id;

-- 12) Implementing the cross join query
create table Labels (label CHAR(10) primary key);
create table Scores (score INT primary key);
insert into Labels (label)
values ('Fahr'), ('Cels');
insert into Scores (score)
values (1), (2);
select * from Labels cross join Scores;

-- 13) Elegant natural join query
select * from my_contacts natural join profession;

-- 14) Applying the inion operator to multiple advanced queries
select * from intrests
union all
select *
from profession
order by profession.prof_id asc;

-- 15) Use a query result to create a table
select Labels.Label, Score
into labels
from scores
where scores>avg(score);

-- 16) Implementing math functions with queries
select avg (score) from scores;
select random() * 100 + 1 as RAND_1_100;

-- 17) Using the advanced subquery in PostgreSQL
select score
from scores
where score > (
select avg (score) FROM scores
);

-- 18) Querying Stats on the Postgre DB
select first_name, last_name from my_contacts order by
last_name desc limit 1;

-- 19) Using PostgreSQL SELECT DISTINCT clause
select distinct score
from scores
where score > (
select avg (score) from scores
);

-- 20) rollup
select first_name, last_name, count(*)
from my_contacts
group by rollup(first_name, last_name);

-- 21) cube
select first_name, last_name, Count(*)
from my_contacts
group by cube(first_name, last_name);

-- 22) index
create index my_contacts_index on my_contacts(phone);

-- 23) Having clause
select first_name, avg(contact_id)
from my_contacts
group by first_name
having count(*)>5;

-- 24) Triggers
create or replace function demo()
returns trigger as
$$
begin
insert into demo1(col1,col2,col3)
values(new.col1,new.col2,current_date);
return new;
end;
$$
language 'plpgsql';

create trigger demo_trigger
after insert
on my_contacts
for each row
execute procedure demo();

-- 25) Missing values in a sequence
select contact_id + 1
from my_contacts a
where not exists (
select NULL
from my_contacts b
where a.contact_id = b.contact_id + 1)
order by contact_id;

-- 26) RANK() function
select first_name, email, phone, profession.prof_id,
rank () over (
partition by first_name
order by phone)
from my_contacts
inner join profession using (prof_id);

-- 27) dense_rank()
select first_name, email, phone, profession.prof_id,
dense_rank () over (
partition by first_name
order by phone )
from my_contacts
inner join profession using (prof_id);

-- 28) first_value()
select first_name, email, phone, profession.prof_id,
first_value(phone) over (
partition by first_name
order by phone) as phone_number
from my_contacts
inner join profession using (prof_id);

-- 29) last_value()
select first_name, email, phone, profession.prof_id,
last_value(phone) over (
partition by first_name
order by phone 
range between unbounded preceding and unbounded
following) as phone_number
from my_contacts
inner join profession using (prof_id);

-- 30) Explain statement
select * from emp1; 
query PLAN Seq Scan on emp1 (cost=0.00..451.00 rows=15000 width=364)

-- 31) create role
create role joe
LOGIN
password 'password123';
select rolname from pg_roles;

-- 32) group roles
create role employee;
grant employee to jeff; 
