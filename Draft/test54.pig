users = LOAD 'users2.tsv' AS (userId, screenName, language, location, statusesCount, favouritesCount, friendsCount, description, name, createdAt, followersCount, timeZone, profileLinkColor, profileTextColor, profileSidebarBorderColor, profileBackgroundColor, profileSidebarFillColor, profileBackgroundImageUrl, profileBannerUrl, url);
tweets = LOAD 'tweets2.tsv' AS (tweetId, userId, tweetTime, language, text);
dutch_users = FILTER users BY language == 'nl';
english_tweets = FILTER tweets BY language != 'nl'; 
usertweets = JOIN dutch_users BY userId, english_tweets BY userId;
STORE usertweets INTO 'output54';