
SELECT
    EXTRACT(MONTH FROM time) AS month,
    city,
    ROUND(AVG(temperature_2m_max), 1) AS avg_temp
FROM weather
GROUP BY month, city
ORDER BY month, city;


SELECT city, time, temperature_2m_max
FROM (
    SELECT city, time, temperature_2m_max,
           ROW_NUMBER() OVER (
               PARTITION BY city
               ORDER BY temperature_2m_max DESC
           ) AS r
    FROM weather
) AS t
WHERE r = 1
ORDER BY temperature_2m_max DESC;


SELECT
    EXTRACT(MONTH FROM time) AS month,
    city,
    ROUND(AVG(precipitation_sum), 1) AS avg_rain
FROM weather
GROUP BY month, city
ORDER BY month, city;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT city) AS total_cities,
    COUNT(*) FILTER (WHERE time IS NULL) AS missing_dates,
    COUNT(*) FILTER (WHERE temperature_2m_max IS NULL) AS missing_temps
FROM weather;

CREATE TABLE forecast (
    city VARCHAR(50),
    date DATE,
    max_temp NUMERIC,
    min_temp NUMERIC,
    rain NUMERIC
);

COPY forecast
FROM 'C:/Users/CHANDRAMOHAN 1/Downloads/India_Weather_Project/india_forecast.csv'
WITH (FORMAT CSV, HEADER TRUE);

SELECT COUNT(*) AS forecast_rows
FROM forecast;

SELECT COUNT(*) AS forecast_rows
FROM forecast;

SELECT
    city,
    ROUND(AVG(max_temp), 1) AS avg_max_temp,
    ROUND(AVG(min_temp), 1) AS avg_min_temp,
    ROUND(SUM(rain), 1) AS total_rainfall
FROM forecast
GROUP BY city
ORDER BY avg_max_temp DESC;

SELECT DISTINCT ON (city)
    city,
    date,
    max_temp,
    min_temp,
    rain
FROM forecast
ORDER BY city, max_temp DESC;

SELECT
    city,
    EXTRACT(MONTH FROM time) AS month,
    ROUND(AVG(precipitation_sum), 2) AS avg_daily_rainfall
FROM weather
GROUP BY city, EXTRACT(MONTH FROM time)
ORDER BY city, avg_daily_rainfall DESC;

SELECT DISTINCT ON (city)
    city,
    time AS hottest_date,
    temperature_2m_max AS max_temperature,
    precipitation_sum AS rainfall
FROM weather
ORDER BY city, temperature_2m_max DESC;

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE time IS NULL) AS missing_dates,
    COUNT(*) FILTER (WHERE city IS NULL) AS missing_cities,
    COUNT(*) FILTER (WHERE temperature_2m_max IS NULL) AS missing_max_temp,
    COUNT(*) FILTER (WHERE precipitation_sum IS NULL) AS missing_rainfall
FROM weather;

SELECT
    city,
    EXTRACT(YEAR FROM time) AS year,
    ROUND(AVG(temperature_2m_max), 1) AS avg_max_temp
FROM weather
GROUP BY city, EXTRACT(YEAR FROM time)
ORDER BY city, year;

SELECT *
FROM weather
ORDER BY city, time;