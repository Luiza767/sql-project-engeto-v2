--Odpověď na otázku 4:
--Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
SELECT
    p.year_common,
    ROUND(
        ((AVG(p.avg_wage::NUMERIC) - AVG(p2.avg_wage::NUMERIC)) / AVG(p2.avg_wage::NUMERIC)) * 100,
        2
    ) AS salary_growth,
    ROUND(
        ((AVG(p.average_price::NUMERIC) - AVG(p2.average_price::NUMERIC)) / AVG(p2.average_price::NUMERIC)) * 100,
        2
    ) AS price_growth,
    ROUND(
        ((AVG(p.average_price::NUMERIC) - AVG(p2.average_price::NUMERIC)) / AVG(p2.average_price::NUMERIC)) * 100,
        2
    ) - ROUND(
        ((AVG(p.avg_wage::NUMERIC) - AVG(p2.avg_wage::NUMERIC)) / AVG(p2.avg_wage::NUMERIC)) * 100,
        2
    ) AS difference,
    CASE
        WHEN (
            ROUND(
                ((AVG(p.average_price::NUMERIC) - AVG(p2.average_price::NUMERIC)) / AVG(p2.average_price::NUMERIC)) * 100,
                2
            ) - ROUND(
                ((AVG(p.avg_wage::NUMERIC) - AVG(p2.avg_wage::NUMERIC)) / AVG(p2.avg_wage::NUMERIC)) * 100,
                2
            )
        ) > 10 THEN 'INTENSIVE PRODUCT PRICE GROWTH'
        ELSE ''
    END AS growth_note
FROM
    t_svitlana_gordienko_project_sql_primary_final AS p
JOIN 
    t_svitlana_gordienko_project_sql_primary_final AS p2
    ON p.industry_name = p2.industry_name
   AND p.food_category = p2.food_category
   AND p.year_common = p2.year_common + 1
GROUP BY
    p.year_common
ORDER BY
    p.year_common;