-- Create table telco_churn to store the data from the telco customer churn dataset

CREATE TABLE telco_churn (
    CustomerID VARCHAR(20),
    Count INT,
    Country VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50),
    ZipCode VARCHAR(10),
    LatLong VARCHAR(50),
    Latitude FLOAT,
    Longitude FLOAT,
    Gender VARCHAR(10),
    SeniorCitizen VARCHAR(5),
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    TenureMonths INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges FLOAT,
    TotalCharges VARCHAR(20),
    ChurnLabel VARCHAR(5),
    ChurnValue INT,
    ChurnScore INT,
    CLTV INT,
    ChurnReason VARCHAR(100)
);

-- Check for NULLs in key columns
SELECT 
  SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customerID,
  SUM(CASE WHEN TenureMonths IS NULL THEN 1 ELSE 0 END) AS null_tenure,
  SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS null_monthly,
  SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total,
  SUM(CASE WHEN ChurnLabel IS NULL THEN 1 ELSE 0 END) AS null_churn
FROM telco_churn;
-- Output: There were no NULL values in the key columns, which is good for our analysis. However, we should also check for empty strings in TotalCharges as it is stored as VARCHAR and may contain empty strings instead of NULLs.

-- Check for empty strings in TotalCharges as total charges had some empty strings ' ' instead of NULLs
SELECT COUNT(*) 
FROM telco_churn 
WHERE TRIM(TotalCharges) = '';

--Output: Got output 11, which means there are 11 records with empty strings in TotalCharges. We can update those empty strings to NULL for better data handling.

-- Distinct churn values and their counts to understand the distribution of churn in the dataset
SELECT DISTINCT ChurnLabel, COUNT(*) 
FROM telco_churn 
GROUP BY ChurnLabel;

-- Output: The distribution of churn is as follows: no is 5174 and yes is 1869, which indicates that the dataset is imbalanced with more non-churned customers than churned customers. This is important to consider when building predictive models.

-- Count of customers by contract type to understand the distribution of contract types in the dataset
SELECT Contract, COUNT(*) 
FROM telco_churn 
GROUP BY Contract;
-- Output: The distribution of contract types is as follows: Month-to-month is 3875, One year is 1473, and Two year is 1695. This indicates that the majority of customers are on month-to-month contracts, which may have implications for churn rates and customer retention strategies.

-- See what is the min, max, and average tenure of customers in the dataset to understand the range and central tendency of customer tenure
SELECT 
  MIN(TenureMonths) AS min_tenure, 
  MAX(TenureMonths) AS max_tenure, 
  ROUND(AVG(TenureMonths), 1) AS avg_tenure
FROM telco_churn;
-- Output: The minimum tenure is 0 months, the maximum tenure is 72 months, and the average tenure is approximately 32.4 months. This indicates that there are customers who have just joined (0 months) as well as long-term customers (up to 72 months), with an average tenure of around 2.7 years.

-- Overall churn rate
SELECT
  COUNT(*) AS total_customers,
  SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn;
-- Output: The total number of customers is 7043, the number of churned customers is 1869, and the overall churn rate is approximately 26.54%. This indicates that about a quarter of the customers in the dataset have churned, which is a significant proportion and highlights the importance of understanding the factors contributing to churn.

-- Churn rate by contract type to understand how churn varies across different contract types and identify which contract types are more prone to churn
SELECT Contract, COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM telco_churn 
GROUP BY Contract 
ORDER BY churn_rate DESC;
-- Output: The churn rates by contract type are as follows: Month-to-month has a churn rate of approximately 42.71%, One year has a churn rate of approximately 11.27%, and Two year has a churn rate of approximately 2.83%. This indicates that customers on month-to-month contracts are significantly more likely to churn compared to those on longer-term contracts, which may suggest that offering incentives for longer-term contracts could help reduce churn.

-- Churn rate by tenure buckets to understand how churn varies across different tenure lengths and identify if there are specific tenure ranges that are more prone to churn
SELECT
  CASE WHEN TenureMonths <= 12 THEN '1. 0-12 months'
       WHEN TenureMonths <= 24 THEN '2. 13-24 months'
       WHEN TenureMonths <= 48 THEN '3. 25-48 months'
       ELSE '4. 49+ months' END AS tenure_bucket,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM telco_churn 
