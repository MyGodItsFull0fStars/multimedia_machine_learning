#########################################
# Delete all data and close all figures #
#########################################

graphics.off()
rm(list=ls())


##################
# Load libraries #
##################

require(e1071)


#######################################################
# Load data from Iris Dataset, generate random subset #
#######################################################

# Random sample select
tr <- sample(1:50, 25)


# Generate training/test split
train <- rbind(iris3[tr,,1], iris3[tr,,2], iris3[tr,,3])
test <- rbind(iris3[-tr,,1], iris3[-tr,,2], iris3[-tr,,3])


# Generate labels (3 classes)
labels <- factor(c(rep("s",25), rep("c",25), rep("v",25)))


###########################################
# Compute SVM model and classify test set #
###########################################

# Train SVM model
S <- svm(train, labels, scale = FALSE, kernel = "linear")
# S <- svm(train, labels, scale = FALSE, kernel = "polynomial", degree=3)
# S <- svm(train, labels, scale = FALSE, kernel = "radial", degree = 5, cost=100)
# S <- svm(train, labels, scale = FALSE, kernel = "sigmoid")


# Classify test data
pred_s = predict(S, test, type="vector")


# Estimate success rate and print results
success_s = sum(pred_s == labels)/length(labels)
res_s = sprintf('   Success rate LDA: %5.2f%%\n', success_s*100)
cat("SVM results on Iris Dataset:\n")
cat(res_s)
