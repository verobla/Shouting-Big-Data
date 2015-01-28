#!/bin/sh
hadoop fs -rm -r FullPigTable
hadoop fs -rm -r FullShoutingWords

#be careful with CRLF line endings. That will cause problems in hadoop fs path names.
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.FullPigTableGenerator /user/alyr/worldcup/* FullPigTableWithNonShouts
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.PigTableGenerator /user/alyr/worldcup/* FullPigTable
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.ShoutingExtactor /user/alyr/worldcup/* FullShoutingWords
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.ShoutingExtactor /user/alyr/worldcup/* FullNonShoutingWords
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.Sorter FullShoutingWords/* FullShoutingWordsSorted
hadoop jar bigdata-0.2.jar nl.utwente.bigdata.shouting.WordCounter FullShoutingWords/* FullNonShoutingWords/*  FullNonShoutingWords

hadoop fs -cat FullShoutingWords/* > ../FullSortedShoutingWords
hadoop fs -cat FullPigTable/* > ../resultFullPigTable

