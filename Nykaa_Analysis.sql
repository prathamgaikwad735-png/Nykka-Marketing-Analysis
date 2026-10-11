CREATE DATABASE IF NOT EXISTS nykaa_db;
use nykaa_db;

CREATE TABLE campaigns (
    Campaign_ID         VARCHAR(20) PRIMARY KEY,
    Campaign_Type       VARCHAR(30),
    Target_Audience     VARCHAR(40),
    Duration            INT,
    Channel_Used        VARCHAR(100),
    Impressions         INT,
    Clicks              INT,
    Leads               INT,
    Conversions         INT,
    Revenue             BIGINT,
    Acquisition_Cost    DECIMAL(10,2),
    ROI                 DECIMAL(8,2),
    Language            VARCHAR(20),
    Engagement_Score    DECIMAL(6,2),
    Customer_Segment    VARCHAR(40),
    Date                DATE,
    Total_Cost          DECIMAL(14,2),
    Profit              DECIMAL(14,2),
    CTR_pct             DECIMAL(6,2),
    Click_to_Lead_pct   DECIMAL(6,2),
    Lead_to_Conv_pct    DECIMAL(6,2),
    Conversion_Rate_pct DECIMAL(6,2),
    Year                INT,
    Month_Num           INT,
    Month_Name          VARCHAR(5),
    Year_mn          VARCHAR(8),
    Quarter             VARCHAR(3),
    Num_Channels        INT,
    ROI_Category        VARCHAR(20),
    Audience_Match      VARCHAR(10),
    Outlier_CAC         VARCHAR(5),
    Outlier_ROI         VARCHAR(5)
);

select * from campaigns;

CREATE TABLE campaign_channels (
    Campaign_ID VARCHAR(20),
    Channel     VARCHAR(20),
    FOREIGN KEY (Campaign_ID) REFERENCES campaigns(Campaign_ID)
);

select * from campaign_channels;

-- Q1. Overall KPIs

SELECT COUNT(*)                             AS total_campaigns,
       SUM(Revenue)                         AS total_revenue,
       ROUND(SUM(Total_Cost),0)             AS total_cost,
       ROUND(SUM(Profit),0)                 AS total_profit,
       ROUND(SUM(Profit)/SUM(Total_Cost),2) AS overall_roi
FROM campaigns;

-- Campaign type pramane performance

SELECT Campaign_Type,
       COUNT(*)             AS campaigns,
       SUM(Revenue)         AS revenue,
       ROUND(SUM(Profit),0) AS profit,
       ROUND(AVG(ROI),2)    AS avg_roi
FROM campaigns
GROUP BY Campaign_Type
ORDER BY profit DESC;

-- Q3. Language Wise engagement

SELECT Language,
       COUNT(*)                          AS campaigns,
       ROUND(AVG(Engagement_Score),2)    AS avg_engagement,
       ROUND(AVG(Conversion_Rate_pct),2) AS avg_conv_rate
FROM campaigns
GROUP BY Language
ORDER BY avg_engagement DESC;

-- Q4. Top 10 profitable campaigns

SELECT Campaign_ID, Campaign_Type, Target_Audience, Revenue, Profit, ROI
FROM campaigns
ORDER BY Profit DESC
LIMIT 10;

-- Q5. Loss-making campaigns

SELECT Campaign_Type,
       COUNT(*)             AS loss_campaigns,
       ROUND(SUM(Profit),0) AS total_loss
FROM campaigns
WHERE ROI < 0
GROUP BY Campaign_Type
ORDER BY loss_campaigns DESC;

-- Q6. Audience pramane funnel

SELECT Target_Audience,
       SUM(Impressions) AS impressions,
       SUM(Clicks)      AS clicks,
       SUM(Leads)       AS leads,
       SUM(Conversions) AS conversions,
       ROUND(SUM(Clicks)*100.0/SUM(Impressions),2) AS ctr_pct,
       ROUND(SUM(Conversions)*100.0/SUM(Clicks),2) AS click_to_conv_pct
FROM campaigns
GROUP BY Target_Audience
ORDER BY conversions DESC;

-- Q7. Monthly trend

SELECT Year_Mn,
       SUM(Revenue)         AS revenue,
       ROUND(SUM(Profit),0) AS profit,
       COUNT(*)             AS campaigns
FROM campaigns
GROUP BY Year_Mn
ORDER BY Year_Mn;

-- Q8. Channel pramane performance

SELECT ch.Channel,
       COUNT(*)                            AS campaigns,
       ROUND(AVG(c.ROI),2)                 AS avg_roi,
       ROUND(AVG(c.Conversion_Rate_pct),2) AS avg_conv_rate,
       ROUND(AVG(c.Acquisition_Cost),2)    AS avg_cac
FROM campaigns c
JOIN campaign_channels ch ON c.Campaign_ID = ch.Campaign_ID
GROUP BY ch.Channel
ORDER BY avg_roi DESC;

-- Q9. Audience match vs mismatch

SELECT Audience_Match,
       COUNT(*)                          AS campaigns,
       ROUND(AVG(ROI),2)                 AS avg_roi,
       ROUND(AVG(Conversion_Rate_pct),2) AS avg_conv_rate
FROM campaigns
GROUP BY Audience_Match;

-- Q10. Single vs multi channel

SELECT Num_Channels,
       COUNT(*)                       AS campaigns,
       ROUND(AVG(ROI),2)              AS avg_roi,
       ROUND(AVG(Acquisition_Cost),2) AS avg_cac
FROM campaigns
GROUP BY Num_Channels
ORDER BY Num_Channels;












