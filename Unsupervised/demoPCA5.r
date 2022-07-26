
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



# reconstruct-Funktion für PCA: Kompression, Rauschentfernung
#
recPCA = function(data, dim_out, model)
{
    if (nargs()==3)
    {
        data = data - model$center
    }

    if (nargs()>=2)
    {
        W = model$rotation[,1:dim_out]
    }
    else
    {
        W = model$rotation
    }

    # proj = t(W)%*%t(data)
    proj = W%*%t(W)%*%t(data)
}



# ATT Daten laden
# rows = 28, cols = 23
#
load("atta.rdata")

# Optinales Speichern der Bilder
save = F

# Generiere Trainings- und Testdaten
#
train = data[1:50,] 
test = data[c(1,11,21,31,41),]



# Visualisierung der Eingangsdaten
#
dev.new(width=8, height=2)
par(mfrow = c(1, 5), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))
showImage(train[1,], 28, 23)
showImage(train[11,], 28, 23)
showImage(train[21,], 28, 23)
showImage(train[31,], 28, 23)
showImage(train[41,], 28, 23)
title("Originaldaten", outer=T, cex.main=2,font=2)

if (save)
{
    savePlot(filename="faces_orig.png", type="png")
}


# Berechne PCA
#
P = prcomp(train, center=F)



# Rekonstruieren des Testbilder

dim_basis = 50
rec = recPCA(test, dim_basis, P)
rec = t(rec)

dev.new(width=8, height=2)
par(mfrow = c(1, 5), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))
showImage(rec[1,], 28, 23)
showImage(rec[2,], 28, 23)
showImage(rec[3,], 28, 23)
showImage(rec[4,], 28, 23)
showImage(rec[5,], 28, 23)

str_title = sprintf("Rekonstruktionen: %d Dimensionen", dim_basis)
title(str_title, outer=T, cex.main=2,font=2)

if (save)
{
    savePlot(filename="pca_rec_05.png", type="png")
}
