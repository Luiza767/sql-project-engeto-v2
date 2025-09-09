--Odpověď na otázku 3:
--Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
SELECT
    curr.food_category,
    ROUND(
        AVG(
            (curr.average_price::NUMERIC - prev.average_price::NUMERIC)
            / prev.average_price::NUMERIC * 100
        ),
        2
    ) AS avg_price_growth_percent
FROM t_svitlana_gordienko_project_sql_primary_final AS curr
JOIN t_svitlana_gordienko_project_sql_primary_final AS prev
    ON curr.food_category = prev.food_category
   AND curr.year_common = prev.year_common + 1
GROUP BY curr.food_category
ORDER BY avg_price_growth_percent ASC
LIMIT 1;