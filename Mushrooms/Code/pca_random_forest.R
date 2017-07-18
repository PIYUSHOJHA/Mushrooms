combi <- read.csv("pca.csv")
library(party)
library(randomForest)
library(dummies)
library(caTools)
set.seed(88)




split=sample.split(combi$class , SplitRatio=0.8)
train<- subset(combi, split == TRUE)
test<- subset(combi, split==FALSE)
output.forest <- randomForest(class ~ odor+gillsize +sporeprintcolor+gillcolor+stalksurfaceabovering + stalksurfacebelowring+ringtype+population,data = combi)
output.forest
