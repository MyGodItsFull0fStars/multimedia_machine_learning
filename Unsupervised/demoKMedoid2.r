require(cluster)

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


# Run K-Medoid
#
num_cluster = 2
PAM = pam(x, num_cluster)

# Plot the results
#
cl <- PAM$clustering
title = sprintf("K-Medoid Clustering with %d clusters",num_cluster)
plot(x, col = cl, main=paste(title))
points(PAM$medoids, pch = 15, col=1:num_cluster, cex=3)
