/* WE want to see total sales */
SELECT count(*) FROM sales.transactions;

/* We want the total  number of customers */
SELECT count(*) FROM sales.customers;

/*  See the first records in the transactions dataset*/
SELECT * FROM sales.transactions limit 5;

/* We want to see all transactions where market_code = "Mark001"*/
SELECT * FROM sales.transactions where market_code="Mark001";

/* We want all transactions thst were done in USD currency*/
SELECT * FROM sales.transactions where currency="USD";

/* We want the entire date dataset*/
SELECT * FROM sales.date;

/* We want to select all columns from both the transactions and date datasets where there is a match between order-date 
and date columns respectively. In other words, it retrieves transaction data along with the corresponding date information 
for each transaction, based on the matching date values.*/
SELECT sales.transactions.*, sales.date.* FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date=sales.date.date;

/*Transaction data along with the corresponding date information for each transaction, based on the matching date in the year of 2020.*/
SELECT sales.transactions.*, sales.date.* FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date=sales.date.date where sales.date.year=2020;

/*Transaction data along with the corresponding date information for each transaction, based on the matching date in the year of 2019.*/
SELECT sales.transactions.*, sales.date.* FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date=sales.date.date where sales.date.year=2019;

/*The sum of the sales in 2020 using the joined datset of transactions and date */
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date=sales.date.date where sales.date.year=2020;

/*The sum of the sales in 2020 in Chennai using the joined datset of transactions and date*/
SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON 
sales.transactions.order_date=sales.date.date where sales.date.year=2020 and sales.transactions.market_code="Mark001";

/*The unique products sold in Chennai from the transactions data set*/
SELECT distinct product_code FROM sales.transactions where market_code="Mark001";

/*How much did each customer spend in total*/
SELECT sales.customers.customer_code, SUM(sales.transactions.sales_amount) AS total_sales
FROM sales.transactions
INNER JOIN sales.customers ON sales.transactions.customer_code=sales.customers.customer_code
GROUP BY sales.customers.customer_code;

/*What are the top 5 most popular products*/
SELECT sales.transactions.product_code, SUM(sales.transactions.sales_amount) AS total_sales
FROM sales.transactions
GROUP BY sales.transactions.product_code
ORDER BY total_sales DESC
LIMIT 5;