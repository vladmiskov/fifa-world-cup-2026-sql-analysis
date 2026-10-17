CREATE VIEW goal_analysis AS
SELECT
g.goal_id,
g.match_id,
g.minute,
g.goal_type,
g.body_part,
g.player_id,
p.player_name,
p.position,
p.age,
p.club,
p.league,
p.player_market_value_eur,
scoring_team.team_id AS team_id,
scoring_team.team_name AS team_name,
scoring_team.team_code,
scoring_team.confederation,
scoring_team.team_market_value_eur,
scoring_team.fifa_rank,
scoring_team.group_name,
opponent_team.team_id AS opponent_team_id,
opponent_team.team_name AS opponent_team,
g.assist_player_id,
ap.player_name AS assist_player_name,
m.match_date,
m.stage,
m.home_goals,
m.away_goals,
m.home_xg,
m.away_xg,
m.home_possession,
m.away_possession,
m.home_shots,
m.away_shots,
m.home_shots_on_target,
m.away_shots_on_target,
m.home_corners,
m.away_corners,
m.home_fouls,
m.away_fouls,
m.home_yellow_cards,
m.away_yellow_cards,
m.home_red_cards,
m.away_red_cards,
m.attendance,
m.stadium,
m.city
FROM goals g
LEFT JOIN players p
ON g.player_id = p.player_id
LEFT JOIN players ap
ON g.assist_player_id = ap.player_id
LEFT JOIN matches m
ON g.match_id = m.match_id
LEFT JOIN teams scoring_team
ON g.team_id = scoring_team.team_id
LEFT JOIN teams opponent_team
ON opponent_team.team_id =
CASE
WHEN g.team_id = m.home_team_id
THEN m.away_team_id
ELSE m.home_team_id
END;
select *
from goal_analysis
