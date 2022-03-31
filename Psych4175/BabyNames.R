library(tidyverse)
setwd('/Users/CameronKalik/Library/CloudStorage/Box-Box/Psych4175/Data')
midus <- read_csv("midus.csv")
midus <- na.omit(midus)
midus %>%
  group_by(sex, age) %>% 
  summarise(total = sum(BMI))
getwd()
