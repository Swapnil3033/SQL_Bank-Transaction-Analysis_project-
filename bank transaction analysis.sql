Create database Bank_details;
use  Bank_details;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(20)
);

CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_type VARCHAR(50),
  balance DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  account_id INT,
  transaction_date DATE,
  amount DECIMAL(10,2),
  type VARCHAR(50),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO customers (customer_id, name, email, phone) VALUES
(1, 'John Doe', 'john@example.com', '1234567890'),
(2, 'Jane Doe', 'jane@example.com', '9876543210'),
(3,'Robin doe','robin@example.com','8945342718'),
(4,'josef sie','sie@example.com','9047342312');

INSERT INTO accounts (account_id, customer_id, account_type, balance) VALUES
(1, 1, 'Savings', 1000.00),
(2, 1, 'Current', 5000.00),
(3, 2, 'Savings', 2000.00),
(4, 3, 'Current', 3000.00);

INSERT INTO transactions (transaction_id, account_id, transaction_date, amount, type) VALUES
(1, 1, '2022-01-01', 100.00, 'Deposit'),
(2, 1, '2022-01-05', 50.00, 'Withdrawal'),
(3, 2, '2022-01-10', 200.00, 'Deposit'),
(4, 3, '2022-01-15', 150.00, 'Withdrawal');

-- 1. Total transactions per customer
SELECT c.name, COUNT(t.transaction_id) as total_transactions
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.name;


-- 2. Total balance by account type
SELECT account_type , SUM(balance) as total_balance
from accounts
group by account_type
   
   
-- 3. top 5 customers by total transaction amount
  
select c.name, SUM(t.amount) as total_amount
from customers c
join accounts a on c.customer_id = a.customer_id
join transactions t on a.account_id = t.account_id
group by c.name
order by total_amount desc
Limit 5 ;


-- 4.Average transaction amount by account type

select a.account_type , avg(t.amount) as average_transaction_amount
from accounts a
join transactions t on a.account_id = t.account_id
group by a.account_type 


