tweets = LOAD 'FullPigTableOfAllData' AS (tweetId, language, tweetTime, device, text);
groups = GROUP tweets BY SUBSTRING(tweetTime,3,16);
counters = FOREACH groups GENERATE group, COUNT(tweets); 
my_output = GENERATE mean.Mean(counters);
STORE my_output INTO 'meancounter';