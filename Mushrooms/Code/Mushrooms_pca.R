combi <- read.csv("de.csv")
str(combi)
library(dummies)

library(caTools)
set.seed(88)
# replacing zero to mean of the column
combi$bruises <- ifelse(combi$bruises == 0, mean(combi$bruises),combi$bruises)
combi$gillattachment <- ifelse(combi$gillattachment == 0, mean(combi$gillattachment),combi$gillattachment)
combi$gillspacing <- ifelse(combi$gillspacing == 0, mean(combi$gillspacing),combi$gillspacing)
combi$gillsize <- ifelse(combi$gillsize == 0, mean(combi$gillsize),combi$gillsize)
combi$stalkshape <- ifelse(combi$stalkshape == 0, mean(combi$stalkshape),combi$stalkshape)
#spliting the dataset into train and test
split=sample.split(combi$class , SplitRatio=0.8)
train<- subset(combi, split == TRUE)
test<- subset(combi, split==FALSE)
#removing the dependent variable
new_my_data <- subset(combi, select = -c(class))
str(new_my_data)
colnames(new_my_data)
pca.train <- new_my_data[1:nrow(train),]
pca.test <- new_my_data[-(1:nrow(train)),]
#PCA of train data
prin_comp <- prcomp(pca.train, scale. = T)
names(prin_comp)
prin_comp$center
prin_comp$scale
prin_comp$rotation
prin_comp$rotation[1:5,1:4]
dim(prin_comp$x)
biplot(prin_comp, scale = 0)
std_dev <- prin_comp$sdev
pr_var <- std_dev^2
pr_var[1:10]
prop_varex <- pr_var/sum(pr_var)
prop_varex[1:20]
plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")
plot(cumsum(prop_varex), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     type = "b")

