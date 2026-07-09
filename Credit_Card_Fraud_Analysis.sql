Create database credit_card_analytics;
use credit_card_analytics;
create table customer_profiles(
customer_id varchar(20) primary key,
mean_amount decimal(10,2),
std_amount decimal(10,2),
mean_nb_tx_per_day decimal(10,4),
network char(1),
id_bin int,
lat_customer decimal(10,6),
log_customer decimal(10,6),
available_terminals text,
nb_terminals int
);
create table terminal_profiles (
terminal_id varchar(20) primary key,
lat_terminal decimal(10,6),
log_terminal decimal(10,6),
mcc int
);
create table transaction (
transaction_id varchar(50) primary key,
post_ts datetime,
customer_id varchar(20),
bin int,
terminal_id varchar(20),
amt decimal(10,2),
entry_mode varchar(20),
fraud tinyint,
fraud_scenario tinyint
);
select count(*) as total_customers
from customer_profiles;
select *
from customer_profiles
limit 5;
select count(*) as total_terminals
from terminal_profiles;
select *
from terminal_profiles
limit 5;
select count(*) as total_customers
from customer_profiles;
select count(*) as total_terminals 
from terminal_profiles;
select count(*) as total_transactions
from transaction;
select *
from transaction
limit 10;
select
count(*) as total_rows,
count(transaction_id) as transaction_id,
count(customer_id) as customer_id,
count(terminal_id) as tarminal_id,
count(amt) as amount
from transaction;
select fraud, count(*) as total
from transaction 
group by fraud;

select sum(amt) as total_transaction_amount
from transaction;

select round(avg(amt),2) as average_transaction_amount
from transaction;

select max(amt) as highest_transaction
from transaction;

select min(amt) as lowest_transaction
from transaction;

select sum(amt) as total_fraud_amount
from transaction
where fraud = 1;

select
count(case when fraud = 1 then 1 end) as fraud_transaction,
count(*) as total_transactions,
round(
count(case when fraud = 1 then 1 end) * 100.0 / count(*),
2
) as fraud_percentage
from transaction;

select
entry_mode,
count(*) as fraud_transactions
from transaction
where fraud = 1
group by entry_mode
order by fraud_transactions DESC;

select 
entry_mode,
sum(amt) as fraud_amount
from transaction
where fraud = 1
group by entry_mode
order by fraud_amount DESC;

select 
bin,
count(*) as fraud_transactions
from transaction
where fraud = 1
group by bin
order by fraud_transactions DESC;

select
terminal_id,
count(*) as fraud_transactions
from transaction
where fraud = 1
group by terminal_id
order by fraud_transactions desc
limit 10;

select
fraud_scenario,
count(*) as total_cases
from transaction
where fraud = 1
group by fraud_scenario
order by total_cases DESC;

select
customer_id,
sum(amt) as total_spent
from transaction
group by customer_id
order by total_spent desc
limit 10;

select 
customer_id,
count(*) as total_transactions
from transaction
group by customer_id
order by total_transactions desc
limit 10;

select
customer_id,
round(avg(amt), 2) as average_spending
from transaction
group by customer_id
order by average_spending desc
limit 10;

select 
customer_id,
count(*) as fraud_transactions
from transaction
where fraud = 1
group by customer_id
order by fraud_transactions desc
limit 10;

select 
customer_id,
sum(amt) as fraud_amount 
from transaction
where fraud = 1
group by customer_id
order by fraud_amount desc
limit 10;

select 
customer_id,
sum(amt) as fraud_amount
from transaction
where fraud = 1
group by customer_id
order by fraud_amount desc
limit 10;

select
terminal_id,
count(*) as total_transactions
from transaction
group by terminal_id 
order by total_transactions desc
limit 10;

select
terminal_id,
count(*) as fraud_transactions
from transaction
where fraud = 1
group by terminal_id
order by fraud_transactions desc
limit 10;

select
terminal_id,
sum(amt) as fraud_amount
from transaction
where fraud = 1
group by terminal_id
order by fraud_amount desc
limit 10;

select
t.transaction_id,
t.customer_id,
c.mean_amount,
t.amt,
t.fraud
from transaction t
join customer_profiles c
on t.customer_id = c.customer_id
limit 10;

select
t.transaction_id,
t.terminal_id,
tp.mcc,
t.amt,
t.fraud
from transaction t
join terminal_profiles tp
on t.terminal_id = tp.terminal_id
limit 10;

select
t.transaction_id,
t.customer_id,
t.terminal_id,
t.amt,
tp.mcc
from transaction t
join terminal_profiles tp
on t.terminal_id = tp.terminal_id
where t.fraud = 1
limit 10;

SELECT
DATE(post_ts) AS transaction_date,
COUNT(*) AS total_transactions
FROM transaction
GROUP BY DATE(post_ts)
ORDER BY transaction_date;

SELECT
DATE(post_ts) AS transaction_date,
SUM(amt) AS total_amount
FROM transaction
GROUP BY DATE(post_ts)
ORDER BY transaction_date;

SELECT
DATE(post_ts) AS transaction_date,
SUM(amt) AS total_amount
FROM transaction
GROUP BY DATE(post_ts)
ORDER BY transaction_date;

SELECT
DATE(post_ts) AS transaction_date,
COUNT(*) AS fraud_transactions
FROM transaction
WHERE fraud = 1
GROUP BY DATE(post_ts)
ORDER BY transaction_date;

SELECT
HOUR(post_ts) AS transaction_hour,
COUNT(*) AS total_transactions
FROM transaction
GROUP BY HOUR(post_ts)
ORDER BY transaction_hour;

SELECT
HOUR(post_ts) AS transaction_hour,
COUNT(*) AS fraud_transactions
FROM transaction
WHERE fraud = 1
GROUP BY HOUR(post_ts)
ORDER BY transaction_hour;