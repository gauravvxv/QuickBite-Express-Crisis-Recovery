# 🍔 QuickBite Express – Crisis Recovery Analytics

## 📌 Project Overview

QuickBite Express is a **data analytics project** focused on analyzing the impact of a major operational crisis that occurred in **June 2025** at a Bangalore-based online food delivery startup. The project uses **Python, SQL, and Power BI** to measure crisis impact, track recovery performance, and generate actionable business insights.

The analysis highlights how the crisis affected **orders, revenue, customer retention, delivery performance, and customer satisfaction**, and provides **data-backed recommendations** to support long-term recovery and growth.

---

## 🎯 Business Context & Problem Statement

QuickBite Express, founded in 2020, faced a significant crisis in June 2025 due to:

* Food safety concerns at partner restaurants
* A week-long delivery outage during the monsoon season

### 🚨 Impact of the Crisis

* Sharp decline in daily orders and revenue
* Significant drop in customer ratings
* Increased cancellations and delivery delays
* Loss of restaurant partners to competitors

---

## 🎯 Objectives of the Analysis

* Measure the impact of the crisis on **orders, revenue, and customers**
* Identify key issues affecting **delivery performance**
* Analyze **customer satisfaction and experience trends**
* Track **city-level recovery performance**
* Provide **actionable recommendations** for business recovery

---

## 🗂️ Dataset Overview

**Time Period:** January 2025 – September 2025

**Tables Used:**

* Customers
* Orders
* Ratings
* Delivery
* Restaurants

---

## ❓ Key Business Questions Answered (SQL)

### 📉 Crisis Impact on Orders

* Orders dropped from **113,806 (Pre-Crisis)** to **35,360 (Crisis)**
* **61% decline** in total orders

### 💰 Revenue Loss Analysis

* Pre-Crisis Revenue: **₹37.62M**
* Crisis Revenue: **₹10.94M**
* Revenue Loss: **₹26.68M**
* **70.92% revenue drop**

### 👥 Customer Churn

* Active customers before crisis: **86.8K**
* Returned during crisis: **14.0K**
* **Customer churn rate: 83.92%**

### 🚚 Delivery Performance

* Avg delivery time increased from **39.5 mins → 60.3 mins (52%)**
* **63.46% of orders were delivered late**
* Late deliveries had higher cancellation rate (**8.01% vs 6.47%**)

### ⭐ Customer Ratings

* Pre-Crisis: **4.5**
* Crisis: **2.5**
* Recovery: **2.4**

### 🌆 City-wise Decline

* All major cities faced **~60–62% decline**
* **Chennai** was the worst hit (**62.48% decline**)

### 📢 Acquisition Channel Performance

* **Organic** had the highest returning customers (**35.86%**)
* Paid campaigns had the lowest retention (**30.45%**)

---

## 📊 Dashboards & Visualizations (Power BI)

### 1️⃣ Crisis Overview Dashboard

<img width="726" height="410" alt="Crisis Overview" src="https://github.com/user-attachments/assets/3ebf666d-02fb-491a-89ed-b27fac7f97c6" />


**Summary:**
The Crisis Overview Dashboard highlights the overall business impact of the June 2025 crisis on QuickBite Express. Average daily orders decline sharply from 22.8k to 8.84k during the crisis, reflecting a 61% drop, while total revenue fell by 71%, from ₹37.62M to ₹10.94M.

Order trends show a sharp fall in June with 9,293 orders, followed by continued decline in July and August. A slight improvement appears in September with 8,694, indicating early recovery. Revenue trends mirror this pattern, dropping sharply in June to ₹28,87,866 and recovering marginally to ₹26,84,804 in September, but still remaining below pre-crisis levels.

---

### 2️⃣ Delivery & Rating Dashboard

<img width="724" height="410" alt="devliery" src="https://github.com/user-attachments/assets/f1c40746-71bd-4c3c-966f-8a2e4d948d77" />


**Summary:**
During the crisis, delivery performance declined sharply. Average delivery time increased from 39m 52s to 60m 12s (52%), while customer ratings dropped from 4.5 to 2.5 (-80%).

Late deliveries had higher cancellations (7,623) compared to on-time orders (3,489). Late orders were highest pre-crisis (64,818), fell sharply during the crisis (7,948), and partially recovered (23,097). Overall, delivery performance worsened during the crisis and recovered only partially.


