-- Create database
create database Cafeteria
GO

-- Active database
use Cafeteria
GO

-- Create tables
create table Category (
	category_id int primary key identity(1,1),
	name nvarchar(50) not null
)
GO

create table Drink (
	drink_id int primary key identity(1,1),
	drink_name nvarchar(200),
	price money,
	category_id int references Category (category_id)
)
GO

create table Staff (
	staff_id int primary key identity(1,1),
	staff_fullname nvarchar(50),
	staff_birthday date,
	staff_gender nvarchar(10),
	staff_phone int,
	staff_address nvarchar(200),
	staff_salary money,
)
GO

create table Customer (
	cus_id int primary key identity(1,1),
	cus_fullname nvarchar(50),
	cus_birthday date,
	cus_gender nvarchar(10),
	cus_phone int,
	cus_email nvarchar(150),
)
GO

create table Orders (
	ord_id int primary key identity(1,1),
	staff_id int references Staff(staff_id),
	cus_id int references Customer(cus_id),
	total_price float,  -- Sai -> thua -> Muc dich nghiep total_price -> xu ly query simple.
	ord_date datetime,
	ord_note nvarchar(500)
)
GO

create table OrderDetail (
	detail_id int primary key identity(1,1),
	drink_id int references Drink(drink_id),
	detail_quantity int,
	detail_price money,
	total_price float, -- Sai -> thua -> Muc dich nghiep total_price -> xu ly query simple.
	order_id int references Orders(ord_id)
)
GO

create table Supplier(
	item_id int primary key identity(1,1) not null,
	supplier_name nvarchar(50),
	item_name nvarchar(50),
	item_quantity int ,
	item_unit varchar(10),
	item_price money
)
GO

-- Insert Data
insert into Category (name)
values
('Cafe'),
('Smoothies'),
('Tea'),
('Juice'),
('Ice Blend')

select * from Category

insert into Drink (drink_name, price, category_id)
values
('Coffee', '16000', 1),
('Vietnamese Coffee', '18000', 1),
('White Coffee', '20000', 1),
('Mocha', '25000', 1),
('Cold Brew', '30000', 1),
('Mocha', '25000', 1),
('Avocado Smoothies	', '42000', 2),
('Mango Smoothies', '42000', 2)

select * from Drink

insert into Staff(fullname, birthday, email, address)
values
('TRAN VAN A', '1999-01-20', 'tranvana@gmail.com', 'Ha Noi')

insert into Customer(fullname, birthday, email, address, phone_number)
values
('TRAN VAN B', '1990-01-20', 'tranvanb@gmail.com', 'Ha Noi', '1234567890')

insert into Orders(staff_id, customer_id, total_price, order_date, note)
values
(1, 1, 96000, '2021-02-26', ''),
(1, 1, 32000, '2021-02-25', ''),
(1, 1, 74000, '2021-02-27', '')

insert into OrderDetail(order_id, product_id, number, price, total_price)
values
(1, 1, 2, 32000, 64000),
(1, 2, 1, 32000, 32000),
(2, 1, 1, 32000, 32000),
(3, 1, 1, 32000, 32000),
(3, 5, 1, 42000, 42000)

-- Query & Proc
select Product.id, Product.title, Product.price, Category.name
from Product left join Category on Product.id_cat = Category.id
where Category.id = 1

create proc proc_view_product_by_category
	@idCat int
as
begin
	select Product.id, Product.title, Product.price, Category.name
	from Product left join Category on Product.id_cat = Category.id
	where Category.id = @idCat
end

exec proc_view_product_by_category 2

-- Order: query & store (proc)
select Product.id, Product.title, Category.name, OrderDetail.number, OrderDetail.price, OrderDetail.total_price
from Product left join Category on Product.id_cat = Category.id
	left join OrderDetail on OrderDetail.product_id = Product.id
where OrderDetail.order_id = 1

create proc proc_products_by_order
	@orderId int
as
begin
	select Product.id, Product.title, Category.name, OrderDetail.number, OrderDetail.price, OrderDetail.total_price
	from Product left join Category on Product.id_cat = Category.id
		left join OrderDetail on OrderDetail.product_id = Product.id
	where OrderDetail.order_id = @orderId
end

exec proc_products_by_order 1

-- Query: Xem thong tin don hang -> 1 khach hang da mua -> Customer, Order
select Customer.id, Customer.fullname, Customer.address, Staff.fullname, Orders.total_price, Orders.order_date
from Orders left join Customer on Orders.customer_id = Customer.id
	left join Staff on Staff.id = Orders.staff_id
where Customer.id = 1

create proc proc_view_order_by_customer
	@customerId int
as
begin
	select Customer.id, Customer.fullname, Customer.address, Staff.fullname, Orders.total_price, Orders.order_date
	from Orders left join Customer on Orders.customer_id = Customer.id
		left join Staff on Staff.id = Orders.staff_id
	where Customer.id = @customerId
end

exec proc_view_order_by_customer 1

-- Doanh thu
select * from Orders

select sum(total_price) 'Tong Doanh Thu' from Orders
where order_date between '2021-02-25' and '2021-02-26'

create proc proce_money
	@startDate date,
	@endDate date
as
begin
	select sum(total_price) 'Tong Doanh Thu' from Orders
	where order_date between @startDate and @endDate
end

exec proce_money '2021-02-25', '2021-02-27'