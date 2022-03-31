superheroData <- read.csv("~/Library/CloudStorage/Box-Box/Psych4175/Data/superheroData (1).csv")
head(superheroData)
#This dataset contains information on different fictional superheros. 
#Some variables that are included are the superhero's name, their height and weight.
class(superheroData$name)
class(superheroData$publisher)
class(superheroData$gender)
class(superheroData$race)
class(superheroData$eyeColor)
#lapply(superheroData[,1:5], class) --> more efficient way to find classes of first 5 columns
class(superheroData)

#The first five columns of my dataset returned
#the class "character." This makes sense because
#all of these features are described using words.
#The class of the dataset returned data frame, which also makes sense.

superheroData$gender <- factor(superheroData$gender)
class(superheroData$gender)

mean(superheroData$height, na.rm = T)
sd(superheroData$height, na.rm = T)
range(superheroData$height, na.rm = T)
mean(superheroData$weight, na.rm = T)
sd(superheroData$weight, na.rm = T)
range(superheroData$weight, na.rm = T)
table(superheroData$gender)

maleSuperhero <- superheroData[superheroData$gender == "Male",]
maleSuperhero$gender <- factor(maleSuperhero$gender)
femaleSuperhero <- superheroData[superheroData$gender == "Female",]
femaleSuperhero$gender <- factor(femaleSuperhero$gender)

mean(maleSuperhero$height, na.rm = T)
sd(maleSuperhero$height, na.rm = T)
range(maleSuperhero$height, na.rm = T)
mean(maleSuperhero$weight, na.rm = T)
sd(maleSuperhero$weight, na.rm = T)
range(maleSuperhero$weight, na.rm = T)

mean(femaleSuperhero$height, na.rm = T)
sd(femaleSuperhero$height, na.rm = T)
range(femaleSuperhero$height, na.rm = T)
mean(femaleSuperhero$weight, na.rm = T)
sd(femaleSuperhero$weight, na.rm = T)
range(femaleSuperhero$weight, na.rm = T)

#The male Superhero dataset has a higher average and higher standard deviation
#of height and weight than the female Superhero dataset. This means that these values
#are highest in the male dataset, second highest in the combined Superhero dataset, and lowest in the female dataset

#attach(superheroData) #supposed to attach dataset to save time, but did not work