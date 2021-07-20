library(tictoc)
library(jsonlite)
library(HelpersMG)
library(R.utils)


wget("https://open.canada.ca/static/od-do-canada.jsonl.gz")

R.utils::gunzip("od-do-canada.jsonl.gz", remove=T)

catalog<-readLines("od-do-canada.jsonl") 
catalog<-lapply(catalog,unlist)

list_of_res<-data.frame("owner","package_id","dataset_name","resource_count")
names(list_of_res)<-c("owner","package_id","dataset_name","resource_count")

tmp_data<-fromJSON(catalog[[i]])

len_cat<-length(catalog)

tic()
for(i in 1:len_cat){ 
  
  tmp_data<-fromJSON(catalog[[i]])
  list_of_res<-rbind(list_of_res, c(tmp_data$organization$name,tmp_data$id,tmp_data$title,tmp_data$num_resources))
}
toc()


clean_list_res<-list_of_res[ !list_of_res$resource_count %in% c("resource_count"), ]


clean_list_res$resource_count<-as.numeric(clean_list_res$resource_count)

mean(clean_list_res$resource_count)

max(clean_list_res$resource_count)

clean_list_res<-clean_list_res %>% arrange(desc(resource_count))
