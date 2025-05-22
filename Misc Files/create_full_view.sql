--Create the View
CREATE OR REPLACE VIEW view_full_data_set AS
SELECT
    imdb.*,
    kaggle.weekly_rank,
    kaggle.weekly_hours_viewed,
    kaggle.runtime,
    kaggle.weekly_views,
    kaggle.cumulative_weeks_in_top_10
FROM
    imdb_movie_data_2023 AS imdb
LEFT JOIN
    kaggle
ON
    imdb.movie_name = kaggle.show_title;

--Pull Data, organized by name and weeks in top 10
select * from view_full_data_set where weekly_rank > 0 order by movie_name asc, cumulative_weeks_in_top_10 desc
