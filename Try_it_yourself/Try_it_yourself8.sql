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

copy pls_fy2014_pupld14a from 'C:\Users\User\Desktop\SQL\Try_it_yourself\pls_fy2014_pupld14a.csv' with (FORMAT csv, header);

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

-- 1. We saw that library visits have declined in most places. But what is the
-- pattern in the use of technology in libraries? Both the 2014 and 2009 library
-- survey tables contain the columns gpterms (the number of internet-connected
-- computers used by the public) and pitusr (uses of public internet computers
-- per year). Modify the code in Listing 8-13 to calculate the percent change in
-- the sum of each column over time. Watch out for negative values!

-- Answer:
-- Use sum() on gpterms (computer terminals) by state, find percent change, and
-- then sort.
select pls14.stabr,
       sum(pls14.gpterms) as gpterms_2014,
       sum(pls09.gpterms) as gpterms_2009,
       round( (cast(sum(pls14.gpterms) as decimal(10,1)) - sum(pls09.gpterms)) /
                    sum(pls09.gpterms) * 100, 2 ) as pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.gpterms >= 0 and pls09.gpterms >= 0
group by pls14.stabr
order by pct_change desc;

-- The query results show a consistent increase in the number of internet
-- computers used by the public in most states.

-- Use sum() on pitusr (uses of public internet computers per year) by state,
-- add percent change, and sort.
select pls14.stabr,
       sum(pls14.pitusr) as pitusr_2014,
       sum(pls09.pitusr) as pitusr_2009,
       round( (cast(sum(pls14.pitusr) as decimal(10,1)) - sum(pls09.pitusr)) /
                    sum(pls09.pitusr) * 100, 2 ) as pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.pitusr >= 0 and pls09.pitusr >= 0
group by pls14.stabr
order by pct_change desc;

-- The query results show most states have seen a decrease in the total uses
-- of public internet computers per year.

-- 2. Both library survey tables contain a column called obereg, a two-digit
-- Bureau of Economic Analysis Code that classifies each library agency
-- according to a region of the United States, such as New England, Rocky
-- Mountains, and so on. Just as we calculated the percent change in visits
-- grouped by state, do the same to group percent changes in visits by US
-- regions using obereg. Consult the survey documentation to find the meaning
-- of each region code. For a bonus challenge, create a table with the obereg
-- code as the primary key and the region name as text, and join it to the
-- summary query to group by the region name rather than the code.

-- Answer:
-- a) sum() visits by region.
select pls14.obereg,
       sum(pls14.visits) as visits_2014,
       sum(pls09.visits) as visits_2009,
       round( (cast(sum(pls14.visits) as decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) as pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0 and pls09.visits >= 0
group by pls14.obereg
order by pct_change desc;

-- b) Bonus: creating the regions lookup table and adding it to the query.
create table obereg_codes (
    obereg varchar(2) constraint obereg_key primary key,
    region varchar(50)
);

insert into obereg_codes
values ('01', 'New England (CT ME MA NH RI VT)'),
       ('02', 'Mid East (DE DC MD NJ NY PA)'),
       ('03', 'Great Lakes (IL IN MI OH WI)'),
       ('04', 'Plains (IA KS MN MO NE ND SD)'),
       ('05', 'Southeast (AL AR FL GA KY LA MS NC SC TN VA WV)'),
       ('06', 'Soutwest (AZ NM OK TX)'),
       ('07', 'Rocky Mountains (CO ID MT UT WY)'),
       ('08', 'Far West (AK CA HI NV OR WA)'),
       ('09', 'Outlying Areas (AS GU MP PR VI)');

-- sum() visits by region.
select obereg_codes.region,
       sum(pls14.visits) as visits_2014,
       sum(pls09.visits) as visits_2009,
       round( (cast(sum(pls14.visits) as decimal(10,1)) - sum(pls09.visits)) /
                    sum(pls09.visits) * 100, 2 ) as pct_change
from pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
   on pls14.fscskey = pls09.fscskey
join obereg_codes
   on pls14.obereg = obereg_codes.obereg
where pls14.visits >= 0 and pls09.visits >= 0
group by obereg_codes.region
order by pct_change desc;

-- 3. Thinking back to the types of joins you learned in Chapter 6, which join
-- type will show you all the rows in both tables, including those without a
-- match? Write such a query and add an IS NULL filter in a WHERE clause to
-- show agencies not included in one or the other table.

-- Answer: a FULL OUTER JOIN will show all rows in both tables.
select pls14.libname, pls14.city, pls14.stabr, pls14.statstru, pls14.c_admin, pls14.branlib,
       pls09.libname, pls09.city, pls09.stabr, pls09.statstru, pls09.c_admin, pls09.branlib
from pls_fy2014_pupld14a pls14 full outer join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.fscskey is NULL or pls09.fscskey is NULL;

-- Note: The IS NULL statements in the WHERE clause limit results to those
-- that do not appear in both tables.