GROUP BY tenure_bucket 
ORDER BY tenure_bucket;
-- Output: The churn rates by tenure buckets are as follows: 0-12 months has a churn rate of approximately 47.44%, 13-24 months has a churn rate of approximately 28.79%, 25-48 months has a churn rate of approximately 20.39%, and 49+ months has a churn rate of approximately 9.51%. This indicates that customers with shorter tenure are more likely to churn, while those with longer tenure are less likely to churn, which may suggest that early engagement and retention efforts are crucial for new customers.

-- Churn rate by payment method to understand how churn varies across different payment methods and identify if certain payment methods are associated with higher churn rates
SELECT PaymentMethod,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM telco_churn 
GROUP BY PaymentMethod 
ORDER BY churn_rate DESC;
-- Output: The churn rates by payment method are as follows: Electronic check has a churn rate of approximately 45.29%, Mailed check has a churn rate of approximately 19.11%, Bank transfer (automatic) has a churn rate of approximately 16.71%, and Credit card (automatic) has a churn rate of approximately 15.24%. This indicates that customers using electronic checks are significantly more likely to churn compared to those using other payment methods, which may suggest that offering incentives for more secure and convenient payment methods could help reduce churn.

-- Average monthly charges and tenure by churn label to understand how monthly charges and tenure differ between churned and non-churned customers, which can provide insights into the characteristics of customers who are more likely to churn
SELECT ChurnLabel,
  ROUND(AVG(MonthlyCharges)::numeric, 2) AS avg_monthly_charges,
  ROUND(AVG(TenureMonths)::numeric, 1) AS avg_tenure_months
FROM telco_churn 
GROUP BY ChurnLabel;
-- Output: The average monthly charges for non-churned customers is approximately $61.27, while for churned customers it is approximately $74.44. The average tenure for non-churned customers is approximately 37.6 months, while for churned customers it is approximately 18.0 months. This indicates that churned customers tend to have higher monthly charges and shorter tenure compared to non-churned customers, which may suggest that high costs and lack of long-term engagement are factors contributing to churn.

-- Monthly revenue at risk by contract type to understand how much monthly revenue is at risk due to churn for each contract type, which can help prioritize retention efforts based on potential revenue loss
SELECT Contract,
  ROUND(SUM(CASE WHEN ChurnLabel = 'Yes' THEN MonthlyCharges ELSE 0 END)::numeric, 2) AS monthly_revenue_at_risk
FROM telco_churn 
GROUP BY Contract 
ORDER BY monthly_revenue_at_risk DESC;
-- Output: The monthly revenue at risk due to churn by contract type is as follows: Month-to-month has approximately $120,847 at risk, One year has approximately $14118 at risk, and Two year has approximately $4165 at risk. This indicates that the majority of the revenue at risk due to churn comes from customers on month-to-month contracts, which may suggest that retention efforts should be focused on this segment to mitigate potential revenue loss.

-- Churn rate by internet service to understand how churn varies across different internet service types and identify if certain internet services are associated with higher churn rates
SELECT InternetService,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM telco_churn 
GROUP BY InternetService 
ORDER BY churn_rate DESC;
-- Output: The churn rates by internet service are as follows: Fiber optic has a churn rate of approximately 41.89%, DSL has a churn rate of approximately 18.96%, and No internet service has a churn rate of approximately 7.4%. This indicates that customers with fiber optic internet service are significantly more likely to churn compared to those with DSL or no internet service, which may suggest that there are issues with the fiber optic service that need to be addressed to reduce churn.

-- Churn rate by SeniorCitizen status to understand how churn varies between senior citizens and non-senior citizens, which can provide insights into whether age is a factor contributing to churn
SELECT SeniorCitizen,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN ChurnLabel = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM telco_churn 
GROUP BY SeniorCitizen 
ORDER BY churn_rate DESC;
-- Output: The churn rates by SeniorCitizen status are as follows: Senior citizens have a churn rate of approximately 41.68%, while non-senior citizens have a churn rate of approximately 23.61%. This indicates that senior citizens are more likely to churn compared to non-senior citizens, which may suggest that there are specific needs or concerns for senior customers that need to be addressed to reduce churn in this segment.