# 🏦 Bank Customer Churn Analysis



\## 📌 Project Overview

This project analyzes 10,000 bank customers 

to identify churn patterns and high risk customers

using PostgreSQL and Power BI.



\---



\## 🛠️ Tools Used

\- \*\*PostgreSQL\*\* — Data storage and SQL analysis

\- \*\*pgAdmin\*\* — Database management

\- \*\*Power BI\*\* — Dashboard and visualization

\- \*\*GitHub\*\* — Project hosting



\---



\## 📊 Dataset

\- \*\*Source:\*\* Maven Analytics

\- \*\*Rows:\*\* 10,000

\- \*\*Columns:\*\* 13

\- \*\*Churn Column:\*\* Exited (0 = Stayed, 1 = Churned)



\### Columns Description

| Column | Description |

|---|---|

| CustomerId | Unique customer ID |

| Surname | Customer last name |

| CreditScore | Customer credit score |

| Geography | Country (France, Germany, Spain) |

| Gender | Male or Female |

| Age | Customer age |

| Tenure | Years with bank |

| Balance | Account balance |

| NumOfProducts | Number of bank products |

| HasCrCard | Has credit card (1=Yes, 0=No) |

| IsActiveMember | Active member (1=Yes, 0=No) |

| EstimatedSalary | Estimated salary |

| Exited | Churned (1=Yes, 0=No) |



\---



\## 🔍 Analysis \& Findings



\### 1️⃣ Overall Churn Rate

\*\*Result:\*\* 20.37%

```sql

SELECT

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate\_percent

FROM bank\_churn;

```

\*\*Finding:\*\* The bank is losing 1 in 5 customers

which is above industry average and needs

immediate attention.



\---



\### 2️⃣ Churn by Gender

\*\*Result:\*\* Female 25.07% | Male 16.46%

```sql

SELECT Gender,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY Gender

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* Female customers churn 52% more

than male customers. Bank should create targeted

retention strategies for female customers.



\---



\### 3️⃣ Churn by Geography

\*\*Result:\*\* Germany 32.44% | Spain 16.67% | France 16.15%

```sql

SELECT Geography,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY Geography

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* Germany has almost double the churn

rate of France and Spain. Urgent investigation

needed for German market.



\---



\### 4️⃣ Churn by Age Group

\*\*Result:\*\* Senior (45-60) has highest churn rate

```sql

SELECT

&#x20; CASE

&#x20;   WHEN Age < 30 THEN 'Young (<30)'

&#x20;   WHEN Age < 45 THEN 'Middle (30-45)'

&#x20;   WHEN Age < 60 THEN 'Senior (45-60)'

&#x20;   ELSE 'Old (60+)'

&#x20; END AS age\_group,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY age\_group

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* Senior customers aged 45-60 are

most at risk. Bank should create special

retention programs for this age group.



\---



\### 5️⃣ Churn by Balance

\*\*Result:\*\* High Balance (>1L) churn rate 25.23%

```sql

SELECT

&#x20; CASE

&#x20;   WHEN Balance = 0 THEN 'No Balance'

&#x20;   WHEN Balance < 50000 THEN 'Low (<50k)'

&#x20;   WHEN Balance < 100000 THEN 'Medium (50k-1L)'

&#x20;   ELSE 'High (>1L)'

&#x20; END AS balance\_segment,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY balance\_segment

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* High balance customers are leaving

the most. This is alarming as these are the

most valuable customers to the bank.



\---



\### 6️⃣ Churn by Number of Products

\*\*Result:\*\* Customers with 4 products have highest churn rate

```sql

SELECT NumOfProducts,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY NumOfProducts

ORDER BY NumOfProducts;

```

\*\*Finding:\*\* Customers with 4 products churn

the most suggesting they feel overwhelmed

or overcharged by the bank.



\---



\### 7️⃣ Churn by Active Member

\*\*Result:\*\* Inactive members churn at 26.85%

```sql

SELECT IsActiveMember,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY IsActiveMember

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* Inactive members churn significantly

more. Customer engagement directly impacts

retention. Re-engagement campaigns are needed.



\---



\### 8️⃣ Churn by Credit Card

\*\*Result:\*\* No Card 20.81% | Has Card 20.18%

```sql

SELECT HasCrCard,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY HasCrCard

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* Credit card ownership has almost

no impact on churn. Difference is only 0.63%.

Offering free credit cards is NOT an effective

