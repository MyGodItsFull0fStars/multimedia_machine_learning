#########################################
# Delete all data and close all figures #
#########################################

graphics.off()
rm(list=ls())

saveFigs = F 


##################
# Load libraries #
##################

library(MASS)


# Open all plots in new window
switch(Sys.info()[['sysname']],
   Windows= {options(device = "windows")},
   Linux  = {options(device = "X11")},
   Darwin = {options(device = "quartz")}
)


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
# Compute LDA model and project data #
######################################

# Compute LDA model
L <- lda(data, cl)


# Project data
P = predict(L, data)
P = P$x

# Extract info for plotting the separating hyperplane
gmean <- L$prior%*%L$means
const <- drop(gmean%*%L$scaling)

slope <- -L$scaling[1]/L$scaling[2]
intercept <- const/L$scaling[2]


########################################################
# Orthogonal projection of data points to linear model #
########################################################

PL = data%*%L$scaling
n_PL = sum(L$scaling*L$scaling)
PL = PL/n_PL


ML = matrix(0,200,2)

idx = 1:200

for (cnt in idx)
{
   tmp = L$scaling%*%PL[cnt]
   ML[cnt,] = tmp

}


####################################################
# Plot original data, projected points, hyperplane #
####################################################


if (saveFigs)
{
   png("lda_projection1.png", width=5, height=4, units="in", res=600)
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


# Plot separating hyperplan
abline(intercept, slope, col=3)


# Plot projected points
points(ML, 
   bg = c("green", "green")[gl(n, k)],
   pch = c(rep(22, k), rep(21, k)),)

title(main="LDA Projection")


if (saveFigs)
{
   dev.off()
}



#########################
# Plot projected points #
#########################

# Values for y-axis
y1 = rep(0, 100)
y2 = rep(0, 100)



if (saveFigs)
{
   png("lda_projection2.png", width=8, height=4, units="in", res=600)
} else
{
   dev.new(width=8, height=4, units="in")
}


# Plot projected data
plot(t(P[1:100]), y1, xlim=c(min(P)-1,max(P)+1), ylim=c(0.0, 0.2), col="red", 
axes=F, yaxt='n', type="p", pch=16, xlab="", ylab="")
par(new=TRUE)
plot(t(P[101:200]), y2, xlim=c(min(P)-1,max(P)+1), ylim=c(0.0, 0.2), col="green",
xlab="Projected input data to 1-dimensional subspace", ylab="", yaxt='n', pch=16)

text(mean(P[101:200]),0.1, "Class 1", col="green")
text(mean(P[1:100]),0.1, "Class 2", col="red")

title(main="LDA Classification")


if (saveFigs)
{
   dev.off()
}
