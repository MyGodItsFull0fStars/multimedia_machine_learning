# Laden von Tools zum Generieren von Zufallsmengen
#
library(SpatialTools)



# Alle offenen Graphiken schließen und Workspace bereinigen
# (Zweiters um zu verhindern, dass mit falschen Daten gearbeitet wird!!)
#
graphics.off()
rm(list=ls())



# PCA über Eigenwertproblem der Kovarianzmatrix (manuell)
#

pca1 = function(data)
{
    # Dimensionen der Datenmatrix auslesen (werden spaeter benötigt)
    r = nrow(data)
    c = ncol(data)

    # Berechne Mittelwert über die Spalten
    m = apply(data, 2, mean) 
    MM = matrix(rep(m, r), r, c, T)    # mean matrix
    
    # Normalisiere Daten: Abziehen des Mittelwertvektors
    data = data-MM
    
    # Berechne die Kovarianzmatrix
    C = 1/(r-1)*t(data)%*%data

    # Loesen des Eignwertproblems
    E = eigen(C)

    # Rueckgabewerte als Liste
    # Zugriff auf Listenelement _el_ in Liste _list: _list_$_el_
    P = list("values" = E$values, "vectors" = E$vectors, "mean" = m)
    return(P)
}



# PCA über Eigenwertproblem der Kovarianzmatrix (R)
#

pca2 = function(data)
{
    # Berechne die Kovarianzmatrix (siehe oben)
    C = cov(data)
    
    E = eigen(C)
    m = apply(data, 2, mean)

    P = list("values" = E$values, "vectors" = E$vectors, "mean" = m)
    return(P)
}



# PCA über Singulärwertzerlegung der Kovarianzmatrix
#
pca3 = function(data)
{
    C = cov(data)

    # Da C eine reele symetrische Matrix ist, kann das EWP durch
    # eine SVD bestimm werden
    S = svd(C)
    m = apply(data, 2, mean)

    P = list("values"=S$d, "vectors"=S$u, "mean" = m)
    return (P)
}




# PCA über Singulärwertzerlegung der normalisierten Datenmatrix
#
pca4 = function(data)
{
    r = nrow(data)
    c = ncol(data)

    m = apply(data, 2, mean) 
    MM = matrix(rep(m, r), r, c, T)    # mean matrix
    data = data-MM
    
    S = svd(t(data))

    # Eigenwerte können aus Singulärwerten berechnet werden
    l = 1/(r-1)*S$d^2

    P = list("values" = l, "vectors" = S$u, "mean" = m)
    return (P)
}


# PCA über interne R-Funktion (verwendet SVD)
#
pca5 = function(data)
{
    PC = prcomp(data, center=T, scale=F)

    # Zufgriff auf Ergebnisse
    #     Achtung: Verwendung der SVD => Singulärwerte müssen quadriert werden
    #     optional: Eleminieren der colnames (sind bei Weiterverarbeitung
    #               irreführend)
    values = (PC$sdev)^2;
    # colnames(values) = NULL
    vectors = PC$rotation;
    # colnames(vectors) = NULL
    
    P = list("values" = values , "vectors" = vectors, "mean" = PC$center)
    return(P)
}



# Testen ob alle Varianten das gleiche Ergebnis liefern anhang von
# einer zufällig erstellten Matrix
#

# Generiere Zufallsmatrix
X = replicate(5, rnorm(3))

# Aufruf der zuvor definierten Funktionen
P1 = pca1(X)
P2 = pca2(X)
P3 = pca3(X)
P4 = pca4(X)
P5 = pca5(X)
