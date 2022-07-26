# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())


# Open all plots in new window
switch(Sys.info()[['sysname']],
   Windows= {options(device = "windows")},
   Linux  = {options(device = "X11")},
   Darwin = {options(device = "quartz")}
)


# Lade Paket für Affinity Propagation
#
require(apcluster)



# Einfache Funktion um Vektoren als Bild ausgeben zu können
#
showImage = function(M, rows, cols)
{
    image(matrix(M, cols, rows, T)[,rows:1], axes = FALSE, col = grey(seq(0, 1, length = 256)))
}



# Coil Daten laden
#
load("coil.rdata")



# Generiere Trainingsdaten
#     Extrahiere Teilmenge aus 16 Objekten a 72 Bildern
#

idx = c()

# wähle je 10 Beispiele pro Klasse
for (i in 1:10)
{
    tmp = seq(i,1152,72)
    idx = c(idx, tmp)
}

idx = sort(idx)
train = data[idx,] 



dev.new(width=12, height=3)
par(mfrow = c(2, 8), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))

for (i in 1:16)
{
     showImage(train[(i-1)*10+1,], 64, 64)
}

title("Trainingsdaten: 16 Klassen", outer=T, cex.main=2,font=2)




# Berechne Ähnlichkeitsmatrix 
# (negative quadrierte euklidsche Distanz)
#
sim <- negDistMat(train, r=2)


# Affinity Propagation
#
AC <- apcluster(sim, details=F)



# Label Vektor (consecutive index of exemplars)
#
labels(AC, type="enum")



# Label vector (index of exemplars within original data set)
#
labels(AC, type="exemplars")


# Extrahiere Exemplars
#
exemplars = AC@exemplars



# Anzeige der Exemplars
#
dev.new(width=12, height=3)
par(mfrow = c(2, 8), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))

for (i in 1:length(exemplars))
{
     showImage(train[exemplars[i],], 64, 64)
}

title("Exemplars - AP", outer=T, cex.main=2,font=2)
