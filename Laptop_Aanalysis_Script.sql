SELECT TOP 5 *
FROM Laptop_cleaned

-- -- MARKET SPLIT
 SELECT 
    brand,
    count(brand) as "Count"
 FROM Laptop_cleaned
 GROUP BY brand

--  -- Which Laptop Brand has the Higest Customer Satisfaction...
SELECT
    brand,
    ROUND(AVG(CAST(rating AS float)),2) AS avg_rating
FROM Laptop_cleaned
GROUP BY brand
ORDER BY avg_rating DESC;

-- --Do gaming laptops receive better ratings than non-gaming laptops?

SELECT 
    is_gaming,
    round(avg(overall_rating),2) as avg_rating   
FROM Laptop_cleaned
WHERE is_gaming = 'NO'
GROUP BY is_gaming

SELECT 
    round(avg(overall_rating),2) as avg_rating
FROM Laptop_cleaned
WHERE is_gaming != 'NO'


-- -- What percentage of reviews are positive, neutral, and negative?

SELECT rating_category
FROM Laptop_cleaned
GROUP BY rating_category

SELECT
        rating_category,
        count(*) as Review_count,
        100 * COUNT(*)/ (SELECT COUNT(*) FROM Laptop_cleaned)  AS percentage
FROM Laptop_cleaned
GROUP BY rating_category
ORDER BY review_count DESC;

-- Which brands have the highest percentage of positive reviews?
SELECT 
        brand,
        count(rating_category) as Review_count,
        100 * count(rating_category)/ (SELECT count(*) FROM Laptop_cleaned) as percentage
FROM Laptop_cleaned
WHERE rating_category = 'Excellent'
GROUP BY brand
ORDER BY [percentage] DESC

-- -- Does RAM influence customer satisfaction?
SELECT ram_gb,
    round(avg(overall_rating),2) as Avg_rating
FROM Laptop_cleaned
GROUP BY ram_gb
ORDER BY Avg_rating DESC

-- -- What are the top drivers of 1-star and 2-star reviews?
SELECT
    rating,
    COUNT(*) AS total_reviews,
    ROUND(100 * SUM(CAST(battery_mentioned AS INT))/ COUNT(*), 2) AS battery_pct,
    ROUND(100 * SUM(CAST(heating_issue AS INT))/ COUNT(*), 2) AS heating_pct,
    ROUND(100 * SUM(CAST(display_mentioned AS INT))/ COUNT(*), 2) AS display_pct,
    ROUND(100 * SUM(CAST(performance_mentioned AS INT))/ COUNT(*), 2) AS performance_pct
FROM Laptop_cleaned
WHERE rating IN (1,2)
GROUP BY rating;

-- -- Which brands receive the most heating complaints?
SELECT brand, SUM(CAST(heating_issue AS INT)) as Heating_complain
FROM Laptop_cleaned
GROUP BY brand
ORDER BY Heating_complain DESC

-- How much do heating issues impact ratings?
SELECT heating_issue,
       ROUND(AVG(rating),2) as AVg_rating
FROM Laptop_cleaned
GROUP BY heating_issue;