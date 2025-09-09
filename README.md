# SQL Projekt – Analýza mezd, cen a HDP v ČR

## Zavedení

V projektu se zabýváme cenami základních potravin, průměrnou mzdou v různých sektorech a HDP v letech 2006–2018.
Cílem projektu bylo vytvořit data, která pomohou odpovědět na níže uvedené výzkumné otázky.
SQL skripty byly vytvořeny v relační databázi **PostgreSQL** pomocí programu **DBeaver**.

## Datové sady

Použité tabulky pocházejí z [Portálu otevřených dat ČR](https://data.gov.cz/) a doplňkových datasetů:

- `czechia_payroll` – informace o mzdách v různých odvětvích za několikaleté období
- `czechia_payroll_calculation` – číselník kalkulací v tabulce mezd
- `czechia_payroll_industry_branch` – číselník odvětví v tabulce mezd
- `czechia_payroll_unit` – číselník jednotek hodnot v tabulce mezd
- `czechia_payroll_value_type` – číselník typů hodnot v tabulce mezd
- `czechia_price` – informace o cenách vybraných potravin za několikaleté období
- `czechia_price_category` – číselník kategorií potravin
- `czechia_region` – číselník krajů České republiky dle normy CZ-NUTS 2
- `czechia_district` – číselník okresů České republiky dle normy LAU
- `countries` – informace o zemích (hlavní město, měna, národní jídlo, výška populace…)
- `economies` – HDP, GINI, daňová zátěž atd. pro daný stát a rok

## Pracovní otázky

1. Rostou mzdy ve všech odvětvích v průběhu času, nebo v některých odvětvích klesají?
2. Kolik litrů mléka a kilogramů chleba bylo možné koupit za průměrnou mzdu v prvním a posledním srovnatelném období?
3. Která kategorie produktů zdražuje nejpomaleji (má nejnižší průměrný roční procentní nárůst)?
4. Existuje rok, ve kterém byl meziroční růst cen potravin výrazně vyšší než růst mezd (o více než 10 %)?
5. Ovlivňuje úroveň HDP změny mezd a cen potravin?

## Výsledky

### Otázka č. 1: Rostou mzdy v průběhu času ve všech odvětvích, nebo v některých odvětvích klesají?

Analýza vývoje průměrných mezd v letech 2006–2018 ukazuje, že ve všech odvětvích obecně došlo k růstu mezd.
V některých sektorech však byly v určitých letech zaznamenány poklesy.
Tyto případy jsou v posledním sloupci `wage_fluctuation` označeny jako „POKLES“.
Největší propad byl zaznamenán v roce 2013 ve finančním a pojišťovacím sektoru, kdy se průměrná mzda snížila o 8,83 %.
Nejčastější poklesy mezd byly zaznamenány v těžebním průmyslu a dobývání nerostných surovin, kde k nim došlo ve čtyřech letech: 2009, 2013, 2014 a 2016.

---

### Otázka č. 2: Kolik litrů mléka a kilogramů chleba by se dalo koupit za průměrný plat v prvním a posledním srovnatelném období?

Bylo analyzováno, kolik chleba a mléka je možné v České republice koupit za průměrnou mzdu v prvním a posledním srovnatelném roce z dostupných údajů – tedy v letech 2006 a 2018.
Nejprve byla vypočtena průměrná cena výrobku a průměrná mzda za daný rok, poté byla mzda vydělena cenou.
Výsledky byly omezeny pouze na kategorie potravin: mléko a chléb.

- V roce 2006 bylo možné za průměrnou mzdu (21 165 Kč) koupit **1 313 kg chleba** (16,12 Kč/kg) nebo **1 466 l mléka** (14,44 Kč/l).
- V roce 2018 průměrná mzda činila 33 091 Kč, což odpovídalo **1 365 kg chleba** (24,24 Kč/kg) nebo **1 670 l mléka** (19,82 Kč/l).

---

### Otázka č. 3: Která kategorie produktů roste v ceně nejpomaleji?

Dotaz porovnává průměrné ceny jednotlivých kategorií potravin mezi po sobě jdoucími roky, vypočítává procentní změnu ceny pro každý rok,
zjišťuje průměrnou hodnotu tohoto růstu za celé období pro každou kategorii a poté je seřadí vzestupně.
Omezení `LIMIT 1` ponechá pouze tu kategorii, která má nejnižší průměrný meziroční procentní růst.

Výsledek: **Cukr krystalový –1,92** znamená, že krystalový cukr v průměru každoročně zlevňoval o 1,92 %, tedy jeho cena rostla nejpomaleji (ve skutečnosti dokonce klesala).

---

### Otázka č. 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než nárůst mezd (o více než 10 %)?

Dotaz porovnává meziroční procentní růst průměrné mzdy a průměrných cen potravin.
Vypočítává rozdíl mezi tempem růstu cen a mezd a označuje roky, kdy růst cen překročí růst mezd o více než 10 %.

Z výsledků vyplývá, že takový rok **neexistuje**, protože rozdíl nikdy nepřekročil 10 %.  
Tudíž rok s výrazným převýšením růstu cen nad mzdami nebyl zjištěn.

---

### Otázka č. 5: Ovlivňuje úroveň HDP změny mezd a cen potravin?

Dotaz ukazuje meziroční tempo růstu HDP, mezd a cen potravin.
Data naznačují, že výrazný růst HDP je někdy doprovázen růstem mezd a cen, ale tento vztah není jednoznačný.  
HDP tedy ovlivňuje mzdy a ceny, ale není jediným faktorem jejich změn.

---

## Spuštění

1. Otevřete **DBeaver** (nebo jiný SQL klient).
2. Připojte se k databázi (PostgreSQL).
3. Načtěte vybraný `.sql` soubor.
4. Spusťte příkaz pomocí **Ctrl + Enter** (Windows/Linux) nebo **Cmd + Enter** (Mac).

## Autor

Projekt vytvořen: ** Svitlana Gordienko**
