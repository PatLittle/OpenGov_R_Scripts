install.packages("R.utils")
install.packages("tictoc")
install.packages("jsonlite")
install.packages("HelpersMG")
install.packages("R.utils")

library(tictoc)
library(jsonlite)
library(HelpersMG)
library(R.utils)


wget("https://open.canada.ca/static/od-do-canada.jsonl.gz")

R.utils::gunzip("od-do-canada.jsonl.gz", remove=T)

catalog<-readLines("od-do-canada.jsonl") 
catalog<-lapply(catalog,unlist)

list_of_res<-data.frame("owner","package_id","dataset_name","resource_id","resource_name")
names(list_of_res)<-c("owner","package_id","dataset_name","resource_id","resource_name")



len_cat<-length(catalog)

tic()
for(i in 1:len_cat){ 
  
  tmp_data<-fromJSON(catalog[[i]])
  tmp_res<-tmp_data$resources
  
  if(length(tmp_res)==0){
    next
    }else
    for(n in 1:nrow(tmp_res)){
      tmp_res_indv<-tmp_res[n,]
      if(tmp_res_indv$datastore_active!=FALSE){
        
        list_of_res<-rbind(list_of_res, c(tmp_data$organization$name,tmp_res_indv$package_id,tmp_data$title,tmp_res_indv$id,tmp_res_indv$name))
      }
      
    }
}
toc()

list_of_res=list_of_res[-c(1),]


setwd("/home/runner/work/OpenGov_R_Scripts/OpenGov_R_Scripts")

write.table(list_of_res,file="list_of_DS_resources.csv",sep=",",row.names = FALSE, col.names = T)


num_dept<-length(unique(list_of_res$owner))
num_datasets<-length(unique(list_of_res$package_id))
num_res<-length(unique(list_of_res$resource_id))
date<-date()

DS_num_tracker<-cbind(date,num_dept,num_datasets,num_res)


write.table(DS_num_tracker,file="DataStore_Numbers_Tracker.csv",append=T,row.names = F,sep=",", col.names = F)
