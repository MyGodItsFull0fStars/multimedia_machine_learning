require("randomForest")



# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())


# Daten laden
#
load("coil.rdata")
# load("faces.rdata")


# Generiere Trainingsdaten
#
cat("Generiere Trainingsdaten ... \n\n")
idx = c(1:100, 501:600)
train = data[idx,] 
label = factor(c(rep(-1,100), rep(1,100)))


# Start Time für Laufzeitanalyse
#
ptm <- proc.time()

# Modell Training
#
cat("Trainiere RF Modell ... \n\n")
S = randomForest(train, label, ntree=1)


# Evaluierung, Sanity Check
#
cat("Evaluiere negative Klasse ... \n\n")
P = predict(S, train[c(1, 25, 50, 75, 80, 90, 100),])
print(P)

cat("Evaluiere positive Klasse ... \n\n")
P = predict(S, train[c(101,125, 150, 175, 180, 190, 200),])
print(P)


# Ausgabe - Laufzeitverhalten
cat("\nLaufzeit:\n")
pt=proc.time() - ptm
print(pt)
