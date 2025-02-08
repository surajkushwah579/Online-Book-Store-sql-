Create database OnlineBookstore;
Use OnlineBookstore;

Create Table Books(
Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
price numeric(10,2),
Stock int);

create table Customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(50),
Country varchar(150));

create table Orders(
Order_ID serial primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID int references Books(Book_ID),
Order_Date Date,
Quantity int,
Total_Amount numeric(10,2));

select * from books;
select * from Customers;
select * from Orders;

-- 1 Retrive all books in the Fiction genre
select * from books where Genre='Fiction';

-- 2 Find books published after the year 1958
select * from books where published_year>1958;

-- 3 List all customers from the Canada;
select * from  customers where country='Canada';

-- 4 Show orders placed in November 2023
select * from orders where Order_Date between '2023-11-01' AND '2023-11-30';

-- 5 Retrieve the total stock of books available
select sum(Stock) Total_Stock from Books;

-- 6 Find the details of the most expensive book;
select * from books order by Price desc limit 1;

-- 7 show all customers who ordered more than 1 quantity of a book
select * from orders where Quantity>1;

-- 8 Retrieve all orders where the total amount exceeds $20
select * from orders where Total_Amount>20;

-- 9 List all genres available in the books table
select distinct genre from Books;

-- 10 Find the book with the lowest stock
select * from Books order by Stock asc limit 1;

-- 11 calculate the total revenue generated from all orders
select round(sum(Total_Amount)) as Revenue from Orders;

-- 1 Retrieve the total number of books sold for each genre
select Genre,sum(Quantity) from Orders join Books on Orders.Book_ID=Books.Book_ID group by Genre;

-- 2 Find the average price of books in the Fantasy genre
select avg(Price) from Books where Genre='Fantasy';

-- 3 List customers who have placed at least 2 orders
select Orders.Customer_ID,Customers.Name,count(Order_ID) from Orders join Customers on Orders.Customer_ID=Customers.Customer_ID group by Orders.Customer_ID,Customers.Name  having count(Order_ID)>=2;
-- 4 Find the most frequently ordered book
select o.Book_ID,b.Title,count(o.Order_ID) as Order_count
from Orders o 
join Books b on o.Book_ID=b.Book_ID
group by o.Book_ID,b.Title
order by Order_count desc limit 1;

-- 5 show the top 3 most expensive books of 'Fantasy' Genre
select * from books
where genre='Fantasy'
order by Price desc limit 3;

-- 6 Retrieve the total quantity of books sold by each author
select b.Author, sum(o.Quantity) as Total_Books_Sold
from Orders o
join Books b on o.Book_ID=b.Book_ID
Group by b.Author
order by Total_Books_Sold desc;

-- 7 List the cities where customers who spent over $30 are located:
select distinct c.City ,Total_Amount
from Orders o 
join Customers c on o.Customer_ID=c.Customer_ID
where o.Total_Amount>30;

-- 8 Find the customer who spent the most on orders
select c.Customer_ID,c.Name,sum(o.Total_Amount) as Total_Spent
from Orders o
join Customers c on o.Customer_ID=c.Customer_ID
group by c.Customer_ID,c.Name
order by Total_Spent desc limit 1;