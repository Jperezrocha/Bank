#1 List all the customers (first and last name) and their age.
SELECT first_name, last_name, 2022 - birth_year as age
FROM customer; 

#2 Show the number of customers by age. Sort the results in ascending order by age.
Select 2022 - birth_year as age, COUNT(*) as num_customers
From customer
Group by age
Order by age ASC;

#3 What is the utilization ratio (balance/credit limits) of each credit card (credit card number)? Round the ratio to 1 decimal place.
Select card_num, ROUND(balance/limits, 1) as utilization_ratio
From credit_card; 

#4 Show the average utilization ratio of each credit card type
Select card_type, AVG(balance/limits) as avg_utilization_ratio
From credit_card
Group by card_type;

#5 How many credit cards does each customer (first and last name) have? 
Select first_name, last_name, COUNT(card_num) as num_credit_cards
FROM customer
Inner join credit_card
On customer.customer_id = credit_card.customer_id
GROUP BY customer.customer_id;

#6 List the customers (first and last name) that have at least 7 Visa or Master cards.
Select first_name, last_name
From customer 
Inner join credit_card
On customer.customer_id = credit_card.customer_id
Where card_type In( 'Visa', 'Master') 
Group by customer.customer_id
Having count(card_num) >= 7; 

#7 For each transaction, show the transaction date, transaction amount and the type of credit card used in the transaction
Select transaction_date, amount, credit_card.card_type 
From transactions 
Inner join credit_card 
On transactions.card_id = credit_card.card_id; 

#8 List the credit cards (card number) that have at least 10 transactions.
Select credit_card.card_num
From credit_card 
Inner join transactions 
On transactions.card_id = credit_card.card_id
Having count(transactions.transaction_id) >= 10; 

#9 Show the transactions (date, amount and category) made by credit cards with a number that starts with 4024.
Select transactions.transaction_date, transactions.amount, transactions.category
From transactions 
Inner join credit_card 
On transactions.card_id = credit_card.card_id 
Where credit_card.card_num like "4024%"; 

#10 We would like to investigate anomalous transactions (DEFINED AS the transactions whose amounts are more than 95% of the corresponding credit card limit). Show all anomalous transactions (date, amount and category)
Select transactions.transaction_date, transactions.amount as anomalous_transactions , transactions.category 
From transactions
Inner join credit_card 
On transactions.card_id = credit_card.card_id 
Where transactions.amount > 0.95 * credit_card.limits; 

#11How many anomalous transactions does each customer (first and last name) have?
Select first_name, last_name, count(transactions.transaction_id) as anomalous_transactions 
From customer 
inner join credit_card
On customer.customer_id = credit_card.customer_id
inner join transactions 
On credit_card.card_num = transactions.transaction_id
Where transactions.amount > 0.95 * credit_card.limits
Group by customer.customer_id; 













