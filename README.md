# Project_4_Grp_1

## Summary
After exporting the Netflix Top 10 movie file and IMDb movie's file, we cleaned up the data set by filtering out the columns that we didn't feel pertained to our ultimate purpose of this project. Once the columns were removed, we split up the cleaned data set into two, one for the visualization portion via Tableau, and converted binary values for the columns that were going to be used in the machine learning models. What we wanted to showcase in this project is to see if machine learning woudl be able to predict, and with how much accuracy, which movies when the information is entered via the flask module, would make it in the top 10 movies or not.

Before moving on to the machine learning coding, we created a couple visualizations via Tableau to showcase what movies/directors, cast members, and genres would fall under the top 10 movies. The types of visualizations we created were bar charts of movie names, treemap of a broad view of all the directors, a bubble map of a more diverse directors visualization with more filters (movie name, all cast members, avg cumulative weeks in top 10, and avg meta score), a treemap comparison of multiple genres versus one genre column. These visualizations will help us know which directors, genres, cast members, meta score, etc would help our API/Netflix on which movies would be a 'big hit/worth possibly buying the writes to.'

To see which model would produce the best accuracy preduction model, we tested out the logistic regression, random forest, keras neural/tuner. With a lot of testing and training, we concluded that the randomm forest model produced the best output with an accuracy level of 99% versus low 90's with the other models. We were also able to conclude that with this model, we were able to predict whether a movie would be in the top 10 or not.

Once we got the machine learning models completed, we worked on integrating the random forest model into the flask API program so that we could create the HTML API to run the preductions. After lots of trial and error, we concluded that the following parameters need to be filled out in order to successfully run the program: IMDb Rating (1-10), Meta Rcore (1-100), Rating Label, Weekly Hours Viewed, Votes, Year, Genre, Cast 1 (at least one cast member), and Director. Once all these fields have been filled, it will produce one of the two messages, 'Yes, it will be in the Netflix Top 10!' or 'Sorry, this movie will not make the cut.'

There were areas in which we definitely believe would help improved our project, one of which would be the more time in general, but also to spend to gather more data engineering features to boost our API/flask program. Secondly, with more time to troubleshoot each of our tasks, it would ultimately help all of us to know how much of the data minipulation would allow all of us to expand the abilities in which we can showcase the more varied visualizations. 
With the tableau data set, it is worth mentioning that the visualizations would create different/similar outcomes if we decided to go with the raw file. We ultimately wanted to utilze the cleaned version to avoid the null values that weren't available within the two data sets.
One ther immport thing we found out very late in the process of this entire project, was the number of null values in our weekly_hours_viewed column (showing as the most important feature in our random forest model) that we filled in with zeros. Not thinking too much on how this could effect our models, we realized that it did in fact impact the predictions of the model, in the sense that it actually gave the answers for the model aheasd of time. This is a good example of data leakage and while the model performed very well with the featurtes inckluded, the results aren't as meaningful since we wouldn't have access to the weekly_hours_viewed data before the movie would become 'popular.' After figuring out all of this, we knew that this little matter isn't something we could rely on to make predictions outside of the Netflix internal team. 

## Final thoughts - how Netflix could use this data
1. Internal Validation
• Test hypotheses about what makes a movie successful on the platform.
• Identify which features (like viewership numbers or genre) most influence Top 10 appearances.
Help data teams evaluate the impact of early engagement metrics.
2. Predictive Power for In-House Releases
• With access to early viewership data, Netflix can use the model internally to predict which new releases are trending toward Top 10.
• Helps with marketing prioritization and promotional placement on the app.
3. Content Strategy Insights
• Identify patterns across successful titles to guide content acquisition or development.
• For example, if certain genres or cast members consistently correlate with Top 10 success, that can guide future investments.
4. Platform Optimization
• Predict what should be featured more prominently on homepages to boost engagement.
• Support algorithmic decisions behind carousels and featured banners.
5. Forecasting Library Value
• Estimate which existing titles in the Netflix catalog might resurge into popularity, helping with licensing decisions or planning seasonal marketing pushes.