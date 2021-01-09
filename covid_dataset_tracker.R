########################################################################################
# simple way to track the number of COVID related datasets published on Open.Canada.ca #
########################################################################################

library(jsonlite)
library(HelpersMG)
library(tidyverse)


#running several queries in order to match the solr synonyms at 
#https://github.com/open-data/ogc_search/blob/4931db3869510abf869c0a1334e7f6afea042101/ogc_search/open_data/solr/lang/synonyms.txt
#this should reduce likelihood of having different results here than from search.open.canada.ca 

query1<-fromJSON("https://open.canada.ca/data/api/action/package_search?q=%22COVID-19%22&rows=1000")
query2<-fromJSON("https://open.canada.ca/data/api/action/package_search?q=corona&rows=1000")
query3<-fromJSON("https://open.canada.ca/data/api/action/package_search?q=coronavirus&rows=1000")
query4<-fromJSON("https://open.canada.ca/data/api/action/package_search?q=%22Covid%22&rows=1000")
query5<-fromJSON("https://open.canada.ca/data/api/action/package_search?q=%22e82b9141-09d8-4f85-af37-d84937bc2503%22") #hack to include a dataset that only mentioned covid in 1 resource title which wasn't getting picked up by the package_search api

#loading query1
ids1<-query1$result$results$id
orgnames1<-query1$result$results$organization$name
orgtype1<-query1$result$results$jurisdiction
title1<-query1$result$results$title
type1<-query1$result$results$type
collection1<-query1$result$results$collection
datecreated1<-query1$result$results$metadata_created
datemodified1<-query1$result$results$metadata_created
q1data<-data.frame(ids1,orgnames1,orgtype1,title1,type1,collection1,datecreated1,datemodified1, stringsAsFactors = F)
names(q1data)<-c("id","org_name","jursdiction","title","type","collection","date_created","date_modified")

rm(query1,ids1,orgnames1,title1,type1,datecreated1,datemodified1)#l33t memory management

#loading query 2
ids2<-query2$result$results$id
orgnames2<-query2$result$results$organization$name
orgtype2<-query2$result$results$jurisdiction
title2<-query2$result$results$title
type2<-query2$result$results$type
collection2<-query2$result$results$collection
datecreated2<-query2$result$results$metadata_created
datemodified2<-query2$result$results$metadata_created
q2data<-data.frame(ids2,orgnames2,orgtype2,title2,type2,collection2,datecreated2,datemodified2, stringsAsFactors = F)
names(q2data)<-c("id","org_name","jursdiction","title","type","collection","date_created","date_modified")

rm(query2,ids2,orgnames2,title2,type2,datecreated2,datemodified2)#l33t memory management

#loading query 3
ids3<-query3$result$results$id
orgnames3<-query3$result$results$organization$name
orgtype3<-query3$result$results$jurisdiction
title3<-query3$result$results$title
type3<-query3$result$results$type
collection3<-query3$result$results$collection
datecreated3<-query3$result$results$metadata_created
datemodified3<-query3$result$results$metadata_created
q3data<-data.frame(ids3,orgnames3,orgtype3,title3,type3,collection3,datecreated3,datemodified3, stringsAsFactors = F)
names(q3data)<-c("id","org_name","jursdiction","title","type","collection","date_created","date_modified")

rm(query3,ids3,orgnames3,orgtype3,title3,type3,collection3,datecreated3,datemodified3)#l33t memory management

#loading query 4
ids4<-query4$result$results$id
orgnames4<-query4$result$results$organization$name
orgtype4<-query4$result$results$jurisdiction
title4<-query4$result$results$title
type4<-query4$result$results$type
collection4<-query4$result$results$collection
datecreated4<-query4$result$results$metadata_created
datemodified4<-query4$result$results$metadata_created
q4data<-data.frame(ids4,orgnames4,orgtype4,title4,type4,collection4,datecreated4,datemodified4, stringsAsFactors = F)
names(q4data)<-c("id","org_name","jursdiction","title","type","collection","date_created","date_modified")

rm(query4,ids4,orgnames4,title4,type4,collection4,datecreated4,datemodified4)#l33t memory management

#adding the one missing dataset
ids5<-query5$result$results$id
orgnames5<-query5$result$results$organization$name
orgtype5<-query5$result$results$jurisdiction
title5<-query5$result$results$title
type5<-query5$result$results$type
collection5<-query5$result$results$collection
datecreated5<-query5$result$results$metadata_created
datemodified5<-query5$result$results$metadata_created
q5data<-data.frame(ids5,orgnames5,orgtype5,title5,type5,collection5,datecreated5,datemodified5, stringsAsFactors = F)
names(q5data)<-c("id","org_name","jursdiction","title","type","collection","date_created","date_modified")


#combining the queries and removing duplicate rows
combineddata<-rbind(q1data,q2data,q3data,q4data,q5data)
uniquedata<-distinct(combineddata)

setwd("/home/runner/work/OpenGov_R_Scripts/OpenGov_R_Scripts")
write.table(uniquedata, file="COVID-dataset-tracker.csv",sep=',', row.names=F, col.names=T)
