tweets = LOAD 'tweets2.tsv' AS (tweetId, userId, tweetTime, language, text); 
english_tweets = FILTER tweets BY language == 'en'; 
groups = GROUP english_tweets BY userId; 
big_groups = FILTER groups BY COUNT(english_tweets) > 10; 
my_output = FOREACH big_groups GENERATE group, COUNT(english_tweets.tweetId); 
STORE my_output INTO 'myoutput';

CREATE TABLE tweets2(
tweetId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
userId INT,
tweetTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
language VARCHAR(2),
text VARCHAR(140)
);

INSERT INTO tweets2(userId,tweetTime,language,text) VALUES(1348812668,DEFAULT,'en','African team can win World Cup, says Nigeria coach #Argentina #SouthAfrica http://t.co/MspYu55TuG');

SELECT userId, count(tweetId)
from tweets2 
where language = 'en'
group by userId HAVING COUNT (*)>10;