/* 
Assuming overall data for N days
MSSQL used to write queries
*/

--1. Which 5 cities placed most orders (ranked highest to lowest)
--Answer:
Select top 5 
	add.city, 
	count(o.id) as 'Count of Orders'
from 
	addresses add
Inner join 
	orders o 
on 
	add.user_id = o.user_id
group by 
	add.city
order by 
	count(o.id) desc;


--2. Which 5 states placed most orders (ranked highest to lowest
--Answer:
Select top 5 
	add.state, 
	count(o.id) as 'Count of Orders'
from 
	addresses add
Inner join 
	orders o 
on 
	add.user_id = o.user_id
group by 
	add.state
order by 
	count(o.id) desc;


--3. What is the split between cash on delivery and prepaid
--Answer:
Select 
	CASE payment_mode
		WHEN 1 THEN 'Prepaid'
		ELSE 'Cash on Delivery'
	END AS 
		'Payment Mode',
	Count(*) 
		AS 'Payment type Count'
From
	orders
Group by 
	payment_mode
Order by 
	Count(*) desc;


--4. Which 10 products were most purchased (ranked highest to lowest)
--Answer:
Select top 10 
	p.name, 
	count(o.id) as 'Count of Orders'
from 
	products p
Inner join 
	orders o
On
	p.id = o.product_id
Group by 
	p.name
Order by 
count(o.id) desc;


--5. How much discount have we given in last N number of days
--Answer:
select 
	(p.mrp - p.selling_price)  * o.quantity
from products p
Inner join
	orders o
On
	p.id = o.product_id


--6. What is the revenue in last N number of days (revenue will be on the basis of selling price)
--Answer:
Select 
	p.selling_price * o.quantity as 'Total Revenue'
From
	products p
Inner join 
	orders o
On
	p.id = o.product_id;


--7. If spend on marketing is assumed to be X rupees, how much profit / loss have we made in last N days
--Answer:
select 
	(p.selling_price * o.quantity) - x       --( x -> imaginary/assumed number)
from products p
Inner join
	orders o
On
	p.id = o.product_id     ---(if we get positive number its profit or else loss.


--8. What is our repeat rate in last N days
--Answer: Assuming overall repeat rate on all orders till date
Select 
	(count(
		Select 
		count(
			CASE user_id
			WHEN user_id >= 2 
				THEN 'Repeat'
				ELSE 'One Timer'
			END AS Repeat_Customer
			Where
			Repeat_Customer ='Repeat'
			) 
			From Orders) /
	count(user_id)
	) * 100 
As 
	'Repeat_Rate_%';


