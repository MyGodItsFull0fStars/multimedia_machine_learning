#########################################
# Delete all data and close all figures #
#########################################

graphics.off()
rm(list=ls())


##################
# Load libraries #
##################

require(e1071)


################################################
# Load data from Iris Dataset, generate subset #
################################################

load("coil.rdata")
# load("faces.rdata")

idx = c(1:100, 501:600)
train = data[idx,] 
label = factor(c(rep(-1,100), rep(1,100)))

idx = c(101:200, 601:700)
test = data[idx,] 


# PCA proprocessing step (optional)

pca_dim = 20
P = prcomp(train, center=T)
P$rotation = P$rotation[,1:pca_dim] 

train = predict(P, train)
test = predict(P, test)


###########################################
# Compute SVM model and classify test set #
###########################################


# Time mesurement: START
ptm <- proc.time()

cat("Train SVM model ... \n\n")
S = svm(train, label, kernel="linear")


cat("Eval negative class ... \n\n")
test_label = c(-1,-1,-1,-1,-1,-1,-1)

X = data.frame(train[c(1, 25, 50, 75, 80, 90, 100),])
P = predict(S, X, type="vector")
cat("   Correct prediction (training data): ", P == test_label, "\n\n")

X = data.frame(test[c(1, 25, 50, 75, 80, 90, 100),])
P = predict(S, X, type="vector")
cat("   Correct prediction (test data):     ", P == test_label)


cat("\n\n\nEvaluiere positive Klasse ... \n\n")
test_label = c(1,1,1,1,1,1,1)

X = data.frame(train[c(101, 125, 150, 175, 180, 190, 200),])
P = predict(S, X, type="vector")
cat("   Correct prediction (training data):", P == test_label, "\n\n")

X = data.frame(test[c(101, 125, 150, 175, 180, 190, 200),])
P = predict(S, X, type="vector")
cat("   Correct prediction (test data):    ", P == test_label)


# Time mesurement: End
cat("\n\n\nRun time:\n")
pt=proc.time() - ptm
print(pt)
