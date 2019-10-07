# killer_yeast_pheno.R
# This R script generates a heatmap representing phenotype data from different yeasts
# with a cladogram on the axes, representing how the data clusters (not phylogeny).

# Remove any previous data from the environment.
remove(list=ls())     
# Set your working directory where your files are located.
setwd('~/Downloads')   

# Open necessary libraries.
library (gplots)
# If not "found" by R, install library with command: install.packages('gplots')

# Read data from pre-formatted dataset.
killerToxin <- read.csv('killer_yeast_pheno.csv', header = TRUE)

# Store lawn strain names and killer strain names as variables.
lawnNames <- as.character(killerToxin[,1])
killerNames <- as.character(colnames(killerToxin))
killerNames <- killerNames[2:11]

# Create matrix. 
# Note: make sure the number of matrix row/column names suit the matrix dimensions)
killerMatrix <- as.matrix(killerToxin[, 2:11])
  # Label the columns and rows with the previously saved names.
rownames(killerMatrix) <- lawnNames
colnames(killerMatrix) <- killerNames

# Choose the colors for the heatmap.
# See website for color cheatsheet: https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf
# 7 indicates how many different color values to include and "YlGnBu" is the Palette.
myPalette <- RColorBrewer::brewer.pal(7,"YlGnBu")

# Plot default heatmap cladogram.
heatmap.2(killerMatrix, trace = 'none', margins = c(9, 9), col = myPalette, 
          key = FALSE)

# Plot Heatmap cladogram with dendrogram only on lawn strains
# and killer strains are in original list order.
heatmap.2(killerMatrix, dendrogram = c("col"), Rowv = FALSE, Colv = TRUE,
          trace = 'none', margins = c(9, 9), col = myPalette, key = FALSE)

