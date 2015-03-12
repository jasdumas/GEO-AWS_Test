# Google Summer of Code test for GEO analysis with Shiny Project
# Jasmine Dumas (@jasdumas)
# 11 March 2015

library(GEOquery)
library(pheatmap)
library(RColorBrewer)

########################################################
# get series GSE13 from the Gene Expression Omnibus
########################################################

GSE13 = getGEO("GSE13")
GSE13
########################################################
# get the gene expression table
########################################################
GSE13.expr = exprs(GSE13[[1]])
head(GSE13.expr)

### creating a heatmap is an informative way to view large tables
col.pal <- brewer.pal(9,"Blues")
expr.heatmap <- pheatmap(mat = GSE13.expr, color = col.pal)

########################################################
# get the phenotypic/clinical data
########################################################
GSE13.p = pData(phenoData(GSE13[[1]]))
head(GSE13.p)

