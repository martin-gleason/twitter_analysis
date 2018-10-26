#access twitter
library(tidyverse)
library(rtweet)
library(httpuv)

source("keys_and_tokens.R")
token <- create_token("sentiment_and_network_analysis",
                      consumer_key = consumer_api, 
                      consumer_secret = secret_api_key,
                      access_token = access_token, 
                      access_secret = Access_token_secret)

#user IDs for intital twitter accounts
cpd <- "chicago_police"
fbi <- "fbi"
cpd_memorial <- "cpdmemorial"
police_one <- "policeone"
chicago_finest <- "chicagosFines19"
#
cpd_profile <- lookup_users("chicago_police")
fbi_profile <- lookup_users("fbi")
cpd_memorial_profile <- lookup_users("cpdmemorial")
police_one_profile <- lookup_users("policeone")
chicagos_finest_profile <- lookup_users("chicagosFines19")
blue_lives_profile <- lookup_users("bluelivesmtr")

#number string can be used to find users. its the twitter id.
milwaukee_pd <- lookup_users("16806352")


#Vectors of userIDs from Friends and folowers
cpd_friends <- get_friends(cpd)
cpd_friends_profiles <- lookup_users(cpd_friends$user_id)

cpd_followers <- get_followers(cpd, retryonratelimit = TRUE)
cpd_followers_profiles <- lookup_users(cpd_followers$user_id)

#Hash tag search. Beware the sewer
tweets_blue_lives <- search_tweets("#bluelivesmatter", n = 18000)
back_blue <- search_tweets("#BackTheBlue", n = 18000)
maga <- search_tweets("#maga", n = 18000)

blue_lives_hash <- tweets_blue_lives$hashtags #rtweet pulls hashtags out easily
blue_lives_hash_flat <- blue_lives_hash %>% unlist() %>% unique()

#plotting blue lives matter
unlist(tweets_blue_lives$hashtags)


#Pulling text of maga tweets


#just getting screen names


#turns list into DF./ Just easier for me to read.

#get friendships
friendships(c(blue_lives))

#favorited



#this is where i will cache/save work so i don't have to call twitter all the time
tweets_from_10_26_18_7am <- list(tweets_blue_lives, back_blue, maga)
saveRDS(tweets_from_10_26_18_7am, "rtweet_data_10_26_18.RDS")