retention strategy.



\---



\### 9️⃣ Average Stats — Churned vs Stayed

\*\*Result:\*\* Churned customers are older (44.8)

with higher balance (91,108)

```sql

SELECT Exited,

&#x20; ROUND(AVG(Age)::numeric, 1) AS avg\_age,

&#x20; ROUND(AVG(CreditScore)::numeric, 1) AS avg\_credit\_score,

&#x20; ROUND(AVG(Balance)::numeric, 2) AS avg\_balance,

&#x20; ROUND(AVG(EstimatedSalary)::numeric, 2) AS avg\_salary,

&#x20; ROUND(AVG(Tenure)::numeric, 1) AS avg\_tenure

FROM bank\_churn

GROUP BY Exited;

```

\*\*Finding:\*\* Churned customers are on average

7 years older and have higher balances.

Age and balance are strongest churn indicators.



\---



\### 🔟 Churn by Credit Score Group

\*\*Result:\*\* Poor (<600) 21.75% | Excellent (800+) 19.54%

```sql

SELECT

&#x20; CASE

&#x20;   WHEN CreditScore >= 800 THEN 'Excellent (800+)'

&#x20;   WHEN CreditScore >= 700 THEN 'Good (700-799)'

&#x20;   WHEN CreditScore >= 600 THEN 'Fair (600-699)'

&#x20;   ELSE 'Poor (< 600)'

&#x20; END AS credit\_group,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY credit\_group

ORDER BY churn\_rate DESC;

```

\*\*Finding:\*\* Credit score has minimal impact

on churn. Difference between best and worst

group is only 2.21%.



\---



\### 1️⃣1️⃣ Churn by Tenure

\*\*Result:\*\* New customers (0 years) churn at 23%

```sql

SELECT Tenure,

&#x20; COUNT(\*) AS total,

&#x20; SUM(Exited) AS churned,

&#x20; ROUND(100.0 \* SUM(Exited) / COUNT(\*), 2) 

&#x20; AS churn\_rate

FROM bank\_churn

GROUP BY Tenure

ORDER BY Tenure ASC;

```

\*\*Finding:\*\* New customers churn the most.

First year is most critical for retention.

Bank should focus heavily on new customer

onboarding experience.



\---



\### 1️⃣2️⃣ High Risk Customers

\*\*Result:\*\* 20 high risk customers identified

```sql

SELECT CustomerId, Surname, Age,

&#x20; Balance, CreditScore, Geography,

&#x20; Gender, IsActiveMember, NumOfProducts

FROM bank\_churn

WHERE Exited = 0

&#x20; AND IsActiveMember = 0

&#x20; AND Age > 40

&#x20; AND Balance > 100000

&#x20; AND NumOfProducts = 1

ORDER BY Balance DESC

LIMIT 20;

```

\*\*Finding:\*\* 20 currently active customers

show all warning signs of churning. Bank

should immediately contact these customers

with personalized retention offers.



\---



\## 💡 Business Recommendations



1\. \*\*Target Female Customers\*\* — Create special

&#x20;  retention offers for female customers



2\. \*\*Focus on Germany\*\* — Investigate why Germany

&#x20;  has double the churn rate



3\. \*\*Senior Customer Program\*\* — Special packages

&#x20;  for customers aged 45-60



4\. \*\*Re-engage Inactive Members\*\* — Launch

&#x20;  re-engagement campaigns immediately



5\. \*\*New Customer Onboarding\*\* — Improve first

&#x20;  year experience to reduce early churn



6\. \*\*High Balance Retention\*\* — Priority service

&#x20;  for customers with balance above 1 Lakh



\---



\## 📈 Dashboard

!\[Bank Churn Dashboard](dashboard.png)



\---



\## 📁 Project Files

| File | Description |

|---|---|

| `bank\_churn\_queries.sql` | All 12 SQL analyses |

| `dashboard.png` | Power BI dashboard |

| `README.md` | Project documentation |



\---



\## 🚀 How to Run

1\. Download dataset from Maven Analytics

2\. Create table in PostgreSQL

3\. Import CSV data into pgAdmin

4\. Run queries from bank\_churn\_queries.sql

5\. Open Power BI and load CSV file



\---



\## 👤 Author

\*\*Avinash Tayade\*\*

\- GitHub: avinashtayade-data

\- LinkedIn: [https://www.linkedin.com/in/avinash-tayade](https://www.linkedin.com/in/avinash-tayade)
