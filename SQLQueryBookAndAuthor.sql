create database BookAndAuthorP228

use BookAndAuthorP228

create table Books(
Id int primary key identity,
Name nvarchar(100) not null constraint Check_Name check(LEN(Name)>2),
PageCount int not null constraint Check_Count check(PageCount > 10),
AuthorId int constraint FK_Books_AuthorId foreign key references Authors(Id)
)

create table Authors(
Id int primary key identity,
Name nvarchar(50) not null,
Surname nvarchar(50) not null
)

insert into Authors
values('Stephen','Hawking'),
('Leo','Tolstoy'),
('Mark','Twain'),
('William','Shakespeare'),
('Charles','Dickens')

insert into Books
values ('A Brief History of Time', 450, 1),
('The Universe in a Nutshell', 550, 1),
('Black Holes and Baby Universes', 600, 1),
('Anna Karenina', 300, 2),
('War and Peace', 400, 2),
('Resurrection', 500, 2),
('Roughing It', 250, 3),
('The Gilded Age', 350, 3),
('The Adventures of Tom Sawyer', 450, 3),
('Hamlet', 700, 4),
('King Lear', 800, 4),
('Romeo and Juliet', 900, 4),
('Great Expectations', 150, 5),
('David Copperfield', 650, 5),
('Bleak House', 350, 5)

-- Task 1 --

create view usv_BooksAndAuthors
as
(select b.Id, b.Name, b.PageCount, (a.Name + ' ' + a.Surname) 'Author' from Books as b
join Authors as a
on b.AuthorId = a.Id)

select * from usv_BooksAndAuthors

-- Task 2 --
--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde olan
--Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin

create procedure usp_AuthorFullName
@Author nvarchar(60)
as
select * from usv_BooksAndAuthors
where @Author = Author 

exec usp_AuthorFullName 'Leo Tolstoy'

-----

create procedure usp_AuthorName --herf kombinasiyasina gore axtarir (like)
@Name nvarchar(30)
as
select * from usv_BooksAndAuthors
where Author like '%' + @Name + '%'

exec usp_AuthorName 'Tols'

----

create procedure usp_AuthorName2 --ancaq ada gore axtarir
@Name nvarchar(30)
as
select b.Id, b.Name, b.PageCount, (a.Name + ' ' + a.Surname) 'Author' from Books as b
join Authors as a
on b.AuthorId = a.Id
where @Name = a.Name

exec usp_AuthorName2 'Leo'

----

create procedure usp_AuthorSurname --ancaq soyada gore axtarir
@Name nvarchar(30)
as
select b.Id, b.Name, b.PageCount, (a.Name + ' ' + a.Surname) 'Author' from Books as b
join Authors as a
on b.AuthorId = a.Id
where @Name = a.Surname

exec usp_AuthorSurname 'Tolstoy'

-- Task 3 --

create procedure usp_DeleteAuthor  --delete for Author
@Id int
as 
delete from Authors
where @Id = Id

exec usp_DeleteAuthor 9

create procedure usp_InsertAuthor  --insert for Author
@Name nvarchar(30),
@Surname nvarchar(30)
as
insert into Authors (Name, Surname)
values(@Name, @Surname)

exec usp_InsertAuthor 'Gerge', 'Orwell'

create procedure usp_UpdateAuthor  --update for Author
@Name nvarchar (30),
@Id int
as
update Authors
set Name = @Name
where Id = @Id

exec usp_UpdateAuthor @Id = 9, @Name = 'George'

-- Addition --

create procedure usp_DeleteBook  --delete for Book
@Name nvarchar(100) = ''
as delete from Books
where @Name = Name

exec usp_DeleteBook 'Bleak House'

create procedure usp_InsertBook  --insert for Book
@Name nvarchar(100),
@PageCount int,
@AuthorId int
as
insert into Books(Name, PageCount, AuthorId)
values(@Name,@PageCount,@AuthorId)

exec usp_InsertBook 'Bleak House', 350, 5

create procedure usp_UpdateBook  --update for Book
@PageCount int,
@Id int
as
update Books
set PageCount = @PageCount
where Id = @Id

exec usp_UpdateBook @Id = 16, @PageCount = 400

-- Task 4 --

create view usv_Author
as
(select a.Id, (a.Name + ' ' + a.Surname) 'Author', Count(b.Name) as 'Books Count', 
MAX(PageCount) as 'Max Page Count' from Books b
full join Authors a
on b.AuthorId = a.Id
group by a.Name, a.Surname, a.Id)

select * from usv_Author