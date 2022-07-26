# Load FSelector package
require(FSelector)

# Load benchmark data
X = read.table("pima-indians-diabetes.data", sep=",")

# Compute weights, select features
cat("\n\nFS based on Chi^2 distance:\n\n")
weights = chi.squared(V9~., X)

# print(weights)
subset <- cutoff.k(weights, 3)
print(subset)

