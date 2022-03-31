library(readr)
ncaaData <- read_csv("Data/ncaaData.csv")
#Installed all the required and optional packages
library(tidyverse)
library(psych)
ncaaData[,1:3] <- lapply(ncaaData[,1:3], factor)
#Categorical variables made into factors
attach(ncaaData)
ncaaData <- na.omit(ncaaData)

describe(Revenue)
describe(Sacount)
describe(MaleSACount, quant = c(.25, .75))
ncaaData$Conference <- factor(ncaaData$Conference)
describeBy(x = ncaaData, group = ncaaData$Conference)
summary(ncaaData)
#I like the summary command better
#because groups of data are organized by
#variable name, making it easier to read than describeBy
#Also summary gives info about all the variables,
#wheras describe gives info about only one of the variables.

cov(SABMgradRate, SAWMgradRate)
scaledSABMgradRate <- scale(SABMgradRate)
scaledSAWMgradRate <- scale(SAWMgradRate)
standardizedData <- data.frame(scaledSABMgradRate, scaledSAWMgradRate)
cov(scaledSABMgradRate, scaledSAWMgradRate)
cor(SABMgradRate, SAWMgradRate)
#The correlation between the two unscaled variables
#is the same value as the covariance between the two
#scaled variables. #This is because the formula for
#correlation standardizes the variables itself.

ggplot(data = ncaaData, aes(x = SABMgradRate, y = SAWMgradRate)) + 
  geom_point(color = "green")
ggplot(data = standardizedData, aes(x = scaledSABMgradRate, y = scaledSAWMgradRate)) + 
  geom_point(color = "purple")
ggplot(data = ncaaData, aes(x = SABMgradRate, y = SAWMgradRate)) +  
  geom_point(aes(color = Conference, shape = Conference)) + 
  geom_smooth(method = "lm", aes(color = Conference))
#For both the Non-power 5 and Power 5 conferences, there is a positive correlation 
#between SABMgradRate and SAWMgradRate. However, the positive correlation between these variables 
#is stronger for the Non-power 5 conference than for the Power 5 conference. 
#I deduced this since the slope of the line of best fit for the non-Power 5 conference 
#is closer to 1 than the slope of the line of best fit for the Power 5 conference.

noOutliersNCAAData <- subset(x = ncaaData, subset = (SABMgradRate < mean(SABMgradRate) + 2*sd(SABMgradRate)) 
& (SABMgradRate > (mean(SABMgradRate) - 2*sd(SABMgradRate))) & (SAWMgradRate < mean(SAWMgradRate) + 2*sd(SAWMgradRate)) 
& (SAWMgradRate > (mean(SAWMgradRate) - 2*sd(SAWMgradRate))))

ggplot(data = noOutliersNCAAData, aes(x = SABMgradRate, y = SAWMgradRate)) +  
  geom_point(aes(color = Conference, shape = Conference)) +
  geom_smooth(method = "lm", aes(color = Conference))
#Yes, the trends are slightly different now that the outliers have been removed. 
#The slope of the linear model for Non-Power 5 Conference became steeper,
#and the slope of the linear model for the Power 5 Conference became less steep.
#Also, the y intercepts of both linear models shifted.
#Still, both linear models show a positive correlation for SABMgradRate and SAWMgradRate.

