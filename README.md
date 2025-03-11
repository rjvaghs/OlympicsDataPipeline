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

## Data Architecture
![Data Architecture](https://github.com/user-attachments/assets/aad61e0d-2f69-463e-bb8f-6ea29deb951d)


## 🚀 **End-to-End Process Flow**
### **1️⃣ Data Ingestion (Azure Data Lake & Azure Function)**
- The raw **Olympics dataset (ZIP file)** is sourced from **Kaggle** via **HTTP** and uploaded to **Azure Data Lake Gen2**.
- A **Blob Trigger in Azure Functions** detects the uploaded ZIP file and **automatically extracts the CSV files** into a designated folder in Data Lake.

### **2️⃣ Data Processing & Transformation**
- The **Azure Synapse Pipeline**, orchestrated by **Azure Data Factory**, picks up the extracted CSV files from **Data Lake**.
- **Dataflow transformation** is applied to:
  - Standardize column names.
  - Convert data types.
  - Remove null and duplicate records.
  - Enrich the dataset with calculated metrics (e.g., total medals per country).
- Additional **Apache Spark Notebook transformations** further refine and process the dataset.

### **3️⃣ Data Storage (Dedicated SQL Pool - Staging & Target Tables)**
- The cleaned data is first loaded into a **staging table** in **Dedicated SQL Pool**.
- A **Stored Procedure** is executed to move data from the **staging table** to **target tables**, ensuring a structured data model.

### **4️⃣ Data Visualization in Power BI**
- Power BI is connected to the **Dedicated SQL Pool** via **DirectQuery**.
- The **Olympics Dashboard** provides insights such as:
  - **Athlete Performance Trends** 📊
  - **Country-wise Medal Analysis** 🥇🥈🥉
  - **Historical Olympic Trends** 📅

## 🛠️ **Technologies Used**
- **Azure Data Lake Storage (ADLS Gen2)** – Stores raw and processed data.
- **Azure Functions (Blob Trigger)** – Automates file extraction from ZIP.
- **Azure Data Factory (ADF) + Synapse Pipelines** – Orchestrates data processing.
- **Dataflow & Apache Spark Notebooks** – Cleans and transforms the data.
- **Dedicated SQL Pool** – Stores structured data for analysis.
- **Power BI** – Provides interactive visualizations.

## 🎯 **Key Achievements**
✅ Automated **data ingestion** from Kaggle to Azure Data Lake.  
✅ Efficient **file extraction** using **Azure Functions (Blob Trigger)**.  
✅ Performed **scalable data transformation** using Dataflow & Spark.  
✅ Implemented **SQL-based analytics** with a structured **data model**.  
✅ Built a **dynamic Power BI dashboard** for **Olympics data insights**. 
