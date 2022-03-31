#Setup
library(readr)
library(ggplot2)
library(tidyverse)
superheroData <- read_csv("Data/superheroData.csv")
superheroData <- na.omit(superheroData)
lapply(superheroData[2:6], factor)

#1st plot:data wrangling
threeRace <- superheroData %>%
  group_by(race) %>%
  summarize(meanStrength = mean(strength)) %>%
  filter(race == "Human" | race == "Alien" | race == "Mutant")
threeRace

#1st plot: plotting
ggplot(data = threeRace, aes(y = meanStrength, x = race)) +
  geom_col(aes(fill = race)) +
  scale_fill_brewer(palette = "Accent") +
  labs(x = "Race", y = "Average Strength", fill = "Race", title = "Superhero Strength Across Races") +
 theme_classic() 
  
#2nd plot
ggplot(data = superheroData, aes(x = gender, y = intelligence)) +
  geom_violin(aes(fill = gender)) +
  scale_fill_manual(values = c("#FF0000", "#0000FF")) +
  labs(title = "Superhero Male vs. Female Intelligence", x = "Gender", y = "Intelligence", fill = "Gender") +
  theme_bw()

#3rd plot
ggplot(data = superheroData, aes(x = height, y = weight)) +
  geom_point(color = "green") +
  labs(title = "Relationship between Superhero Height and Weight", x = "Height", y = "Weight") +
  theme_gray()

#My favorite is my first plot that compares
#strength across 3 different races. I
#like this one the best because I think
#the comparison shown is pretty
#insightful and the theme and color scheme
#look nice

#1st plot, adding Gender: data wrangling
threeRaceGender <- superheroData %>%
  group_by(race) %>%
  summarize(meanStrength = mean(strength), gender = gender) %>%
  filter(race == "Human" | race == "Alien" | race == "Mutant")
threeRaceGender

#1st plot, adding Gender: plotting
ggplot(data = threeRaceGender, aes(y = meanStrength, x = race)) +
  geom_col(aes(fill = gender)) +
  scale_fill_brewer(palette = "Accent") +
  labs(x = "Race", y = "Male & Female Combined Average Strength", fill = "Gender", title = "Superhero Strength Across Superhero Races & Genders") +
  theme_classic() 

#Adding the gender variable overall detracted from the plot.
#The color distinction between the three races disappeared and
#was replaced by a color distinction between genders, which
#unemphasizes the contrast between the three races. Also, stacked
#bar graphs can sometimes be hard to read. For instance, it may
#be somewhat difficult to determine the mean strength of females across the three races.
#Finally interpreting the average combined strength (male average + female average strength)
#is a bit more difficult than just the general average.

#Plot with 3 geoms: Data wrangling
marvelDC <- superheroData %>%
  group_by(publisher, gender) %>%
  summarize(fightScore = mean(total), 
            lowBar = mean(total) - sd(total),
            upperBar = mean(total) + sd(total)) %>%
  filter(publisher == "Marvel Comics" | publisher == "DC Comics")
marvelDC

#Plot with 3 geoms: Plot
ggplot(data = marvelDC, aes(x = publisher, y = fightScore, group = gender)) +
  geom_point(aes(color = gender,shape = gender), size = 8) +
  geom_errorbar(aes(ymin = lowBar, ymax = upperBar, color = gender),
                width = .2) +
  geom_line(aes(color = gender)) +
  theme_classic() +
  labs(x = "Publisher", y = "Average Superhero Fighting Ability", 
       color = "Gender", shape = "Gender", title = "Marvel vs. DC Superhero Fighting Prowress")

#I think the geom_line layer is useful to add, as it is clearer to see the trend that the average
#superhero fighting ability is lower for superheros in the Marvel comics than the DC comics.
#I don't think the geom_error layer is particularly useful for this plot, since the variances of
#average superhero fighting ability are approximately equal across comic book categories and genders.
#Thus the error bars are not providing that much information. Moreover, the error bars tend
#to clutter the graph a bit, and make the overall trend less clear.
