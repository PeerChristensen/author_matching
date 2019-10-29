
library(tidystringdist)
library(tidyverse)

data <- c("Ron L. Hubbard", "L. Ron Hubbard",
          "Ron Hubbard", "L Ron Hubbard", "John L Hubbard","Ernest Hemingway")



data2 <- c("Jussi Adler-Olsen", "Jussi Adler Olsen","Jussi Parikka", "Jonas Langvad Nilsson",
           "Jussi M Hanhimaki","Heikki Jussila","Jussi Adler-Olsen","Jussi Kantola","Jo Nesbø",
           "Jussi Chydenius","Jussi Tavast","Elsebeth Egholm",
           "Jussi Suikkanen","Jussi Rantala","Jussi Niittyviita","Jussi Klemela",
           "Jesper Stein","Waldemar Karwowski","Jussi Laine","Petri Jussila",
           "Jussi Allan Olsen", "Jussi A. Olsen")

df <- tidy_comb(data2, base = "Jussi Adler-Olsen") # set to most frequent name

dist_df <- tidy_stringdist(df) 

dist_df %>% 
  summarise_if(is.numeric, mean)

dist_df %>%
  filter(V1 != V2) %>%
  select_if(is.numeric) %>%
  gather(key,value) %>%
  ggplot(aes(x=key,y=value)) +
  geom_jitter(width=.2) +
  geom_boxplot(alpha=.4) +
  facet_wrap(~key,scales="free")


dist_df %>%
  filter(V1 != V2,jaccard<.4) %>% select(-V1, -hamming)
