data<-read.csv("CDA_R.csv")
data <- na.omit(data)
library(tidyverse)  # Provides functions for data manipulation
data
data<- data %>%
  drop_na()  # Removes rows with any missing values
anyNA(data)  # Should return FALSE if no missing values remain
data
str(data)

library(writexl)
write_xlsx(data,"C:/Users/shahd/Desktop/CDA_Project//stata.xlsx")
data$Y_merged
table(data$Y_merged)

data$Q47_factor<- as.factor(data$Q47)
data$Q131_factor<- as.factor(data$Q131)
data$Q287_factor<- as.factor(data$Q287)
data$Q164_factor<- as.factor(data$Q164)
data$Q112_factor<- as.factor(data$Q112)
data$Q260_factor<- as.factor(data$Q260)
data$Y_factor<- as.factor(data$Y)
glm<-glm(Y~ data$Q47_factor + data$Q131_factor + data$Q287_factor + data$Q164_factor + data$Q112_factor +data$Q260_factor+data$Q260_factor*data$Q47_factor ,data = data, family = binomial)
summary(glm)
#check for multicollinearity 
library(car)
# Assuming your_model is your linear regression model
vif_values <- vif(glm)
print(vif_values)
#backward and forwad elimination 
backward_model <- step(glm, direction = "backward",  criterion = "p-value", threshold = 0.15)
summary(backward_model)
#INTERACTION TERM IS REMOVED
vif_bm<-vif(backward_model)
print(vif_bm)

#Analysis of deviance table
anova(backward_model)
anova(backward_model, test = "Chisq")
anova(backward_model, test ="LRT")
#ODDS RATIO 
coef(backward_model)
exp(coef(backward_model))
exp(confint(backward_model))
cbind(coef(backward_model), odds_ratio= exp(coef(backward_model)),exp(confint(backward_model)))
#ACCORDING TO AIC BACKWARD MODEL IS BETTER
#predict probabilities 
data$predprob<-fitted(backward_model)
data$predprob
#ROC curve
library(pROC)
roc <- roc(data$Y,data$predprob)
roc_curve<- plot(roc, main= "ROC Curve", xlab= "1-Specificity", xlim= c(1,0))
axis(1, at = rev(seq(0, 1, by =0.1)), labels = rev(seq(1,0,by =-0.1)))
auc(roc_curve)
cutoff_point <- coords(roc_curve, "best")$threshold
cutoff_point  
 #classification table with cutoff =0.905
predicted_class <- ifelse(data$predprob > 0.9048087, 1, 0)
conf_matrix1 <- table(data$Y, predicted_class)
conf_matrix1
library(caret)
confusionMatrix(data$Y_factor,factor(predicted_class))

chi_square_result <- chisq.test(conf_matrix1)
chi_square_result 

anova(backward_model, test ="Chisq")
anova(backward_model, test ="LRT")/

#Enter method
stepwise_model <- step(glm, direction = "both", scope = formula(glm))
summary(stepwise_model)


#Ordinal logistic model
library(ordinal)
data$response_Q46 <- ordered(data$Q46)
model <- clm(data$response_Q46~ data$Q47_factor + data$Q131_factor + data$Q287_factor + data$Q164_factor + data$Q112_factor +data$Q260_factor+data$Q260_factor*data$Q47_factor, data = data)
summary(model)

# Check proportional odds assumption
nominal_test(model)
 #ASSUMPTION IS VIOLATED

#multinomial
library(nnet)
mn <- multinom(data$Q46~ data$Q47_factor + data$Q131_factor + data$Q287_factor + data$Q164_factor + data$Q112_factor +data$Q260_factor, data = data)
summary(mn)

z<- summary(mn)$coefficients/summary(mn)$standard.errors
p<- (1-pnorm(abs(z),0, 1)) *2
p
rrr <- exp(coef(mn))
rrr
cbind(coef(mn), rrr= exp(coef(mn)),exp(confint(mn)))
