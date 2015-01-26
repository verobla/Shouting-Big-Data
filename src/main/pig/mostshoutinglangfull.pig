tweets = LOAD 'FullPigTable' AS (tweetId, language, tweetTime, device, text);
groups = GROUP tweets BY language;
counting = FOREACH groups GENERATE group, COUNT(tweets.language) as mycount;
final = ORDER counting BY mycount;
STORE final INTO 'mostshoutlangs';