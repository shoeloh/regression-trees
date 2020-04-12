# Solder.R
# Analysis Using RPart Package
# 
# MIT License
# 
# Copyright (c) 2019 Shane Zabel 
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
###############################################################################

#Uncomment line below if rpart is not installed
#install.packages("rpart", dependencies=TRUE)

#Install rpart
library(rpart)

#Load kyphosis data
data(solder)

#Set Seed
set.seed(1)

#Build a model using the rpart function
K  <- rpart(solder$Solder ~ ., data = solder, method = 'class', minsplit=2, minbucket=1)

#Create a nice decision tree plot
par(mar = rep(0.1, 4))
plot(K,margin=0.05)
text(K,use.n=TRUE,cex=0.8)
summary(K)

#List the important attributes
K$variable.importance

#Find the best pruning paramater - CP with lowest xerror
printcp(K)

#Create a pruned tree
K1 <- prune(K,K$cptable[which.min(K$cptable[,"xerror"]),"CP"])

#Create a nice decision tree plot
par(mar = rep(0.1, 4))
plot(K1,margin=0.05)
text(K1,use.n=TRUE,cex=0.8)
summary(K1)

#Divide the dataset into two parts. 80% for training data and 20% for test data
train80<-sample(nrow(solder),size=576)
trainingData80<-solder[train80,]
testData20<-solder[-train80,]

#Build a pruned model using just the taining data
K80  <- rpart(trainingData80$Solder ~ ., data = trainingData80, method = 'class',minsplit=2,minbucket=1)
printcp(K80)
K80_1 <- prune(K80,K80$cptable[which.min(K80$cptable[,"xerror"]),"CP"])

#Create a nice decision tree plot
par(mar = rep(0.1, 4))
plot(K80_1,margin=0.05)
text(K80_1,use.n=TRUE,cex=0.8)
summary(K80_1)

#Find the prediction on the test data
out <- predict(K80_1,newdata=testData20,type="vector")
out
testData20$Solder

#Calculate the accuracy
dataNum=array(NA,c(1,dim(testData20)[1]))
for(i in 1:dim(testData20)[1]){
	if(testData20$Solder[i]=="Thick"){
		dataNum[i] <- 1
	}else{
		dataNum[i] <- 2
	}
}
result<-dataNum-out
counter<-0
for(i in 1:dim(testData20)[1]){
	counter<-counter+abs(result[i])
}
accuracy80<-1-counter/dim(testData20)[1]
accuracy80

#Divide the dataset into two parts. 90% for training data and 10% for test data
train90<-sample(nrow(solder),size=648)
trainingData90<-solder[train90,]
testData10<-solder[-train90,]

#Build a pruned model using just the taining data
K90  <- rpart(trainingData90$Solder ~ ., data = trainingData90, method = 'class',minsplit=2,minbucket=1)
printcp(K90)
K90_1 <- prune(K90,K90$cptable[which.min(K90$cptable[,"xerror"]),"CP"])

#Create a nice decision tree plot
par(mar = rep(0.1, 4))
plot(K90_1,margin=0.05)
text(K90_1,use.n=TRUE,cex=0.8)
summary(K90_1)

#Find the prediction on the test data
out2 <- predict(K90_1,newdata=testData10,type="vector")
out2
testData10$Solder

#Calculate the accuracy
dataNum2=array(NA,c(1,dim(testData10)[1]))
for(i in 1:dim(testData10)[1]){
	if(testData10$Solder[i]=="Thick"){
		dataNum2[i] <- 1
	}else{
		dataNum2[i] <- 2
	}
}
result2<-dataNum2-out2
counter2<-0
for(i in 1:dim(testData10)[1]){
	counter2<-counter2+abs(result2[i])
}
accuracy90<-1-counter2/dim(testData10)[1]
accuracy90

