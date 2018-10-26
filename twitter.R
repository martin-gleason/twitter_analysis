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
tweets_blue_lives <- searchTwitter("#bluelivesmatter", n = 20000) %>% twListToDF()
back_blue <- searchTwitter("#BackTheBlue", n = 10000) %>% twListToDF()
maga <- searchTwitter("#maga", n = 10000) %>% twListToDF()



#Pulling text of maga tweets
maga_text <- maga %>% select(text)

#just getting screen names
maga_screen_names <- maga$screenName
nrow(maga_screen_names)



#turns list into DF./ Just easier for me to read.
tweets_Df <- tweets %>% twListToDF()

#Get followers
cpd_followers <- cpd$getFollowerIDs()
blue_lives_followers <- blue_lives$getFollowerIDs()

#get friendships
friendships(c(blue_lives))

#favorited
favorite_cpd <- cpd$getFavorites
favorite_cpd <- favorite_cpd %>% twListToDF()


#this is where i will cache/save work so i don't have to call twitter all the time
tweets_from_10_26_18_7am <- list(tweets_blue_lives, back_blue, maga)
saveRDS(tweets_from_10_26_18_7am, "tweet_data_10_26_18.RData")
