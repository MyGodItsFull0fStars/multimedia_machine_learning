# Laden des FSelector Pakets
#
require(FSelector)



# Laden des Benchmark Datensatz (Daten + Labels)
#

data(iris)
str(iris)



# Variante 1 - Information gain
#     mehrere Varianten: auskommentieren
#

cat("\n\nFS basierend auf informationstheoretischen Maßen:\n\n")

# Bestimme Gewichte
# weights = gain.ratio(Species~., iris)
# weights = symmetrical.uncertainty(Species~., iris)
weights = information.gain(Species~., iris)
print(weights)

# Wähle relevanten Feature Kanäe und zeige diese an
subset = cutoff.k(weights, 2)
print(subset)



# Variante 2 -  Random Forests

cat("\n\nFS basierend auf Random Forests:\n\n")

# Bestimme Gewichte
weights = random.forest.importance(Species~., iris, 2)
print(weights)

# Wähle relevanten Feature Kanäe und zeige diese an
subset = cutoff.k(weights, 2)
print(subset)



# Variante 3 -  Random Forests

cat("\n\nFS basierend auf Relief Filter:\n\n")

# Bestimme Gewichte
weights = relief(Species~., iris, neighbours.count = 5, sample.size = 20)
print(weights)


# Wähle relevanten Feature Kanäe und zeige diese an
subset = cutoff.k(weights, 2)
print(subset)



# Variante 4 -  Korrelation

cat("\n\nFS basierend auf Korrelation:\n\n")

# Direkte Auswahl des besten Feature Kanals
subset = cfs(Species~., iris)
print(subset)



# Variante 5 -  Korrelation

cat("\n\nFS basierend auf Konsistenzmaß:\n\n")


# Direkte Auswahl des besten Feature Kanals
subset = consistency(Species~., iris)
print(subset)







