setwd("D:/Véronique/School/Twente/BigDataManagement/Project/BigData/Shouting-Big-Data/Time")
results<-read.table("results.csv", sep = ";", header = TRUE)
results$time <-as.POSIXct(results$time,format="%m %d %H:%M")
yrng <- range(results$count)



jun12 <- subset(results, subset = (time>="2015-06-12 8:30:00" & time <"2015-06-13 8:30:00"))
graph <- qplot(time,count,title = "2014-06-12 8:30:00 to 2014-06-13 8:30:00", geom = "line", data = jun12, binwidth = 1)
matchesjun12 <-read.csv("matchesJun12.csv")
matchesjun12$time <-as.POSIXct(matchesjun12$time,format="%m %d %H:%M")
library(lubridate)
length = nrow(matchesjun12)/2
length
i=1
while (i <= length)
{
date1<-matchesjun12$time[i]
date2<-matchesjun12$time[i+1]
int <- interval(date1,date2)
match1 <- jun12[jun12$time %within% int,]
graph<-graph+geom_area(aes(x= match1$time,y=match1$count), data = match1, binwidth = 1,fill = "blue")
i<-i+2
}
i
graph



