-- ============================================
-- FIFA WORLD CUP 2026 — SQL DATA ANALYSIS
-- PostgreSQL
-- ============================================


-- 1. Clubs whose players scored the most goals

SELECT
    p.club,
    COUNT(g.goal_id) AS total_goals,
    COUNT(DISTINCT g.player_id) AS total_players
FROM goals g
JOIN players p
    ON g.player_id = p.player_id
GROUP BY p.club
ORDER BY total_goals DESC;


-- 2. Teams with actual goals above xG

with  team_goals_xg  as                                                                    /*Сумуємо к-сть матчів, голи та XG до кожної team_id*/
(
select sum(total_match) as total_match, sum(total_goals) total_goals, sum(total_xg ) as total_xg, team_id
from (
        select count(m.home_team_id ) as total_match,  sum(m.home_goals) as total_goals,sum(REGEXP_REPLACE (m.home_xg, ',' , '.' ,'g')::numeric) as total_xg ,m.home_team_id as team_id
        from matches m
        group by 4
        union all
        select count(m.away_team_id  ) as total_match, sum(m.away_goals) as total_goals, sum(REGEXP_REPLACE(m.away_xg, ',' , '.' ,'g')::numeric) as total_xg ,m.away_team_id as team_id
        from matches m
        group by  4)
group by 4
)
select  t2.team_name
       ,t.total_match as matches
       ,t.total_goals  as goals
       ,t.total_xg as xg
       ,Round(t.total_goals *1.00/ t.total_xg, 2) as goals_xg_ratio
from team_goals_xg  t
join teams t2  on t2.team_id = t.team_id
where t.total_match > 4
group by 1, 2, 3, 4
having  t.total_goals *1.00 / t.total_xg > 1.00
order by 5 desc;


-- 3. Top scorer's share of team goals

with cte_1 as(
select count(g.goal_id ) as goals, g.player_name , g.team_name
from goals g
group by g.player_name , g.team_name
),
ranked_players as
(
select goals
       ,player_name
       ,team_name
       ,SUM(goals) OVER (PARTITION BY team_name) AS team_goals
       ,rank() over(partition by team_name order by goals desc) number_one
from cte_1
),
scorer_share as
(
select *
       ,round( goals*100.0/team_goals, 2  ) as scorer_share
from ranked_players
where team_goals >= 10 and
number_one = 1
order by scorer_share desc
)
select  team_name
       ,player_name
       ,goals
       ,team_goals
       ,scorer_share
from scorer_share
where scorer_share > 33.33;


-- 4. Team market value vs goals by group

with cte_1 as
(
    select t.team_id
           ,team_name
           ,REGEXP_REPLACE(t.team_market_value_eur, '[^0-9]', '', 'g')::numeric as team_value_eur
           ,t.group_name
    from teams t
),
team_goals as
(
select sum(total_goals) as total_goals, team_id
from (
        select sum(m.home_goals) as total_goals ,m.home_team_id as team_id
        from matches m
        where m.stage = 'Group Stage'
        group by m.home_team_id
        union all
        select sum(m.away_goals) as total_goals ,m.away_team_id as team_id
        from matches m
        where m.stage = 'Group Stage'
        group by  m.away_team_id)
group by team_id
)
select  c.team_name
       ,c.team_value_eur
       ,c.group_name
       ,AVG(c.team_value_eur ) over(partition by c.group_name ) as avg_value_for_group
       ,t.total_goals  as goals
       ,sum(t.total_goals ) over (partition by c.group_name ) as group_goals
from cte_1 c
join team_goals t on t.team_id = c.team_id
order by c.group_name;


-- 5. Goal contribution by league

WITH league_goals AS (
    SELECT
        p.league,
        COUNT(g.goal_id) AS goals,
        COUNT(DISTINCT p.player_id) AS total_players
    FROM players p
    LEFT JOIN goals g
        ON p.player_id = g.player_id
    GROUP BY p.league
),
ranked_leagues AS (
    SELECT
        league,
        goals,
        total_players,
        ROW_NUMBER() OVER (
            ORDER BY goals DESC
        ) AS league_rank,
        SUM(goals) OVER () AS total_goals
    FROM league_goals
),
grouped_leagues AS (
    SELECT
        CASE
            WHEN league_rank <= 8 THEN league
            ELSE 'Other 72 leagues'
        END AS league_group,
        SUM(goals) AS goals,
        MAX(total_goals) AS total_goals,
        SUM(total_players) AS total_players
    FROM ranked_leagues
    GROUP BY 1
)
SELECT
    league_group,
    goals,
    ROUND(
        goals * 100.0 / total_goals,
        1
    ) AS goal_share_percent,
    total_players,
    ROUND(
        goals * 1.0 / total_players,
        2
    ) AS goals_per_player
FROM grouped_leagues
ORDER BY goals DESC;
