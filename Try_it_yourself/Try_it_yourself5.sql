 -- Chapter 5
 
 -- Question 1
 -- Calculate the area of the circle of radius 12.7cm
 select 3.14 * 12.7 ^ 2;
 
 -- Question 2
 
 -- Find which New York state county has the highest percentage of the population
 -- that identify as (American indian/Alaska Native Alone)
 select geo_name,
       state_us_abbreviation,
       p0010001 as total_population,
       p0010005 as american_indian_alaska_native_alone,
       (cast(p0010005 as numeric(8,1)) / p0010001) * 100
           as percent_american_indian_alaska_native_alone
from us_counties_2010
where state_us_abbreviation = 'NY'
order by percent_american_indian_alaska_native_alone desc;

-- Question 3

-- Is the median county population higher in california or New York
select state_us_abbreviation,
       percentile_cont(0.5)
          within group (order by p0010001) as median
from us_counties_2010
where state_us_abbreviation in ('NY', 'CA')
group by state_us_abbreviation;
-- There for California has a higher median population than New York