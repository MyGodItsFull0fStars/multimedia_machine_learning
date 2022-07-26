# Close all graphics windows and clear all variables
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


# Init random test data
#
x <- rbind(
matrix(rnorm(100, sd = 0.2), ncol = 2),
matrix(rnorm(100, mean = 1, sd = 0.2), ncol = 2),
matrix(rnorm(100, mean = -1, sd = 0.2), ncol = 2),
matrix(c(rnorm(100, mean = 1, sd = 0.2),
rnorm(100, mean = -1, sd = 0.2)), ncol = 2),
matrix(c(rnorm(100, mean = -1, sd = 0.2),
rnorm(100, mean = 1, sd = 0.2)), ncol = 2))
colnames(x) <- c("x", "y")


# Berechne Ähnlichkeitsmatrix 
# (negative quadrierte euklidsche Distanz)
#
sim <- negDistMat(x, r=2)


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


# Plot the results
#
plot(AC,x)

