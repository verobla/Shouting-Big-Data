# Shouting-Big-Data
-------------------
Our project for the Big Data Assignment Course.
Like most of the sport events, football also triggers people to produce and share their ideas on social media, like Facebook, WhatsApp or Twitter. These reactions to events could have an emotional load, in other words the entries of the users may express happiness or frustration. The most extreme way of expressing emotions is shouting, especially in the sport events. One can imagine that large sport events, such as FIFA World Cup or Olympic games, can trigger various kinds of emotional data waiting to be mined. The twitter data give a lot of information such as language, devices used etc. and that helps for analysis. 
Analyzing the emotions of people expressed on Twitter by shouting can be useful for psychological studies and it can provide interesting results for companies.

We use tweets from the 2014 World Cup.

The specified analytical goals are:
1. Extracting shouting tweets from the supplied data
2. Finding most shouted words in Twitter
3. Analysis of language of shouting
4. Analysis of devices used to shout with
5. Analysis of the time of shouting

## RUNNING THE PROGRAM

Our project consists of 2 main parts:
1) MapReduce part
2) Pig Latin part

1) Running Mapreduce Part

- You need to download the whole project and build it with `mvn package `command or you can donwload the jar file. *(note that jar file might not be the latest build)*
- After putting jar file to the cluster, you can run FullLauncher.sh or give the following commands with desired input files and output directories:

`hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.PigTableGenerator /user/alyr/worldcup/* FullPigTable`

Different MapReduce tasks are put in different classes which have main methods for clarity and simplicity.

Available programs inside the jar are:

 - **PigTableGenerator:**		to generate the table that are used by Pig Latin
 - **ShoutingExtractor:**		to extract the shouting tweets
 - **NonShoutingExtractor:**	to extract the non shouting tweets
 - **Sorter:**			to sort the tweets
 - **WordCounter:**			to count the words in a tweet

They are all in package "nl.utwente.bigdata.shouting". For more information about the programs check the comments.

2) Pig Latin part

You first need to make sure you have the FullPigTable or the PigTable (depending if you want to test on the whole data or just a small part) on the hadoop file system. For this, run the command:

`hadoop fs -ls `
(add the folder name if it's not in the main folder)
	
And see if the file is there.

Then run the following:

Languages: (in PigLatinResults/Language)

`pig mostshoutinglang.pig`		if you want to test on a small part of the data (PigTable)
	
`pig mostshoutingdlangfull.pig`		if you want to test on the whole table

Devices: (in PigLatinResults/Devices)
	
`pig mostshoutingdevice.pig`		if you want to test on a small part of the data (PigTable)
	
`pig mostshoutingdevicefull.pig`		if you want to test on the whole table

Time: (in PigLatinResults/Time)

`pig time.pig`			if you want to test on a small part of the data (PigTable)
	
`pig timeWhole.pig `		if you want to test on the whole table
	
