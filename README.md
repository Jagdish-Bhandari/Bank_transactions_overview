# 🏦 Bank Transaction Monitoring Dashboard (MySQL Project)

## 📌 Project Overview
---
This project is designed to support a banking system in monitoring credit and debit transaction behavior across banks, branches, and customers. The dashboard enables:

- Identification of top spending customers
- Detection of high-traffic branches
- Analysis of preferred payment methods
- Flagging periods of low transaction activity
- Detection of suspicious or potentially fraudulent transactions
---
## 🎯 Key Features

- Dynamic KPIs and SQL Views
- Fraud and risk flagging logic
- Real-time transaction insights
- Data structured for integration with BI tools (Tableau/Power BI)
---
## 📊 KPIs Monitored

- Transaction Volume by Bank & Branch
- Transaction Trend Overview
- Top 10 Customers by Balance & Amount
- Transactions: Amount & Count
- Branch-wise Balance
- Branch-wise Count of Transactions Over Period
- Credit to Debit Ratio
- Net Transaction Amount
- Total Amount
- Balance Amount
- Total Debit Amount
- Total Credit Amount
- High-Risk Transaction Counts
---
## 🏗️ Database Schema

Table: Bank Debit_Credit transactions
---
## SQL Queries like:

### Total_transaction_Amount:
```sql
SELECT CONCAT(ROUND(SUM(Amount) / 1000000, 1), 'M') AS total_transaction_amount
FROM `debit and credit bank_data`;
```
---
### Transaction wise total_amount
```sql
select `transaction type`,concat(round(sum(Amount/1000000),2),"M") as Total_amount 
from `debit and credit bank_data`
group by `transaction type`;
```
---
### Credit_to_debit ratio
```Sql
SELECT 
round( (SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'credit') /
    (SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'debit'),4) 
    AS credit_to_debit_ratio;
```
---
### Net transaction amount
```sql
SELECT
round((SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'credit') -
    (SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'debit'),2)
AS credit_to_debit_ratio;
```
---
### TOP-10 Account_IDs and their transaction ratios
```sql
SELECT `Account Number`, COUNT(*) AS total_transactions, MAX(Balance) AS account_balance,
    ROUND(COUNT(*) / MAX(Balance), 4) AS activity_ratio
FROM `debit and credit bank_data`
GROUP BY `Account Number` order by account_balance desc limit 10;
```
---
### Transactions number as per years , months , weak , days
```sql
select year(`transaction date`) as Years,month(`transaction date`) As Monthly,monthname(`transaction date`) as Month_names,
week(`transaction date`) as weekly,day(`transaction date`) as Day_wise,count(*) as Total_transaction_count 
from `debit and credit bank_data`
group by Years,Monthly,Month_names,weekly, Day_wise;
```
---
###  High-Risk Transaction Flag
> Here, added a column named threshold to specify hight-risk  and normal _transactions based on avg_trans amount
```sql
Alter table `debit and credit bank_data` add column Threshold varchar(25);

UPDATE `debit and credit bank_data`
SET Threshold = CASE 
 WHEN Amount > 2549 THEN 'High_Trans'
 ELSE 'Normal_Trans'
END;

set SQl_safe_updates = 0;
select * from `debit and credit bank_data`;
```

---
### Suspicious Transaction Frequency:
```sql
select `Account Number`,Threshold,sum(amount) as Trans_amount , count(*) as trans_count from `debit and credit bank_data`
where threshold = "High_Trans"
group by `Account Number`,Threshold order by trans_amount desc limit 10;
```


---
## 🔒 License

[MIT License](LICENSE)

## 👨‍💻 Author

**Jagdish Bhandari**  
📧 [jagdish.bhandari@example.com](mailto:jagdishbhandari0503@gmail.com)  
🔗 [LinkedIn Profile](https://linkedin.com/in/jagdishbhandari)  





