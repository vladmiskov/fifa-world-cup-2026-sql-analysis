# FIFA World Cup 2026 — SQL Data Analysis

## Project Overview

This portfolio project analyzes FIFA World Cup 2026 data using PostgreSQL and SQL.

The main goal is to explore team, player, goal, league and match performance and identify interesting patterns in the tournament data.

The analysis focuses on goals, expected goals (xG), player contribution, team market value and league performance.

## Key Analytical Questions

The project answers the following questions:

1. Which clubs had the most goals scored by their players?
2. Which teams scored more goals than expected based on their xG?
3. How much did the top scorer contribute to their team's total goals?
4. Is team market value related to goal-scoring performance?
5. Which football leagues contributed the most goals?
6. How does the number of goals compare with the number of players from each league?

## Tools & Technologies

- PostgreSQL
- SQL
- DBeaver
- Jupyter Notebook
- Python — used to connect to the database and display SQL results
- Tableau — used for data visualization
- GitHub

## SQL Skills Demonstrated

The project demonstrates practical use of:

- JOINs
- LEFT JOIN
- GROUP BY
- Aggregations
- CTEs
- UNION ALL
- Window functions
- RANK()
- ROW_NUMBER()
- SUM() OVER
- AVG() OVER
- PARTITION BY
- CASE expressions
- HAVING
- Data cleaning with REGEXP_REPLACE
- Calculated metrics and ratios

## Key Analyses

### Clubs with the Most Goals

Identifies clubs whose players scored the most goals during the tournament.

The analysis also shows the number of different players who scored for each club.

### Actual Goals vs Expected Goals

Compares actual goals with expected goals (xG) for each team.

This helps identify teams that converted their chances more effectively than expected.

### Top Scorer's Contribution

Measures how large a share of a team's total goals was scored by its top scorer.

This helps identify teams that relied heavily on one main goalscorer.

### Team Market Value vs Goals

Compares national team market value with goals scored during the group stage.

The analysis also compares average market value and total goals between tournament groups.

### Goal Contribution by League

Ranks football leagues by the number of goals scored by their players.

The analysis also calculates goals per player to compare scoring productivity between leagues.

## Data

The project uses four main datasets:

- `teams.csv` — national team information
- `matches.csv` — match statistics
- `players.csv` — player information
- `goals.csv` — individual goal records

### Data Sources

The data was compiled from publicly available football data sources:

- FIFA — tournament information, teams, fixtures and results
- Transfermarkt — player and team market values
- FotMob — match and player statistics

The datasets were collected and prepared specifically for this portfolio project.

## Project Structure

```text
FIFA-World-Cup-2026-SQL-Analysis/
│
├── data/
│   ├── goals.csv
│   ├── matches.csv
│   ├── players.csv
│   ├── teams.csv
│   └── README.md
│
├── images/
│   └── README.md
│
├── notebook/
│   ├── World_Cup_2026_SQL_Analysis.ipynb
│   └── README.md
│
├── sql/
│   ├── world_cup_analysis.sql
│   └── README.md
│
└── README.md
