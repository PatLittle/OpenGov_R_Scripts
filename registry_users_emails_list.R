# This script will take the list of registry users and extract the email addresses,
# then convert it into a semi-comma seperated list, suitable to copy and paste into
# OUTLOOK

# Before you can run the script you need to generate the json blog of user data.You do this 
# in ckan by running action user_list. The simplest way to do that is while logged into the
# registry paste the URL 'https://registry.open.canada.ca/api/action/user_list' into a new tab
# then save the output as user_list.json



library(jsonlite)
user_list<-fromJSON("user_list.json")
emails<-as.data.frame(user_list$result$email)
emails_blob<-paste(as.character(emails[,1]),"; ")
write(emails_blob,"emails.txt")

