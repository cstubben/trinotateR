# source("~/plague/genome/plants/trinotateR/R/read_trinotate.R")

read_trinotate <- function( file){
   x <- read.delim( file, comment="", stringsAsFactors=FALSE, na.string=".")
   message("Read ", nrow(x), " rows")
   # replace X.gene_id  since names in row 1 start with # 
   names(x)[1] <- "gene_id"
   # empty columns
   n <- apply(x, 2, function(y) all(is.na(y)) )
   if( sum(n) > 0) message("Empty columns: ", paste(names(n[n]), collapse=", ") )

   # rearrange so gene, transcript and protein id are together?
   x <- x[, c(1:2, 6:7, 3:5, 8:17)] 
# or switch to fread instead of read.delim
   x <- data.table(x, key=c("gene_id", "transcript_id") )
  x
}


