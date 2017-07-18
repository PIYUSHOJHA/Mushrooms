# Reading the csv file
data <- read.csv('mushrooms.csv')
str(data)
library(caTools)
set.seed(88)
# spliting the data as train and test
split <- sample.split(train$class, SplitRatio = 0.8)
dresstrain <- subset(train, split == TRUE)
dresstest <- subset(train, split == FALSE)
# Logistic Model
model <- glm (class ~capsurface+capshape+capcolor+bruises+odor+gillattachment+gillspacing+gillsize+gillcolor+stalkshape+stalkroot+stalksurfaceabovering+stalksurfacebelowring+stalkcolorabovering+stalkcolorbelowring+veilcolor+ringnumber+ringtype+sporeprintcolor+population+habitat, data = dresstrain, family = binomial)
summary(model)
predicttrain <- predict(model, type = 'response')
summary(predicttrain)
# Calculating thresold value
tapply(predicttrain,dresstrain$class,mean)
table(dresstrain$class, predicttrain > 0.5)
# Plotting ROC curve
library("ROCR")
ROCRpred=prediction(predicttrain,dresstrain$class)
ROCRpref=performance(ROCRpred,"tpr","fpr")
plot(ROCRpref,colorize="TRUE",print.cutoffs.at=seq(0,1,0.1),text.adj=c(0.2,1.7))
predicttest=predict(model,type="response",newdata=dresstest)