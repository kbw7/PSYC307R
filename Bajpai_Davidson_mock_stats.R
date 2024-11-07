#Mock Statistical Analysis
#install kableExtra for tables with descriptive stats
#table1 package does the APA format looking table with calculations
#sjplot to summarize regression models, tab_model(nameofmodel) is the command, very beautiful table
install.packages(kableExtra)
library(kableExtra)

#import our mock data set
df <- read.csv(file.choose()) #this is the data frame we will be working with

#change effort and gender variable to categorical
df$effort <- as.factor(df$effort)
df$gender <- as.factor(df$gender)

#Descriptive Statistics

#age
summary(df$age)
sd(df$age)
#AER
summary(df$AER)
sd(df$AER)
#time
summary(df$time)
sd(df$time)
#gender
table(df$gender)

#analyze persistence with both adult social models and emotion regulation, we would run a multiple regression
multReg <- lm(time~effort * AER + age, data = df)
summary(multReg)

#graphing our data (simple version)
plot(df$AER, df$time, col = df$effort)

