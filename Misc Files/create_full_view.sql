	
	--updated with a new name.  copied the kaggle table as netflix
CREATE OR REPLACE VIEW view_full_data_set_no_nulls AS 
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
    imdb.movie_name = netflix.show_title

WHERE 
    imdb.cast0 IS NOT NULL AND 
    imdb.number_rating IS NOT NULL AND
    imdb.genre0 IS NOT NULL AND 
    imdb.meta_score IS NOT NULL AND
    netflix.weekly_rank IS NOT NULL AND
    netflix.cumulative_weeks_in_top_10 IS NOT NULL
	
	--this makes a new table from the view, so we can  update the target columns (weekly_rank and cumulative_weeks_in_top_10) the cumulative column could have been left out of the join.
CREATE table full_data_set_no_rank AS
SELECT * FROM view_full_data_set_no_rank
	
	--this renames the weekly_rank to netflix_top_10 (because we no longer care about rank)
ALTER TABLE netflix RENAME COLUMN weekly_rank TO netflix_top_10
	
	--this will set the null values for all the movies that never made the Top 10 to zero
update full_data_set_no_rank 
set  netflix_top_10 = 0 where netflix_top_10 is null
		
	--this removes teh cummulative_weeks_in_top_10 (because we no longer care about # of weeks and it is just extra duplicate rows)
ALTER TABLE netflix DROP COLUMN cumulative_weeks_in_top_10;