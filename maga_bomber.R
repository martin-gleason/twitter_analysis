library(twitteR)
maga_bomber1 <- getUser("@hardrockintlent")

maga_bomber_tweets1 <- userTimeline(maga_bomber1, n = 3200)

maga_bomber2 <- getUser("@hardrock2016")

mega_bomber_tweets2 <- userTimeline(maga_bomber2, n = 3200)

maga_bomb1_friends <- maga_bomber1$getFriendIDs()

maga_bomber2_friends <- maga_bomber2$getFriendIDs()

maga_bomber_hash <- searchTwitter("#magabomber", n = 30000) %>% twListToDF()

previous_search <- min(maga_bomber_hash$created)

(oldest_ID <- min(maga_bomber_hash$id))


maga_bomber_hash_older <- searchTwitter("#magabomber", n = 30000, maxID = oldest_ID) %>% twListToDF()

maga_bomber_list <- list(maga_bomber_tweets1, mega_bomber_tweets2,
                         maga_bomb1_friends, maga_bomber2_friends, 
                         maga_bomber_hash)


saveRDS(maga_bomber_list, "maga_bomber_list")
