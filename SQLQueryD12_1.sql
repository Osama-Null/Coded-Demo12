create database DemoDb1
go
use DemoDb1
go
--     <To group tables & for security permission>
--        |
--        V
create schema Coded
go
--                .<object>
create table Coded.Employee(
	EmpID int primary key identity(1,1) not null,
	EmpName nvarchar(50) not null, 
	Salary money not null,
	City nvarchar(50),
	Email nvarchar(100) not null,
	Bonus money,
	Promotion bit,
	IsActive bit,
	IsDeleted bit,
	CreationDate Datetime
)
go
-- Insert data into table
insert into Coded.Employee values('Rami', 1500, 'Egypt', 'ra@gmail.eg', 250, 1, 1, 0, GETDATE())
go
insert into Coded.Employee(EmpName, City, Salary, Email, Bonus) values('Mohammad', 'Kuwait', 1500, 'mo@gmail.kw', 300)
go
insert into Coded.Employee values('Osama', 1500, 'Kuwait', 'os@gmail.eg', 500, 1, 1, 0, GETDATE()),
								 ('Ahmed', 1500, 'Kuwait', 'ah@gmail.eg', 500, 1, 1, 0, GETDATE()),
								 ('Aboudy', 1500, 'Kuwait', 'ab@gmail.eg', 500, 1, 1, 0, GETDATE()),
								 ('Fatmah', 1500, 'Kuwait', 'fa@gmail.eg', 500, 1, 1, 0, GETDATE()),
								 ('Zainab', 1500, 'Kuwait', 'ra@gmail.eg', 500, 1, 1, 0, GETDATE()),
								 ('Alena', 1300, 'Russia', 'ol@gmail.eg', 300, 1, 1, 0, GETDATE())
go
--     * == all
select * from Coded.Employee
go
select * from Coded.Employee where Promotion is not null
go
select * from Coded.Employee where Promotion = 1
go
select * from Coded.Employee where City = 'Kuwait' and Salary >= 1000
go
select * from Coded.Employee where Salary >= 1000 and Salary <= 2000
-- OR: `select * from Coded.Employee where Salary between 1000 and 2000`
go
select * from Coded.Employee where City = 'Russia' or City = 'Egypt'
-- OR: `select * from Coded.Employee where City in ('Russia', 'Egypt')`
go
-- <find first, add %= even if contain strings or spaces after and it depends>
select * from Coded.Employee where EmpName like 'Ahmed%'
go --                                      <find last, add %>
select * from Coded.Employee where EmpName like 'Ahmed%'
go --                                      <find specific, add %<name>%>
select * from Coded.Employee where EmpName like '%Ahmed%'
go --                                                 <%d%d%d... and spaces count too>
select * from Coded.Employee where EmpName like 'Ahmed_______'
go
select * from Coded.Employee where EmpName like 'Ahm_d%'
go --                                               <range beteen [-] or [,] must use `like`>
select * from Coded.Employee where EmpName like 'Ahm[a, e]d%'
go
------ Like `%a%` contains
-- like `a%` start a
-- like `%a` end a
-- like `___` 3 char
-- like `ahm[a, b, c, d]%` 
select distinct City from Coded.Employee
--     <No duplicates>
go
select * from  Coded.Employee order by Salary asc
go
select * from  Coded.Employee order by Salary desc
--                            < sort >        <ascending or descending>  
go
select * from Coded.Employee where Salary = (select max(Salary) from Coded.Employee)
go -- OR: 
select top 1 * from Coded.Employee order by Salary desc
go --  <first two results>
select top 2 * from Coded.Employee order by Salary desc
go
-- Name: Ghazaleh, Total Salary: 2350
select concat('Name: ', EmpName, ', Total Salary: ', Salary+Bonus) from Coded.Employee
-- same as Console.Write("string" + value);
go
select City, SUM(Salary) from Coded.Employee group by City
go
-- after creating View_1
select * from Coded.View_1
go -- Create view
create view Coded.View_2 as (
	select EmpName, Salary, IsDeleted from Coded.Employee where IsDeleted= 1
)
go -- update or edit the with set
update Coded.Employee set Salary += 50, Bonus += 150 where Salary <= 1000
go
select * from Coded.Employee
go
-- delete from Coded.Employee where IsDeleted = 1
go
