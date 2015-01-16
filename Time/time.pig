tweets = LOAD 'resultPigTable' AS (tweetId, language, tweetTime, device, text, shout); 
shout_tweets = FILTER tweets BY shout != 'false';
day_tweets = FILTER shout_tweets BY tweetTime >= 'Wed Jun 18 00:00:00 +0000 2014' AND tweetTime < 'Wed Jun 18 23:59:59 +0000 2014'; 
groups = GROUP day_tweets BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweets); 
STORE my_output INTO 'time';