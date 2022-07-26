require("class")
require("MASS")



# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())


# Daten laden
load("atta.rdata")


# Generiere Trainingsdaten
#

cat("Generiere Trainingsdaten ... \n\n")
idx = c(1:8, 11:18, 21:28, 31:38, 41:48)
train = data[idx,] 
cat(dim(train), "\n\n")



cl = factor(c(rep(1,8), rep(2,8), rep(3,8), rep(4,8), rep(5,8)))

idx = c(9:10, 19:20, 29:30, 39:40, 49:50)
test = data[idx,] 
cat(dim(test), "\n\n")

# Ausgabe des Timings: Start
#
ptm <- proc.time()

P = prcomp(train, center=T)
P$rotation = P$rotation[,1:2] 

p_train2 = predict(P, train)
cat(dim(p_train2), "\n\n")


p_test2 = predict(P, test)
cat(dim(p_test2), "\n\n")


cat(knn(p_train2, p_test2, cl, k = 1), "\n\n")
cat(knn(p_train2, p_test2, cl, k = 2), "\n\n")
cat(knn(p_train2, p_test2, cl, k = 3), "\n\n")
# summary(knn(p_train2, p_test2, cl, k = 1))

# plot(p_train2, main='Trainingsdaten')
plot(p_train2, main='Projected Data', col='red',  pch=16)
points(p_test2, col='green',  pch=16)
savePlot(filename="projected_data_b.png", type="png")


# Ausgabe des Timings: 
cat("\nLaufzeit:\n")
pt=proc.time() - ptm
print(pt)
