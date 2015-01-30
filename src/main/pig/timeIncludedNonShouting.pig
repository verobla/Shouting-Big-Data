tweets = LOAD 'PigTableSmallDataSet' AS (tweetId, language, tweetTime, device, text);
groups = GROUP tweets BY SUBSTRING(tweetTime,3,16);
my_output = FOREACH groups GENERATE group, COUNT(tweets); 
STORE my_output INTO 'timeeverythingsmall';