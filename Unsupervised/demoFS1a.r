# Laden des FSelector Pakets
#
require(FSelector)



# Laden des Benchmark Datensatz (Daten + Labels)
#     R stellt zahlreiche Testdatensätze zur Verfügung
#     Praktisch, aber auch gefährlich - Demos werden meist mit den
#     gleichen, sehr speziellen Daten gezeigt 
#     Konkretes Beispiel: ps://en.wikipedia.org/wiki/Iris_flower_data_set
#
data(iris)
str(iris)



# Bestimme Gewichte aus chi^2 Test
#
weights = chi.squared(Species~., iris)
print(weights)



# Wähle relevanten Feature Kanäle und zeige diese an
#
subset = cutoff.k(weights, 2)
print(subset)

