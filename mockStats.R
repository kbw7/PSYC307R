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
#analyze persistence and adult social model ONLY - t-test one-way ANOVA
tTest <- t.test(time~effort, var.equal = TRUE, data = df)
anova <- aov(time ~ effort, data = df)

#analyze persistence and emotion regulation ONLY - Pearson correlation
pearCor <- cor(df$time, df$AER, method = 'pearson')

#analyze persistence with both adult social models and emotion regulation, we would run a multiple regression
multReg <- lm(time~effort * AER, data = df)
summary(multReg)

#graphing our data (simple version)
plot(df$AER, df$time, col = df$effort)
