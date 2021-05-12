install.packages("googleAnalyticsR")
library(googleAnalyticsR)
library(tidyr)




#set the ga view ID, start date, end date. 
myid<-68455797
datestart<-"2020-06-01"
dateend<-"2021-04-30"

#read in the dataset list generated separately within the repo, then create a list of UUIDs
datasets<-read.table("COVID-dataset-list.csv", header=T, sep = ",", stringsAsFactors = F)
pagex<-datasets$id


#initialize a 2nd counter and a data frame
i<-1

output<-data.frame("a","b","c","d")


#loop over the API for each dataset in the CSV
for (p in pagex){

querypage<-paste0("ga:pagePath=@",pagex[i],sep="")

print(querypage)

web_data <- data.frame(google_analytics(myid, 
                               date_range = c(datestart, dateend),
                               metrics = c("totalEvents","pageviews"),
                               dimensions = c("yearMonth"), 
                               anti_sample = TRUE,
                               filtersExpression = querypage), pagex[i])

colnames(output)<-colnames(web_data)
output<-rbind(output,web_data, rownames=F, colnames=F)

i<-i+1
}





#clean up the output removing some artifacts
names(output)<-c("year/month", "downloads","pageviews","id")
outputclean<-output[ !output$id %in% c(FALSE,"d"), ]

write.table(outputclean,file="covid-datasets-analytics.csv", append=FALSE, sep=",",row.names=F,col.names=T, fileEncoding = "UTF-8")


#do a summary report
overallnumbers<-data.frame("")
overallnumbers$total<-"Total"
overallnumbers$yearmonth <- paste(datestart,"-",dateend)
overallnumbers$downloads<-sum(as.numeric(outputclean$downloads))
overallnumbers$pageviews<-sum(as.numeric(outputclean$pageviews))
overallnumbers$X..<-NULL

write.table(overallnumbers, file="covid-datasets-total-analytics.csv", append=TRUE, sep=",",row.names=F,col.names=F, fileEncoding = "UTF-8")


