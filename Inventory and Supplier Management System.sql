#Creating the database

Create Database inventory;
use inventory;

#Creating Table

Create Table Products (
    prodID Int auto_increment Primary Key,
    productName varchar(150) NOT NULL,
    prodtype varchar(75) NOT NULL
);

Create Table Inventory(
   Inventory_id int auto_increment Primary Key,
   prodID int not null,
   Quant_available int not null check(Quant_available>=0),
   MinQuantity int not null check(MinQuantity>=0),
   foreign key(prodID) references Products(prodID)
   
);

Create Table Suppliers(
   S_id int auto_increment Primary Key,
   S_name varchar(100) not null,
   contact varchar(150)
);
Create Table Restockschedule (
    scheduleID int auto_increment primary key,
    prodID int not null,
    restockdate date not null,
    restockquantity int not null check (restockquantity > 0),
    foreign key (prodID) references Products(prodID) 
);


Create Table ProdSupplier (
    prodID int not null,
    S_id int not null,
    primary key (prodID, S_id),
    foreign key (prodID) references Products(prodID),
    foreign key (S_id) references Suppliers(S_id)
);

#Inserting Data

insert into Products (productName, prodtype) values
('smartphone', 'electronics'),
('marker', 'office stuff'),
('table chair', 'office stuff');

insert into Suppliers (S_name, contact) values
('QuickTech Ltd', 'quick@tech.com'),
('OffSolutions Ltd', 'offsol@info.com');

insert into ProdSupplier (prodID, S_id) values
(1, 1),  #smartphone supplied by QuickTech Ltd
(2, 2),  #marker supplied by OffSolutions Ltd
(3, 2);  #table chair also supplied by OffSolutions Ltd

insert into inventory (prodID, Quant_available, MinQuantity) values
(1, 80, 30),  #smartphone: 80 in stock, min is 30
(2, 40, 10),   #marker: 40 in stock, min is 10
(3, 130, 50);  #table chair: 130 in stock, min is 50

insert into Restockschedule (prodID, restockdate, restockquantity) values
(1, '2025-03-01', 25),     #Restocking 25 smartphones on March 1, 2025
(2, '2025-02-25', 15);     #Restocking 15 markers on  Feb 25, 2025


#QUERIES FOR REQUIRED WORK

#Fetch products that need restocking and are out of stock
select* from inventory;
select* from products;
select p.productName, i.Quant_available, i.MinQuantity
from inventory i
join products p on i.prodID = p.prodID
where i.Quant_available = 0;

#Fetch restocking history for a particular product
select* from products;
select* from restockschedule;
SELECT p.productName, r.restockdate, r.restockquantity
from restockschedule r
join products p on r.prodID = p.prodID
WHERE p.productName = 'smartphone';  

#Fetch products that are never restocked
select* from products;
select* from restockschedule;
select p.productName
from products p
left join restockschedule r on p.prodID = r.prodID
where r.prodID is null;

#Fetch suppliers for products with low stock
select* from products;
select* from ProdSupplier;
select* from suppliers;
select* from inventory;
SELECT p.productName, s.S_name, i.Quant_available
from products p
join inventory i on p.prodID=i.prodID
join ProdSupplier ps on i.prodID = ps.prodID
join suppliers s ON ps.S_id = s.S_id
where i.Quant_available < i.MinQuantity;

#Fetch the no. of products below the minimum for each supplier:
select* from suppliers;
select* from prodsupplier;
select* from inventory;

SELECT s.S_name, COUNT(ps.prodID) as Productlowstock
from Suppliers s
join Prodsupplier ps on s.S_id = ps.S_id
join inventory i on ps.prodID = i.prodID
where i.Quant_available < i.MinQuantity
Group by s.S_name;

