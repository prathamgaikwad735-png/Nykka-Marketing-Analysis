# Nykaa Marketing Campaign Analysis

> **End-to-end data analytics portfolio project** using Python, SQL, and
> Power BI to explore marketing campaign performance, profitability,
> audience engagement, conversion funnels, and channel-level results.

## Quick Navigation

-   [Project Overview](#project-overview)
-   [Business Questions](#business-questions)
-   [Tools and Technologies](#tools-and-technologies)
-   [Project Workflow](#project-workflow)
-   [Dataset](#dataset)
-   [Key Metrics](#key-metrics)
-   [SQL Analysis](#sql-analysis)
-   [Power BI Dashboard](#power-bi-dashboard)
-   [Initial Findings](#initial-findings)
-   [Repository Structure](#repository-structure)
-   [How to Run the Project](#how-to-run-the-project)
-   [Data Notes and Limitations](#data-notes-and-limitations)

## Project Overview

This project analyzes a marketing-campaign dataset associated with the
Nykaa project brief. The goal is to turn campaign-level data into useful
insights about revenue, costs, profit, ROI, conversions, engagement,
target audiences, campaign types, and marketing channels.

The workflow covers data preparation in Python, analytical queries in
MySQL, and interactive reporting in Power BI.

**Important:** The files provided for this project do not establish that
the dataset is official internal Nykaa business data. Describe it as the
dataset used for this portfolio project unless its provenance is
independently verified.

## Business Questions

The analysis is designed to investigate questions such as:

1.  What are the overall campaign, revenue, cost, profit, and ROI
    metrics?
2.  Which campaign types generate the highest revenue and profit?
3.  How does engagement and conversion rate vary by language?
4.  Which campaigns are the most profitable, and which are loss-making?
5.  How do audiences move through impressions, clicks, leads, and
    conversions?
6.  How do revenue and profit change month by month?
7.  How do marketing channels compare on ROI, conversion rate, and
    acquisition cost?
8.  Do campaigns marked as audience matches perform differently from
    mismatches?
9.  How do single-channel and multi-channel campaigns compare?
10. How do campaign type, language, customer segment, channel, and time
    filters change the results?

## Tools and Technologies

-   **Python / Pandas** --- data cleaning and preparation (based on the
    supplied cleaned output; add the notebook to this repository to
    document the exact cleaning steps).
-   **CSV** --- prepared data exchange between tools.
-   **MySQL** --- relational tables and business-analysis queries.
-   **Power BI** --- interactive KPI cards, charts, slicers, and report
    pages.

## Project Workflow

1.  **Prepare the data:** clean the original marketing data in Python
    and export the prepared data to CSV.
2.  **Model the data in SQL:** store campaign-level data in `campaigns`
    and the campaign-to-channel mapping in `campaign_channels`.
3.  **Analyze performance:** use SQL aggregations and comparisons to
    answer business questions.
4.  **Build the report:** use Power BI to summarize campaign KPIs and
    provide filters for exploring performance.
5.  **Interpret results:** compare campaign types, audiences, channels,
    time periods, and loss-making campaigns.

## Dataset

The supplied files contain the following records:

  -------------------------------------------------------------------------------------
  File                                  Rows              Columns Purpose
  --------------------- -------------------- -------------------- ---------------------
  `nykaa_clean.csv`                   55,555                   32 One row per campaign,
                                                                  including performance
                                                                  metrics and derived
                                                                  fields

  `nykaa_channel.csv`                110,903                    2 Campaign-to-channel
                                                                  mapping, with one row
                                                                  per campaign/channel
                                                                  association
  -------------------------------------------------------------------------------------

### Main fields in `nykaa_clean.csv`

-   **Campaign identifiers and descriptors:** `Campaign_ID`,
    `Campaign_Type`, `Target_Audience`, `Duration`, `Channel_Used`,
    `Language`, `Customer_Segment`
-   **Funnel metrics:** `Impressions`, `Clicks`, `Leads`, `Conversions`
-   **Financial metrics:** `Revenue`, `Acquisition_Cost`, `Total_Cost`,
    `Profit`, `ROI`
-   **Engagement and rates:** `Engagement_Score`, `CTR_pct`,
    `Click_to_Lead_pct`, `Lead_to_Conv_pct`, `Conversion_Rate_pct`
-   **Time fields:** `Date`, `Year`, `Month_Num`, `Month_Name`,
    `Year_Month`, `Quarter`
-   **Analysis flags/categories:** `Num_Channels`, `ROI_Category`,
    `Audience_Match`, `Outlier_CAC`, `Outlier_ROI`

`nykaa_channel.csv` contains `Campaign_ID` and `Channel`. It is a
mapping table: campaigns can appear multiple times because a campaign
can use more than one channel.

## Key Metrics

-   **Revenue:** total campaign revenue.
-   **Total Cost:** total recorded campaign cost.
-   **Profit:** revenue minus total cost, as represented in the prepared
    dataset.
-   **ROI:** the campaign-level ROI field supplied in the data. Confirm
    its exact formula and whether it is stored as a ratio or percentage
    before comparing it with other ROI measures.
-   **CTR:** click-through rate.
-   **Conversion Rate:** conversion rate as represented by
    `Conversion_Rate_pct`.
-   **CAC / Acquisition Cost:** customer acquisition cost field supplied
    in the dataset.
-   **Funnel:** impressions → clicks → leads → conversions.

## SQL Analysis

The supplied `Nykaa_Analysis.sql` creates a database named `nykaa_db`,
defines the `campaigns` and `campaign_channels` tables, and includes
queries for:

1.  Overall KPIs
2.  Campaign-type performance
3.  Language-wise engagement
4.  Top 10 profitable campaigns
5.  Loss-making campaigns
6.  Audience funnel performance
7.  Monthly trends
8.  Channel-wise performance
9.  Audience match versus mismatch
10. Single-channel versus multi-channel campaigns

### SQL setup note

Before importing the CSV, align the SQL table definition with the actual
CSV column names. The supplied CSV uses **`Year_Month`**, while the SQL
schema/query uses **`Year_mn` / `Year_Mn`**. Rename the SQL field and
the monthly-trend query to `Year_Month`, or consistently rename the CSV
column. MySQL may treat letter case differently depending on the
object/platform, but the missing/extra underscore and different spelling
still need to be aligned.

For `campaign_channels`, load `nykaa_channel.csv` after loading
`nykaa_clean.csv` into `campaigns`, because the channel table has a
foreign key to `campaigns.Campaign_ID`.

## Power BI Dashboard

The supplied Power BI file is `Nykaa_Marketing_Analysis.pbix`. Its
report definition contains two pages:

### 1. Campaign Overview

The page includes KPI cards for total revenue, total profit, overall
ROI, total conversions, average engagement, and loss-campaign
percentage. It also includes visuals for revenue by campaign type,
revenue by customer segment, channel revenue, and revenue over time,
plus slicers for language, customer segment, quarter, campaign type, and
channel.

### 2. Performence & Cost

The second page includes average ROI, loss-campaign count and
percentage, average engagement, a funnel visual, a campaign-level table,
revenue by language, average ROI by campaign type, and average ROI by
CAC group. Slicers include quarter, channel, customer segment, language,
and campaign type.

**Review limitation:** The PBIX file structure was inspected to identify
pages and visual fields, but the report has not been rendered
interactively here. Therefore, this README does not claim that every
visual, relationship, measure, interaction, or formatting choice has
been fully validated. Open the PBIX in Power BI Desktop and test
slicers, totals, relationships, and the DAX measures before publishing.

## Initial Findings

The following are calculated directly from the supplied
`nykaa_clean.csv` file:

-   **55,555 campaigns** are present, with unique `Campaign_ID` values
    and no fully duplicated rows detected.
-   The campaign date range is **July 1, 2024 to June 24, 2025**.
-   Total recorded revenue is approximately **28.66 billion** in the
    dataset's unspecified currency units.
-   Total recorded cost is approximately **9.70 billion**.
-   Total recorded profit is approximately **18.96 billion**.
-   The aggregate `Profit / Total_Cost` ratio is approximately **1.95**.
    This is a calculated ratio and should not automatically be labelled
    as `195% ROI` unless the project defines ROI that way.
-   **13,220 campaigns (about 23.8%)** have a negative value in the
    supplied `ROI` field.
-   `nykaa_channel.csv` contains **110,903 campaign-channel
    associations** across six channels.

These are dataset-level observations, not independently verified
real-world claims about Nykaa.

## Repository Structure

A clean GitHub repository could use this structure:

``` text
nykaa-marketing-campaign-analysis/
├── README.md
├── data/
│   ├── nykaa_clean.csv
│   └── nykaa_channel.csv
├── python/
│   └── nykaa_data_cleaning_and_eda.ipynb
├── sql/
│   └── Nykaa_Analysis.sql
├── powerbi/
│   └── Nykaa_Marketing_Analysis.pbix
└── screenshots/
    ├── campaign-overview.png
    └── performance-and-cost.png
```

The notebook and screenshots shown above are suggested paths; add those
files only if you have them. If the CSV files are too large for GitHub,
consider Git LFS or provide a small, clearly labelled sample dataset and
instructions for obtaining the full data.

## How to Run the Project

1.  Clone or download this repository.
2.  Open the Python notebook and run the documented cleaning workflow if
    the notebook is included.
3.  In MySQL Workbench, run the SQL setup after aligning `Year_Month` in
    the schema with the CSV.
4.  Import `nykaa_clean.csv` into `nykaa_db.campaigns`, mapping columns
    to the table definition.
5.  Import `nykaa_channel.csv` into `nykaa_db.campaign_channels` after
    the campaign table is populated.
6.  Execute the analytical queries in `Nykaa_Analysis.sql`.
7.  Open `Nykaa_Marketing_Analysis.pbix` in Power BI Desktop, confirm
    the data source paths and relationships, refresh the model, and test
    all slicers and KPI calculations.

## Data Notes and Limitations

-   Currency units are not specified in the provided CSV, so financial
    totals are reported without a currency symbol in this README.
-   The exact original data source and whether the records are real,
    simulated, or generated were not established from the supplied
    files.
-   The supplied cleaned CSV has no missing cells or exact duplicate
    rows according to a direct file check; this does not prove every
    field is semantically valid.
-   Confirm the formulas behind `ROI`, `Total_Cost`, `Profit`,
    conversion rates, and the Power BI measures before using them in
    business decisions.
-   Avoid uploading confidential or licensed data to a public
    repository. Check the dataset's usage terms first.

------------------------------------------------------------------------

**Project focus:** Marketing Analytics · Data Cleaning · SQL Analysis ·
KPI Reporting · Power BI Dashboarding
