#maga_analysis
maga.RDS <- readRDS("maga.RDS")

library(igraph)
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
  select(text) %>%
  str_count("maga")

(eda_hash <- unnested_hashtags %>%
    filter(is_retweet == FALSE | is_quote == FALSE) %>%
    select(text, user_id, screen_name, status_id, hashtags, location, place_name) %>%
    group_by(hashtags) %>% 
    summarise(count = n(),
              prop = count/length(unique_hashtags)) %>%
    arrange(desc(count)))

unnested_tweets %>% select(text)
nrow(unnested_hashtags)



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

token_hashtags %>% 
  ggplot(aes(x = tokens, y = n, fill = screen_name)) + 
  geom_bar(stat = "identity", position =) +
  coord_flip()


#in depth
lucy <- lookup_users("837155895104651265")
