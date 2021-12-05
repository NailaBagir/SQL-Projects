use TSQLV4
-- 1. Data of employees and their managers

SELECT E.empid, E.firstname,E.lastname,E.title,
m.empid as manager_empid, m.firstname as manager_firstname, m.lastname as manager_lastname, m.title  AS manager_title
FROM HR.Employees e, HR.Employees M
WHERE  M.empid=E.mgrid

-- 2. 

--Production.Products
--Sales.stores
--Production.Categories

use BikeStores
select * from production.products where brand_id=9 and model_year=2016;
select * from production.brands;

select * from production.products p join production.brands b on p.brand_id=b.brand_id;

create function production.TotalRevenueQuantity (@brand_name  VARCHAR (255))
returns TABLE
AS
RETURN
(
    select sum(p.list_price) as total_revenue, count(*) as quantity, p.model_year
    from production.products p 
    join production.brands b on p.brand_id=b.brand_id where b.brand_name=@brand_name
    group by p.brand_id, model_year 

);
GO
select * from production.TotalRevenueQuantity('Trek')




select * from production.categories;
select * from production.products 

-- 2.1

CREATE FUNCTION production.Cat_TotalRevenueQuantity (@category_name VARCHAR (255))
RETURNS TABLE
AS
RETURN
(
    select sum(p.list_price) as total_revenue,count(*) as quantity,model_year from production.products p join production.categories c 
    on p.category_id=c.category_id where c.category_name = @category_name
    group by p.category_id, model_year 

);

select * from production.Cat_TotalRevenueQuantity('Children Bicycles')

-- 2.2 

select * from sales.stores;
select * from production.products 
select * from production.stocks

select * from production.products p 
JOIN production.stocks s 
on p.product_id = s.product_id
JOIN sales.stores st on s.store_id=st.store_id

CREATE FUNCTION sales.ListOfProducts (@store_name VARCHAR (255) ,@model_year SMALLINT)
RETURNS TABLE 
AS
RETURN
(
    select product_name, quantity from production.products p 
    JOIN production.stocks s 
    on p.product_id = s.product_id
    JOIN sales.stores st on s.store_id=st.store_id
    where store_name = @store_name and model_year = @model_year
    
);

select * from sales.ListOfProducts('Santa Cruz Bikes',2016);



   