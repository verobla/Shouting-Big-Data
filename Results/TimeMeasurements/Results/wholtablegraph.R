setwd("D:/Véronique/School/Twente/BigDataManagement/Project/BigData/Shouting-Big-Data/PigLatinResults/Time/Results")
Sys.setenv(LANG = "en")
results<-read.table("resultsWhole.csv", sep = ";", header = TRUE)
results$time <-as.POSIXct(results$time,format="%m %d %H:%M")
resultsevery<-read.table("results.csv", sep = ";", header = TRUE)
resultsevery$time <-as.POSIXct(resultsevery$time,format="%m %d %H:%M")
yrng <- range(results$count)
require(ggplot2)
library(lubridate)
for (j in 12:26)
{
	nam <- paste("matchesJun",j,sep ="")
	nam <- paste(nam,".csv", sep = "")
	assign(nam, 1:j)
	title <- paste("Number of shouting tweets and all tweets per minute - Jun ",j,sep = "")
	title <- paste(title,j+1,sep = "-")
	assign(title, 1:j)
	title
	lim1 <- paste("2015-06-",j,sep = "")
	lim1 <- paste(lim1," 8:30:00",sep = "")
	lim2 <- paste("2015-06-",j+1,sep = "")
	lim2 <- paste(lim2," 8:30:00",sep = "")
	
	graph <- paste("graph",j,sep="")
	assign(graph, 1:j)
	graph
	sub = subset(results, subset = (time>=lim1 & time <lim2))
	subevery = subset(resultsevery, subset = (time>=lim1 & time <lim2))
	sub
	
	matches = read.csv(nam)
	matches$time <-as.POSIXct(matches$time,format="%m %d %H:%M")
	length = nrow(matches)
	windows()
	graph
	if(length == 4)
	{
		date1<-matches$time[1]
		date2<-matches$time[4]
		int <- interval(date1,date2)
		filename <- paste("Jun",j,sep ="")
		filename <- paste(filename,".png", sep = "")
		match <- sub[sub$time %within% int,]
		nrow(match)
		graph <- ggplot()+geom_line(aes(x=sub$time,y=sub$count), data = sub, binwidth = 1, colour = "mediumpurple4")+xlab("Time") + ylab("Count")+ggtitle(title)
		graph <- graph+geom_area(aes(x= match$time,y=match$count), data = match, binwidth = 1,fill = "blue")
		graph <- graph + geom_line(aes(x=subevery$time,y=subevery$count), data = subevery, binwidth = 1, colour = "black")
		print(graph)
		dev.copy(png,filename)
		dev.off()
	}
	else if(length == 8)
	{
		date1<-matches$time[1]
		date2<-matches$time[4]
		date3<-matches$time[5]
		date4<-matches$time[8]
		int1 <- interval(date1,date2)
		int2 <- interval(date3,date4)
		filename <- paste("Jun",j,sep ="")
		filename <- paste(filename,".png", sep = "")
		match1 <- sub[sub$time %within% int1,]
		nrow(match1)
		match2 <- sub[sub$time %within% int2,]
		nrow(match2)
		graph <- ggplot()+geom_line(aes(x=sub$time,y=sub$count), data = sub, binwidth = 1, colour = "mediumpurple4")+xlab("Time") + ylab("Count")+ggtitle(title)
		graph <- graph+geom_area(aes(x= match1$time,y=match1$count), data = match1, binwidth = 1,fill = "blue")
		graph <- graph+geom_area(aes(x= match2$time,y=match2$count), data = match2, binwidth = 1,fill = "green")
		graph <- graph + geom_line(aes(x=subevery$time,y=subevery$count), data = subevery, binwidth = 1, colour = "black")
		
		print(graph)
		dev.copy(png,filename)
		dev.off()

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
		filename <- paste("Jun",j,sep ="")
		filename <- paste(filename,".png", sep = "")
		match1 <- sub[sub$time %within% int1,]
		nrow(match1)
		match2 <- sub[sub$time %within% int2,]
		nrow(match2)
		match3 <- sub[sub$time %within% int3,]
		nrow(match3)

		graph <- ggplot()+geom_line(aes(x=sub$time,y=sub$count), data = sub, binwidth = 1, colour = "mediumpurple4")+xlab("Time") + ylab("Count")+ggtitle(title)
		graph <- graph+geom_area(aes(x= match1$time,y=match1$count), data = match1, binwidth = 1,fill = "blue")
		graph <- graph+geom_area(aes(x= match2$time,y=match2$count), data = match2, binwidth = 1,fill = "green")
		graph <- graph+geom_area(aes(x= match3$time,y=match3$count), data = match3, binwidth = 1,fill = "red")
		graph <- graph + geom_line(aes(x=subevery$time,y=subevery$count), data = subevery, binwidth = 1, colour = "black")
		
		print(graph)
		dev.copy(png,filename)
		dev.off()
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
		filename <- paste("Jun",j,sep ="")
		filename <- paste(filename,".png", sep = "")
		match1 <- sub[sub$time %within% int1,]
		nrow(match1)
		match2 <- sub[sub$time %within% int2,]
		nrow(match2)
		match3 <- sub[sub$time %within% int3,]
		nrow(match3)
		match4 <- sub[sub$time %within% int4,]
		nrow(match4)
		graph <- ggplot()+geom_line(aes(x=sub$time,y=sub$count), data = sub, binwidth = 1, colour = "mediumpurple4")+xlab("Time") + ylab("Count")+ggtitle(title)
		graph <- graph+geom_area(aes(x= match1$time,y=match1$count), data = match1, binwidth = 1,fill = "blue")
		graph <- graph+geom_area(aes(x= match2$time,y=match2$count), data = match2, binwidth = 1,fill = "green")
		graph <- graph+geom_area(aes(x= match3$time,y=match3$count), data = match3, binwidth = 1,fill = "red")
		graph <- graph+geom_area(aes(x= match4$time,y=match4$count), data = match4, binwidth = 1,fill = "yellow")
		graph <- graph + geom_line(aes(x=subevery$time,y=subevery$count), data = subevery, binwidth = 1, colour = "black")
		
		print(graph)
		dev.copy(png,filename)
		dev.off()
	} 
	
	Sys.sleep(3)
}




