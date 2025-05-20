DROP TABLE IF EXISTS cl_match_stats

CREATE TABLE public.cl_match_stats
(
    match_id INT,
    phase VARCHAR (50),
    home_team VARCHAR (100),
    away_team VARCHAR (100),
    goals_combined INT,
    shots_combined INT,
    shots_on_target_combined INT,
    big_chances_combined INT,
    expected_goals_combined NUMERIC,
    coefficient_difference NUMERIC,
    PRIMARY KEY (match_id)
);