# Customer Churn & Retention Analytics

## Project Overview

A telecom customer churn analysis project focused on identifying the key factors associated with customer churn and developing data-driven customer retention recommendations.

The analysis covers **7,043 customers** and examines contract type, tenure, monthly charges, payment method, internet service, and other customer attributes to understand churn patterns and identify high-risk customer segments.

## Problem Statement

The telecom company has an overall customer churn rate of **26.54%**, meaning roughly 1 in 4 customers have left.

The objective of this project is to:

- Identify customer segments with the highest churn rates
- Understand the factors associated with customer churn
- Analyze the relationship between churn, tenure, contract type, charges, and payment methods
- Perform exploratory data analysis and predictive modeling
- Develop actionable recommendations to improve customer retention

## Dataset

**Dataset:** IBM Telco Customer Churn Dataset

- **7,043 customers**
- **33 columns** in the raw dataset
- Customer-level telecom service and churn information
- Target variable: **Churn**

### Key Variables

- Contract
- Tenure Months
- Monthly Charges
- Total Charges
- Internet Service
- Payment Method
- Churn Label
- Churn Score
- CLTV
- Churn Reason

## Data Cleaning & Preparation

The raw dataset was cleaned and prepared using Python and Pandas.

Key preprocessing steps included:

- Converted `Total Charges` from text to numeric format
- Identified and handled **11 blank `Total Charges` values**
- Removed unnecessary location and administrative columns
- Created a binary churn variable for modeling
- Standardized column names
- Saved the cleaned dataset for further analysis

### Cleaning Summary

- Raw dataset: **7,043 rows × 33 columns**
- Blank `Total Charges` values handled: **11**
- Final cleaned dataset: **7,043 rows × 29 columns**

## Tools & Technologies

- **Python**
- **Pandas**
- **Matplotlib**
- **Seaborn**
- **Scikit-learn**
- **SQL**
- **PostgreSQL**
- **pgAdmin**
- **Jupyter Notebook**
- **VS Code**

## Project Structure

