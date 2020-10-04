#!/usr/bin/env Rscript

main <- function() {
  
  ## load libraries
  packages = c('gplots','stringr')
  # check.packages function: install and load multiple R packages.
  # Check to see if packages are installed. Install them if they are not, then load them into the R session.
  check.packages <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg)) 
      install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
  }
  msg.trap <- capture.output( suppressMessages( check.packages(packages)) ) # silent mode
  
  ##################### PARSE ARGUMENTS #####################
  args = commandArgs(trailingOnly = TRUE)
  
  ## input data (argument #1, required)
  file = args[1] 
  
  # graph height option (argument #2)
  if (is.na(args[2])==FALSE){
    grheight = as.numeric(args[2])
  } else {
    grheight = 10
  }
  
  # graph width option (argument #3)
  if (is.na(args[3])==FALSE){
    grwidth = as.numeric(args[3])
  } else {
    grwidth = 10
  }
  
  # output option (argument #4)
  if (is.na(args[4])==FALSE){
    if ( args[4]=="pdf") {
      pdf("killer_assay_heatmap.pdf", width=grwidth, height=grheight)
    } else if ( args[4]=="png") {
      png("killer_assay_heatmap.png", width=grwidth, height=grheight, units="in", res=120)
    } else if ( args[4]=="tiff") {
      tiff("killer_assay_heatmap.tiff", width=grwidth, height=grheight, units="in", res=120)
    } else {
      jpeg("killer_assay_heatmap.jpeg", width=grwidth, height=grheight, units="in", res=120)
    } 
  } else {
    jpeg("killer_assay_heatmap.jpeg", width=grwidth, height=grheight, units="in", res=120)
  }
  
  # number of toxin categories option (argument #5)
  if (is.na(args[5])==FALSE){
    toxcat = as.numeric(args[5])
    myPalette = RColorBrewer::brewer.pal(toxcat,"YlGnBu")
    # Website for colors: https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf
  } else {
    toxcat = 2
    myPalette = c('oldlace','lightblue')
  }
  
  #****************** MAIN SCRIPT *******************
  
  ## Read data from pre-formatted dataset.
  killerToxin = read.csv(file, header = FALSE, na.strings=c("","NA"))
  
  # Store lawn strain names and killer strain names as variables
  lawnNames = as.character(killerToxin[,1][-1])
  killerNames = as.character(killerToxin[1,][-1])
  
  # Create matrix so that heatmap.2 will work 
  numdata = killerToxin[c(-1)] # delete first column
  numdata = numdata[-1,] # delete fiirst row
  numdata = as.data.frame(lapply(numdata, as.numeric))
  killerMatrix = as.matrix(numdata)
  rownames(killerMatrix) = lawnNames
  colnames(killerMatrix) = killerNames
  
  ################ Generate Heatmap cladogram #######################
  heatmap.2(killerMatrix, trace='none', margins=c(12, 12), col=myPalette, key=FALSE,
            xlab='Lawns', ylab="Killers")
  print('Created output file: killer_assay_heatmap.jpeg')
  invisible(dev.off()) 
}

main()