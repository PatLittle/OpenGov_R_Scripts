
library(tidyverse)
library(jsonlite)

#R.utils::gunzip("od-do-canada.jl_2021-03-24.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
#R.utils::gunzip("od-do-canada.jl_2021-03-25.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
#R.utils::gunzip("od-do-canada.jl_2021-03-31.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
R.utils::gunzip("od-do-canada.jl_2021-04-15.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping


mar24<-readLines("od-do-canada.jl_2021-03-24") #reading it into R line by line
mar25<-readLines("od-do-canada.jl_2021-03-25") #reading it into R line by line
mar31<-readLines("od-do-canada.jl_2021-03-31") #reading it into R line by line
apr15<-readLines("od-do-canada.jl_2021-04-15") #reading it into R line by line


m24_lines<- lapply(mar24,unlist)
m25_lines<- lapply(mar25,unlist)
m31_lines<- lapply(mar31,unlist)
a15_lines<- lapply(apr15,unlist)

q1<-fromJSON(m24_lines[[1]])
ID<-q1$id
org<-q1$organization$name
title<-q1$title
collection<-q1$collection
date_created<-q1$metadata_created
date_last_mod<-q1$metadata_modified
q1data<-data.frame(ID,org,title,collection,date_created,date_last_mod)
names(q1data)<-c("ID","org","title","collection","date_created","date_last_mod")
for(i in 2:length(m24_lines)){ #loop over this for each line of json - except the 1st line, append each line to the dataframe
  q1<-fromJSON(m24_lines[[i]])
  ID<-q1$id
  title<-q1$title
  org<-q1$organization$name
  collection<-q1$collection
  date_created<-q1$metadata_created
  date_last_mod<-q1$metadata_modified
  q1data<- q1data %>% add_row(ID,org,title,collection,date_created,date_last_mod)
}

q2<-fromJSON(m25_lines[[1]])
ID<-q2$id
org<-q2$organization$name
title<-q2$title
collection<-q2$collection
date_created<-q2$metadata_created
date_last_mod<-q2$metadata_modified
q2data<-data.frame(ID,org,title,collection,date_created,date_last_mod)
names(q2data)<-c("ID","org","title","collection","date_created","date_last_mod")
for(i in 2:length(m25_lines)){ #loop over this for each line of json - except the 1st line, append each line to the dataframe
  q2<-fromJSON(m25_lines[[i]])
  ID<-q2$id
  org<-q2$organization$name
  title<-q2$title
  collection<-q2$collection
  date_created<-q2$metadata_created
  date_last_mod<-q2$metadata_modified
  q2data<- q2data %>% add_row(ID,org,title,collection,date_created,date_last_mod)
}


q3<-fromJSON(m31_lines[[1]])
ID<-q3$id
org<-q3$organization$name
title<-q3$title
collection<-q3$collection
date_created<-q3$metadata_created
date_last_mod<-q3$metadata_modified
q3data<-data.frame(ID,org,title,collection,date_created,date_last_mod)
names(q3data)<-c("ID","org","title","collection","date_created","date_last_mod")
for(i in 2:length(m31_lines)){ #loop over this for each line of json - except the 1st line, append each line to the dataframe
  q3<-fromJSON(m31_lines[[i]])
  ID<-q3$id
  org<-q3$organization$name
  title<-q3$title
  collection<-q3$collection
  date_created<-q3$metadata_created
  date_last_mod<-q3$metadata_modified
  q3data<- q3data %>% add_row(ID,org,title,collection,date_created,date_last_mod)
}


q4<-fromJSON(a15_lines[[1]])
ID<-q4$id
org<-q4$organization$name
title<-q4$title
collection<-q4$collection
date_created<-q4$metadata_created
date_last_mod<-q4$metadata_modified
q4data<-data.frame(ID,org,title,collection,date_created,date_last_mod)
names(q4data)<-c("ID","org","title","collection","date_created","date_last_mod")
for(i in 2:length(a15_lines)){ #loop over this for each line of json - except the 1st line, append each line to the dataframe
  q4<-fromJSON(a15_lines[[i]])
  ID<-q4$id
  org<-q4$organization$name
  title<-q4$title
  collection<-q4$collection
  date_created<-q4$metadata_created
  date_last_mod<-q4$metadata_modified
  q4data<- q4data %>% add_row(ID,org,title,collection,date_created,date_last_mod)
}


head(q2data)

delta<-anti_join(q1data,q2data, by = "ID")
head(delta)

delta_stat<-subset(delta, org=="statcan") %>% arrange(desc(date_created))

delta_stat

delta_31st<-anti_join(delta_stat,q3data,by="ID")

delta_a15<-anti_join(delta_stat,q4data,by="ID")

stat1extra<-anti_join(delta_a15,delta_31st,by="ID")

write.csv(delta_stat,file="deleted_statcan.csv")



library(jqr)

output_file<-tempfile()
output<-file(output_file,'wt')

for(i in 1:length(m24_lines)){
    line<-fromjson(m24_lines[i])
    if(uuid %in% line{
      writeLines(line, output)
      }
}

