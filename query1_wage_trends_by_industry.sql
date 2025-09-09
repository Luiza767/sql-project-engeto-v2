--Odpověď na otázku 1:
--Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SELECT 
    p.industry_name AS industry_name,
    p.year_common AS report_year,
    ROUND(AVG(p.avg_wage)::numeric, 2) AS current_wage,
    ROUND(
        (
            (AVG(p.avg_wage) - AVG(p_prev.avg_wage)) 
            / AVG(p_prev.avg_wage) * 100
        )::numeric, 2
    ) AS wage_growth_percent,
    CASE 
        WHEN ROUND(
            (
                (AVG(p.avg_wage) - AVG(p_prev.avg_wage)) 
                / AVG(p_prev.avg_wage) * 100
            )::numeric, 2
        ) < 0 THEN 'decrease'
        ELSE 'increase'
    END AS wage_trend
FROM t_svitlana_gordienko_project_sql_primary_final p
JOIN t_svitlana_gordienko_project_sql_primary_final p_prev
    ON p.industry_name = p_prev.industry_name
   AND p.year_common = p_prev.year_common + 1
GROUP BY p.industry_name, p.year_common
ORDER BY p.industry_name, p.year_common;