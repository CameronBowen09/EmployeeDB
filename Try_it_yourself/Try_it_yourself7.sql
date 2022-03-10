-- Consider the following two tables from a database you’re making to keep
-- track of your vinyl LP collection. Start by reviewing these CREATE TABLE
-- statements.

-- The albums table includes information specific to the overall collection
-- of songs on the disc. The songs table catalogs each track on the album.
-- Each song has a title and its own artist column, because each song might.
-- feature its own collection of artists.
create table albums (
    album_id bigserial,
    album_catalog_code varchar(100),
    album_title text,
    album_artist text,
    album_time interval,
    album_release_date date,
    album_genre varchar(40),
    album_description text
);

-- Check the columns are rigth
select * from albums;

-- Drop the table too add new constraints
drop table albums;

create table songs (
    song_id bigserial,
    song_title text,
    song_artist text,
    album_id bigint
);

-- Check if the columns are right
select * from songs;

-- Drop the table too add new constraints
drop table songs;

-- Modify these CREATE TABLE statements to include primary and foreign keys
-- plus additional constraints on both tables. Explain why you made your
-- choices.

create table albums (
    album_id bigserial,
    album_catalog_code varchar(100) not NULL,
    album_title text not NULL,
    album_artist text not NULL,
    album_release_date date,
    album_genre varchar(40),
    album_description text,
    constraint album_id_key primary key (album_id),
    constraint release_date_check check (album_release_date > '1/1/1925')
);

-- Check the columns are rigth
select * from albums;

create table songs (
    song_id bigserial,
    song_title text not NULL,
    song_artist text not NULL,
    album_id bigint references albums (album_id),
    constraint song_id_key primary key (song_id)
);

-- Check the columns are rigth
select * from songs;

-- 1a) Both tables get a primary key using surrogate key id values that are
-- auto-generated via serial data types.

-- b) The songs table references albums via a foreign key constraint.

-- c) In both tables, the title and artist columns cannot be empty, which
-- is specified via a NOT NULL constraint. We assume that every album and
-- song should at minimum have that information.

-- d) In albums, the album_release_date column has a CHECK constraint
-- because it would be likely impossible for us to own an LP made before 1925.

-- 2) We could consider the album_catalog_code. We would have to answer yes to
-- these questions:
-- Is it going to be unique across all albums released by all companies?
-- Will we always have one?

-- 3) Primary key columns get indexes by default, but we should add an index
-- to the album_id foreign key column in the songs table because we'll use
-- it in table joins. It's likely that we'll query these tables to search
-- by titles and artists, so those columns in both tables should get indexes
-- too. The album_release_date in albums also is a candidate if we expect
-- to perform many queries that include date ranges.