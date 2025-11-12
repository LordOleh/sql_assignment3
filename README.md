# sql_assignment3

# Banking Transactions DWH

## Business Case
Analyzing customer transactions, account activity, and bank revenue from fees.

## Data Sources (RAW)
- bank_db.customers.csv
- bank_db.accounts.csv
- bank_db.transactions.csv

## Architecture
RAW → STAGE → MART (fact + 3 dims)

## Fact & Dimensions
- fact_bank_summary
- dim_customers
- dim_accounts
- dim_date
- dim_transactions

## Analytical Question
Which transaction types generate the most revenue per month?
