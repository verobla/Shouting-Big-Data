# Shouting-Big-Data
Our real nice project for the Big Data Assignment Course

# RUNNING THE PROGRAM

Our project consists of 2 main parts:
1) Mapreduce part
2) Pig Latin part

1) Running Mapreduce Part
 - You need to download the whole project and build it with "mvn package" command or you can donwload the jar file. ( note that jar file might not be the latest build )
 - After putting jar file to the cluster, you can run FullLauncher.sh or give the following commands with desired input files and output directories :

 hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.PigTableGenerator /user/alyr/worldcup/* FullPigTable

 Different mapreduce tasks are put in different classes which have main methods for clarity and simplicity.

 Available programs inside the jar are:

 PigTableGenerator
 ShoutingExtractor
 NonShoutingExtractor
 Sorter
 WordCounter

 they are all in package "nl.utwente.bigdata.shouting". For more information about the programs check the comments.

2) Pig Latin part