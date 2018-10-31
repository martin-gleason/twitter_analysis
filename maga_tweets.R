#maga_analysis
maga.RDS <- readRDS("maga.RDS")

library(tidyverse)
library(tidytext)
library(rtweet)

maga_df <- maga.RDS[[1]]