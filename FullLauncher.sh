hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.PigTableGenerator /user/alyr/worldcup/* FullPigTable
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.ShoutingExtactor /user/alyr/worldcup/* FullShoutingWords
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.Sorter FullShoutingWords/* FullShoutingWordsSorted

hadoop fs -cat FullShoutingWords/* > ../FullSortedShoutingWords
hadoop fs -cat FullPigTable/* > ../resultFullPigTable

