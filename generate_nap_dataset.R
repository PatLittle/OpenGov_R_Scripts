library(yaml)
library(tidyverse)
library(lubridate)
library(tictoc)

nap_yaml<-read_yaml(file="C:/Users/Pat/Documents/GitHub/PatLittle/ckanext-canada/ckanext/canada/tables/nap5.yaml")

indicators<-nap_yaml$resources[[1]]$fields[[4]]$choices #%>% jsonlite::flatten()
milestones<-nap_yaml$resources[[1]]$fields[[3]]$choices
milestones<-as.data.frame(do.call(cbind,            # Convert nested list to data frame by column
                                  milestones)) %>% transpose() %>% as.data.frame(rownames_to_column("Milestones"))
milestones<-apply(milestones,2,as)

test3<- as.data.frame(do.call(cbind,            # Convert nested list to data frame by column
                         indicators))



test3<-test3 %>% transpose()

test3<-as.data.frame(do.call(cbind,test3[1:5]))
test3$deadline<-NULL
test3<-as_tibble(test3)
test3<-test3 %>% rownames_to_column("Indicator")
test3<- apply(test3,2,as.character)

write.table(test3,file="nap5listofindicators.csv", sep=",",row.names = F, fileEncoding = "UTF-8")
