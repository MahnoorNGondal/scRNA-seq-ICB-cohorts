# scRNA-seq-ICB-cohorts
This repository contained single-cell RNA-seq datasets with ICB treated patients
Currently, the following studies have been curated to devise this data. 
![V2 of Figure_01 Data descriptor - revised](https://github.com/user-attachments/assets/b7fc1077-2415-4a51-9fd6-50f004c9c519)





![image](https://github.com/user-attachments/assets/f7c541fe-5cc8-4d0c-bfdf-9b557275e4b5)






Link to the data above: [https://docs.google.com/spreadsheets/d/17JrD1BEhG1CxLW1HvA_SUlu-uI8ki0Xbyro2qTLvBeU/edit#gid=0](https://docs.google.com/spreadsheets/d/1p9mGcxFW5MZlJvQWdcDZOCvBmMDjCNp07g8mlPMdK6s/edit?gid=0#gid=0)

The pseudobulk data can be analyzed using Rshiny app: [https://scrnaseqicb.shinyapps.io/icbsc_pseudobulk_v12/](https://scrnaseqicb.shinyapps.io/iscsc_pseudobulk_v12/)

**ShinyCell Applications**
- All cells
https://scrnaseqicb.shinyapps.io/06_shinycell_all/
- Malignant cells only
https://scrnaseqicb.shinyapps.io/shinyapp/

### Requirements
In order to run the Rmd files, you will need to install the following dependencies:
(please use R version 4.1.1)

- library(Seurat) -  v4.1.1
- library(SeuratDisk) - v0.0.0.9020
- library(ggplot2) - v3.3.6
- library(dplyr) - v1.0.9
- library(tidyr) - v1.2.0
- library(ggpubr) - v0.4.0
- library(shiny) - v1.7.1
- library(shinythemes) - v1.2.0
- library(shinyFiles) - 0.9.2
- library(rsconnect) - v1.1.0.9000
- library(googledrive) - v2.0.0
- library(stats) - v4.1.1
- library(DoubletFinder) - v2.0.3
- library(RColorBrewer) - v1.1-3
- library(data.table) - v1.14.2
