# Shouting-Big-Data
Our real nice project for the Big Data Assignment Course

# RUNNING THE PROGRAM

Our project consists of 2 main parts:
1) MapReduce part
2) Pig Latin part

1) Running Mapreduce Part
 - You need to download the whole project and build it with "mvn package" command or you can donwload the jar file. (note that jar file might not be the latest build)
 - After putting jar file to the cluster, you can run FullLauncher.sh or give the following commands with desired input files and output directories:

 hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.PigTableGenerator /user/alyr/worldcup/* FullPigTable

 Different MapReduce tasks are put in different classes which have main methods for clarity and simplicity.

 Available programs inside the jar are:

 - PigTableGenerator:		to generate the table that are used by Pig Latin
 - ShoutingExtractor:		to extract the shouting tweets
 - NonShoutingExtractor:	to extract the non shouting tweets
 - Sorter:					to sort the tweets
 - WordCounter:			to count the words in a tweet

 they are all in package "nl.utwente.bigdata.shouting". For more information about the programs check the comments.

2) Pig Latin part
-You first need to make sure you have the FullPigTable or the PigTable (depending if you want to test on the whole data or just a small part) on the hadoop file system. For this, run the command:

	hadoop fs -ls 
	(add the folder name if it's not in the main folder)
	
and see if the file is there.

Then run the following:	

	pig time.pig		if you want to test on a small part of the data (PigTable)
	
	pig timeWhole.pig 	if you want to test on the whole table
	