tweets = LOAD 'FullPigTable' AS (tweetId, language, tweetTime, device, text);

day_tweetsJun12 = FILTER tweets BY tweetTime >= 'Thu Jun 12 00:00:00 +0000 2014' AND tweetTime < 'Thu Jun 12 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun12 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun12); 
STORE my_output INTO 'Jun12';

day_tweetsJun13 = FILTER tweets BY tweetTime >= 'Fri Jun 13 00:00:00 +0000 2014' AND tweetTime < 'Fri Jun 13 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun13 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun13); 
STORE my_output INTO 'Jun13';

day_tweetsJun14 = FILTER tweets BY tweetTime >= 'Sat Jun 14 00:00:00 +0000 2014' AND tweetTime < 'Sat Jun 14 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun14 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun14); 
STORE my_output INTO 'Jun14';

day_tweetsJun15 = FILTER tweets BY tweetTime >= 'Sun Jun 15 00:00:00 +0000 2014' AND tweetTime < 'Sun Jun 15 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun15 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun15); 
STORE my_output INTO 'Jun15';

day_tweetsJun16 = FILTER tweets BY tweetTime >= 'Mon Jun 16 00:00:00 +0000 2014' AND tweetTime < 'Mon Jun 16 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun16 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun16); 
STORE my_output INTO 'Jun16';

day_tweetsJun17 = FILTER tweets BY tweetTime >= 'Tue Jun 17 00:00:00 +0000 2014' AND tweetTime < 'Tue Jun 17 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun17 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun17); 
STORE my_output INTO 'Jun17';

day_tweetsJun18 = FILTER tweets BY tweetTime >= 'Wed Jun 18 00:00:00 +0000 2014' AND tweetTime < 'Wed Jun 18 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun18 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun18); 
STORE my_output INTO 'Jun18';

day_tweetsJun19 = FILTER tweets BY tweetTime >= 'Thu Jun 19 00:00:00 +0000 2014' AND tweetTime < 'Thu Jun 19 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun19 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun19); 
STORE my_output INTO 'Jun19';

day_tweetsJun20 = FILTER tweets BY tweetTime >= 'Fri Jun 20 00:00:00 +0000 2014' AND tweetTime < 'Fri Jun 20 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun20 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun20); 
STORE my_output INTO 'Jun20';

day_tweetsJun21 = FILTER tweets BY tweetTime >= 'Sat Jun 21 00:00:00 +0000 2014' AND tweetTime < 'Sat Jun 21 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun21 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun21); 
STORE my_output INTO 'Jun21';

day_tweetsJun22 = FILTER tweets BY tweetTime >= 'Sun Jun 22 00:00:00 +0000 2014' AND tweetTime < 'Sun Jun 22 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun22 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun22); 
STORE my_output INTO 'Jun22';

day_tweetsJun23 = FILTER tweets BY tweetTime >= 'Mon Jun 23 00:00:00 +0000 2014' AND tweetTime < 'Mon Jun 23 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun23 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun23); 
STORE my_output INTO 'Jun23';

day_tweetsJun24 = FILTER tweets BY tweetTime >= 'Tue Jun 24 00:00:00 +0000 2014' AND tweetTime < 'Tue Jun 24 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun24 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun24); 
STORE my_output INTO 'Jun24';

day_tweetsJun25 = FILTER tweets BY tweetTime >= 'Wed Jun 25 00:00:00 +0000 2014' AND tweetTime < 'Wed Jun 25 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun25 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun25); 
STORE my_output INTO 'Jun25';

day_tweetsJun26 = FILTER tweets BY tweetTime >= 'Thu Jun 26 00:00:00 +0000 2014' AND tweetTime < 'Thu Jun 26 23:59:59 +0000 2014'; 
groups = GROUP day_tweetsJun26 BY SUBSTRING(tweetTime,11,16);
my_output = FOREACH groups GENERATE group, COUNT(day_tweetsJun26); 
STORE my_output INTO 'Jun26';