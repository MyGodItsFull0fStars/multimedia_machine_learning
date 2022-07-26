# Laden des FSelector Pakets
#
require(FSelector)



# Laden des Benchmark Datensatz (Daten + Labels)
#

data(iris)
str(iris)


#  -  Random Forests

cat("\n\nFS basierend auf Random Forests:\n\n")

# Bestimme Gewichte
weights = random.forest.importance(Species~., iris, 2)
print(weights)

# Wähle relevanten Feature Kanäe und zeige diese an
subset = cutoff.k(weights, 2)
print(subset)
