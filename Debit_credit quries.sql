select * from `debit and credit bank_data`;
alter table `debit and credit bank_data` rename column `ï»¿Customer ID` to Customers_ID;

#1.Total_transaction_Amount
select Sum(Amount) as total_transaction_amount from `debit and credit bank_data`;

SELECT CONCAT(ROUND(SUM(Amount) / 1000000, 1), 'M') AS total_transaction_amount
FROM `debit and credit bank_data`;

#2 Transaction wise total_amount
select `transaction type`,concat(round(sum(Amount/1000000),2),"M") as Total_amount from `debit and credit bank_data`
group by `transaction type`;

#3 Total_credit_Amount
select concat(round(sum(Amount/1000000),2),"M") as Total_credit_amount from `debit and credit bank_data`
where `Transaction Type` ="Credit";

#4 Total_Debit_Amount
select concat(round(sum(Amount/1000000),2),"M") as Total_credit_amount from `debit and credit bank_data`
where `Transaction Type` ="Debit";

#5 Credit_to_debit ratio
SELECT round( (SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'credit') /
    (SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'debit'),4) AS credit_to_debit_ratio;

#6 Net transaction amount
SELECT  round((SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'credit') -
    (SELECT SUM(Amount) FROM `debit and credit bank_data` WHERE `Transaction Type` = 'debit'),2)AS credit_to_debit_ratio;

#7 TOP-10 Account_IDs and their transaction ratios
SELECT `Account Number`, COUNT(*) AS total_transactions, MAX(Balance) AS account_balance,
    ROUND(COUNT(*) / MAX(Balance), 4) AS activity_ratio FROM `debit and credit bank_data`
GROUP BY `Account Number` order by account_balance desc limit 10;

## Transactions number as per years , months , weak , days

##9 yearly
select year(`transaction date`) as Years,count(*) as Total_transaction_count from `debit and credit bank_data`
group by Years;

## 10 Monthly
select year(`transaction date`) as Years,month(`transaction date`) As Monthly,monthname(`transaction date`) as Month_names,
count(*) as Total_transaction_count 
from `debit and credit bank_data`
group by Years,Monthly,Month_names;

##11 weekly
select year(`transaction date`) as Years,week(`transaction date`) As weekly,
count(*) as Total_transaction_count 
from `debit and credit bank_data`
group by Years,weekly;

##12 Mothy_Daywise
select month(`transaction date`) as Monthly,Day(`transaction date`) As Day_wise,
count(*) as Total_transaction_count 
from `debit and credit bank_data`
group by Monthly,Day_wise;

select year(`transaction date`) as Years,month(`transaction date`) As Monthly,monthname(`transaction date`) as Month_names,
week(`transaction date`) as weekly,day(`transaction date`) as Day_wise,count(*) as Total_transaction_count 
from `debit and credit bank_data`
group by Years,Monthly,Month_names,weekly, Day_wise;

# 13 Total number of Transactions by branch
select Branch,concat(round(sum(Amount)/10000000,2),"Cr") as Total_trans_amount,count(*) as Total_trans_count 
from `debit and credit bank_data`
group by Branch;

#14 transactional Method distrubution
select `transaction method`,count(*) as Distrubutional_count from `debit and credit bank_data`
group by `transaction method`;

#15 High-Risk Transaction Flag
select * from `debit and credit bank_data`;

#16 Avg_transactional_amount
select round(avg(amount),0) from `debit and credit bank_data`;

Alter table `debit and credit bank_data` add column Threshold varchar(25);

UPDATE `debit and credit bank_data`
SET Threshold = CASE 
 WHEN Amount > 2549 THEN 'High_Trans'
 ELSE 'Normal_Trans'
END;

set SQl_safe_updates = 0;
select * from `debit and credit bank_data`;

#17-Threshold_overview
select threshold,count(*) as Risk_analysis from `debit and credit bank_data`
group by threshold;

#18-Suspicious Transaction Frequency:
select `Account Number`,Threshold,sum(amount) as Trans_amount , count(*) as trans_count from `debit and credit bank_data`
where threshold = "High_Trans"
group by `Account Number`,Threshold order by trans_amount desc limit 10;

Select * from `debit and credit bank_data`;

