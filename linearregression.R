setwd("~/Desktop/linearregression/")
dataset = read.csv(file = 'Predicting_Salaries.csv',sep = ",",
                   fileEncoding="utf-16")
library(caTools)
set.seed(123)
split =sample.split(dataset$AnnualSalary, SplitRatio = 0.75)
training_set= subset(dataset, split== TRUE)
testing_set= subset(dataset, split == FALSE)
linearregressor = lm(formula = AnnualSalary ~ YearsOfExperience,data= training_set)
Y_pred = predict(linearregressor,newdata= testing_set)
library(scales)
library(ggplot2)
ggplot() +
  geom_point(aes(x=training_set$YearsOfExperience, y=training_set$AnnualSalary),
             colour = 'red') +
  geom_line (aes( x= training_set$YearsOfExperience, y=predict(linearregressor, newdata= training_set)),
             colour = 'navy') +
  ggtitle ('Annual Salaries of Data Scientists vs Experience in Years (Training Set)') +
  xlab ('Years of Experience') +
  ylab ('Annual Salary') +
  scale_x_continuous(limits = c(0, 12)) + 
  scale_y_continuous(limits = c(0, 150000)) 
library(ggplot2)
ggplot() +
  geom_point(aes(x=testing_set$YearsOfExperience, y=testing_set$AnnualSalary),
             colour = 'red') +
  geom_line (aes( x= training_set$YearsOfExperience, y=predict(linearregressor, newdata= training_set)),
             colour = 'navy') +
  ggtitle ('Annual Salaries of Data Scientists vs Experience in Years (Test Set)') +
  xlab ('Years of Experience') +
  ylab ('Annual Salary')  +
    scale_x_continuous(limits = c(0, 12)) + 
  scale_y_continuous(limits = c(0, 150000))
