
# Initialisiere Paket für PCA
#
# library(MASS)



# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())



# Einfache Funktion um Vektoren als Bild ausgeben zu können
#
showImage = function(M, rows, cols)
{
    image(matrix(M, cols, rows, T)[,rows:1], axes = FALSE, col = grey(seq(0, 1, length = 256)))
}


# Optinales Speichern der Bilder
save = F


# ATT Daten laden
load("atta.rdata")



# Generiere Trainingsdaten
#
train = data[1:50,] 



# Berechne PCA
#
P = prcomp(train, center=F)



# Visualisierung der Basisvektoren (ueber P$rotation gegeben)
#
dev.new(width=8, height=4)
par(mfrow = c(2, 5), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))
showImage(P$rotation[,1], 28, 23)
showImage(P$rotation[,2], 28, 23)
showImage(P$rotation[,3], 28, 23)
showImage(P$rotation[,4], 28, 23)
showImage(P$rotation[,5], 28, 23)
showImage(P$rotation[,6], 28, 23)
showImage(P$rotation[,7], 28, 23)
showImage(P$rotation[,8], 28, 23)
showImage(P$rotation[,9], 28, 23)
showImage(P$rotation[,10], 28, 23)
title("Basis Vectors: 1-10", outer=T, cex.main=2,font=2)

if (save)
{
    savePlot(filename="pca_bases_10.png", type="png")
}


dev.new(width=8, height=4)
par(mfrow = c(2, 5), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))
showImage(P$rotation[,11], 28, 23)
showImage(P$rotation[,12], 28, 23)
showImage(P$rotation[,13], 28, 23)
showImage(P$rotation[,14], 28, 23)
showImage(P$rotation[,15], 28, 23)
showImage(P$rotation[,16], 28, 23)
showImage(P$rotation[,17], 28, 23)
showImage(P$rotation[,18], 28, 23)
showImage(P$rotation[,19], 28, 23)
showImage(P$rotation[,20], 28, 23)
title("Basis Vectors: 11-20", outer=T, cex.main=2,font=2)

if (save)
{
    savePlot(filename="pca_basis_20.png", type="png")
}




# Ausgabe der Eigenwerte (gegeben ueber P$sdev)
#
total = sum(as.vector(P$sdev)^2)

dev.new(width=7, height=4)
barplot(as.vector(P$sdev)^2/total, col="red", 
    names.arg=1:length(P$sdev),
    main="Energy of Eigenvalues",
    xlab="PCA Components",
    ylab="Energy in %")

if (save)
{
    savePlot(filename="pca_energy.png", type="png")
}
