CREATE DATABASE CIBC_ITAM;
USE CIBC_ITAM;

CREATE TABLE assets (
    asset_id INT PRIMARY KEY,
    asset_type VARCHAR(50),
    purchase_date DATE,
    warranty_expiry DATE,
    cost INT,
    department VARCHAR(50),
    status VARCHAR(50),
    vendor VARCHAR(100),
    owner VARCHAR(100),
    criticality VARCHAR(20),
    replacement_priority INT,
    business_impact_score INT
);

CREATE TABLE incidents (
    incident_id INT PRIMARY KEY,
    asset_id INT,
    incident_date DATE,
    severity VARCHAR(20),
    downtime_hours INT,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
);

CREATE TABLE software_licenses (
    license_id INT PRIMARY KEY,
    software_name VARCHAR(100),
    total_licenses INT,
    used_licenses INT,
    expiry_date DATE,
    annual_cost INT
);

SELECT COUNT(*) AS total_assets FROM assets;
SELECT COUNT(*) AS total_incidents FROM incidents;
SELECT COUNT(*) AS total_licenses FROM software_licenses;

SELECT 
    COUNT(*) AS total_assets,
    SUM(cost) AS total_investment,
    ROUND(AVG(cost),2) AS avg_asset_cost
FROM assets;

select 
department,
count(*) as asset_count,
sum(cost) as departmetn_investment
from assets 
group by department
order by departmetn_investment desc;

select count(*) as expiring_Soon
from assets 
where warranty_expiry between curdate()
and date_add(curdate(), interval 6 month);

SELECT 
    asset_id,
    asset_type,
    department,
    replacement_priority
FROM assets
WHERE replacement_priority >= 4
ORDER BY replacement_priority DESC;

SELECT 
    a.department,
    SUM(i.downtime_hours) AS total_downtime
FROM assets a
JOIN incidents i ON a.asset_id = i.asset_id
GROUP BY a.department
ORDER BY total_downtime DESC;

SELECT 
    software_name,
    total_licenses,
    used_licenses,
    ROUND((used_licenses/total_licenses)*100,2) AS utilization_percent
FROM software_licenses;











