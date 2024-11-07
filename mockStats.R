#Mock Statistical Analysis
#install packages
#install.packages("kableExtra")
library(kableExtra)


#import our mock data set
d <- read.csv(file.choose()) #original dataset
df <- read.csv(file.choose()) #this is the dataframe we will be working with

#change effort and gender variable to categorical
df$effort <- as.factor(df$effort)
df$gender <- as.factor(df$gender)

#Descriptive Statistics
#add here

#analyze persistence with both adult social models and emotion regulation, we would run a multiple regression
multReg <- lm(time~effort~age * AER, data = df)
summary(multReg)

#maybe add age as a predictor var

#graphing our data (simple version)
plot(df$AER, df$time, col = df$effort)
