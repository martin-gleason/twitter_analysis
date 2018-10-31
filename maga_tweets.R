#maga_analysis
maga.RDS <- readRDS("maga.RDS")

library(tidyverse)
library(tidytext)

maga_df <- maga.RDS[[1]]
nrow(maga_df)

maga_df_unnested <- maga_df %>% unnest(hashtags)
nrow(maga_df_unnested)

hashtags <- maga_df$hashtags

unique_hashtags <- hashtags %>%
  unlist() %>% unique()

length(unique_hashtags)
length(hashtags %>% unlist())


#group_by means count instances of (x, y, ..) in a vector/data set.
#how many times is this hashtag in this tweet
maga_df_unnested %>% 
  filter(is_retweet == FALSE | is_quote == FALSE) %>%
  select(user_id, status_id, hashtags, screen_name, created_at) %>%
  filter(!is.na(hashtags)) %>%
  group_by(screen_name, user_id, status_id, hashtags) %>%
  summarise(count = n()) %>%
  arrange(screen_name)

maga_df %>% 
  filter(status_id == "1056170715936944129") %>%
  select(text,hashtags) %>%
  unlist()

maga_df_flatten$hashtags %>% 
  str_count("Maga") %>% 
  sum(na.rm = TRUE)
