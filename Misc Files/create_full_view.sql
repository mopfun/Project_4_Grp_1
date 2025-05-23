--Create the View
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

--Pull Data, organized by name and weeks in top 10
select * from view_full_data_set where weekly_rank > 0 order by movie_name asc, cumulative_weeks_in_top_10 desc

--view NO NULLS
CREATE OR REPLACE VIEW view_full_data_set_no_nulls AS 
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
    imdb.movie_name = kaggle.show_title

WHERE 
    imdb.cast0 IS NOT NULL AND 
    imdb.cast1 IS NOT NULL AND
    imdb.cast2 IS NOT NULL AND 
    imdb.cast3 IS NOT NULL AND 
    imdb.number_rating IS NOT NULL AND
    imdb.genre0 IS NOT NULL AND 
    imdb.genre1 IS NOT NULL AND 
    imdb.genre2 IS NOT NULL AND 
    imdb.genre3 IS NOT NULL AND 
    imdb.meta_score IS NOT NULL AND
    kaggle.weekly_rank IS NOT NULL AND
    kaggle.weekly_hours_viewed IS NOT NULL AND
    kaggle.weekly_views IS NOT NULL AND
    kaggle.cumulative_weeks_in_top_10 IS NOT NULL
	
	
	--take three!
	
	--view NO NULLS
CREATE OR REPLACE VIEW view_full_data_set_no_nulls AS 
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
    imdb.movie_name = kaggle.show_title

WHERE 
    imdb.cast0 IS NOT NULL AND 
    imdb.number_rating IS NOT NULL AND
    imdb.genre0 IS NOT NULL AND 
    imdb.meta_score IS NOT NULL AND
    kaggle.weekly_rank IS NOT NULL AND
    kaggle.weekly_hours_viewed IS NOT NULL AND
    kaggle.weekly_views IS NOT NULL AND
    kaggle.cumulative_weeks_in_top_10 IS NOT NULL

--take 4!!

	--view NO NULLS
CREATE OR REPLACE VIEW view_full_data_set_no_nulls AS 
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
    imdb.movie_name = kaggle.show_title

WHERE 
    imdb.cast0 IS NOT NULL AND 
    imdb.number_rating IS NOT NULL AND
    imdb.genre0 IS NOT NULL AND 
    imdb.meta_score IS NOT NULL AND
    kaggle.weekly_rank IS NOT NULL AND
    kaggle.cumulative_weeks_in_top_10 IS NOT NULL
