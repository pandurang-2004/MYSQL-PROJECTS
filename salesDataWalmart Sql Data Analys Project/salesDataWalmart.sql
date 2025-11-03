create database if not exists salesDataWalmart; 
 drop database salesdatawalmart;
 
 use salesdatawalmart;

DROP TABLE IF EXISTS sales;

s
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(12 , 4 ) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_pct FLOAT(11 , 9 ),
    gross_income DECIMAL(12 , 4 ),
    rating FLOAT(2 , 1 )
);



-- Feature Enginering

-- time of day

SELECT 
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_date
FROM
    sales;
 
 alter table sales add column time_of_day varchar(20);
 
UPDATE sales 
SET 
    time_of_day = (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);
 
 
 -- day name
 
SELECT 
    date, DAYNAME(date)
FROM
    sales;

alter table sales add column day_name varchar(10);

UPDATE sales 
SET 
    day_name = DAYNAME(date); 

-- month name

SELECT 
    date, MONTHNAME(date)
FROM
    sales;

alter table sales add column month_name varchar(10);

UPDATE sales 
SET 
    month_name = MONTHNAME(date);

select * from sales;

---------------------------------------------------------------------------------------------------------------------------

-- GENRIC

--  How many unique cities does the data have?

select distinct(city) from sales;

-- In which city is each branch?

select distinct city,branch from sales;

-------------------------------------------------------------------------------------------------------------------------
-- Product

-- How many unique product lines does the data have?

SELECT DISTINCT
    product_line
FROM
    sales;

-- What is the most selling product line

SELECT 
    product_line, SUM(quantity) AS qty
FROM
    sales
GROUP BY product_line
ORDER BY qty DESC;

-- what is the most common payemnt method

SELECT 
    payment, COUNT(payment) AS cnt
FROM
    sales
GROUP BY payment
ORDER BY cnt DESC;

 -- what is the most selling product line
 
SELECT 
    product_line, COUNT(product_line) AS cnt
FROM
    sales
GROUP BY product_line
ORDER BY cnt DESC;

-- waht is most total revenue by month

SELECT 
    MONTHNAME(date) AS month, SUM(total) AS toatal_revenue
FROM
    sales
GROUP BY MONTHNAME(date)
ORDER BY toatal_revenue;

-- what month had the largest cogs

SELECT 
    MONTHNAME(date) AS month, SUM(cogs) AS cogs
FROM
    sales
GROUP BY MONTHNAME(date)
ORDER BY cogs DESC;


-- what product line had the lagest revenue

SELECT 
    product_line, SUM(total) AS total_revenue
FROM
    sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- what is the city with the largest revenue

SELECT 
    city, branch, SUM(total) AS total_revenue
FROM
    sales
GROUP BY city , branch
ORDER BY total_revenue;

-- what product line had the largest value vat

SELECT 
    product_line, AVG(tax_pct) AS avg_tax
FROM
    sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- which branch sold more product than avrage product soled

 SELECT 
    ROUND(AVG(rating), 2) AS avg_rating, product_line
FROM
    sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- what is the most common product line in gender

SELECT 
    gender, product_line, COUNT(gender) AS total_cnt
FROM
    sales
GROUP BY gender , product_line
ORDER BY total_cnt DESC;

-- what is avarage rating of each product line

SELECT 
    ROUND(AVG(rating), 2) AS avg_rating, product_line
FROM
    sales
GROUP BY product_line
ORDER BY avg_rating DESC;



