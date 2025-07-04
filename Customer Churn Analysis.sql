 Customer Churn KPI Analysis

-- 1. Total Customers and Churn Rate
SELECT 
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  SUM(CASE WHEN churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
  ROUND(100.0 * SUM(CASE WHEN churn = 'No' THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_rate_pct
FROM telco_churn;

-- 2. Average Tenure of Churned vs Retained
SELECT 
  churn,
  ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_churn
GROUP BY churn;

-- 3. Average Monthly Charges (Churned vs Retained)
SELECT 
  churn,
  ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges
FROM telco_churn
GROUP BY churn;

-- 4. Revenue Lost Due to Churn
SELECT 
  ROUND(SUM(CAST(NULLIF(totalcharges, '') AS FLOAT)), 2) AS total_revenue_lost
FROM telco_churn
WHERE churn = 'Yes';

-- 5. Churn by Senior Citizen
SELECT 
  seniorcitizen,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY seniorcitizen;

-- 6. Churn by Gender
SELECT 
  gender,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY gender;

-- 7. Churn by Partner and Dependents
SELECT 
  partner, dependents,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY partner, dependents;

-- 8. Churn by Tenure Group
SELECT 
  CASE 
    WHEN tenure <= 12 THEN '0-12 months'
    WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
    WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
    ELSE '49+ months'
  END AS tenure_group,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY tenure_group
ORDER BY tenure_group;

-- 9. Churn by Phone and Multiple Lines
SELECT 
  phoneservice, multiplelines,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_churn
GROUP BY phoneservice, multiplelines;

-- 10. Churn by Internet Service
SELECT 
  internetservice,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY internetservice;

-- 11. Churn by Tech Support / Security Features
SELECT 
  techsupport,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY techsupport;

-- 12. Churn by Streaming Services
SELECT 
  streamingtv, streamingmovies,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_churn
GROUP BY streamingtv, streamingmovies;

-- 13. Churn by Contract Type
SELECT 
  contract,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY contract;

-- 14. Churn by Paperless Billing
SELECT 
  paperlessbilling,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY paperlessbilling;

-- 15. Churn by Payment Method
SELECT 
  paymentmethod,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY paymentmethod;

-- 16. Top Churn Predictors (Correlation-like Summary)
SELECT 
  internetservice, contract, techsupport, paymentmethod, gender,
  COUNT(*) AS total,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_churn
GROUP BY internetservice, contract, techsupport, paymentmethod, gender
ORDER BY churned DESC
LIMIT 10;


