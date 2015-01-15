tweets = LOAD 'tweets2.tsv' AS (tweetId, language, tweetTime, device, text, hashtag, shout); 
shout_tweets = FILTER tweets BY shout == 'true';
day_tweets = FILTER shout_tweets BY tweetTime >= 'Mon Jun 16 00:00:00 +0000 2014' AND tweetTime < 'Mon Jun 16 23:59:59 +0000 2014'; 
groups = GROUP day_tweets BY tweetTime;
my_output = FOREACH groups GENERATE group, COUNT(day_tweets.tweetTime); 
STORE my_output INTO 'time';