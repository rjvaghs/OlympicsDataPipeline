# OlympicsDataPipeline
End-to-end Olympics data pipeline using Azure Data Factory, Azure Synapse Analytics and PowerBI

## 📌 Project Overview
This project ingests **Olympics data from Kaggle** into **Azure Data Lake** and processes it using **Azure Synapse**. The pipeline includes:
- **Azure Function Blob Trigger**: Automatically unzips CSV files when uploaded.
- **Dataflow & Apache Spark**: Cleans and transforms the data.
- **Dedicated SQL Pool**: Stores processed data in staging and final tables.
- **Power BI**: Visualizes insights from the data.

## 📁 Project Structure
```
📂 olympics-azure-project
├── 📜 README.md  # Project documentation
├── 📂 azure-function
│   ├── blob_trigger_function.py  # Azure function to unzip files
│   ├── requirements.txt  # Dependencies for the function
├── 📂 synapse-pipeline
│   ├── ingest_olympics_pipeline.json  # Synapse pipeline JSON
│   ├── transformations_notebook.ipynb  # Apache Spark notebook for transformation
├── 📂 sql-scripts
│   ├── create_staging_table.sql  # SQL script for staging table
│   ├── insert_into_target.sql  # SQL script for final table
├── 📂 powerbi-report
│   ├── olympics_dashboard.pbix  # Power BI visualization
└── 📂 data-samples
    ├── sample_olympics_data.zip  # Sample ZIP file with CSVs
```

## ⚙️ Setup Instructions
### 1️⃣ **Azure Function - Blob Trigger**
1. Navigate to **Azure Portal** → Create a **Function App**.
2. Deploy the function from the **`azure-function/`** folder.
3. Update the **storage connection string** in `local.settings.json`.

### 2️⃣ **Azure Synapse Pipeline**
1. Import `ingest_olympics_pipeline.json` into **Azure Synapse Studio**.
2. Configure the **source dataset** (Azure Data Lake path).
3. Set the **staging table** in **Dedicated SQL Pool**.

### 3️⃣ **Data Transformation**
1. Run `transformations_notebook.ipynb` in **Apache Spark Notebook**.
2. Execute `create_staging_table.sql` and `insert_into_target.sql`.

### 4️⃣ **Power BI Integration**
1. Open `olympics_dashboard.pbix` in **Power BI Desktop**.
2. Connect to the **Dedicated SQL Pool**.
3. Publish the report to **Power BI Service**.

## 🏆 Results & Insights
- **Athlete Performance Trends** 📊
- **Country-wise Medal Analysis** 🥇🥈🥉
- **Historical Olympic Trends** 📅

## 🚀 Next Steps
- Automate data refresh using **Azure Data Factory**.
- Add **real-time event streaming** using **Event Hub**.
- Implement **Machine Learning** for predictive analysis.

---
This project demonstrates an end-to-end **Azure Synapse pipeline** for **large-scale data ingestion and analysis**. Perfect for **enterprise data engineering**
