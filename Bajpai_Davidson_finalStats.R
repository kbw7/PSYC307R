#Mock Statistical Analysis
library(sjmisc)
library(sjPlot)
library(kableExtra)
library(ggplot2)

#import our mock data set
df <- read.csv(file.choose()) #this is the data frame we will be working with

#change effort and sex variable to categorical
df$effort <- as.factor(df$effort)
df$sex <- as.factor(df$sex)

#Descriptive Statistics

#As a whole... in BOTH conditions
#age
summary(df$age)
sd(df$age)
#AER
summary(df$AER)
sd(df$AER)
#time
summary(df$time)
sd(df$time)
#sex
table(df$sex)


#how many participants in both conditions
table(df$effort)
#sex and effort
table(df$effort, df$sex)
#age and effort
table(df$effort, df$age)


#er in high
summary(df$ER[df$effort == "1"])
sd(df$ER[df$effort == "1"])

#er in low
summary(df$ER[df$effort == "0"])
sd(df$ER[df$effort == "0"])

#ln in high
summary(df$LN[df$effort == "1"])
sd(df$LN[df$effort == "1"])

#ln in low
summary(df$LN[df$effort == "0"])
sd(df$LN[df$effort == "0"])

#AER in high
summary(df$AER[df$effort == "1"])
sd(df$AER[df$effort == "1"])

#AER in low
summary(df$AER[df$effort == "0"])
sd(df$AER[df$effort == "0"])

#time in high
summary(df$time[df$effort == "0"])
sd(df$time[df$effort == "0"])

#time in low
summary(df$time[df$effort == "1"])
sd(df$time[df$effort == "1"])

#average age in low and high effort conditions
#low
summary(df$age[df$effort == 0])
sd(df$age[df$effort == 0])

#high
summary(df$age[df$effort == 1])
sd(df$age[df$effort == 1])

#gender differences for Emotion Regulation
summary(df$AER[df$sex == "M"])
summary(df$AER[df$sex == "F"])

summary(df$ER[df$sex == "M"])
summary(df$ER[df$sex == "F"])

summary(df$LN[df$sex == "M"])
summary(df$LN[df$sex == "F"])

#gender differences for Persistence
summary(df$time[df$sex == "M"])
summary(df$time[df$sex == "F"])

#analyze persistence with both adult social models and emotion regulation, we would run a multiple regression
multReg <- glm(time~effort * AER + age, data = df, family = "poisson")
summary(multReg)

#chi-squared test to see if model fit data well
#Source: https://stats.oarc.ucla.edu/r/dae/poisson-regression/#:~:text=Therefore%2C%20if%20the%20residual%20difference,an%20issue%20of%20over%2Ddispersion.
with(multReg, cbind(res.deviance = deviance, df = df.residual,
               p = pchisq(deviance, df.residual, lower.tail=FALSE)))

#confidence intervals of our data
confint(multReg)

#graphing our data (simple version)
plot(df$AER, df$time, col = df$effort)

#SJ plot with regression table - don't end up using the incidence rate ratios, std. error, and CI values
#tab_model(multReg, show.se =TRUE, show.stat = TRUE)

#SJ plot model with visualization
p <- plot_model(multReg, type = "pred", terms = c("AER[1.0, 4.0]", "effort"), 
                axis.title = c("AER", "Time (seconds)"), 
                title = c("Predicted seconds of persistence across measures of AER"),
                legend.title = c("Effort Condition"), alpha= 0.3)

apatheme=theme_bw()+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border=element_blank(),
        axis.line=element_line(), 
        axis.text= element_text(size = 12),
        axis.title.x= element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y= element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)),
        plot.title= element_text(face = "italic", size = 12, margin = margin(t = 0, r = 0, b = 20, l = 0)),
        legend.title=element_text(size = 12))

p + apatheme + scale_color_manual(name= "Effort Condition", values = c("red", "blue"), labels = c("Low", "High"))

#plotting AER scores for individuals, with effort condition noted
aerDf <- data.frame(Participant = c(1:27), AER = df$AER, Effort = df$effort)

aerPlot <-ggplot(aerDf, aes(x = Participant, y = AER, col= Effort)) + 
  ylim(1.0,4.0) +
  scale_x_continuous(breaks= seq(1, 27, by=1)) + 
  theme_classic() +
  geom_point(size=3) +
  theme(axis.text.y = element_text(size = 14)) + 
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14)) +
  labs(color = "Effort Condition") + 
  scale_color_discrete(
    labels = c("0" = "Low", 
               "1" = "High")
  )
aerPlot
