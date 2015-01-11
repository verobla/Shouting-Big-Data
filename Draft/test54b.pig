users = LOAD 'users2.tsv' AS (userId, screenName, language, location, statusesCount, favouritesCount, friendsCount, description, name, createdAt, followersCount, timeZone, profileLinkColor, profileTextColor, profileSidebarBorderColor, profileBackgroundColor, profileSidebarFillColor, profileBackgroundImageUrl, profileBannerUrl, url);
tweets = LOAD 'tweets2.tsv' AS (tweetId, userId, tweetTime, language, text);
dutch_users = FILTER users BY language == 'nl';
english_tweets = FILTER tweets BY language != 'nl'; 
usertweets = COGROUP dutch_users BY userId, english_tweets BY userId;
joinusertweets = FOREACH usertweets GENERATE FLATTEN(dutch_users), FLATTEN(english_tweets);
STORE joinusertweets INTO 'output54b';