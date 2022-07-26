# Close all graphics windows and clear all variables
#
graphics.off()
rm(list=ls())


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


# Run hierarchical clustering
#
num_cluster = 5
hc <- hclust(dist(x), method="ward")
cl <- cutree(hc, k=num_cluster)


# Plot Clusters
title = sprintf("Hierarchical Clustering with %d clusters",num_cluster)
plot(x, col = cl, main=paste(title))
