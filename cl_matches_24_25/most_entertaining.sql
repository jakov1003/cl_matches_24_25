WITH basic_stats AS (
    SELECT 
        match_id,
        phase,
        home_team,
        away_team,
        goals_combined,
        shots_combined,
        shots_on_target_combined,
        big_chances_combined,
        expected_goals_combined,
        coefficient_difference
    FROM 
        cl_match_stats
),

ranks AS (
    SELECT 
        match_id,
        DENSE_RANK() OVER (ORDER BY goals_combined DESC) AS goals_rank,
        DENSE_RANK() OVER (ORDER BY shots_combined DESC) AS shots_rank,
        DENSE_RANK() OVER (ORDER BY shots_on_target_combined) AS shots_on_target_rank,
        DENSE_RANK() OVER (ORDER BY big_chances_combined DESC) AS big_chances_rank,
        DENSE_RANK() OVER (ORDER BY expected_goals_combined DESC) AS xg_combined_rank,
        DENSE_RANK() OVER (ORDER BY coefficient_difference ASC) AS coefficient_difference_rank
    FROM 
        cl_match_stats
),

weighted_ranks as (
    SELECT 
        b.*,
        ROUND((
            r.goals_rank * 1.6 +
            r.shots_rank * 1.2 +
            r.shots_on_target_rank * 1.3 +
            r.big_chances_rank * 1.5 +
            r.xg_combined_rank * 1.1 +
            r.coefficient_difference_rank * 1.4 
        ) / 8.1, 2) AS weighted_average_rank
    FROM 
        basic_stats b
    INNER JOIN 
        ranks r ON b.match_id = r.match_id
    ORDER BY
        weighted_average_rank
)

SELECT 
    match_id,
    DENSE_RANK() OVER (ORDER BY weighted_average_rank ASC) AS entertainment_rank,
    phase,
    home_team,
    away_team,
    goals_combined,
    shots_combined,
    shots_on_target_combined,
    big_chances_combined,
    expected_goals_combined,
    coefficient_difference,
    weighted_average_rank
FROM 
    weighted_ranks;

