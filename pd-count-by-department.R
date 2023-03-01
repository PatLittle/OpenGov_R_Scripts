##########################################################################################
#simple way to calculate number of PD records by department on the Open Government Portal#
##########################################################################################


install.packages("HelpersMG")

options(timeout = max(300, getOption("timeout")))

library(HelpersMG)

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

URLS1<-c(URL_ati,URL_ati_nil,URL_contracts,URL_contracts_nil,
         URL_contracts_agg,URL_reclass,
         URL_reclass_nil,URL_travela,URL_travel_nil,
         URL_hosp,URL_hosp_nil,URL_wrongdoing)
URLS2<-c(URL_grants_nil,URL_dac,URL_bn,URL_qp)
#URLS3<-c(URL_grants)

wget(URLS1,quote="")
wget(URLS2,quote="")
#wget(URLS3,quote="")
wget(URL_travelq,quote="") #isolating travelq since it was giving an error


ati<-read.csv("ati-all.csv")
ati_nil<-read.csv("ati-nil.csv")
contracts<-read.csv("contracts.csv")
contracts_nil<-read.csv("contracts-nil.csv")
contracts_agg<-read.csv("contractsa.csv")
grants<-read.csv(URL_grants)
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



atiSum<-as.data.frame(table(as.character(ati$owner_org)))
ati_nilSum<-as.data.frame(table(as.character(ati_nil$owner_org)))
contractsSum<-as.data.frame(table(as.character(contracts$owner_org)))
contracts_nilSum<-as.data.frame(table(as.character(contracts_nil$owner_org)))
contracts_aggSum<-as.data.frame(table(as.character(contracts_agg$owner_org)))
grantsSum<-as.data.frame(table(as.character(grants$owner_org)))
grants_nilSum<-as.data.frame(table(as.character(grants_nil$owner_org)))
reclassSum<-as.data.frame(table(as.character(reclass$owner_org)))
reclass_nilSum<-as.data.frame(table(as.character(reclass_nil$owner_org)))
travelaSum<-as.data.frame(table(as.character(travela$owner_org)))
travelqSum<-as.data.frame(table(as.character(travelq$owner_org)))
travel_nilSum<-as.data.frame(table(as.character(travel_nil$owner_org)))
hospitalitySum<-as.data.frame(table(as.character(hospitality$owner_org)))
hospitality_nilSum<-as.data.frame(table(as.character(hospitality_nil$owner_org)))
dacSum<-as.data.frame(table(as.character(dac$owner_org)))
bnSum<-as.data.frame(table(as.character(bn$owner_org)))
qpnotesSum<-as.data.frame(table(as.character(qpnotes$owner_org)))
wrongdoingSum<-as.data.frame(table(as.character(wrongdoing$owner_org)))





orgs<-c(as.character(ati$owner_org),as.character(ati_nil$owner_org),as.character(contracts$owner_org),as.character(contracts_agg$owner_org),
as.character(grants$owner_org), as.character(grants_nil$owner_org), as.character(reclass$owner_org), as.character(travela$owner_org),
as.character(travelq$owner_org), as.character(travel_nil$owner_org), as.character(hospitality$owner_org), as.character(hospitality_nil$owner_org),
as.character(dac$owner_org), as.character(bn$owner_org), as.character(qpnotes$owner_org), as.character(wrongdoing$owner_org))

orgs<-as.data.frame(unique(orgs))
orgs$Var1<-orgs$`unique(orgs)`
orgs$`unique(orgs)`<-NULL

fullatiSum<-merge(orgs,atiSum, by="Var1", all=T)
fullati_nilSum<-merge(orgs,ati_nilSum, by="Var1", all=T)
fullcontractsSum<-merge(orgs,contractsSum, by="Var1", all=T)
fullcontracts_nilSum<-merge(orgs,contracts_nilSum, by="Var1", all=T)
fullcontracts_aggSum<-merge(orgs,contracts_aggSum, by="Var1", all=T)
fullgrantsSum<-merge(orgs,grantsSum, by="Var1", all=T)
fullgrants_nilSum<-merge(orgs,grants_nilSum, by="Var1", all=T)
fullreclassSum<-merge(orgs,reclassSum, by="Var1", all=T)
fullreclass_nilSum<-merge(orgs,reclass_nilSum, by="Var1", all=T)
fulltravelaSum<-merge(orgs,travelaSum, by="Var1", all=T)
fulltravelqSum<-merge(orgs,travelqSum, by="Var1", all=T)
fulltravel_nilSum<-merge(orgs,travel_nilSum, by="Var1", all=T)
fullhospitalitySum<-merge(orgs,hospitalitySum, by="Var1", all=T)
fullhospitality_nilSum<-merge(orgs,hospitality_nilSum, by="Var1", all=T)
fulldacSum<-merge(orgs,dacSum, by="Var1", all=T)
fullbnSum<-merge(orgs,bnSum, by="Var1", all=T)
fullqpnotesSum<-merge(orgs,qpnotesSum, by="Var1", all=T)
fullwrongdoingSum<-merge(orgs,wrongdoingSum, by="Var1", all=T)

report<-cbind.data.frame(fullatiSum,fullati_nilSum$Freq,fullcontractsSum$Freq,fullcontracts_nilSum$Freq,fullcontracts_aggSum$Freq,
                         fullgrantsSum$Freq,fullgrants_nilSum$Freq,fullreclassSum$Freq,fullreclass_nilSum$Freq,fulltravelaSum$Freq,fulltravelqSum$Freq,
                         fulltravel_nilSum$Freq,fullhospitalitySum$Freq,fullhospitality_nilSum$Freq,fulldacSum$Freq,fullbnSum$Freq,
                         fullqpnotesSum$Freq,fullwrongdoingSum$Freq)



colnames(report)<-c("owner_org","ati","ati_nil","contracts","contracts_nil","contracts_a","grants","grants_nil","reclass","relass_nil","travel_a","travel_q","travel_nil",
                "hospitiality","hospitiality_nil","dac","bn","qp_notes","wrong_doing")

setwd("/home/runner/work/OpenGov_R_Scripts/OpenGov_R_Scripts")
write.table(report, file="pd-count-by-department.csv",sep=',', na="0", row.names=F, col.names=T)

                          
