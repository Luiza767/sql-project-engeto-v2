--Odpověď na otázku 2:
--Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední 
--srovnatelné období v dostupných datech cen a mezd?
SELECT
    f.food_category,
    f.year_common AS report_year,
    ROUND(AVG(f.average_price::NUMERIC), 2) AS avg_product_price,
    ROUND(AVG(f.avg_wage)::NUMERIC, 2) AS avg_wage,
    ROUND(AVG(f.avg_wage) / AVG(f.average_price)) AS purchasable_amount,
    f.price_value,
    f.price_unit
FROM t_svitlana_gordienko_project_sql_primary_final f
WHERE f.year_common IN (2006, 2018)
  AND f.food_category IN (
      'Chléb konzumní kmínový',
      'Mléko polotučné pasterované'
  )
GROUP BY
    f.food_category,
    f.year_common,
    f.price_value,
    f.price_unit
ORDER BY
    f.food_category,
    f.year_common;