# Customer Churn Analysis — Telecom Dataset

## Project Status
✅ Day 3 Complete — Dashboard Published

## Live Dashboard
🔗 [View Live Tableau Dashboard](https://public.tableau.com/views/CustomerChurnAnalysisTelecomDataset/Dashboard)

## Problem Statement
A telecom company is losing 26.54% of its customers — roughly 1 in 4. This analysis identifies which customer segments churn most and why, and provides actionable data-driven recommendations to reduce churn and recover lost revenue.

## Dataset
- Source: IBM Telco Customer Churn (Kaggle)
- 7,043 customers, 33 columns
- Location: California, USA
- Key columns: Contract type, Tenure, Monthly Charges, Internet Service, Payment Method, Churn Label, Churn Score, CLTV, Churn Reason

**Data Quality Issues Found & Fixed:**
- `Total Charges` had 11 blank values (0.15% of records) — likely customers who just joined and haven't been billed yet. Imputed with median value during Python cleaning.
- `Total Charges` was stored as text instead of a number — converted to float during cleaning.
- Dataset had extra location columns not needed for analysis — dropped during cleaning.

## Tools & Stack
- PostgreSQL 18 — data storage and SQL analysis
- pgAdmin 4 — SQL query interface
- Python 3.14 — data cleaning, EDA, and modeling
- Pandas — data manipulation
- Seaborn & Matplotlib — data visualization
- Scikit-learn — logistic regression model
- Jupyter Notebook (VS Code) — development environment
- Tableau Public — interactive dashboard

## File Structure
```
churn_project/
├── sql/
│   └── foundation_queries.sql
├── notebooks/
│   └── churn_analysis.ipynb
├── visuals/
│   ├── churn_distribution.png
│   ├── tenure_churn.png
│   ├── charges_churn.png
│   ├── contract_churn.png
│   └── correlation_heatmap.png
├── data/
│   └── telco_churn_cleaned.csv
└── README.md
```

## Key Findings

### Finding 1 — Contract Type is the #1 Actionable Risk Factor
Month-to-month customers churn at **42.71%** vs just **2.83%** for two year contracts — a **15x difference**. With 55% of all customers on month-to-month plans and $120,847 in monthly revenue at risk from this segment alone, converting customers to longer contracts is the single highest-impact retention lever available.

### Finding 2 — The First 12 Months is the Danger Zone
**47.44%** of customers in their first year churn — nearly double the overall churn rate of 26.54%. The logistic regression confirms tenure is the second strongest predictor of churn (coefficient -1.43). If the company can retain customers through year one, churn drops to 20% by year two and just 9.51% by year four.

### Finding 3 — High Paying Customers Feel the Least Value
Churned customers paid **$74.44/month** vs $61.27 for retained customers — a $13 difference. Monthly Charges is the second strongest predictor in the logistic regression model (coefficient +1.02). Fiber optic customers — the highest priced service — churn at **41.89%**, more than double DSL customers at 18.96%, suggesting a price-value mismatch in the premium tier.

## Recommendations
1. **Launch a contract conversion incentive** — offer month-to-month customers a meaningful discount (1–2 months free) to switch to annual contracts. Even converting 10% of month-to-month customers could save ~$12,000/month in lost revenue.
2. **Build an early tenure retention program** — implement a proactive check-in or loyalty reward at the 3-month and 6-month marks specifically targeting new customers. The data shows if you can get a customer past 12 months their churn risk drops dramatically.
3. **Investigate fiber optic value perception** — conduct customer satisfaction surveys specifically for fiber optic customers. The 41.89% churn rate despite being a premium service strongly suggests either a pricing issue or a service quality problem worth investigating.
4. **Nudge customers toward automatic payments** — electronic check customers churn at 45.29% vs ~15% for automatic payment customers. Adding friction to cancellation by encouraging auto-pay enrollment could meaningfully reduce churn.

## SQL Analysis Results

### Overall Churn Rate
**26.54%** — 1,869 out of 7,043 customers have left.

### Churn by Contract Type
| Contract | Customers | Churn Rate |
|----------|-----------|------------|
| Month-to-month | 3,875 | 42.71% |
| One year | 1,473 | 11.27% |
| Two year | 1,695 | 2.83% |

### Churn by Tenure Bucket
| Tenure | Customers | Churn Rate |
|--------|-----------|------------|
| 0-12 months | 2,186 | 47.44% |
| 13-24 months | 1,024 | 28.71% |
| 25-48 months | 1,594 | 20.39% |
| 49+ months | 2,239 | 9.51% |

### Churn by Payment Method
| Payment Method | Churn Rate |
|----------------|------------|
| Electronic check | 45.29% |
| Mailed check | 19.11% |
| Bank transfer (automatic) | 16.71% |
| Credit card (automatic) | 15.24% |

### Churned vs Retained Customer Profile
| Metric | Churned | Retained |
|--------|---------|----------|
| Avg Monthly Charges | $74.44 | $61.27 |
| Avg Tenure | 18 months | 37.6 months |

### Monthly Revenue at Risk
| Contract | Monthly Revenue Lost |
|----------|---------------------|
| Month-to-month | $120,847 |
| One year | $14,118 |
| Two year | $4,165 |
| **Total** | **$139,130** |

### Churn by Internet Service
| Internet Service | Customers | Churn Rate |
|-----------------|-----------|------------|
| Fiber optic | 3,096 | 41.89% |
| DSL | 2,421 | 18.96% |
| No internet | 1,526 | 7.40% |

### Churn by Senior Citizen Status
| Senior Citizen | Customers | Churn Rate |
|----------------|-----------|------------|
| Yes | 1,142 | 41.68% |
| No | 5,901 | 23.61% |

## Python EDA & Modeling

### Data Cleaning Summary
- Loaded raw CSV (7,043 rows, 33 columns)
- Converted `Total_Charges` from string to float
- Imputed 11 blank `Total_Charges` values with median
- Dropped 5 non-analytical columns (CustomerID, Count, Country, State, Lat Long)
- Created `Churn_Binary` column (Yes=1, No=0) for modeling
- Renamed all columns replacing spaces with underscores
- Saved cleaned dataset: `data/telco_churn_cleaned.csv` (7,043 rows, 29 columns)

### EDA Visualizations
All plots saved in `/visuals`:
- **Churn Distribution** — 5,174 retained vs 1,869 churned (26.54% churn rate)
- **Tenure by Churn** — churned customers heavily concentrated in first 12 months
- **Monthly Charges by Churn** — churned customers median ~$80 vs retained ~$64
- **Churn Rate by Contract** — month-to-month 42.71% vs two year 2.83%
- **Correlation Heatmap** — tenure (-0.35) and churn score (+0.66) strongest numeric correlates

### Logistic Regression Model
- **Accuracy: 89%** on held-out test set (1,409 customers)
- Train/test split: 80/20 with random_state=42
- Features scaled with StandardScaler

**Model Performance:**
| Class | Precision | Recall | F1-Score |
|-------|-----------|--------|----------|
| Retained (0) | 0.92 | 0.93 | 0.92 |
| Churned (1) | 0.81 | 0.79 | 0.80 |

**Feature Importance (Coefficients):**
| Feature | Coefficient | Direction |
|---------|-------------|-----------|
| Churn_Score | +4.24 | Strong churn driver |
| Monthly_Charges | +1.02 | Higher charges = more churn |
| CLTV | +0.02 | Minimal effect |
| Total_Charges | -0.02 | Minimal effect |
| Tenure_Months | -1.43 | Longer tenure = less churn |

## Tableau Dashboard
Built 4 interactive visualizations published on Tableau Public:
- **Overall Churn Rate KPI** — 26.54% headline number
- **Churn Rate by Contract Type** — 42.71% vs 11.27% vs 2.83%
- **Churn Rate by Customer Tenure** — 47.44% danger zone in first 12 months
- **Monthly Revenue at Risk** — $120,847 from month-to-month contracts alone

🔗 [View Live Dashboard](https://public.tableau.com/views/CustomerChurnAnalysisTelecomDataset/Dashboard)