```text
customer-churn-analysis-main/
│
├── data/
│   ├── Telco_customer_churn.csv
│   └── telco_churn_cleaned.csv
│
├── notebooks/
│   └── churn_analysis.ipynb
│
├── sql/
│   └── foundation_queries.sql
│
├── visuals/
│   ├── churn_distribution.png
│   ├── tenure_churn.png
│   ├── charges_churn.png
│   ├── contract_churn.png
│   └── correlation_heatmap.png
│
└── readme.md

Key Findings
1. Contract Type Is a Major Churn Risk Factor
Month-to-month customers have a 42.71% churn rate, compared with only 2.83% for customers on two-year contracts.
Contract Type	Customers	Churn Rate
Month-to-month	3,875	42.71%
One year	1,473	11.27%
Two year	1,695	2.83%


The large difference suggests that customers with longer-term contracts are substantially more likely to remain with the company.
2. The First 12 Months Are the Highest-Risk Period
Customers in their first 12 months have a 47.44% churn rate, significantly higher than the overall churn rate of 26.54%.
Tenure	Customers	Churn Rate
0–12 months	2,186	47.44%
13–24 months	1,024	28.71%
25–48 months	1,594	20.39%
49+ months	2,239	9.51%


Churn decreases substantially as customer tenure increases, making the early customer lifecycle an important period for retention efforts.
3. Churned Customers Have Higher Monthly Charges
Average monthly charges differ between churned and retained customers.
Customer Status	Average Monthly Charges
Churned	$74.44
Retained	$61.27


Churned customers pay approximately $13 more per month on average than retained customers.
This suggests that pricing and perceived value may be important areas to investigate.
4. Payment Method Shows a Strong Churn Difference
Customers using electronic checks have a substantially higher churn rate than customers using automatic payment methods.
Payment Method	Churn Rate
Electronic check	45.29%
Mailed check	19.11%
Bank transfer (automatic)	16.71%
Credit card (automatic)	15.24%


This indicates that payment behavior may be associated with customer retention and should be considered when designing retention strategies.
5. Fiber Optic Customers Have Higher Churn
Internet Service	Customers	Churn Rate
Fiber optic	3,096	41.89%
DSL	2,421	18.96%
No internet	1,526	7.40%


Fiber optic customers show a considerably higher churn rate than DSL customers.
This may indicate a potential pricing, service quality, or perceived-value issue that requires further investigation.
6. Senior Citizen Customers Have Higher Churn
Senior Citizen	Customers	Churn Rate
Yes	1,142	41.68%
No	5,901	23.61%


Senior citizen customers have a higher observed churn rate and may benefit from targeted customer support and retention initiatives.
SQL Analysis
The project includes SQL-based analysis of customer churn patterns.
Overall Churn
26.54% — 1,869 out of 7,043 customers have churned.
Churn by Contract Type
Contract	Customers	Churn Rate
Month-to-month	3,875	42.71%
One year	1,473	11.27%
Two year	1,695	2.83%


Churn by Tenure
Tenure	Customers	Churn Rate
0–12 months	2,186	47.44%
13–24 months	1,024	28.71%
25–48 months	1,594	20.39%
49+ months	2,239	9.51%


Churn by Payment Method
Payment Method	Churn Rate
Electronic check	45.29%
Mailed check	19.11%
Bank transfer (automatic)	16.71%
Credit card (automatic)	15.24%


Monthly Revenue at Risk
The analysis estimates monthly revenue associated with churned customers across contract types.
Contract	Monthly Revenue Lost
Month-to-month	$120,847
One year	$14,118
Two year	$4,165
Total	$139,130


Month-to-month customers account for the largest share of monthly revenue associated with churn.
Python EDA & Visualization
Exploratory data analysis was performed using Pandas, Matplotlib, and Seaborn.
Visualizations
The project includes:
- Churn Distribution
  - 5,174 retained customers
  - 1,869 churned customers
  - 26.54% overall churn rate
- Tenure by Churn
  - Highlights the concentration of churn among customers with shorter tenure
- Monthly Charges by Churn
  - Compares monthly charges between churned and retained customers
- Churn Rate by Contract
  - Highlights the significant difference between month-to-month and long-term contracts
- Correlation Heatmap
  - Shows relationships between numerical customer attributes and churn-related variables
Logistic Regression Model
A Logistic Regression model was developed to analyze customer churn patterns and identify variables associated with churn.
Model Setup
- Train/test split: 80/20
- random_state = 42
- Features scaled using StandardScaler
- Test set: 1,409 customers
Model Performance
Accuracy: 89%
Class	Precision	Recall	F1-Score
Retained	0.92	0.93	0.92
Churned	0.81	0.79	0.80


Model Coefficients
Feature	Coefficient	Direction
Churn Score	+4.24	Higher churn risk
Monthly Charges	+1.02	Higher charges associated with churn
CLTV	+0.02	Minimal effect
Total Charges	-0.02	Minimal effect
Tenure Months	-1.43	Longer tenure associated with lower churn


The model indicates that higher monthly charges are associated with increased churn, while longer customer tenure is associated with lower churn.
Business Recommendations
1. Encourage Longer-Term Contracts
Target month-to-month customers with incentives to move toward annual or two-year contracts.
The strong difference in churn rates suggests that contract conversion could be an important retention strategy.
2. Focus on Early-Tenure Customers
Develop proactive onboarding and retention programs during the first 3–12 months.
Possible approaches include:
- Customer check-ins
- Loyalty incentives
- Personalized support
- Early satisfaction surveys
3. Investigate Fiber Optic Customer Experience
Analyze pricing, service quality, customer support, and perceived value among fiber optic customers.
The 41.89% churn rate indicates that this customer segment requires further investigation.
4. Encourage Automatic Payment Methods
Promote automatic payment methods among customers currently using electronic checks.
The substantially higher churn rate among electronic-check customers makes this an area worth investigating as part of retention initiatives.
Project Outcome
This analysis identifies customer segments and behavioral patterns associated with higher churn risk and translates those findings into practical retention strategies.
Key Business Insights
- Month-to-month customers have the highest churn rate
- Customers in their first 12 months represent the highest-risk tenure group
- Churned customers have higher average monthly charges
- Electronic-check customers have substantially higher churn
- Fiber optic customers show higher churn than other internet-service groups
- Longer customer tenure is associated with lower churn
