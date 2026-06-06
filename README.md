# 📊 Superstore Sales & Profit Analysis

Identifying root causes of profit decline in retail data by analyzing discount strategy, shipping costs, and product performance — enabling data-driven business decisions.

---

## 🔍 Overview

A retail superstore is experiencing a puzzling problem: **sales are growing, but profits are declining**. This project digs into the data to find out exactly why — and what the business should do about it.

---

## 🎯 Objectives

- Analyze sales and profit trends over time
- Identify key factors causing margin decline
- Detect loss-making products, regions, and categories
- Quantify the impact of discounting on profitability
- Provide actionable business recommendations

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|---|---|
| Python (Pandas, Matplotlib, Seaborn) | Data analysis and visualization |
| SQL (MySQL) | Trend analysis using Window Functions (LAG, LEAD) |
| Power BI | Interactive dashboard for business reporting |

---

## 📂 Files in This Repository

| File | Description |
|---|---|
| `SuperStoreOrders.csv` | Raw dataset |
| `Superstore_Analysis.ipynb` | Python analysis notebook |
| `Superstore_Analysis.sql` | SQL queries with window functions |
| `Superstore_Analysis_Dashboard.pbix` | Power BI dashboard |
| `Superstore-Sales-and-Profit-Analysis.pdf` | Project report (PDF) |
| `Superstore_Analysis_Report.docx` | Project report (Word) |

---

## 🧠 Key Insights

- **Discounts above 20% consistently result in negative profit margins** — heavy discounting is the #1 driver of losses
- **Furniture category (especially Tables) is the most unprofitable** category, generating losses despite high sales volume
- **The Central region generates the most losses** compared to other regions
- **High shipping costs on low-value orders** erode margins significantly
- Sales volume and profit are negatively correlated in discounted segments — more sales does not mean more profit

---

## 🔬 Root Cause Analysis

The profit decline is driven by a combination of factors:

| Factor | Impact |
|---|---|
| High discounting on low-margin products | Primary driver of losses |
| Elevated shipping costs | Reduces net margins on small orders |
| Unfavorable product mix (Furniture) | Negative profit despite strong sales |
| Regional inefficiencies (Central) | Consistent loss-making geography |

---

## 📊 Power BI Dashboard

The interactive dashboard includes:
- Sales vs Profit trend (line chart)
- Profit margin by category and sub-category
- Discount impact analysis (scatter plot)
- Region performance heatmap
- Top loss-making products

**Interactive filters:** Category | Region | Segment | Year | Discount Range

### Dashboard Preview
https://github.com/hemnath126-collab/Superstore-Sales-Profit-Analysis/blob/main/Dashbord%20Screenshot-1.png

https://github.com/hemnath126-collab/Superstore-Sales-Profit-Analysis/blob/main/Dashbord%20Screenshot-2.png

## 💡 Business Recommendations

1. **Cap discounts at 15–20%** — discounts beyond this threshold consistently produce losses
2. **Review Furniture category pricing** — particularly Tables; consider discontinuing or repricing
3. **Optimize shipping strategy** — apply minimum order value thresholds for free shipping
4. **Focus on Technology category** — highest margin products with consistent profitability
5. **Audit Central region operations** — identify whether losses are driven by pricing, logistics, or product mix

---

## 🚀 Future Improvements

- Build a discount optimization model using machine learning
- Forecast regional sales trends with time series analysis
- Create a profitability scoring system per product SKU

---

## 📌 Conclusion

The business shows strong sales performance but weak profitability. The core issue is not a revenue problem — it's a **cost and pricing strategy problem**. Optimizing discounting, logistics, and product mix can significantly improve margins without sacrificing sales volume.

---

## ⭐ Skills Demonstrated

`Root Cause Analysis` `SQL Window Functions` `Python EDA` `Power BI` `Profitability Analysis` `Business Recommendations` `Data Storytelling`

---

## 💼 Author

**Hemnath S**  
Data Analyst | Python | SQL | Power BI  
📧 hemnath126@gmail.com | 🔗 [GitHub](https://github.com/hemnath126-collab)

