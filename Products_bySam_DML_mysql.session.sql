------------------------------------------ DDL -----------------------------

-- Data definition language (DDL) is used to define and manage the structure of a database, including tables, indexes, and constraints.

-- CREATE
-- CREATE TABLE table_name (
--     column_name data_type,
--     column_name data_type,
--     ...
-- );


/* generate a table named 'Products' with fields like
ProductNumber with datatypes alphanumeric
ProductName with datatype varchar
ManufacturingDate of datatype date
ExpiryDate of datatype date
ProductDescription of datatype varchar
price of datatype decimal
quanitityInStock of datattype integer
supplier of datatype varchar
SerialNumber of datatype varchar
SubCategory of datatype varchar
TaxRate of datatype decimal
Manufacturer of datatype varchar
ManufactureCountry of datatype varchar
*/

CREATE TABLE Products_bySam (
    ProductNumber VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(50),
    ManufacturingDate DATE,
    ExpiryDate DATE,
    ProductDescription VARCHAR(100),
    price DECIMAL(10, 2),
    quanitityInStock INTEGER,
    supplier VARCHAR(50),
    SerialNumber VARCHAR(20),
    SubCategory VARCHAR(50),
    TaxRate DECIMAL(10, 2),
    Manufacturer VARCHAR(50),
    ManufactureCountry VARCHAR(50)
);

-- insert data into table
-- insert into table_name (column1, column2, ...) 
-- VALUES (value1, value2, ...)
-- GROUP BY column_name
-- ORDER BY column_name ASC|DESC;

insert into Products_bySam (
        ProductName,
        ManufacturingDate,
        ExpiryDate,
        ProductDescription,
        price,
        QuantityInStock,
        supplier,
        SerialNumber,
        SubCategory,
        TaxRate,
        Manufacturer,
        ManufactureCountry
    )
VALUES (
        'Banana',
        '1968-02-15',
        '1968-03-31',
        'yellow bend fruit',
        1,
        100000000,
        'SuperFruits',
        'S3501',
        'exotic fruits',
        10,
        'Chiquita',
        'Costa Rica'
    );

select * from Products_bySam

-- update an existing entry
update Products_bySam
set ProductDescription = 'yellow, bend fruit'
where ProductNumber = 'P231';


-- change column name
alter table Products_bySam
rename column quanitityInStock to QuantityInStock;


-- delete primary key from table
alter table Products_bySam
drop primary key;

-- create new primary key column
ALTER TABLE Products_bySam 
ADD COLUMN ProductID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- delete column from table
alter table Products_bySam
drop column ProductNumber

update Products_bySam
set ManufacturingDate = '2024-06-24',
    ExpiryDate = DATE_ADD(ManufacturingDate, INTERVAL 60 DAY)
where ProductID = 1;

-- delete row from table
delete from Products_bySam
where ProductID = 1;

-- change null constraints to no
alter table Products_bySam
modify column ProductName varchar(50) not null;

-- set TaxRate to be 10
alter table Products_bySam
modify column TaxRate decimal(10, 2) default 10;


create table Customers_bySam (
    CustomerID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    CustomerAddress VARCHAR(100) NOT NULL,
    CustomerCity VARCHAR(50) NOT NULL,
    CustomerState VARCHAR(50) NOT NULL
);

create table Orders_bySam (
    OrderID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ProductID INT UNSIGNED NOT NULL,
    CustomerID INT UNSIGNED NOT NULL,
    OrderDate DATE,
    QuantityOrdered INT UNSIGNED NOT NULL,
    ProductPrice DECIMAL(10, 2) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT UNSIGNED NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products_bySam(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers_bySam(CustomerID)
);

insert into Customers_bySam (CustomerName, CustomerAddress, CustomerCity, CustomerState)
VALUES ('John Doe', '123 Main St', 'New York', 'NY'),
       ('Jane Smith', '456 Oak Rd', 'Boston', 'MA');

-- change the name of column 'price' of Products_bySam
alter table Products_bySam
change column price ProductPrice decimal(10, 2);

-- add multiple test-records to Products_bySam
insert into Products_bySam (ProductName, ManufacturingDate, ExpiryDate, ProductDescription, ProductPrice, QuantityInStock, supplier, SerialNumber, SubCategory, Manufacturer, ManufactureCountry)
VALUES ('Apple', '2024-02-23', DATE_ADD(ManufacturingDate, INTERVAL 60 DAY), 'yummy Apples', 1.23, 200, 'Rewe', 'RR232', 'regional fruits', 'Kanzi', 'Germany');

-- link the ProductPrice of Products_bySam with the ProductPrice of Orders_bySam
alter table Orders_bySam
add foreign key (ProductPrice) references Products_bySam(ProductPrice);
-- not working... apparently index needed


-- create multiple Orders for the Products_bySam
insert into Orders_bySam (ProductID, CustomerID, OrderDate, QuantityOrdered)
VALUES (2, 1, '2024-03-01', 10),
       (3, 2, '2024-03-02', 5),
       (3, 1, '2024-03-02', 50);

-- delete column from table
alter table Orders_bySam
drop column QuantityInStock;


-- automatically adjust the number of QuantityInStock when a new order is placed
create trigger update_stock
before insert on Orders_bySam
for each row
begin
    update Products_bySam
    set QuantityInStock = QuantityInStock - new.QuantityOrdered
    where ProductID = new.ProductID;
end;

insert into Orders_bySam (ProductID, CustomerID, OrderDate, QuantityOrdered)
VALUES (2, 1, '2024-07-01', 10),
       (3, 2, '2024-07-02', 5),
       (3, 1, '2024-07-02', 50);


create trigger update_stock
before insert on Orders_bySam
for each row
begin
    update Products_bySam
    set QuantityInStock = QuantityInStock - new.QuantityOrdered
    where ProductID = new.ProductID;
end;


-- delete column from table
alter table Orders_bySam
drop column ProductPrice;


-- create a trigger that multiplies ProductPrice from Products_bySam table with ordered amount and outputs it in UnitPrice
create trigger update_unit_price
before insert on Orders_bySam
for each row
begin
    set new.UnitPrice = (select ProductPrice from Products_bySam where ProductID = new.ProductID) * new.QuantityOrdered;
end;


-- delete all rows from table
delete from Orders_bySam;

-- deletes all records at once (faster than delete)
truncate table Orders_bySam;

