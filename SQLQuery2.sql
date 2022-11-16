create database ClassTask1

use ClassTask1

create table Brands
(
Id int identity primary key,
Name nvarchar(100) not null
)
--1
create table Notebooks
(
Id int identity primary key,
Name nvarchar(100) not null,
Price money,
BrandId int foreign key references Brands(Id)
)
--2
create table Phones
(
Id int identity primary key,
Name nvarchar(100) not null,
Price money,
BrandId int foreign key references Brands(Id)
)

INSERT INTO Brands
VALUES
('Apple'),
('Hp'),
('Samsung'),
('Xiaomi'),
('Huawei'),
('Asus'),
('Dell')

INSERT INTO Notebooks
VALUES
('250 G5', 943, 2),
('250 G6', 1158, 2),
('250 G7', 1251, 2),
('Air', 2363, 1),
('Pro 13', 2975, 1),
('Pro 15', 3439, 1),
('ROG', 2928, 6),
('ROG PRO', 3968, 6),
('VIVOBOOK 15', 1536, 6),
('VIVOBOOK 14', 1325, 6),
('Mate X', 1600, 5),
('Mate X PRO', 1900, 5),
('Mate XL PRO', 1864, 5),
('Mate XXL PRO', 1253, 5),
('Mi Notebook Air', 1753, 4),
('Mi Notebook Pro', 2153, 4),
('Lustrous Grey', 4681, 4),
('Galaxy Book', 1874, 3),
('Galaxy Book PRO', 3274, 3),
('Galaxy Book AIR', 2574, 3),
('Galaxy Book AIR PRO', 3367, 3)



INSERT INTO Phones
VALUES
('13', 2463, 1),
('13 Pro', 3075, 1),
('13 Pro Max', 3339, 1),
('Mate Pad', 1600, 5),
('Mate Xs', 1900, 5),
('Nova 9 SE', 1864, 5),
('P50E', 1853, 5),
('Poco 5', 1753, 4),
('Poco 4', 2153, 4),
('Poco 6', 4681, 4),
('A11', 275, 3),
('A21', 285, 3),
('A31', 374, 3),
('A41', 467, 3),
('A51', 567, 3),
('A61', 667, 3),
('A71', 767, 3),
('A81', 867, 3),
('A91', 967, 3)

SELECT * FROM Brands
SELECT * FROM Notebooks
SELECT * FROM Phones


-- 3
SELECT  Notebooks.Name, Brands.Name 'BrandName', Price from Notebooks
join Brands on Notebooks.Id=BrandId;

-- 4
SELECT Phones.Name, Brands.Name 'BrandName', Price from Phones
join Brands on Phones.Id=BrandId;

-- 5
Select * from Notebooks
join Brands
on Notebooks.BrandId = Brands.Id WHERE Brands.Name like '%s%'

-- 6
Select * from Notebooks where Price between 2000 and 5000 or Price > 5000

-- 7
Select * from Phones  where Price between 1000 and 1500 or Price > 1500

-- 8
Select Brands.Name, Count(*) 'Notebook Count' from Brands
join Notebooks
on  Notebooks.BrandId = Brands.Id  Group By Brands.Name

-- 9
Select Brands.Name, Count(*) 'Phone Count'  from Brands
join Phones
on  Phones.BrandId = Brands.Id  Group By Brands.Name

-- 10
Select Notebooks.Name, Notebooks.BrandId from Notebooks
union
Select Phones.Name, Phones.BrandId from Phones

--11
Select Notebooks.Id,Notebooks.Name,Notebooks.Price, Notebooks.BrandId from Notebooks
union
Select Phones.Id,Phones.Name,Phones.Price, Phones.BrandId from Phones

--12
SELECT Phones.Id,Phones.Name,Phones.Price, Brands.Name 'BrandName', Price from Phones
join
Brands on Phones.Id=BrandId
union
SELECT Notebooks.Id,Notebooks.Name,Notebooks.Price, Brands.Name 'BrandName', Price from Notebooks
join
Brands on Notebooks.Id=BrandId;

--13
SELECT Phones.Id,Phones.Name,Phones.Price, Brands.Name 'BrandName', Price from Phones
join
Brands on Phones.Id=BrandId
union 
SELECT Notebooks.Id,Notebooks.Name,Notebooks.Price, Brands.Name 'BrandName', Price from Notebooks
join
Brands on Notebooks.Id=BrandId
where Price > 2000;
