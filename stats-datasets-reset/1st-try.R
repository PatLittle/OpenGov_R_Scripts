library(jsonlite)

R.utils::gunzip("od-do-canada.jl_2021-03-22.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
R.utils::gunzip("od-do-canada.jl_2021-03-23.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
R.utils::gunzip("od-do-canada.jl_2021-03-24.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
R.utils::gunzip("od-do-canada.jl_2021-03-25.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping
R.utils::gunzip("od-do-canada.jl_2021-03-31.gz", remove=F) #taking the metadata catalogue jsonlines and gunzipping


mar22<-readLines("od-do-canada.jl_2021-03-22") #reading it into R line by line
mar23<-readLines("od-do-canada.jl_2021-03-23") #reading it into R line by line
mar24<-readLines("od-do-canada.jl_2021-03-24") #reading it into R line by line
mar25<-readLines("od-do-canada.jl_2021-03-25") #reading it into R line by line
mar31<-readLines("od-do-canada.jl_2021-03-31") #reading it into R line by line
lines <- lapply(query1,unlist) #converting it from a bunch of list objects to json
num_recs<-length(lines) #getting the number of records currently on the portal



m24_lines<- lapply(mar24,unlist)
m25_lines<- lapply(mar25,unlist)



q1<-fromJSON(m24_lines[[1]])
ID<-q1$id
org<-q1$organization$name
collection<-q1$collection
date_created<-q1$metadata_created
date_last_mod<-q1$metadata_modified
q1data<-data.frame(ID,org,collection,date_created,date_last_mod)
names(q1data)<-c("ID","org","collection","date_created","date_last_mod")
for(i in 2:length(m24_lines)){ #loop over this for each line of json - except the 1st line, append each line to the dataframe
  q1<-fromJSON(lines[[i]])
  ID<-q1$id
  org<-q1$organization$name
  collection<-q1$collection
  date_created<-q1$metadata_created
  date_last_mod<-q1$metadata_modified
  q1data<- q1data %>% add_row(ID,org,collection,date_created,date_last_mod)
}

q2<-fromJSON(m25_lines[[1]])
ID<-q2$id
org<-q2$organization$name
collection<-q2$collection
date_created<-q2$metadata_created
date_last_mod<-q2$metadata_modified
q2data<-data.frame(ID,org,collection,date_created,date_last_mod)
names(q2data)<-c("ID","org","collection","date_created","date_last_mod")
for(i in 2:length(m24_lines)){ #loop over this for each line of json - except the 1st line, append each line to the dataframe
  q2<-fromJSON(m25_lines[[i]])
  ID<-q2$id
  org<-q2$organization$name
  collection<-q2$collection
  date_created<-q2$metadata_created
  date_last_mod<-q2$metadata_modified
  q2data<- q2data %>% add_row(ID,org,collection,date_created,date_last_mod)
}

head(q2data)

delta<-anti_join(q1data, q2data, by = "ID")
head(delta)

delta_stat<-subset(delta, org=="statcan") %>% arrange(desc(date_last_mod))

delta_stat[1:100,]

