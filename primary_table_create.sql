--Nova primarni tabulka
CREATE TABLE t_svitlana_gordienko_project_sql_primary_final AS
SELECT
    wages.year_common,
    prices.food_category,
    prices.average_price,
    prices.price_value,
    prices.price_unit,
    wages.industry_name,
    wages.avg_wage
FROM (
    SELECT
        cp.payroll_year AS year_common,
        cpib.name AS industry_name,
        ROUND(AVG(cp.value), 2) AS avg_wage
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib
        ON cp.industry_branch_code = cpib.code
    WHERE cp.value_type_code = 5958
      AND cp.calculation_code = 200
    GROUP BY cp.payroll_year, cpib.name
) wages
JOIN (
    SELECT
        CAST(DATE_PART('year', cpr.date_from) AS int) AS price_year,
        cpc.name AS food_category,
        ROUND(AVG(cpr.value), 2) AS average_price,
        cpc.price_value,
        cpc.price_unit
    FROM czechia_price cpr
    JOIN czechia_price_category cpc
        ON cpr.category_code = cpc.code
    WHERE cpr.region_code IS NULL
    GROUP BY
        cpc.name,
        CAST(DATE_PART('year', cpr.date_from) AS int),
        cpc.price_value,
        cpc.price_unit
) prices
    ON wages.year_common = prices.price_year
ORDER BY
    wages.year_common,
    wages.industry_name,
    prices.food_category;
