CREATE TABLE animals (
    id bigserial,
    animal_type varchar(25),
	animal_specifics varchar(25),
	animal_origin varchar(25)
);

-- Added the origin of the animal to understand where it comes from

insert into animals (animal_type, animal_specifics, animal_origin)
values('Lion', 'Carnivor', 'Africa'),
      ('Tiger', 'Carnivor', 'Asia'),
	  ('Kawala', 'Herbivor', 'Australia'),
	  ('Polar Bear', 'Carnivor', 'North Pole');
	  
-- It shows what line the error would be affecting as well as what character the error is on
-- This would help find the error as it brings attention to the lines where the error accured

select * from animals;