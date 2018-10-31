#maga_analysis
maga.RDS <- readRDS("maga.RDS")

library(igraph) # probably should make own script, really.
library(tidyverse)
library(tidytext)
library(rtweet)

maga_df <- maga.RDS[[1]]

ccot_df <- maga.RDS[[2]]

QAnon <- maga.RDS[[3]]

ccot_2 <- maga.RDS[[4]]

#hashtag analysis

unnested_hashtags <- unnest(maga_df, hashtags)

tweets <- maga_df %>% select(text)

unique_hashtags <- unique(unnested_hashtags$hashtags)
number_hashtags <- length(unique_hashtags)

total_na <- sum(is.na(unnested_hashtags$hashtags))

total_maga_in_text <- unnested_hashtags %>%
  filter(is.na(hashtags)) %>%
  select(text) %>%
  str_count("[maga\\i]")

tweet_by_user <- unnested_hashtags %>%
  filter(is_retweet == FALSE | is_quote == FALSE) %>%
  filter(!is.na(hashtags)) %>%
  group_by(screen_name) %>%
  summarise(number_of_tweets = n()) %>%
  arrange(desc(number_of_tweets))


user_hash <- unnested_hashtags %>%
  filter(is_retweet == FALSE | is_quote == FALSE) %>%
  filter(!is.na(hashtags)) %>%
  group_by(screen_name, hashtags) %>%
  summarise(name_and_hash = n()) %>%
  arrange(desc(name_and_hash))

tweet_hash <- unnested_hashtags %>%
  filter(is_retweet == FALSE | is_quote == FALSE) %>%
  filter(!is.na(hashtags)) %>%
  group_by(status_id, hashtags) %>%
  summarise(tweet_hash = n()) %>%
  arrange(desc(tweet_hash))

unnested_hashtags %>% select(hashtags) %>% unique()

unnested_hashtags_filtered <- unnested_hashtags %>%
  filter(is_retweet == FALSE | is_quote == FALSE) %>%
  filter(!is.na(hashtags)) %>%
  group_by(status_id, hashtags)

prop_tweets_user_hash <- tweet_by_user_hash %>%
  left_join(tweet_by_user, by = "screen_name") %>%
  mutate(prop = name_and_hash/number_of_tweets)

prop_tweets_user_hash  %>% 
  filter(prop >= .5 & number_of_tweets >= 20) %>%
  ggplot(aes(x = hashtags, y = number_of_tweets, fill = screen_name)) + 
  geom_bar(stat = "identity")

(eda_hash <- unnested_hashtags %>%
    filter(is_retweet == FALSE | is_quote == FALSE) %>%
    filter(!is.na(hashtags))%>%
    select(text, user_id, screen_name, status_id, hashtags, location, place_name) %>%
    group_by(hashtags, screen_name) %>% 
    summarise(count = n(),
              prop = count/length(unique_hashtags)) %>%
    ungroup() %>%
    arrange(desc(count)))


# Text analsysi
unnested_tweets <- unnested_hashtags %>%
  unnest_tokens(output = text_tokens, 
                input = text, token = "tweets")
nrow(unnested_tweets)

#Remember, this isn't number of tweets, but numbrer of tokens per tweet
eda_tweets <- unnested_tweets %>% 
  filter(is_retweet == FALSE) %>%
  group_by(user_id, status_id) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

token_hashtags <- unnested_hashtags %>% 
  filter(is_retweet == FALSE) %>%
  unnest_tokens(output = tokens, input = hashtags) %>%
  select(status_id, screen_name, tokens, created_at) %>%
  group_by(status_id, screen_name, tokens, created_at) %>%
  summarize(n = n()) %>%
  arrange(desc(n))

hash_plot <- token_hashtags %>% 
  filter(n > 500) %>%
  ggplot(aes(x = tokens, y = n, fill = screen_name)) + 
  geom_bar(stat = "identity") +
  coord_flip()


#in depth
lucy <- lookup_users("837155895104651265")
