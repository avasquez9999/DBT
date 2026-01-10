# Bike & Weather Data: End-to-End Analytics Engineering with dbt & Snowflake

## 📌 Project Overview
This project demonstrates a full-scale data engineering lifecycle. I integrated raw **Weather** and **Bike-sharing** datasets to build a scalable data warehouse in **Snowflake** using the **Kimball Dimensional Modeling** methodology. The workflow utilizes **dbt (Data Build Tool)** for transformation and **GitHub** for version control and CI/CD, separating the environment into distinct **Development** and **Production** stages.

---

## 🏗️ Architecture & Workflow

### 1. Development Environment
* **Data Modeling:** Designed a **Star Schema** consisting of a centralized **Fact Table** and multiple **Dimension Tables**.
* **dbt Modeling:** Developed SQL models in dbt to clean, transform, and join raw bike and weather data.
* **Snowflake Execution:** Ran and tested these models within a development schema in Snowflake to ensure data integrity.
* **Version Control:** Committed and pushed all dbt models and configurations to GitHub.

### 2. Production Environment & CI/CD
* **GitHub Sync:** Synced the validated development code to the main production branch.
* **Deployment:** Pulled the latest production code into the dbt Cloud environment.
* **Production Job:** Created a production job in dbt that automates the population of the production warehouse in Snowflake using the code saved in GitHub.

### 3. Automated Ingestion (Snowflake Tasks)
To ensure the warehouse stays up-to-date, I implemented automated ingestion pipelines using **Snowflake Stages** and **Tasks**.

#### Weather Data Ingestion Task
Automated the ingestion of semi-structured JSON weather data on a daily schedule.

```sql
CREATE OR REPLACE TASK DEMO.DEMO_SCHEMA.WEATHERTASK
  WAREHOUSE = 'COMPUTE_WH'
  SCHEDULE = 'USING CRON 0 0 * * * UTC'
AS
COPY INTO DEMO.DEMO_SCHEMA.WEATHER
FROM (
    SELECT
        $1:city:findname,
        $1:city:coord:lat,
        $1:city:coord:lon,
        $1:clouds:all,
        $1:main:humidity,
        $1:main:pressure,
        $1:main:temp,
        $1:time,
        $1:weather[0]:main
    FROM @DEMO.DEMO_SCHEMA.weather_stage
);

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
