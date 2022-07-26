# Close all graphics windows and clear all variables
#
graphics.off()
rm(list=ls())

# Open all plots in new window
switch(Sys.info()[['sysname']],
   Windows= {options(device = "windows")},
   Linux  = {options(device = "X11")},
   Darwin = {options(device = "quartz")}
)


# Init random test data
#
x <- rbind(
matrix(rnorm(100, sd = 0.2), ncol = 2),
matrix(rnorm(100, mean = 1, sd = 0.2), ncol = 2),
matrix(rnorm(100, mean = -1, sd = 0.2), ncol = 2),
matrix(c(rnorm(100, mean = 1, sd = 0.2),
rnorm(100, mean = -1, sd = 0.2)), ncol = 2),
matrix(c(rnorm(100, mean = -1, sd = 0.2),
rnorm(100, mean = 1, sd = 0.2)), ncol = 2))
colnames(x) <- c("x", "y")


# Run K-Means 
#
num_cluster = 8
KM = kmeans(x, num_cluster )


# Plot the results
#
cl <- KM$cluster
title = sprintf("K-Means Clustering with %d clusters",num_cluster)
plot(x, col = cl, main=paste(title))
points(KM$centers, pch = 15, col=1:num_cluster, cex=3)
