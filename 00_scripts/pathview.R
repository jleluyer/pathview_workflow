#### PATHVIEW ####

#Install
source("http://bioconductor.org/biocLite.R")
biocLite("AnnotationDbi")
library(AnnotationDbi)
biocLite("org.Hs.eg.db")
biocLite("pathview")
install.packages("httr")
library(pathview)
library('org.Hs.eg.db')
biocLite("gage")
library("dplyr")
biocLite("gageData")
biocLite("KEGG.db")
library(gage)
library(gageData)
library(KEGG.db)


# demo
data("kegg.sets.ko")
data("sigmet.idx.ko")
kegg.sets.ko = kegg.sets.ko[sigmet.idx.ko]
head(kegg.sets.ko, 3)

#test 

res<-read.table("02_data/input_file.txt", header=T)
rownames(res) <- res[,1]
res[,1]<- NULL

foldchanges = res$logFC
names(foldchanges) = res$entryko
head(foldchanges)

#get the results
keggres = gage(foldchanges, gsets=kegg.sets.ko, same.dir=TRUE)
lapply(keggres, head)
head(keggres$greater)

#plot
#Adapt limit for the limit logFC of your data
pathview(gene.data=foldchanges, pathway.id="ko04150", species="ko", limit=list(gene=10, cpd=10),bins = list(gene = 10, cpd = 10), species="ko",low = list(gene = "dodgerblue4", cpd = "dodgerblue4"),high = list(gene = "yellow", cpd = "yellow"), new.signature=FALSE)

# Get the IDs.
keggresids = substr(keggrespathways, start=1, stop=8)
keggresids
