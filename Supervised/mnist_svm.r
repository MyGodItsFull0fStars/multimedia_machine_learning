# load packages
require("e1071")


#disable warnings
options(warn=-1)


# source load_mnist.r if not already called
if(!exists("load_mnist", mode="function")) source("load_mnist.r")


# load mnist data
load_mnist()


# select subset for training
num_train = 2500 # number might be increased/decreased
data_tr = train$x[1:num_train,]
data_tr = data_tr/255 
labels_tr = train$y[1:num_train]
labels_tr = factor(labels_tr)


# select subset for testing
num_test = 1000
data_te = test$x[1:num_test,]
data_te = data_te/255 
labels_te = test$y[1:num_test]
labels_te = factor(labels_te)



# init timer
t1 = proc.time()


# train SVM
S = svm(data_tr, labels_tr)


# eval SVM (train and test data)
pr_tr = predict(S, data_tr)
success = sum(pr_tr==labels_tr)/length(labels_tr)*100
cat("Erfolgsrate (Train): ", success, "%\n")

pr_te = predict(S, data_te)
success = sum(pr_te==labels_te)/length(labels_te)*100
cat("\nErfolgsrate  (Test): ", success, "%\n")


# end time, calculate elapsed time
t2 = proc.time()
t = t2-t1
cat("\nBenötigte Berechnungszeit:\n")
print(t)
