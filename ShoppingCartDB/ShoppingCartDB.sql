create database ShoppingCartDB;

create table Pricelist(
	item_id bigserial constraint item_id_key primary key,
	item_price integer,
	item varchar(50)
);

create table Users(
	user_id bigserial constraint user_id_key primary key,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(150) constraint email_unique unique
);

create table Cart(
	item_id integer not null references Pricelist(item_id),
	user_id integer not null references Users(user_id)
);

create table UserShoppingCart(
	user_id integer,
	email varchar(50),
	item_id integer,
	item varchar(50),
	item_price integer
);

insert into Pricelist (item_price, item)
values (10, 'Coke'),
       (15, 'Beer'),
	   (150, 'Cheese'),
	   (30, 'Pasta'),
	   (8, 'Bar One');

insert into Users (first_name, last_name, email)
values ('Cameron', 'Bowen', 'Cameronbowen075@gmail.com'),
       ('Vanessa', 'Wright', 'Vanessa@gmail.com'),
	   ('Nikita', 'Soman', 'Nikita@gmail.com'),
	   ('John', 'Doe', 'John@gmail.com'),
	   ('Chental', 'Mann', 'Chantel@gmail.com');
	   
insert into Cart(item_id, user_id)
values (1, 1),
       (3, 2),
	   (4, 2),
	   (1, 3),
	   (2, 5),
	   (3, 4),
	   (4, 1);
	   
-- Display the menu for the users
select item, item_price from Pricelist;

-- Add and item to the cart that a user has select
insert into UserShoppingCart(user_id, email, item_id, item, item_price)
select Cart.user_id, Users.email, Cart.item_id, Pricelist.item, Pricelist.item_price
from Cart 
left join Users
on Cart.user_id = Users.user_id
left join Pricelist
on Cart.item_id = Pricelist.item_id;

-- Chech if the UserShoppingCart table has been updated
select * from UserShoppingCart;

-- Show a current users shopping cart
select * from UserShoppingCart
where user_id = 2;

-- Calculate the total of the shopping cart and create order
select user_id, email, count(item) as item_count, sum(item_price) as total
from UserShoppingCart
where user_id = 1
group by user_id, email;

-- Create an order table
create table UserOrder(
	order_id bigserial,
	user_id integer,
	email varchar(50),
	item_count integer,
	total integer
);

-- Show a users order
select user_id, email, count(item) as item_count, sum(item_price) as total
from UserShoppingCart
where user_id = 2
group by user_id, email;

-- Store users orders in UserOrder table
insert into UserOrder(user_id, email, item_count, total)
select user_id, email, count(item) as item_count, sum(item_price) as total
from UserShoppingCart
group by user_id, email;

-- Check if UserOrder table has been updated
select * from UserOrder;