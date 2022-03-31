library(readr)
nhanes_small_assignment3 <- read_csv("Data/nhanes_small_assignment3.csv")
nhanes_small_assignment3
library(tidyverse)
#Test notebook worked

#Data/Plotting setup
nhanes_small_assignment3 <- na.omit(nhanes_small_assignment3)
library(ggplot2)
lapply(nhanes_small_assignment3, class)
nhanes_small_assignment3$Gender <- factor(nhanes_small_assignment3$Gender)
nhanes_small_assignment3$Smoke100n <- factor(nhanes_small_assignment3$Smoke100n)

#Making data frame for bar graph
sub_nhanes <- nhanes_small_assignment3 %>%
  group_by(Gender, Smoke100n) %>%
  summarize(meanWeight = mean(Weight), lowBar = mean(Weight) - sd(Weight), highBar = mean(Weight) + sd(Weight))

#Bar graph
ggplot(data = sub_nhanes, aes(x = Gender, y = meanWeight, fill = Smoke100n)) +
 geom_col(position = position_dodge(width=.9)) + 
  geom_errorbar(aes(ymin = lowBar, ymax = highBar),
                position = position_dodge(width=.9),
                width = .2)

#The data is currently in long format since each row is a
#single observation but not necessarily a unique participant.

#Make data frame wide and print
nhanes_wide <- nhanes_small_assignment3 %>%
  pivot_wider(names_from = TimePoint, values_from = c(Age, Weight, Poverty)) 
print(nhanes_wide[1:15,4:15])

#The data frame was widened based on the TimePoint variable. I combined the different
#TimePoints with the 3 different continuous variables to form separate columns
#where each continuous variable was associated with one TimePoint.
#The result was that each row contained a unique participant.

#Data Wrangling Part 2
modified_nhanes <- nhanes_small_assignment3 %>%
  filter(Gender == "male") %>%
  select(-TimePoint) %>%
  unite(col = "Weight & Age", Weight, Age, sep = " & ")
