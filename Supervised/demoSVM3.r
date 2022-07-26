#########################################
# Delete all data and close all figures #
#########################################

graphics.off()
rm(list=ls())


##################
# Load libraries #
##################

require(e1071)



#############
# Load data #
#############

load(file = "ESL.mixture.rda")
names(ESL.mixture)
attach(ESL.mixture)


################################
# Open all plots in new window #
################################

switch(Sys.info()[['sysname']],
   Windows= {options(device = "windows")},
   Linux  = {options(device = "X11")},
   Darwin = {options(device = "quartz")}
)


###########################################
# Compute SVM model and classify test set #
###########################################

XY = data.frame(y = factor(y), x)

# Switch between linear, radial, and polynomial kernel
# S = svm(factor(y) ~ ., data = XY, scale = FALSE, kernel = "linear", cost = 1)
S = svm(factor(y) ~ ., data = XY, scale = FALSE, kernel = "radial", cost = 1)
# S = svm(factor(y) ~ ., data = XY, scale = FALSE, kernel = "polynomial", degree = 2, cost = 10)



#############################
# Compute decision boundary #
#############################

# Plot original points
plot(x, col = y + 1, pch = 19)


# Plot decision boundary

xgrid = expand.grid(X1 = px1, X2 = px2)
func = predict(S, xgrid, decision.values = TRUE)
func = attributes(func)$decision

contour(px1, px2, matrix(func, 69, 99), level = 0, add = TRUE)
contour(px1, px2, matrix(func, 69, 99), level = 0.5, add = TRUE, col = "blue", lwd = 2)
