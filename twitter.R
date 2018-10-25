#access twitter
library(tidyverse)
library(twitteR)

source("keys_and_tokens.R")

setup_twitter_oauth(consumer_api, secret_api_key, access_token, Access_token_secret)

#user IDs for intital twitter accounts
cpd <-  getUser("@chicago_police")
fbi <- getUser("@fbi")
cpd_memorial <- getUser("@cpdmemorial")
police_one <- getUser("@policeone")
chicagos_finest <- getUser("@chicagosFines19")
blue_lives <- getUser("@bluelivesmtr")

#number string can be used to find users. its the twitter id.
milwaukee_pd <- getUser("16806352")


#Vectors of userIDs from Friends
cpd_friends <- cpd$getFriendIDs()

#Hash tag search. Beware the sewer
tweets_blue_lives <- searchTwitter("#bluelivesmatter")
back_blue <- searchTwitter("#BackTheBlue")


#turns list into DF./ Just easier for me to read.
tweets_Df <- tweets %>% twListToDF()

#Get followers
cpd_followers <- cpd$getFollowerIDs()
blue_lives_followers <- blue_lives$getFollowerIDs()

#get friendships
friendships(c(blue_lives))
