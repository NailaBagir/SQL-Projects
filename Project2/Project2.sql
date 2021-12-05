


select * from TSQLV4.Sales.Orders;

use TSQLV4;
-- 1. Assign a sequential integer
CREATE SEQUENCE Sales.OrderSeq  
    AS INT  
    START WITH 1  
    INCREMENT BY 1 ;  


SELECT NEXT VALUE FOR Sales.OrderSeq OVER (ORDER BY freight) AS Ordernum from Sales.Orders;
-- Restart Sequence
ALTER SEQUENCE Sales.OrderSeq    
RESTART WITH 1 ;  

-- Execute select statement again to verify that the Sales.OrderSeq sequence restarted with number 1.
SELECT NEXT VALUE FOR Sales.OrderSeq OVER (ORDER BY freight) AS Ordernum, * from Sales.Orders;




use BikeStores

select * from production.stocks;
-- 2.
-- The report of the products
select quantity,
case
when quantity = (select avg(quantity) from production.stocks) then 'Stock Normal'
when quantity > (select avg(quantity) from production.stocks) then 'Stock Go Out'
else 'Stock Normal'
end as condition
from production.stocks;



select * from sales.orders;
select * from sales.customers;
select * from production.products;
select * from sales.order_items




-- 3.
-- Customer spending on each product

select customers.customer_id, first_name, last_name,email , products.product_id,product_name,quantity, products.list_price, discount
,products.list_price - products.list_price * discount as discount_price, 
(products.list_price - products.list_price * discount)* quantity as total_price
from sales.orders 
INNER JOIN sales.customers on orders.customer_id=customers.customer_id
INNER JOIN sales.order_items on orders.order_id  = order_items.order_id
INNER JOIN production.products on order_items.product_id=products.product_id
order by customers.customer_id ;





