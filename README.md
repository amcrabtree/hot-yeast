hot-yeast_CL.R
------------------
This R script should produce a nice heatmap cladogram of yeast killer strains vs. lawns. The default plot makes cladograms of x- and y- axes and rearranges both killer strains and lawns into clades with the information given (NOT phylogeny). You can streamline the graph by not allowing it to reorder lawns or killers, or taking away the cladogram on either axis. 

<b>Dependencies</b>
* [R](https://www.r-project.org/), [zenity](https://linuxconfig.org/how-to-use-graphical-widgets-in-bash-scripts-with-zenity)

Downloading zenity

&nbsp;&nbsp;&nbsp;&nbsp;MacOS using [Homebrew](https://formulae.brew.sh/formula/zenity):
```
brew install zenity
```
&nbsp;&nbsp;&nbsp;&nbsp;Linux (or windows users using [Ubuntu](https://zoomadmin.com/HowToInstall/UbuntuPackage/zenity) app):
```
sudo apt-get update -y
sudo apt-get install -y zenity
```
<p>&nbsp;</p>

<b>Zenity Usage</b>
- Right click on file ("hot-yeast_zenity") and open with Terminal (MacOS) or Ubuntu app (Windows)
<p>&nbsp;</p>

<b>CLI Usage</b>
```
Rscript hot-yeast_CL.py KILLER_DATA.csv hot-yeast_data.csv
```
<p>&nbsp;</p>

<b>Options</b>
argument | description
------------ | -------------
[ARG1]	| (required) data file; must be in CSV format 
[ARG2]	| height of output graph, in inches (default=10)
[ARG3]	| width of output graph, in inches (default=10)
[ARG4]	| type of output graph (default=jpg): <i>jpg, pdf, png, tiff</i>
[ARG5]	| number of killing categories (default=2); ex: 2 if only kill or not kill


<p>&nbsp;</p>

* Default Graph

<img src="https://raw.githubusercontent.com/amcrabtree/hot-yeast/master/images/killer_assay_heatmap.jpeg" alt="drawing" width="500"/>

* Graph with 7 killing categories

<img src="https://raw.githubusercontent.com/amcrabtree/hot-yeast/master/images/killer_assay_heatmap_7.jpeg" alt="drawing" width="500"/>


<b>Examples</b>

change dimensions to height of 6", width of 5", with 7 different killing category assignments
```
Rscript hot-yeast_CL.py hot-yeast_data.csv 6 5 jpeg 7
```

default dimensions with 4 different killing categories
```
Rscript hot-yeast_CL.py hot-yeast_data.csv 10 10 jpeg 4
```

change output to pdf filetype
```
Rscript hot-yeast_CL.py hot-yeast_data.csv pdf
```
