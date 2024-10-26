create database  Greens_project;
select * from walmart;

-------- Generic questions
-- How many unique cities does the data have?
select distinct city from walmart;

-- In which city is each branch?
select City,Branch from walmart group by City,Branch;


-------- product
-- 1)How many unique product lines does the data have?
alter table walmart change column `Product line` Product_line text;

select distinct Product_line from walmart;

-- 2)What is the most common payment method?

select Payment, count(*) as count_of_payments from walmart group by Payment order by count_of_payments desc limit 1;

-- 3)What is the most selling product line?

select Product_line, count(*) as total_sales from walmart group by Product_line order by total_sales desc limit 1;

-- 4)What is the total revenue by month?
select date_format(`Date`,'%Y-%M') as Month, sum(Total) as Total_revenue from walmart group by Month;

-- 5)What month had the largest COGS?
select date_format(`Date`,'%Y-%M') as Month, max(cogs) as COGS from walmart group by Month;

-- 6)What product line had the largest revenue?
select product_line,sum(Total) as largest_revenue from walmart group by Product_line order by largest_revenue limit 1;

-- 7)What is the city with the largest revenue?
select city,sum(Total) as largest_revenue from walmart group by city order by largest_revenue limit 1;

-- 8)What product line had the largest VAT?
alter table walmart change column `Tax 5%` Tax_5_Percent text;
select product_line, sum(Tax_5_percent) as VAT from walmart group by product_line order by VAT  limit 1;

-- 9)Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select product_line, count(*) as total_sales,case when count(*) > (select avg(product_count) from
(select count(*) as product_count from walmart group by product_line) as avg_sales)
then 'Good'
else 'Bad'
End as sales_status
from walmart
group by product_line;

-- 10)Which branch sold more products than average product sold?
select Branch, count(*) as total_prod_sold from walmart group by Branch
having total_prod_sold > (select avg(product_count) from (select count(*) as product_count from walmart group by Branch) as avg_products);

-- 11)What is the most common product line by gender?
select product_line, Gender, count(*) as Most_common from walmart group by product_line, gender order by Most_common desc;

-- 12. What is the average rating of each product line?
select product_line,avg(Rating) as avg_rating from walmart group by product_line order by avg_rating ;

### Customer

-- 1)How many unique customer types does the data have?
select distinct Customer from walmart;

-- 2. How many unique payment methods does the data have?
select distinct payment from walmart;

-- 4. Which customer type buys the most?
alter table walmart change column `Customer type` Customer_type text;
select Customer_type,sum(Total) as customer_buys from walmart group by Customer_type order by customer_buys;

-- 5. What is the gender of most of the customers?
select Gender,count(*) as count_of_gender from walmart group by Gender order by count_of_gender;

-- 6. What is the gender distribution per branch?
select Gender,Branch,count(*) as distribution from walmart group by Gender,Branch order by Gender,distribution;

-- 7. Which time of the day do customers give most ratings?
select Date,Time,count(Rating) as most_rated from walmart group by Date,Time order by most_rated desc limit 6;

-- 8. Which time of the day do customers give most ratings per branch?
select branch, time_format(Time, '%H:%m:%s') as Time_of_day, count(*) as Total_ratings from walmart group by branch, Time_of_day order by branch, Total_ratings;

-- 9. Which day fo the week has the best avg ratings?
select dayname(Date) as Day_name, avg(Rating) as AVG_RATINGS from walmart group by Day_name order by AVG_RATINGS;

-- 10. Which day of the week has the best average ratings per branch?
select branch, dayname(Date) as Day_of_week, avg(Rating) as AVG_RATINGS from walmart group by branch, Day_of_week order by branch, AVG_RATINGS desc;

----- ------ Sales

-- 1. Number of sales made in each time of the day per weekday
select dayname(date) as day_of_week, time_format(time, '%H:00:00') as time_of_day, count(*) as Total_sales from walmart group by day_of_week, time_of_day order by day_of_week, day_of_week;

-- 2. Which of the customer types brings the most revenue?
select Customer_type, sum(total) as Total_revenue from walmart group by Customer_type order by Total_revenue desc ;

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
select city, max(Tax_5_percent) as Largest_tax_percent from walmart group by city order by Largest_tax_percent desc;

-- 4. Which customer type pays the most in VAT?
select Customer_type, sum(Tax_5_percent) as total_tax from walmart group by Customer_type order by total_tax desc;







