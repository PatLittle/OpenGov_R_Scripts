############################################################################
#simple way to calculate number of PD records on the Open Government Portal#
############################################################################

system("sudo apt-get install libjq-dev")



options(timeout = max(300, getOption("timeout")))

install.packages("HelpersMG")
install.packages("jsonlite")
install.packages("jqr", verbose = T)
install.packages("R.utils")
library(HelpersMG)
library(jsonlite)
library(jqr)
library(R.utils)


#Structured Resources Part#

URL_ati<-"https://open.canada.ca/data/dataset/0797e893-751e-4695-8229-a5066e4fe43c/resource/19383ca2-b01a-487d-88f7-e1ffbc7d39c2/download/ati-all.csv"
URL_ati_nil<-"https://open.canada.ca/data/dataset/0797e893-751e-4695-8229-a5066e4fe43c/resource/5a1386a5-ba69-4725-8338-2f26004d7382/download/ati-nil.csv"
URL_contracts<-"https://open.canada.ca/data/dataset/d8f85d91-7dec-4fd1-8055-483b77225d8b/resource/fac950c0-00d5-4ec1-a4d3-9cbebf98a305/download/contracts.csv"
URL_contracts_nil<-"https://open.canada.ca/data/dataset/d8f85d91-7dec-4fd1-8055-483b77225d8b/resource/fa4ff6c4-e9af-4491-9d4e-2b468e415a68/download/contracts-nil.csv"
URL_contracts_agg<-"https://open.canada.ca/data/dataset/d8f85d91-7dec-4fd1-8055-483b77225d8b/resource/2e9a82e2-bb18-4bff-a61e-59af3b429672/download/contractsa.csv"
URL_grants<-"https://open.canada.ca/data/dataset/432527ab-7aac-45b5-81d6-7597107a7013/resource/1d15a62f-5656-49ad-8c88-f40ce689d831/download/grants.csv"
URL_grants_nil<-"https://open.canada.ca/data/dataset/432527ab-7aac-45b5-81d6-7597107a7013/resource/4e4db232-f5e8-43c7-b8b2-439eb7d55475/download/grants-nil.csv"
URL_reclass<-"https://open.canada.ca/data/dataset/f132b8a6-abad-43d6-b6ad-2301e778b1b6/resource/bdaa5515-3782-4e5c-9d44-c25e032addb7/download/reclassification.csv"
URL_reclass_nil<-"https://open.canada.ca/data/dataset/f132b8a6-abad-43d6-b6ad-2301e778b1b6/resource/1e955e4d-df35-4441-bf38-b7086192ece2/download/reclassification-nil.csv"
URL_travela<-"https://open.canada.ca/data/dataset/4ae27978-0931-49ab-9c17-0b119c0ba92f/resource/a811cac0-2a2a-4440-8a81-2994fc753171/download/travela.csv"
URL_travelq<-"https://open.canada.ca/data/dataset/009f9a49-c2d9-4d29-a6d4-1a228da335ce/resource/8282db2a-878f-475c-af10-ad56aa8fa72c/download/travelq.csv"
URL_travel_nil<-"https://open.canada.ca/data/dataset/009f9a49-c2d9-4d29-a6d4-1a228da335ce/resource/d3f883ce-4133-48da-bc76-c6b063d257a2/download/travelq-nil.csv"
URL_hosp<-"https://open.canada.ca/data/dataset/b9f51ef4-4605-4ef2-8231-62a2edda1b54/resource/7b301f1a-2a7a-48bd-9ea9-e0ac4a5313ed/download/hospitalityq.csv"
URL_hosp_nil<-"https://open.canada.ca/data/dataset/b9f51ef4-4605-4ef2-8231-62a2edda1b54/resource/36a3b6cc-4f45-4081-8dbd-2340ca487041/download/hospitalityq-nil.csv"
URL_dac<-"https://open.canada.ca/data/dataset/8634f1c9-597e-416d-91f2-df24d2ffbeea/resource/499383b6-cd2a-466a-9fcf-910d3e427700/download/dac.csv"
URL_bn<-"https://open.canada.ca/data/dataset/ee9bd7e8-90a5-45db-9287-85c8cf3589b6/resource/299a2e26-5103-4a49-ac3a-53db9fcc06c7/download/briefingt.csv"
URL_qp<-"https://open.canada.ca/data/dataset/ecd1a913-47da-47fc-8f96-2432be420986/resource/c55a2862-7ec4-462c-a844-22acab664812/download/qpnotes.csv"
URL_wrongdoing<-"https://open.canada.ca/data/dataset/6e75f19c-d19d-48aa-984e-609c8d9bc403/resource/84a77a58-6bce-4bfb-ad67-bbe452523b14/download/wrongdoing.csv"
URL_adminair<-"https://open.canada.ca/data/dataset/98abeb62-7c76-4dfb-a134-1551f55ede55/resource/1495406e-338c-43ec-9995-ec8d8c90d17e/download/adminaircraft.csv"

