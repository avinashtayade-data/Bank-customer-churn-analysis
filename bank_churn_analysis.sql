--creation of table and columns to import data(column names should be same according to csv file)



create table bank_churn(
CustomerId int primary key,
Surname varchar(60),
CreditScore int,
Geography varchar(60),
Gender varchar(50),
Age int,
Tenure	int,
Balance float,
NumOfProducts	int,
HasCrCard int,
IsActiveMember	int,
EstimatedSalary	float,
Exited int);



--Altering the column datatype to numeric



ALTER TABLE bank_churn
ALTER COLUMN Balance TYPE NUMERIC;




--query to display all data in the file

select * from bank_churn;

--upto 10 rows

select * from bank_churn LIMIT 10;


-- T0 display null values

select 
COUNT(*) -COUNT(CustomerId) AS null_CustomerId,
COUNT(*) -COUNT(Balance) AS null_Balance,
COUNT(*) -COUNT(HasCrCard) AS null_HasCrCard,
COUNT(*) -COUNT(IsActiveMember) AS null_IsActiveMember

FROM bank_churn;

SELECT
  COUNT(*) - COUNT(Customer_id)    AS null_Customer_id,
  COUNT(*) - COUNT(credit_score)   AS null_credit_score,
  COUNT(*) - COUNT(age)            AS null_age,
  COUNT(*) - COUNT(balance)        AS null_balance,
  COUNT(*) - COUNT(churn)          AS null_churn
FROM bank_churn;


--To display null valiues in the column exited


SELECT 
COUNT(*) -COUNT(Exited)  AS null_Exited 
FROM bank_churn;


--total number of stayed and leaved persons in exited column 0 = stayed, 1 = churned/left


select Exited,Count(*) As total
From bank_churn
GROUP BY Exited;

--overall churn rate


select 
Round(100.0 * SUM(Exited)/COUNT(*),2) As churn_rate_percent
From bank_churn;


--churned rate by Geography(residence)


SELECT 
Geography,
count(*) as total,
Sum(Exited) As churned,
Round(100.0*Sum(Exited)/COUNT(*),2)As churn_rate
From bank_churn
GROUP BY Geography
ORDER BY churn_rate Desc;

--churn rate by gender


SELECT
Gender,
Count(*) as total,
Sum(Exited) as churned,
Round(100.*Sum(Exited)/COUNT(*),2)As churn_rate
From bank_churn
GROUP BY Gender
ORDER BY churn_rate DESC;

--churned rate by age group


select 
case
WHEN Age< 30 THEN 'YOUNG(<30)'
WHEN AGE<45 THEN 'MIDDLE(30-45)'
WHEN AGE<60 THEN 'SENIOR(45-60)'
ELSE 'Old(60+)'
END AS age_group,
COUNT(*) AS total,
SUM(Exited) AS churned,
ROUND(100.0*SUM(Exited)/COUNT(*),2)AS churn_rate
FROM bank_churn
GROUP BY age_group
ORDER BY churn_rate DESC;



--churned finding with help of balance.


select 
case
WHEN Balance =0 THEN 'No Balance'
WHEN Balance < 50000 THEN 'Low (< 50k)'
WHEN Balance < 100000 Then 'Medium(50k-1L)'
Else 'High(>1L)'
END AS Balance_segment,
COUNT(*) AS total,
SUM(Exited) as churned,
ROUND(100.0 * SUM(Exited) / COUNT(*),2) As churn_rate
From bank_churn
GROUP BY Balance_segment
ORDER BY churn_rate DESC;


--churn analysis based on product


SELECT
  NumOfProducts,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate
  
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts DESC;



--analysis of active member

SELECT
  IsActiveMember,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM bank_churn
GROUP BY IsActiveMember
ORDER BY churn_rate DESC;


--anlaysis by credit card


SELECT
  HasCrCard,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM bank_churn
GROUP BY HasCrCard
ORDER BY churn_rate DESC;


--Avg Stats Churned vs Stayed


SELECT
  Exited,
  ROUND(AVG(Age)::numeric, 1)              AS avg_age,
  ROUND(AVG(CreditScore)::numeric, 1)      AS avg_credit_score,
  ROUND(AVG(Balance)::numeric, 2)          AS avg_balance,
  ROUND(AVG(EstimatedSalary)::numeric, 2)  AS avg_salary,
  ROUND(AVG(Tenure)::numeric, 1)           AS avg_tenure
FROM bank_churn
GROUP BY Exited;



--analysis based on credit score


SELECT
  CASE
    WHEN CreditScore >= 800 THEN 'Excellent (800+)'
    WHEN CreditScore >= 700 THEN 'Good (700-799)'
    WHEN CreditScore >= 600 THEN 'Fair (600-699)'
    ELSE 'Poor (< 600)'
  END AS credit_group,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM bank_churn
GROUP BY credit_group
ORDER BY churn_rate DESC;





--analysis based on tenure.

SELECT
  Tenure,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100.0 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM bank_churn
GROUP BY Tenure
ORDER BY Tenure ASC;



--analysis based on all columns


SELECT
  CustomerId,
  Surname,
  Age,
  Balance,
  CreditScore,
  Geography,
  Gender,
  IsActiveMember,
  NumOfProducts
FROM bank_churn
WHERE Exited = 0
  AND IsActiveMember = 0
  AND Age > 40
  AND Balance > 100000
  AND NumOfProducts = 1
ORDER BY Balance DESC
LIMIT 20;




