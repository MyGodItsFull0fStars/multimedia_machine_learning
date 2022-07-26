#########################################
# Delete all data and close all figures #
#########################################

graphics.off()
rm(list=ls())


##################
# Load libraries #
##################

require(MASS)


# Open all plots in new window
switch(Sys.info()[['sysname']],
   Windows= {options(device = "windows")},
   Linux  = {options(device = "X11")},
   Darwin = {options(device = "quartz")}
)


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
# Compute LDA model and classify test set #
###########################################

# Train LDA model
L <- lda(train, labels)


# Classify test data
PL = predict(L,test)
pred_l = PL$class


# Estimate success rate and print results
success_l = sum(pred_l == labels)/length(labels)
res_l = sprintf('   Success rate LDA: %5.2f%%\n', success_l*100)
cat("LDA results on Iris Dataset:\n")
cat(res_l)
