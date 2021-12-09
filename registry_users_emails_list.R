# This script will take the list of registry users and extract the email addresses,
# then convert it into a semi-comma seperated list, suitable to copy and paste into
# OUTLOOK

# Before you can run the script you need to generate the json blog of user data.You do this 
# in ckan by running action org_list. The simplest way to do that is while logged into the
# registry paste the URL 'https://registry.open.canada.ca/api/action/org_list' into a new tab
# then save the output as org_list.json



library(jsonlite)
org_list<-fromJSON("organization_list.json")
fullname<-as.data.frame(org_list$result$display_name)
name<-as.data.frame(org_list$result$name)
created_date<-as.data.frame(org_list$result$created)


registry_orgs<-cbind.data.frame(fullname,name,created_date)

write.csv(registry_orgs, file="registry_orgs.csv",row.names = F,fileEncoding = "UTF-8")
