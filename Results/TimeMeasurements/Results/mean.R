setwd("D:/Véronique/School/Twente/BigDataManagement/Project/BigData/Shouting-Big-Data/PigLatinResults/Time/Results")
Sys.setenv(LANG = "en")
results<-read.table("results.csv", sep = ";", header = TRUE)
results$time <-as.POSIXct(results$time,format="%m %d %H:%M")
resultsevery<-read.table("resultsWhole.csv", sep = ";", header = TRUE)
resultsevery$time <-as.POSIXct(resultsevery$time,format="%m %d %H:%M")
require(ggplot2)
library(lubridate)
list1<-list()
for (j in 12:26)
{
	nam <- paste("matchesJun",j,sep ="")
	nam <- paste(nam,".csv", sep = "")
	assign(nam, 1:j)


	
	matches = read.csv(nam)
	matches$time <-as.POSIXct(matches$time,format="%m %d %H:%M")
	length = nrow(matches)
	yrn = range(matches$time)
	lim1<-yrn[1]-2*60*60;
	lim2<-yrn[2]+2*60*60;
	sub = subset(results, subset = (time>=lim1 & time <lim2))
	subevery = subset(resultsevery, subset = (time>=lim1 & time <lim2))
	sub
	if(length == 4)
	{
		date1<-matches$time[1]
		date2<-matches$time[4]
		int <- interval(date1,date2)

		match <- sub[sub$time %within% int,]
		nomatch <- sub[!(sub$time %within% int),]
		matchevery <- sub[subevery$time %within% int,]
		nomatchevery <- sub[!(subevery$time %within% int),]
		mean <- mean(match$count)
		meanno <-mean(nomatch$count)
		print(mean)
		print(meanno)
		print("and")
		
		mean2 <- mean(matchevery$count)
		meanno2 <-mean(nomatchevery$count)
		print(mean2)
		print(meanno2)
		list1[[j-11]]<-c(mean,meanno,mean2,meanno2);
	}
	else if(length == 8)
	{
		date1<-matches$time[1]
		date2<-matches$time[4]
		date3<-matches$time[5]
		date4<-matches$time[8]
		int1 <- interval(date1,date2)
		int2 <- interval(date3,date4)
		

		match <- sub[sub$time %within% int1 | sub$time %within% int2 ,]
		nomatch <- sub[!(sub$time %within% int1) & !( sub$time %within% int2) ,]
		matchevery <- sub[subevery$time %within% int1 | subevery$time %within% int2 ,]
		nomatchevery <- sub[!(subevery$time %within% int1) & !( subevery$time %within% int2) ,]
		mean <- mean(match$count)
		meanno <-mean(nomatch$count)

		print(mean)
		print(meanno)
		print("and")
		
		mean2 <- mean(matchevery$count)
		meanno2 <-mean(nomatchevery$count)
		print(mean2)
		print(meanno2)
		list1[[j-11]]<-c(mean,meanno,mean2,meanno2);

	}
	else if(length == 12)
	{
		date1<-matches$time[1]
		date2<-matches$time[4]
		date3<-matches$time[5]
		date4<-matches$time[8]
		date5<-matches$time[9]
		date6<-matches$time[12]
		int1 <- interval(date1,date2)
		int2 <- interval(date3,date4)
		int3 <- interval(date5,date6)
		

		match <- sub[sub$time %within% int1| sub$time %within% int2| sub$time %within% int3,]
		nomatch <- sub[!(sub$time %within% int1)& !( sub$time %within% int2)&! (sub$time %within% int3),]
		matchevery <- sub[subevery$time %within% int1| subevery$time %within% int2| subevery$time %within% int3,]
		nomatchevery <- sub[!(subevery$time %within% int1)& !( subevery$time %within% int2)&! (subevery$time %within% int3),]

		mean <- mean(match$count)
		meanno <-mean(nomatch$count)
		print(mean)
		print(meanno)
		print("and")
		
		mean2 <- mean(matchevery$count)
		meanno2 <-mean(nomatchevery$count)
		print(mean2)
		print(meanno2)
		list1[[j-11]]<-c(mean,meanno,mean2,meanno2);
	}
	else if(length == 16)
	{
		date1<-matches$time[1]
		date2<-matches$time[4]
		date3<-matches$time[5]
		date4<-matches$time[8]
		date5<-matches$time[9]
		date6<-matches$time[12]
		date7<-matches$time[13]
		date8<-matches$time[16]
		int1 <- interval(date1,date2)
		int2 <- interval(date3,date4)
		int3 <- interval(date5,date6)
		int4 <- interval(date7,date8)

		match <- sub[sub$time %within% int1| sub$time %within% int2| sub$time %within% int3| sub$time %within% int4,]
		nomatch <- sub[!(sub$time %within% int1)& !(sub$time %within% int2)& !(sub$time %within% int3) & !(sub$time %within% int4),]
		matchevery <- sub[subevery$time %within% int1| subevery$time %within% int2| subevery$time %within% int3| subevery$time %within% int4,]
		nomatchevery <- sub[!(subevery$time %within% int1)& !(subevery$time %within% int2)& !(subevery$time %within% int3) & !(subevery$time %within% int4),]
				

		mean <- mean(match$count)
		meanno <-mean(nomatch$count)
		print(mean)
		print(meanno)
		print("and")
		
		mean2 <- mean(matchevery$count)
		meanno2 <-mean(nomatchevery$count)
		print(mean2)
		print(meanno2)
		list1[[j-11]]<-c(mean,meanno,mean2,meanno2);
	} 
	
	Sys.sleep(3)
}


print(list1)
write.csv2(list1,"mean.csv");
