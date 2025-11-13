CREATE DATABASE bank_db;
USE bank_db;
CREATE TABLE bank_db.customers (
    customer_id     BIGINT PRIMARY KEY,
    full_name       TEXT,
    city            TEXT,
    segment         TEXT
);

CREATE TABLE bank_db.accounts (
    account_number  BIGINT PRIMARY KEY,
    customer_id     BIGINT REFERENCES bank_db.customers(customer_id),
    currency        TEXT,
    open_date       DATE,
    status          TEXT
);

CREATE TABLE bank_db.transactions (
    transaction_id  BIGINT PRIMARY KEY,
    account_number  BIGINT REFERENCES bank_db.accounts(account_number),
    txn_timestamp   TIMESTAMP,
    type            TEXT,
    status          TEXT,
    amount          NUMERIC(18,2),
    fee_amount      NUMERIC(18,2)
);

CREATE TABLE dim_date (
    date_key     INTEGER PRIMARY KEY, -- формат YYYYMMDD
    full_date    DATE UNIQUE NOT NULL,
    day_of_week  TEXT,
    year         INTEGER,
    is_weekend   BOOLEAN
);

## date generation
-- Створюємо таблицю дат
CREATE TABLE dim_date (
    date_key     INT PRIMARY KEY,
    full_date    DATE UNIQUE NOT NULL,
    day_of_week  VARCHAR(10),
    year         INT,
    is_weekend   BOOLEAN
);
SET @@cte_max_recursion_depth = 5000;
-- Генерація дат з 2024-01-01 по 2026-12-31 (MySQL 8.0+)
WITH RECURSIVE dates AS (
    SELECT DATE('2024-01-01') AS full_date
    UNION ALL
    SELECT DATE_ADD(full_date, INTERVAL 1 DAY)
    FROM dates
    WHERE full_date < '2026-12-31'
)
SELECT
    YEAR(full_date) * 10000 +
    MONTH(full_date) * 100 +
    DAY(full_date) AS date_key,
    full_date,
    DAYNAME(full_date) AS day_of_week,
    YEAR(full_date) AS year,
    CASE WHEN DAYOFWEEK(full_date) IN (1,7) THEN TRUE ELSE FALSE END AS is_weekend
FROM dates;



## customers
INSERT INTO bank_db.customers (customer_id, full_name, city, segment)
VALUES
(1001, 'Ivan Petrenko', 'Kyiv', 'Retail'),
(1002, 'Olha Shevchenko', 'Lviv', 'Retail'),
(1003, 'Andrii Bondar', 'Odesa', 'SME'),
(1004, 'LLC TechNova', 'Dnipro', 'Corporate'),
(1005, 'Maria Koval', 'Kharkiv', 'Retail');

## accounts
INSERT INTO bank_db.accounts (account_number, customer_id, currency, open_date, status)
VALUES
(20001, 1001, 'UAH', '2024-01-10', 'Active'),
(20002, 1002, 'EUR', '2024-02-15', 'Active'),
(20003, 1003, 'USD', '2023-12-01', 'Closed'),
(20004, 1004, 'USD', '2024-03-05', 'Active'),
(20005, 1005, 'UAH', '2024-04-20', 'Frozen');

## transactions
INSERT INTO bank_db.transactions (transaction_id, account_number, txn_timestamp, type, status, amount, fee_amount)
VALUES
(30001, 20001, '2024-05-01 09:30:00', 'Deposit', 'Completed', 15000.00, 0.00),
(30002, 20001, '2024-05-03 11:15:00', 'Payment', 'Completed', -2500.00, 25.00),
(30003, 20002, '2024-05-04 14:00:00', 'Withdrawal', 'Completed', -300.00, 3.00),
(30004, 20003, '2024-05-05 16:45:00', 'Transfer', 'Failed', -1000.00, 5.00),
(30005, 20004, '2024-05-06 10:20:00', 'Deposit', 'Completed', 50000.00, 0.00),
(30006, 20005, '2024-05-07 13:10:00', 'Payment', 'Pending', -1200.00, 12.00),
(30007, 20001, '2024-05-08 08:50:00', 'Withdrawal', 'Completed', -500.00, 5.00),
(30008, 20002, '2024-05-09 17:30:00', 'Transfer', 'Completed', -1000.00, 10.00),
(30009, 20004, '2024-05-10 12:00:00', 'Payment', 'Completed', -7500.00, 75.00),
(30010, 20005, '2024-05-11 15:40:00', 'Deposit', 'Completed', 3000.00, 0.00);

