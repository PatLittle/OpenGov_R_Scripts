library(tictoc)
library(jsonlite)
library(HelpersMG)
library(R.utils)
library(ckanr)
library(dplyr)
library(stringr)
install.packages("jqr")
library(jqr)

wget("https://open.canada.ca/static/od-do-canada.jsonl.gz")

R.utils::gunzip("od-do-canada.jsonl.gz", remove=T) #taking the metadata catalogue jsonlines and gunzipping
query1<-readLines("od-do-canada.jsonl") #reading it into R line by line

qqq<-jq(query1,'{id,title,metadata_created,digital_object_identifier}') %>% select(.digital_object_identifier | contains("doi.org"))


qq1<-fromJSON(qqq[[1]])

qID<-qq1$id
qtitle<-qq1$title
qmeta<-qq1$metadata_created
qdoi<-qq1$digital_object_identifier

q<-data.frame(qID,qtitle,qmeta,qdoi)

for (i in 2:length(qqq)){
  qq1<-fromJSON(qqq[[i]])
  qID<-qq1$id
  qtitle<-qq1$title
  qmeta<-qq1$metadata_created
  qdoi<-qq1$digital_object_identifier
  q<- q %>% add_row(qID,qtitle,qmeta,qdoi)
  
}