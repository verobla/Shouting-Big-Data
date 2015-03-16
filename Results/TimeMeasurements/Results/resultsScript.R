setwd("D:/Véronique/School/Twente/BigDataManagement/Project/BigData/Shouting-Big-Data/Time")
results<-read.table("results.csv", sep = ";", header = TRUE)
results$time <-as.POSIXct(results$time,format="%m %d %H:%M")
yrng <- range(results$count)
require(ggplot2)
library(lubridate)
j = 16
for (j in 12:26)
{
	nam <- paste("matchesJun",j,sep ="")
	nam <- paste(nam,".csv", sep = "")
	assign(nam, 1:j)
	lim1 <- paste("2015-06-",j,sep = "")
	lim1 <- paste(lim1," 8:30:00",sep = "")
	lim2 <- paste("2015-06-",j+1,sep = "")
	lim2 <- paste(lim2," 8:30:00",sep = "")
	
	graph <- paste("graph",j,sep="")
	assign(graph, 1:j)
	graph
	sub = subset(results, subset = (time>=lim1 & time <lim2))
	sub
	
	matches = read.csv(nam)
	matches$time <-as.POSIXct(matches$time,format="%m %d %H:%M")
	length = nrow(matches)-3
	windows()
	graph
	match
	for(i in seq(1,length,4))
	{
		date1<-matches$time[i]
		date2<-matches$time[i+3]
		int <- interval(date1,date2)
		#match <- paste("match",i,sep="")
		#assign(match, paste("match",i,sep=""))
		filename <- paste("Jun",j,sep ="")
		filename <- paste(filename,i, sep = "")
		filename <- paste(filename,".png", sep = "")
		match <- sub[sub$time %within% int,]
		nrow(match)
		graph <- ggplot()+geom_line(aes(x=sub$time,y=sub$count), data = sub, binwidth = 1)
		graph <- graph+geom_area(aes(x= match$time,y=match$count), data = match, binwidth = 1,fill = "blue")
		print(graph)
		dev.copy(png,filename)
		dev.off()
		Sys.sleep(0)
	}
	print(match)
	i
	graph
	Sys.sleep(5)
}




