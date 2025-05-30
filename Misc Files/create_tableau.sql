-- Create a view that contains films that have and have not reached netflix top 10


CREATE OR REPLACE VIEW view_full_data_set AS
SELECT
    imdb.*,
    kaggle.weekly_rank,
    kaggle.weekly_hours_viewed,
    kaggle.weekly_views,
    kaggle.cumulative_weeks_in_top_10
FROM
    imdb_movie_data_2023 AS imdb
LEFT JOIN
    kaggle
ON
    imdb.movie_name = kaggle.show_title;
	
CREATE TABLE tableau as 
SELECT * FROM view_full_data_set
WHERE pr_rating not like '%TV%'