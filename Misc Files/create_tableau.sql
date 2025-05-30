-- Create a view that contains films that have and have not reached netflix top 10


CREATE OR REPLACE VIEW view_full_data_set AS
SELECT
    imdb.*,
    netflix.weekly_rank,
    netflix.weekly_hours_viewed,
    netflix.weekly_views,
    netflix.cumulative_weeks_in_top_10
FROM
    imdb_movie_data_2023 AS imdb
LEFT JOIN
    netflix
ON
    imdb.movie_name = netflix.show_title;
	
CREATE TABLE tableau as 
SELECT * FROM view_full_data_set