# SQL Analysis

This folder contains SQL queries used for the FIFA World Cup 2026 data analysis.

## Analyses

### 1. Clubs with the Most Goals
Identifies football clubs whose players scored the most goals during the tournament.

**SQL techniques:**
- JOIN
- GROUP BY
- COUNT
- COUNT DISTINCT
- ORDER BY

### 2. Actual Goals vs Expected Goals (xG)
Compares teams' actual goals with their expected goals (xG) to identify teams that scored more goals than expected.

**SQL techniques:**
- CTE
- UNION ALL
- JOIN
- GROUP BY
- Aggregations
- HAVING
- Data type conversion

### 3. Top Scorer's Share of Team Goals
Identifies teams where the top scorer contributed more than one-third of the team's total goals.

**SQL techniques:**
- CTE
- Window functions
- SUM() OVER
- RANK()
- PARTITION BY
- GROUP BY

### 4. Team Market Value vs Goals by Group
Analyzes the relationship between team market value and goals scored during the group stage.

**SQL techniques:**
- CTE
- UNION ALL
- JOIN
- Window functions
- AVG() OVER
- SUM() OVER
- Data cleaning with REGEXP_REPLACE

### 5. Goal Contribution by League
Compares the number of goals scored by players from different football leagues and calculates goals per player.

**SQL techniques:**
- LEFT JOIN
- CTE
- ROW_NUMBER()
- SUM() OVER
- CASE
- GROUP BY
- Aggregations

## SQL Skills Demonstrated

The project demonstrates practical use of:

- SELECT and filtering
- JOINs
- GROUP BY and aggregations
- CTEs
- Window functions
- RANK and ROW_NUMBER
- CASE expressions
- UNION ALL
- Data cleaning and type conversion
- Analytical ratios and calculated metrics
