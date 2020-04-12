# ABOUT
This program is an implementation and test of the regression tree learning algorithm   
   
Program was written in R using R native functions  

Analysis uses the rpart package

The following sample datasets are provided with the R package rpart:
- kyphosis
- solder

For both of these the programs perform the following analysis:
1) Create a model using the rpart function
2) Create a regression tree plot
3) List the important attributes
4) Using the best pruning paramter, create a prunded tree 
5) Divide the dataset into an 80/20 training/test split
6) Build a pruned model using just the training data and use it to find the predicion on the test dataset. How much is the accuracy obtained.
7) Repeate step 6) but this time use a 90/10 training/test split

# COMPILING, INSTALLATION AND RUNNING  
Program files are Kyphosis.R and Solder.R  

## Compiling:  

No compiling of R … its an interpreted language.  

## How to run the code and a genric run command statement.  

Assumes RPart is installed. If not run:  
> install.packages("rpart", dependencies=TRUE)  

Generic run command: Rscript Kyphosis.R
Generic run command: Rscript Solder.R  

## RESULTS  

Results are shown in the Results.pdf file. 

Regression Tree plots are printed to RGraphics and are shown in the Rplots.pdf file.

Accuracies are printed to the Console.

## LICENSE  
[MIT License](https://github.com/shoeloh/decision-trees-R/blob/master/LICENSE)  

