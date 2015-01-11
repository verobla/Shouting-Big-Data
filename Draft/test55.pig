REGISTER wheresArjen.jar;
tweets = LOAD 'tweets2.tsv' AS (tweetId, userId, tweetTime, language, text); 
arjen_tweets = FILTER tweets BY wheresArjen.WheresArjen(text);
grouptweets = GROUP arjen_tweets ALL;
total = FOREACH grouptweets GENERATE COUNT(arjen_tweets);
STORE total INTO 'output55t';