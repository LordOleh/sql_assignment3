SELECT
  d.year,
  d.month_name,
  c.segment,
  SUM(f.amount) AS total_deposit_amount,
  COUNT(f.transaction_id) AS total_transactions
FROM
  bank_db_ftc.fact_bank_summary AS f
LEFT JOIN
  bank_db_dwh.Dim_Customer AS c ON f.customer_key = c.customer_key
LEFT JOIN
  bank_db_dwh.Dim_Date AS d ON f.date_key = d.date_key
WHERE
  f.type = 'Deposit'
GROUP BY
  d.year,
  d.month_name,
  c.segment
ORDER BY
  d.year,
  d.month_name,
  total_deposit_amount DESC;
