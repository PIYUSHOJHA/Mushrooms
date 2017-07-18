combi <- read.csv("mushrooms.csv")
library(party)
library(randomForest)
library(dummies)
library(caTools)
set.seed(88)




split=sample.split(combi$class , SplitRatio=0.8)
train<- subset(combi, split == TRUE)
test<- subset(combi, split==FALSE)
# use of random forest function
output.forest <- randomForest(class ~ odor+gillsize +sporeprintcolor + stalksurfacebelowring+ringtype,data = train)
output.forest
