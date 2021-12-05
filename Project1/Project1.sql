
use TSQLV4;
exec sp_help 'HR.Employees';
select * from hr.Employees;

-- First part
-- Figure out the gender ratio in the different departments of the company X 

select title, cast(sum(case when gender = 'M' then 1 else 0 end) as float) / cast(count(*) as float) as male_ratio,
       cast(sum(case when gender= 'F' then 1 else 0 end) as float) /cast(count(*) as float) as female_ratio
from
(select title, case  
when titleofcourtesy in  ('Mr.')  then 'M'
when titleofcourtesy in ('Ms.' , 'Mrs.') then 'F'
else 'Unknown'
end as Gender
from hr.Employees   ) as g group by title;


-- The Full name of employees who work in the company longer than 5 years .

select * from HR.Employees;

select CONCAT(firstname,' ' ,lastname) as fullname from HR.Employees where DATEDIFF(YEAR, hiredate, GETDATE())>5;

--- The oldest and youngest employees in the company

select * from hr.Employees;

select CONCAT(firstname, ' ', lastname) as fullname, DATEDIFF(YEAR,birthdate,GETDATE()) as age  from hr.Employees WHERE 
birthdate= 
(select MAX(birthdate) from HR.Employees) OR birthdate= (select MIN(birthdate) from HR.Employees) ;


---- Second part
select * from Sales.Customers;
-- Replacing null values with phone numbers

UPDATE Sales.Customers 
set fax=phone 
WHERE fax is NULL;

--- Display the first name and last name as two different columns.
ALTER TABLE Sales.Customers 
add firstname NVARCHAR(20)  NULL,
    lastname  NVARCHAR(20)  NULL;

UPDATE Sales.Customers
set lastname = SUBSTRING(contactname,1, CHARINDEX(',',contactname)-1),
    firstname =  trim(SUBSTRING(contactname,CHARINDEX(',',contactname)+1,LEN(contactname)-CHARINDEX(',',contactname)));

ALTER TABLE Sales.Customers ALTER COLUMN firstname NVARCHAR(20) NOT NULL;
ALTER TABLE Sales.Customers ALTER COLUMN lastname NVARCHAR(20) NOT NULL;
alter table Sales.Customers drop column contactname;