URLS1<-c(URL_ati,URL_ati_nil,URL_contracts,URL_contracts_nil,
       URL_contracts_agg,URL_reclass,
       URL_reclass_nil,URL_travela,URL_travel_nil,
       URL_hosp,URL_hosp_nil,URL_wrongdoing)
URLS2<-c(URL_grants,URL_grants_nil,URL_dac,URL_bn,URL_qp, URL_adminair)

wget(URLS1,quote="")
wget(URLS2,quote="")
wget(URL_travelq,quote="") #isolating travelq since it was giving an error
  
ati<-read.csv("ati-all.csv")
ati_nil<-read.csv("ati-nil.csv")
contracts<-read.csv("contracts.csv")
contracts_nil<-read.csv("contracts-nil.csv")
contracts_agg<-read.csv("contractsa.csv")
grants<-read.csv("grants.csv")
grants_nil<-read.csv("grants-nil.csv")
reclass<-read.csv("reclassification.csv")
reclass_nil<-read.csv("reclassification-nil.csv")
travela<-read.csv("travela.csv")
travelq<-read.csv("travelq.csv")
travel_nil<-read.csv("travelq-nil.csv")
hospitality<-read.csv("hospitalityq.csv")
hospitality_nil<-read.csv("hospitalityq-nil.csv")
dac<-read.csv("dac.csv")
bn<-read.csv("briefingt.csv")
qpnotes<-read.csv("qpnotes.csv")
wrongdoing<-read.csv("wrongdoing.csv")
adminair<-read.csv("adminaircraft.csv")

report<-data.frame("")

report$date<-date()
report$ati<-nrow(ati)
report$ati_nil<-nrow(ati_nil)
report$contracts<-nrow(contracts)
report$contracts_nil<-nrow(contracts_nil)
report$contracts_agg<-nrow(contracts_agg)
report$grants<-nrow(grants)
report$grants_nil<-nrow(grants_nil)
report$reclass<-nrow(reclass)
report$reclass_nil<-nrow(reclass_nil)
report$travela<-nrow(travela)
report$travelq<-nrow(travelq)
report$travel_nil<-nrow(travel_nil)
report$hospitality<-nrow(hospitality)
report$hospitality_nil<-nrow(hospitality_nil)
report$dac<-nrow(dac)
report$qpnotes<-nrow(qpnotes)
report$bn<-nrow(bn)
report$wrongdoing<-nrow(wrongdoing)
report$adminair<-nrow(adminair)
report$X..<-NULL
report$sum<-sum(report[2:19])

print(report$sum)
print(head(report))


setwd("/home/runner/work/OpenGov_R_Scripts/OpenGov_R_Scripts")
write.table(report, file="PD-Count.csv",sep=',', append=T, row.names=F, col.names=F)


#non-structured part#

wget("https://open.canada.ca/static/od-do-canada.jsonl.gz")
R.utils::gunzip("od-do-canada.jsonl.gz", remove=T) #taking the metadata catalogue jsonlines and gunzipping
metadata<-readLines("od-do-canada.jsonl") #reading it into R line by line

#metadata<-lapply(metadata,unlist)

transition<-length(jq(metadata,'{collection}') %>% jqr::select(.collection =="transition"))
transition_deputy<-length(jq(metadata,'{collection}') %>% jqr::select(.collection =="transition_deputy"))
parliament_report<-length(jq(metadata,'{collection}') %>% jqr::select(.collection =="parliament_report"))
parliament_committee<-length(jq(metadata,'{collection}') %>% jqr::select(.collection =="parliament_committee"))
parliament_committee_deputy<-length(jq(metadata,'{collection}') %>% jqr::select(.collection =="parliament_committee_deputy"))

non_str_report<-data.frame("")
non_str_report$date<-date()
non_str_report$X..<-NULL
non_str_report$transition<-as.integer(transition)
non_str_report$transition_deputy<-as.integer(transition_deputy)
non_str_report$parliament_report<-as.integer(parliament_report)
non_str_report$parliament_committee<-as.integer(parliament_committee)
non_str_report$parliament_committee_deputy<-as.integer(parliament_committee_deputy)

non_str_report$sum<-sum(non_str_report[2:6])
write.table(non_str_report, file="PD-Count-nonStr.csv",sep=',', append=T, row.names=F, col.names=F)

#structured v non report

sVn_report<-data.frame("")
sVn_report$date<-date()
sVn_report$X..<-NULL
sVn_report$structured<-as.integer(report$sum)
sVn_report$non_structured<-as.integer(non_str_report$sum)
sVn_report$total<-sum(sVn_report[2:3])
write.table(sVn_report, file="sVn-report.csv",sep=',', append=T, row.names=F, col.names=F)

#delete the jsonlines file from the directory so it doesn't throw an error when I regenerate the report next time
if (file.exists("od-do-canada.jsonl")) {
  #Delete file if it exists
  file.remove("od-do-canada.jsonl")
} 
