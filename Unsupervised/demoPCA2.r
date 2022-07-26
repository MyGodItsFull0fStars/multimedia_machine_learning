# Laden von Tools zum Generieren von Zufallsmengen
#
library(SpatialTools)



# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())

interactive = T;
save = F



# Generiere 2-dimensionale normalverteilte Zufallsvariablen
# (mittels einem Seed-Wert wäre das Ergebnis deterministisch)
#
# set.seed(12)
n=500
mu=c(0,0)
sigma <- matrix(c(4,3,3,3), ncol=2)
data = rmvnorm(n, mu, sigma)
data = t(data)



# Normalisieren der Daten
# (Hier primär um trotz zufällig generierter Punkte eine standardisierte
# Visualisierung zu erhalten)
#
means = apply(data,2,mean) 
sd    = apply(data,2,sd) 
data = (data-means)/sd



# Ausgabe der Originaldaten
# Achtung: Achsenlimits beachten, ansonsten kann Darstellung irreführend sein!!
#
dev.new()    # Erzeugt neue Graphik Instanz
plot(data, main='Input Data', xlim=c(-5,5), ylim=c(-5,5), 
    xlab="x-axis", ylab="y-axis")

# Optionales Speichern des Ergebnisses
if (save == T) {
    savePlot(filename="input.png", type="png")
}


# Berechnung der PCA mittels prcomp aus dem (internen) Paket "stats"
# Anmerkung: Da intern muss das Paket nicht geladen werden!
# 
# prcomp verwendet eine SVD Implementierung (empfohlen)
# Parameter: center=T: Daten werden mittelwertnormalisiert
#            scale=F: Daten werden nicht varianznormalisiert
#
P = prcomp(data, center=T, scale=T, retx=T)



# Optional: Warten auf Benutzereingabe (Tastendruck)
#
if (interactive==T)
{
    line <- readline()  
}



# Anzeige der berechneten Rotationsachsen:
#

dev.new()    # Erzeugt neue Graphik Instanz
plot(data, main='Compute Pricipal Directions', xlim=c(-5,5), ylim=c(-5,5), 
    xlab="x-axis", ylab="y-axis")

# Erste PCA Achse, größte Varianz
abline(0.0, P$rotation[2,1]/P$rotation[1,1], col="red", lwd=2) 

# Zweite PCA Achse, zweitgrößte Varianz
abline(0.0, P$rotation[2,2]/P$rotation[1,2], col="blue", lwd=2)

# Zusätzlich kann eine Legende angegeben werden
legend(-1.0, -3.75, c("PC 1","PC 2"), lty=c(1,1), col=c("red","blue"), lwd=c(2,2))

if (save == T) {savePlot(filename="achsen.png", type="png")}



# Optional: Warten auf Benutzereingabe (Tastendruck)
#
if (interactive==T)
{
    line <- readline()  
} 



# Ausgabe der rotierten Daten
# Achtung: Gleiche Achsenlimits wie bei Originaldaten verwenden!
# 
dev.new()
plot(P$x, col='red', main='Rotated Data', xlim=c(-5,5), ylim=c(-5,5),
    xlab="x-axis", ylab="y-axis")

if (save == T)
{
    savePlot(filename="rotiert.png", type="png")
}


# Optional: Warten auf Benutzereingabe (Tastendruck)
#
if (interactive==T)
{
    line <- readline()  
}



# Ausgabe der der Originaldaten im Vergleich zur Rotation
# Achtung: Gleiche Achsenlimits wie bei Originaldaten verwenden!
#
dev.new()
plot(data, main='Data before and afer Rotation', xlim=c(-5,5), ylim=c(-5,5))
points(P$x, col='red')

if (save == T)
{
   savePlot(filename="input+rotiert.png", type="png")
}



# Optional: Warten auf Benutzereingabe (Tastendruck)
#
if (interactive==T)
{
    line <- readline()  
}



# Ausgabe der skalierten Daten
# Achtung: Gleiche Achsenlimits wie bei Originaldaten verwenden!
#
dev.new()
plot(P$x%*%diag(1/P$sdev), col='green', main='Scaled Data',
    xlim=c(-5,5), ylim=c(-5,5), xlab="x-axis", ylab="y-axis")

if (save == T)
{
    savePlot(filename="skaliert.png", type="png")
}


# Optional: Warten auf Benutzereingabe (Tastendruck)
#
if (interactive==T)
{
    line <- readline()  
}



# Ausgabe der rekonstruierten Daten
# Achtung: Gleiche Achsenlimits wie bei Originaldaten verwenden!
#
dev.new()
plot(P$x%*%P$rotation, col='blue', main='Reconstructed Data', 
    xlim=c(-5,5), ylim=c(-5,5), xlab="x-axis", ylab="y-axis")

if (save == T)
{
    savePlot(filename="rekonstruiert.png", type="png")
}

