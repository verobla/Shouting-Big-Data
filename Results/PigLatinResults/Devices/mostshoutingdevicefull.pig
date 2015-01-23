tweets = LOAD 'FullPigTable' AS (tweetId, language, tweetTime, device, text);
groups = GROUP tweets BY device;
counting = FOREACH groups GENERATE group, COUNT(tweets.device) as mycount;
final = ORDER counting BY mycount;
STORE final INTO 'mostshoutdevices';