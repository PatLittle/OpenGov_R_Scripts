library(readxl)
library(openxlsx)
library(tidyverse)
library(R.utils)
library(tidymodels)
library(data.table)

query1<-readLines("new-od-do-canada.jl_2021-03-31")
lines <- lapply(query1,unlist)

library(jsonlite)
q1<-fromJSON(lines[[1]])
ID<-q1$id
org<-q1$organization$name
collection<-q1$collection
freq<-q1$frequency
jurisdiction<-q1$jurisdiction
date_created<-q1$metadata_created
date_last_mod<-q1$metadata_modified
type<-q1$type
q1data<-data.frame(ID,org,collection,freq,jurisdiction,date_created,date_last_mod,type)
names(q1data)<-c("ID","org","collection","freq","jurisdiction","date_created","date_last_mod","type")

for(i in 2:length(lines)){ #loop over this for each line of json - except the 1st line
  q1<-fromJSON(lines[[i]])
  ID<-q1$id
  org<-q1$organization$name
  collection<-q1$collection
  freq<-q1$frequency
  jurisdiction<-q1$jurisdiction
  date_created<-q1$metadata_created
  date_last_mod<-q1$metadata_modified
  type<-q1$type
  q1data<- q1data %>% add_row(ID,org,collection,freq,jurisdiction,date_created,date_last_mod,type)
}


fy202021<-q1data %>% filter(date_created >="2020-04-01") %>% filter(date_created<="2021-03-31")

non_sp<-fy202021 %>% filter(type=="dataset")%>% filter(collection!="fgp") %>% filter(collection!="geogratis")   #%>% filter(jurisdiction=="federal")

fed_202021<- non_sp %>% filter(jurisdiction=="federal")

write.csv(non_sp, "FY2020-21-2.csv")
