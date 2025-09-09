-- Nova sekundarni tabulka
CREATE TABLE t_svitlana_gordienko_project_sql_secondary_final AS
SELECT
    e.year,
    e.gdp,
    e.population,
    e.gini,
    e.country
FROM economies e
JOIN countries c
    ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.year BETWEEN 2006 AND 2018
GROUP BY
    e.year,
    e.gdp,
    e.population,
    e.gini,
    e.country
ORDER BY
    e.year,
    e.country;