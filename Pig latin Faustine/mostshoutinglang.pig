tweets = LOAD 'samplePigTable.tsv' AS (tweetId, language, tweetTime, device, text,shout);
shout_tweets = FILTER tweets by shout == 'true';
groups = GROUP shout_tweets BY language;
counting = FOREACH groups GENERATE group, COUNT(shout_tweets.language);
STORE counting INTO 'mostshoutlang';