---

### 3️⃣ Customer Experience Dashboard

<img width="726" height="409" alt="Customer" src="https://github.com/user-attachments/assets/2e245b13-73cc-4099-a64a-c385ff3a8b10" />


**Summary:**
The Customer Overview shows that the June 2025 crisis had a strong negative impact on QuickBite Express. The platform had 86.8K active customers before the crisis, but only 14.0K customers returned during the crisis, resulting in a high churn rate of 84%. Monthly customer counts, which were above 20K before the crisis, dropped sharply to around 8K per month during the crisis.

New customer acquisition was hit the hardest, falling from 21K-13K pre-crisis to 4.7K–3.8K during the crisis, while returning customers stayed relatively stable at around 4.0K–4.4K. In terms of acquisition channels, Organic performed best with 52K customers, followed by Paid (24K), Referral (14K), and Social (10K), showing that organic and referral channels are key for customer recovery and retention.


---

### 4️⃣ City & Restaurant Impact Dashboard

<img width="736" height="412" alt="city" src="https://github.com/user-attachments/assets/de8bb46a-8316-4d30-8e66-e2704ed001dd" />


**Summary:**

The City & Restaurant Impact dashboard shows that the June 2025 crisis affected 8 major cities, resulting in a total revenue loss of ₹26.68M. Chennai was the worst-hit city, recording a 62.48% decline in orders, followed closely by Kolkata (61.49%), Bengaluru (61.46%), and Hyderabad (61.14%). Overall, city-wise order declines ranged between 59.86% and 62.48%, indicating a widespread and uniform impact across regions.

From a restaurant perspective, 19.98K restaurants were impacted during the crisis. Active restaurants dropped from 19.91K pre-crisis to 16.59K during the crisis, reflecting a loss of over 3.3K active restaurants. Average orders declined sharply across all cities for example, Bengaluru fell from 5.6K to 2.2K, Delhi from 3.4K to 1.3K, and Mumbai from 3.4K to 1.3K orders highlighting a significant reduction in restaurant activity and demand during the crisis period.


---

### 5️⃣ Recovery Performance Dashboard

<img width="732" height="409" alt="Recovery" src="https://github.com/user-attachments/assets/8cae9988-babc-4db5-9de2-f71308085a59" />


**Summary:**
The recovery dashboard shows partial business improvement after the crisis. Average recovery orders stand at 8.78K, which is 38.6% of pre-crisis levels, generating ₹8.14M in recovered revenue. Monthly revenue stabilized between ₹2.64M–₹2.89M, while orders dipped from 9.3K in June to 8.6K in August before a slight recovery to 8.7K in September.

Customer experience remains a concern during recovery. Average ratings peaked at 2.69 in July but declined to 2.31 by September, and delivery time showed minimal improvement, hovering around 60 minutes. City-wise recovery is consistent, ranging from 37.4% to 40%, with Pune (40%) performing best and Chennai (37%) lagging, indicating recovery is underway but not yet strong or stable.


---

## 📈 Key Insights & Findings

* Crisis caused **61% order decline** and **71% revenue drop**
* Delivery delays were the **primary driver** of cancellations and low ratings
* Customer trust was heavily damaged, leading to **84% churn**
* Recovery is **partial and unstable**, with experience metrics still weak

---

## 🧠 Business Recommendations

* **Fix delivery operations** as top priority (routing, rider availability, SLA monitoring)
* **Launch win-back campaigns** to reduce high churn
* **Focus on Organic & Referral channels** instead of Paid
* **Support high-impact cities and restaurants first**
* **Re-activate inactive restaurant partners** with incentives
* **Track recovery quality**, not just order volume
* **Set city-level benchmarks** using top performers like Pune

---

## 🛠️ Tools & Technologies

* **Python & Pandas** – Data cleaning, preprocessing, feature creation, EDA
* **SQL** – Querying, filtering, business analysis
* **Power BI** – KPIs, dashboards, data visualization

---

## 📽️ Project Presentation

👉 [View Project Presentation](https://docs.google.com/presentation/d/1n8ETPXH0o8b78heyyQfRf6dyS1oIowrU-OKFpRRmZVk/edit?usp=sharing)

---

## 📄 License

This project is licensed under the **MIT License**.

---

## 👤 Author

**Gaurav Sharma**
Aspiring Data Analyst | Python • SQL • Power BI
