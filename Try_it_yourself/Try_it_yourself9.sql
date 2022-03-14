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
from 'C:\Users\User\Desktop\SQL\Try_it_yourself\MPI_Directory_by_Establishment_Name.csv'
with (FORMAT csv, header, delimiter ',');

create index company_idx on meat_poultry_egg_inspect (company);

-- Add the columns
alter table meat_poultry_egg_inspect add column meat_processing boolean;
alter table meat_poultry_egg_inspect add column poultry_processing boolean;

select * FROM meat_poultry_egg_inspect; -- view table with new empty columns

-- Update the columns
update meat_poultry_egg_inspect
set meat_processing = TRUE
where activities ilike '%meat processing%'; -- case-insensitive match with wildcards

update meat_poultry_egg_inspect
set poultry_processing = TRUE
where activities ilike '%poultry processing%'; -- case-insensitive match with wildcards

view the updated table

SELECT * FROM meat_poultry_egg_inspect;

-- Count meat and poultry processors
select count(meat_processing), count(poultry_processing)
from meat_poultry_egg_inspect;

-- Count those who do both
select count(*)
from meat_poultry_egg_inspect
where meat_processing = TRUE and
      poultry_processing = TRUE;
