# sql_assignment3
## Bondar Oleg, Hromovyi Ivan, Yaroshenko Liliia

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

## Short overall
We have transactions, we have users, we have their accounts. We create by `row_date`, there it is not clean, there are nulls, there are duplicates. We filter it in the stage. Next, we create Dimensions, this is already the Mart stage, where we create Dimensions with our surrogate keys. We create Dimensions Date separately so that we can analyze by a specific time period, which we will then support with our Transactions. Accordingly, our final analysis is done from the fact table. Facts are all the dimensions connected to us, but we do not have dimension transactions, there are only stage transactions. We take details about them from it when we analyze. Accordingly, in our analytical query it is written that we want to see transactions for each of the quarters for the years that brought the most money. It seems that there is a deposit, from the deposits that brought the most money. It is better visible there in the code. The query will show which customer segment (Retail, SME, Corporate) brings in the most money in deposits, and how this changes from month to month.
