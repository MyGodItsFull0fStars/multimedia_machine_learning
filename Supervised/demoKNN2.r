require("class")
require("MASS")



# close open graphic instances and clean workspace
#
graphics.off()
rm(list=ls())


# load datan
#
# load("coil.rdata")
# load("faces.rdata")
load("atta.rdata")


# generate training data
#

cat("Generate training daten ... \n\n")

idx_tr = c()
idx_te = c()

for(i in 1:5)
{
    tmp = seq(72*(i-1)+1, 72*(i-1)+72, 2)
    idx_tr = c(idx_tr, tmp)
    tmp = seq(72*(i-1)+2, 72*(i-1)+72, 8)
    idx_te = c(idx_te, tmp)
}

cl = factor(c(rep(1,36), rep(2,36), rep(3,36), rep(4,36), rep(5,36)))
test_labels = factor(c(rep(1,9), rep(2,9), rep(3,9), rep(4,9), rep(5,9)))

train = data[idx_tr,]
test  = data[idx_te,]



cat("Compute matching ... \n\n")

# compute timing: start
ptm <- proc.time()


# reduce dimensions using PCA
P = prcomp(train, center=T)
train = predict(P, train)
train = train[,1:2]
cat(dim(train), "\n\n")


test = predict(P, test)
test = test[,1:2]
cat(dim(test), "\n\n")


# compute the kNNs
# pred = knn(train, test, cl, k = 1)
pred =  knn(train, test, cl, k = 2)
# pred = knn(train, test, cl, k = 5)

verify = as.numeric(test_labels) == pred 
correct = sum(as.numeric(as.numeric(test_labels) == pred ))/length(test_labels)
cat(verify, "\n\n")
cat(correct, "\n\n")


# plot training and test data
plot(train, main='kNN Illustration')
points(test, col='red',  pch=16)


# output of timing 
cat("\nLaufzeit:\n")
pt=proc.time() - ptm
print(pt)
