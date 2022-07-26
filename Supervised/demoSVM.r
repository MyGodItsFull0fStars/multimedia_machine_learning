require("e1071")



# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())


# Daten laden
#
# load("coil.rdata")
load("faces.rdata")


# Generiere Trainingsdaten
#

cat("Generiere Trainingsdaten ... \n\n")
idx = c(1:100, 501:600)
train = data[idx,] 

# P = prcomp(train, center=T)
# train = predict(P, train)
# train = train[,1:50]

label = factor(c(rep(-1,100), rep(1,100)))


ptm <- proc.time()

cat("Trainiere SVM Modell ... \n\n")
S = svm(train, label)


cat("Evaluiere negative Klasse ... \n\n")
X = data.frame(train[c(1, 25, 50, 75, 80, 90, 100),])
P = predict(S, X, type="vector")
print(P)

cat("Evaluiere positive Klasse ... \n\n")
X = data.frame(train[c(101,125, 150, 175, 180, 190, 200),])
P = predict(S, X, type="vector")
print(P)

cat("\nLaufzeit:\n")
pt=proc.time() - ptm
print(pt)
