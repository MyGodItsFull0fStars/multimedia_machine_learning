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


# Load paclage for K-Medoids
#
require(cluster)



# Define simple function to plot a vector as an image
#
showImage = function(M, rows, cols)
{
    image(matrix(M, cols, rows, T)[,rows:1], axes = FALSE, col = grey(seq(0, 1, length = 256)))
}



# Load Coil data
# 
load("coil.rdata")



# Geneate training data: extract subset consiting of 16 objetcs (72 image each)#

idx = c()

# wähle je 10 Beispiele pro Klasse
for (i in 1:10)
{
    tmp = seq(i,1152,72)
    idx = c(idx, tmp)
}

idx = sort(idx)
train = data[idx,] 


# Show data

dev.new(width=12, height=3)
par(mfrow = c(2, 8), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))

for (i in 1:16)
{
     showImage(train[(i-1)*10+1,], 64, 64)
}

title("Trainingsdaten: 16 Klassen", outer=T, cex.main=2,font=2)




# K Medoids Clustering
#
num_cluster = 5  # max. 24 clusters (just for visualization)
PAM = pam(train, num_cluster)


dev.new(width=12, height=9/2)
par(mfrow = c(3, 8), oma=c(0,0,2,0), mai = c(0.1, 0.1, 0.1, 0.1))

for (i in 1:num_cluster)
{
     showImage(PAM$medoids[i,], 64, 64)
}

title("Cluster centers K-Medoids", outer=T, cex.main=2,font=2)
