library(tictoc)
library(jsonlite)
library(HelpersMG)
library(R.utils)
library(ckanr)
library(dplyr)
library(stringr)
library(googleAnalyticsR)
library(jqr)
library(purrr)
library(tidyr)
#install.packages("splitstackshape")
library(splitstackshape)
library(lubridate)

#download our files into the working directory
wget("https://open.canada.ca/static/od-do-canada.jsonl.gz")

R.utils::gunzip("od-do-canada.jsonl.gz", remove=T) #taking the metadata catalogue jsonlines and gunzipping
query1<-readLines("od-do-canada.jsonl") #reading it into R line by line
qqq<-jq(query1,'{id,title_translated,collection,organization,display_flags}') %>% select(.collection | contains("fgp"))
datas<-stream_in(textConnection(qqq))

viewable<-subset(datas, datas$display_flags=="fgp_viewer") %>% jsonlite::flatten(recursive=T)
viewable$title_translated.en<-coalesce(viewable$title_translated.en,viewable$`title_translated.en-t-fr`)
viewable$title_translated.fr<-coalesce(viewable$title_translated.fr,viewable$`title_translated.fr-t-en`)

#set the ga view ID, start date, end date. 
myid<-68455797

dateend<-rollbackward(Sys.Date(),roll_to_first = F, preserve_hms = F)
datestart<-rollbackward(dateend,roll_to_first = T)
querypage<-paste0("ga:pagePath=@/openmap/,ga:pagePath=@/carteouverte/",sep="")

tic()
web_data <- google_analytics(myid, 
                             date_range = c(datestart, dateend),
                             metrics = "pageviews",
                             dimensions = c("yearmonth","pagepath"),
                             anti_sample = TRUE,
                             filtersExpression = querypage)
toc()

web_data$pagePath<-str_remove_all(web_data$pagePath,"/openmap/")
web_data$pagePath<-str_remove_all(web_data$pagePath,"/carteouverte/")
web_data$pagePath<-sub("\\?.*","",web_data$pagePath)



new_stuff <- cSplit(web_data,"pagePath",",")

page1<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_01) %>% na.omit() 
page2<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_02) %>% na.omit()
page3<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_03) %>% na.omit()
page4<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_04) %>% na.omit()
page5<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_05) %>% na.omit()
page6<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_06) %>% na.omit()
page7<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_07) %>% na.omit()
page8<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_08) %>% na.omit()
page9<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_09) %>% na.omit()
page10<-data.frame(new_stuff$yearmonth,new_stuff$pageviews,new_stuff$pagePath_10) %>% na.omit()
names(page1)<-c("yearmonth","pageviews","id")
names(page2)<-c("yearmonth","pageviews","id")
names(page3)<-c("yearmonth","pageviews","id")
names(page4)<-c("yearmonth","pageviews","id")
names(page5)<-c("yearmonth","pageviews","id")
names(page6)<-c("yearmonth","pageviews","id")
names(page7)<-c("yearmonth","pageviews","id")
names(page8)<-c("yearmonth","pageviews","id")
names(page9)<-c("yearmonth","pageviews","id")
names(page10)<-c("yearmonth","pageviews","id")

pre_sum_data<-data.frame(page1)
names(pre_sum_data)<-c("yearmonth","pageviews","id")
pre_sum_data<-rbind.data.frame(pre_sum_data,page2,page3,page4,page5,page6,page7,page8,page9,page10)

sum_data<-aggregate(pre_sum_data$pageviews,by=list(pre_sum_data$id),FUN=sum)

analytics<-merge(viewable,sum_data,by.x="id",by.y="Group.1")
analytics['Year']=year(dateend)  
analytics['Month']=month(dateend)


report<-data.frame(analytics$Year,analytics$Month,analytics$id,analytics$title_translated.en,analytics$title_translated.fr,analytics$organization.name,
                   analytics$organization.title,analytics$x)

names(report)<-c("year","month","id","title_en","title_fr","owner_org","org_name","pageviews")

down_data<-read.csv("https://open.canada.ca/data/dataset/2916fad5-ebcc-4c86-b0f3-4f619b29f412/resource/15eeafa2-c331-44e7-b37f-d0d54a51d2eb/download/open-maps-analytics-3.csv", fileEncoding = "UTF-8-BOM")

up_data<-rbind.data.frame(report,down_data)%>% unique()



write.csv(up_data,file="open-maps-analytics.csv",append=F,row.names = F, fileEncoding = "UTF-8")

#ckanr_setup(url="https://open.canada.ca/data", key= "189ef2a1-e08e-4ad3-8ce3-0f27f969588e")

#resource_update(id="15eeafa2-c331-44e7-b37f-d0d54a51d2eb",up_data)