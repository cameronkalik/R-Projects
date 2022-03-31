#Review & Random Lecture
library(readr)
library(psych)
library(dpylr)
library(ggplot2)
setwd("/Users/CameronKalik/Library/CloudStorage/Box-Box/Psych4175/Data")
midus <- read_csv("midus.csv")
attach(midus)
lapply(midus, class)
ID <- factor(ID)
sex <- factor(sex)
heart_self <- factor(heart_self)
heart_father <- factor(heart_father)
#it says objects are masked from global enviornment/midus --> we cant see it?

mean_self_esteem <- mean(self_esteem, na.rm = T)
mean_self_esteem #37.665
midus_high_self_esteem <- subset(x = midus, subset = self_esteem > mean_self_esteem)
head(midus_high_self_esteem)

midus <- na.omit(midus)
midus

dim(midus)
nrow(midus)
ncol(midus)

write.csv(x = midus_high_self_esteem, file = "modifiedMidus.csv", row.names = FALSE)

setwd("/Users/CameronKalik/Library/CloudStorage/Box-Box/Psych4175/Data")
write.csv(x = midus_high_self_esteem, file = "modifiedMidus.csv", row.names = FALSE)

#Plotting with ggplot2 lecture
library(ggplot2)
ggplot(data = midus, aes(x = self_esteem, y = life_satisfaction)) + geom_point(aes(color = sex), size = 3)

#DpylR Lecture

