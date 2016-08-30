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
biocLite("gageData")
biocLite("KEGG.db")
library(gage)
library(gageData)
library(KEGG.db)

setwd("./")

# demo
data("kegg.sets.ko")
data("sigmet.idx.ko")
kegg.sets.ko = kegg.sets.ko[sigmet.idx.ko]
head(kegg.sets.ko, 3)

#test 

res<-read.table("inpu_file.txt", header=T)
rownames(res) <- res[,1]
res[,1]<- NULL

foldchanges = res$log2FoldChange
names(foldchanges) = res$entryko
head(foldchanges)

#get the results
keggres = gage(foldchanges, gsets=kegg.sets.ko, same.dir=TRUE)
lapply(keggres, head)

head(keggres$greater)
#get the pathways
keggrespathways = data.frame(id=rownames(keggres$greater), keggres$greater) %>% 
  tbl_df() %>% 
  filter(row_number()<=5) %>% 
  .$id %>% 
  as.character()
keggrespathways

#plot
pathview(gene.data=foldchanges, pathway.id="ko04150", species="ko", new.signature=FALSE)

# Get the IDs.
keggresids = substr(keggrespathways, start=1, stop=8)
keggresids
