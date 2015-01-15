mvn package
cd $HOME/Documents/Lectures/BigData/Shouting-Big-Data/target

hadoop fs -rm -R pigTable
hadoop fs -rm -R shoutingWords
hadoop fs -rm -R nonShoutingWords
hadoop fs -rm -R shoutingWordsSorted
hadoop fs -rm -R wordCount

hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.PigTableGenerator worldcup-part*.json pigTable
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.ShoutingExtactor worldcup-part*.json shoutingWords
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.NonShoutingExtractor worldcup-part*.json nonShoutingWords
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.Sorter shoutingWords/* shoutingWordsSorted
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.WordCounter shoutingWords/* nonShoutingWords/* wordCounts

: '
cd $HOME/Documents/Lectures/BigData/Shouting-Big-Data/mapreduceResults

hadoop fs -cat pigTable/* > resultPigTable
hadoop fs -cat shoutingWords/* > resultShoutingWords
hadoop fs -cat shoutingWordsSorted/* > resultShoutingWordsSorted
hadoop fs -cat nonShoutingWords/* > nonShouting
hadoop fs -cat wordCounts/* > wordCounts
'
