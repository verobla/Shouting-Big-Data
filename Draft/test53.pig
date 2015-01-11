tweets = LOAD 'tweets2.tsv' AS (tweetId, userId, tweetTime, language, text); 
seconds_tweets = FILTER tweets BY tweetTime >= 'Sun Jul 13 21:24:00 +0000 2014' AND tweetTime < 'Sun Jul 13 21:25:00 +0000 2014'; 
groups = GROUP seconds_tweets BY tweetTime;
my_output = FOREACH groups GENERATE group, COUNT(seconds_tweets.tweetTime); 
STORE my_output INTO 'output53';