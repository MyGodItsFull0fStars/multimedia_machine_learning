# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())





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



# Hierarchisches Clustering
#
d = dist(train)
hc = hclust(d)      
plot(hc) 
memb = cutree(hc, k = 10)
