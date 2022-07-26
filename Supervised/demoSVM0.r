#########################################
# Delete all data and close all figures #
#########################################

graphics.off()
rm(list=ls())


# Open all plots in new window
switch(Sys.info()[['sysname']],
   Windows= {options(device = "windows")},
   Linux  = {options(device = "X11")},
   Darwin = {options(device = "quartz")}
)

saveFigs = F 


##################
# Load libraries #
##################

library(e1071)
library(MASS)


####################################
# Generate simulated Gaussian data #
####################################

# Set fixed seed to compare results
# set.seed(512)

# Samples per class
k = 100

# Number of classes
n = 2

# Generate two Gaussian distributions 
x1 = mvrnorm(k, mu = c(-10, 6), matrix(c(4,2,2,4), ncol = 2))
x2 = mvrnorm(k, mu = c(0, 0), matrix(c(4,2,2,4), ncol = 2))
data <- rbind(x1, x2)

# Generate according labels
y = c(rep(-1,100), rep(1,100))
cl = factor(y)


######################################
# Compute SVM model and project data #
######################################

S <- svm(data, cl, scale = FALSE, kernel = "linear")
WS = coef(S)
P = predict(S, data, type="vector")


#############################
# Plot hyperlane and margin #
#############################

if (saveFigs)
{
   png("SVM_hyperplane1.png", width=5, height=4, units="in", res=600)
   # par(mar=c(2.5,2.5,0.0,0.0))
} else
{
   dev.new(width=5, height=4, units="in")
}


# Plot original data
plot(data[, 1], data[, 2], 
   bg = c("#E41A1C", "#377EB8")[gl(n, k)],
   pch = c(rep(22, k), rep(21, k)),
   xlab="", ylab="")


# plot margin and mark support vectors
cf = coef(S)

abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "green")

abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "blue")
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "blue")

points(S$SV, pch = 5, cex = 2)

title(main="SVM Hyperplane + Margin")


if (saveFigs)
{
   dev.off()
}

# coef(S)
# 


########################################################
# Orthogonal projection of data points to linear model #
########################################################


beta = t(S$SV) %*% S$coefs
beta0 = S$rho


P = data%*%beta
n_beta = sum(beta*beta)
P = P/n_beta


idx = 1:200

M = matrix(0,200,2)

for (cnt in idx)
{
   tmp = t(P[cnt]*beta)
   M[cnt,] = tmp
}


####################################################
# Plot original data, projected points, hyperplane #
####################################################


if (saveFigs)
{
   png("SVM_projection1.png", width=5, height=4, units="in", res=600)
} else
{
   dev.new(width=5, height=4, units="in")
}


# par(mar=c(2.5,2.5,0.0,0.0))

# Plot original data
plot(data[, 1], data[, 2], 
   bg = c("#E41A1C", "#377EB8")[gl(n, k)],
   pch = c(rep(22, k), rep(21, k)),
   xlab="", ylab="")


# Plot hyperplane
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "green")


# Plot projected points
points(M, 
   bg = c("green", "green")[gl(n, k)],
   pch = c(rep(22, k), rep(21, k)),)


title(main="SVM Projected Points")


if (saveFigs)
{
   dev.off()
}


#########################
# Plot projected points #
#########################

# Projekt points to 1 dimension
P = data%*%beta - beta0


# Values for y-axis
y1 = rep(0, 100)
y2 = rep(0, 100)


if (saveFigs)
{
  png("SVM_projection2.png", width=8, height=4, units="in", res=600)
} else
{
   dev.new(width=8, height=4, units="in")
}


# Plot projected data
plot(P[1:100], y1, xlim=c(min(P)-1,max(P)+1), ylim=c(0.0, 0.2), col="red", 
axes=F, yaxt='n', type="p", pch=16, xlab="", ylab="")
par(new=TRUE)
plot(P[101:200], y2, xlim=c(min(P)-1,max(P)+1), ylim=c(0.0, 0.2), col="green",
xlab="Projected input data to 1-dimensional subspace", ylab="", yaxt='n', pch=16)

text(mean(P[101:200]),0.1, "Class 1", col="green")
text(mean(P[1:100]),0.1, "Class 2", col="red")

title(main="SVM Classification")


if (saveFigs)
{
   dev.off()
}
