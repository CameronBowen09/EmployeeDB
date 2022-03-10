-- Chapter 6

CREATE TABLE us_counties_2000 (
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

copy us_counties_2000 from 'C:\Users\User\Desktop\SQL\Try_it_yourself\us_counties_2000.csv' with (FORMAT csv, header);

--  Counties that exist in 2010 data but not 2000 include five county equivalents
-- in Alaska (called boroughs) plus Broomfield County, Colorado.
select c2010.geo_name,
       c2010.state_us_abbreviation,
       c2000.geo_name
from us_counties_2010 c2010 left join us_counties_2000 c2000
on c2010.state_fips = c2000.state_fips
   and c2010.county_fips = c2000.county_fips
where c2000.geo_name is NULL;

-- Counties that exist in 2000 data but not 2010 include three county
-- equivalents in Alaska (called boroughs) plus Clifton Forge city, Virginia,
-- which gave up its independent city status in 2001:
select c2010.geo_name,
       c2000.geo_name,
       c2000.state_us_abbreviation
from us_counties_2010 c2010 right join us_counties_2000 c2000
on c2010.state_fips = c2000.state_fips
   and c2010.county_fips = c2000.county_fips
where c2010.geo_name is NULL;
  
 -- Using percentile_cont():
select percentile_cont(.5)
       within group (order by round((cast(c2010.p0010001 as numeric(8,1)) - c2000.p0010001)
           / c2000.p0010001 * 100, 1 )) as percentile_50th
from us_counties_2010 c2010 inner join us_counties_2000 c2000
on c2010.state_fips = c2000.state_fips
   and c2010.county_fips = c2000.county_fips
   
-- Which county had the greatest percentage loss of population between 2000
-- and 2010? Do you have any idea why? Hint: a weather event happened in 2005.

-- Answer: St. Bernard Parish, La. It and other Louisiana parishes (the county
-- equivalent name in Louisiana) experienced substantial population loss
-- following Hurricane Katrina in 2005.
select c2010.geo_name,
       c2010.state_us_abbreviation,
       c2010.p0010001 as pop_2010,
       c2000.p0010001 as pop_2000,
       c2010.p0010001 - c2000.p0010001 as raw_change,
       round((cast(c2010.p0010001 as decimal(8,1)) - c2000.p0010001)
           / c2000.p0010001 * 100, 1 ) AS pct_change
from us_counties_2010 c2010 inner join us_counties_2000 c2000
on c2010.state_fips = c2000.state_fips
   and c2010.county_fips = c2000.county_fips
order by pct_change asc;
