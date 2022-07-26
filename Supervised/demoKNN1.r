require("class")
require("MASS")



# close open graphic instances and clean workspace
#
graphics.off()
rm(list=ls())


# load data
#
# load("coil.rdata")
load("atta.rdata")


# generate training data
#
cat("Generate training daten ... \n\n")
idx = c(1:8, 11:18, 21:28, 31:38, 41:48)
train = data[idx,] 
cat(dim(train), "\n\n")


cl = factor(c(rep(1,8), rep(2,8), rep(3,8), rep(4,8), rep(5,8)))

idx = c(9:10, 19:20, 29:30, 39:40, 49:50)
test = data[idx,] 
cat(dim(test), "\n\n")


# compute timing: start
#
ptm <- proc.time()


# reduce dimensions using PCA
P = prcomp(train, center=T)
train_p = predict(P, train)
train_p = train_p[,1:2]
cat(dim(train), "\n\n")

test_p = predict(P, test)
test_p = test_p[,1:2]
cat(dim(test), "\n\n")



# compute the kNNs
cat(knn(train_p, test_p, cl, k = 1), "\n\n")
cat(knn(train_p, test_p, cl, k = 2), "\n\n")
cat(knn(train_p, test_p, cl, k = 3), "\n\n")
summary(knn(train_p, test_p, cl, k = 1))

X =knn(train_p, test_p, cl, k = 3)



# plot training and test data

y = c(1,1,1,1,1,1,1,1,
      2,2,2,2,2,2,2,2,
      3,3,3,3,3,3,3,3,3,3,3,3, 
      4,4,4,4,4,4,4,4,4,4, 
      5,5,5,5)



# plot(train_p, main='kNN Illustration', col=y)
plot(train_p, main='kNN Illustration')
# points(test_p, col='red',  pch=16)
points(test_p, col=X,  pch=16)
# points(test_p, col=2,  pch=16)


# output of timing 
cat("\nLaufzeit:\n")
pt=proc.time() - ptm
print(pt)
