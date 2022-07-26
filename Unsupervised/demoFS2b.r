# Load FSelector package
require(FSelector)


# Load benchmark data
X = read.table("pima-indians-diabetes.data", sep=",")


cat("\n\nFS based on correlation:\n\n")
subset = cfs(V9~., X)
print(subset)

cat("\n\nFS baed auf Chi^2 distance:\n\n")
weights = chi.squared(V9~., X)
# print(weights)
subset <- cutoff.k(weights, 3)
print(subset)


cat("\n\nFS based on consistence meassure:\n\n")
subset = consistency(V9~., X)
print(subset)


cat("\n\nFS based on correlation 1:\n\n")
weights = linear.correlation(V9~., X)
# print(weights)
subset <- cutoff.k(weights, 3)
print(subset)


cat("\n\nFS based on correlation 2:\n\n")
weights = rank.correlation(V9~., X)
subset <- cutoff.k(weights, 3)
print(subset)



cat("\n\nFS based on Relief Filter:\n\n")
weights = relief(V9~., X, neighbours.count = 5, sample.size = 20)
# print(weights)
subset = cutoff.k(weights, 3)
print(subset)


cat("\n\nFS based on Random Forests:\n\n")
weights = random.forest.importance(V9~., X, 2)
# print(weights)
subset = cutoff.k(weights, 3)
print(subset)


cat("\n\nFS based on information theoretical measurement:\n\n")
weights = gain.ratio(V9~., X)
# weights = symmetrical.uncertainty(V9~., X)
# weights = information.gain(V9~., X)
# print(weights)
subset = cutoff.k(weights, 3)
print(subset)
