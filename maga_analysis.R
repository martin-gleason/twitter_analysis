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

unnested_hashtags <- unnest(maga_df, hashtags)

unnested_hashtags <- unnested_hashtags %>%
  unnest_tokens(output = text_tokens, 
                input = text, token = "tweets")

token_hashtags <- unnested_hashtags %>% 
  filter(is_retweet == FALSE) %>%
  unnest_tokens(output = tokens, input = hashtags) %>%
  group_by(user_id, screen_name, tokens) %>%
  summarize(n_tokens_per_id = n()) %>%
  arrange(desc(n_tokens_per_id)) %>%
  filter(n_tokens_per_id > 1728)

token_hashtags %>% 
  ggplot(aes(x = tokens, y = n_tokens_per_id, fill = screen_name)) + 
  geom_bar(stat = "identity", position =) +
  coord_flip()


#in depth
lucy <- lookup_users("837155895104651265")
