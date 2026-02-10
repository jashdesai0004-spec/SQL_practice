SELECT
    ROUND(AVG(ret), 2) AS fraction
FROM (
    SELECT
        f.player_id,
        CASE
            WHEN COUNT(a.player_id) > 0 THEN 1
            ELSE 0
        END AS ret
    FROM (
        SELECT
            player_id,
            MIN(event_date) AS first_date
        FROM Activity
        GROUP BY player_id
    ) f
    LEFT JOIN Activity a
    ON f.player_id = a.player_id
    AND a.event_date = DATE_ADD(f.first_date, INTERVAL 1 DAY)
    GROUP BY f.player_id
) t;
