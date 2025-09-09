--Odpověď na otázku 5:
--Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
--projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
SELECT 
    main_data.report_year,
    ROUND(
        (AVG(main_data.curr_wage::NUMERIC) - AVG(main_data.prev_wage::NUMERIC))
        / NULLIF(AVG(main_data.prev_wage::NUMERIC), 0) * 100, 
        2
    ) AS wage_growth_pct,
    ROUND(
        (AVG(main_data.curr_price::NUMERIC) - AVG(main_data.prev_price::NUMERIC))
        / NULLIF(AVG(main_data.prev_price::NUMERIC), 0) * 100, 
        2
    ) AS food_price_growth_pct,
    ROUND(
        (eco_data.curr_gdp::NUMERIC - eco_data.prev_gdp::NUMERIC)
        / NULLIF(eco_data.prev_gdp::NUMERIC, 0) * 100, 
        2
    ) AS gdp_growth_pct
FROM (
    SELECT 
        cur.year_common AS report_year,
        prev.year_common AS base_year,
        cur.avg_wage AS curr_wage,
        prev.avg_wage AS prev_wage,
        cur.average_price AS curr_price,
        prev.average_price AS prev_price
    FROM t_svitlana_gordienko_project_sql_primary_final AS cur
    INNER JOIN t_svitlana_gordienko_project_sql_primary_final AS prev
        ON cur.industry_name = prev.industry_name
       AND cur.food_category = prev.food_category
       AND prev.year_common = cur.year_common - 1
) AS main_data
INNER JOIN (
    SELECT 
        e1.country,
        e1.year AS eco_year,
        e2.year AS base_eco_year,
        e1.gdp AS curr_gdp,
        e2.gdp AS prev_gdp
    FROM t_svitlana_gordienko_project_sql_secondary_final AS e1
    INNER JOIN t_svitlana_gordienko_project_sql_secondary_final AS e2
        ON e1.country = e2.country
       AND e2.year = e1.year - 1
    WHERE e1.year BETWEEN 2006 AND 2018
      AND e1.country = 'Czech Republic'
) AS eco_data
    ON main_data.report_year = eco_data.eco_year
GROUP BY 
    main_data.report_year,
    eco_data.curr_gdp,
    eco_data.prev_gdp
ORDER BY 
    main_data.report_year;