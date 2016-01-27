# source("~/plague/genome/plants/trinotateR/R/summary_GO.R")

summary_GO <- function(x){
   uniq <-  c( GO = uniqueN(x$go),  genes=  uniqueN(x$gene), transcripts = uniqueN(x$transcript), proteins = uniqueN(x$protein) )
   y <- x[,.( genes=uniqueN(gene), transcripts=uniqueN(transcript), proteins = uniqueN(protein), total =.N ), by=.(go, ontology, name) ]
 
   y <- y[order(-y$genes, tolower(y$name)),]

   annot <- colSums(y[, .(total, genes, transcripts, proteins) ])  
   z <-  cbind(unique=uniq, annotations= annot) 
   attr(y, "counts") <- z
   message(nrow(y), " rows")
   y
}

