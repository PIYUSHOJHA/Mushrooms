# Data visualization
library(ggplot2)
# the read_csv function
library(readr) 
library(caret)
library(randomForest)
#<- For stratified split
library(caTools)   
library(rpart.plot)
library(rattle)
train01<-read.csv("mushrooms1.csv")
summary(train01)
# Calculate number of class for each variable
z<-cbind.data.frame(Var=names(train01), Total_Class=sapply(train01,function(x){as.numeric(length(levels(x)))}))

print(z)
train01$veil.type<-NULL
set.seed(101) 
sample = sample.split(train01$class, SplitRatio = .7)
x_train = subset(train01, sample == TRUE)
x_test = subset(train01, sample == FALSE)

y_train<-x_train$class
y_test <- x_test$class

x_train$class<-NULL
x_test$class<-NULL
# Create a stratified sample for repeated cv
cv.10.folds<-createMultiFolds(y_train,k=10,times=2)

# create a control object for repeated cv in caret
ctrl.1<-trainControl(method="repeatedcv",number=10,repeats=2,index=cv.10.folds)
rf.1.cv<-train(x=x_train,y=y_train,method="rf",trControl=ctrl.1,tuneLength=3)

plot(varImp(rf.1.cv),main="Random Forest - Variable Importance Plot")

# shows 100% accuracy, lets predict on test set

y_predicted<-predict(rf.1.cv,x_test)

df1<-data.frame(Orig=y_test,Pred=y_predicted)

confusionMatrix(table(df1$Orig,df1$Pred))
