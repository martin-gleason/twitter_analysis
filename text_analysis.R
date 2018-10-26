#text analysis
library(tidyverse)
library(tidytext)

#pul saved tweets
tweets_10_26_2018 <- readRDS("tweet_data_10_26_18.RData")
maga_bomber <- readRDS("maga_bomber_list")

# create data frames. should be a function
# Data loading function should -- 
# Take data source, create data frames from list. 
blue_lives_hash <- tweets_10_26_2018[[1]]
back_blue <- tweets_10_26_2018[[2]]
maga <- tweets_10_26_2018[[3]]


#
length(tweets_10_26_2018)

#function to get screen names from tables

maga_names <- maga$screenName
blue_lives_names <- blue_lives_hash$screenName
back_blue_names <- back_blue$screenName

unique_blue_lives_names <- unique(blue_lives_names)


length(maga_unique)/length(maga$text)

length(unique(maga_names))

length(maga_names)

####
maga_unique <- unique(maga$text)

#regex
hash_tag <- "[#\\S+]"

maga$text %>% str_extract(hash_tag)
maga[2, ]
