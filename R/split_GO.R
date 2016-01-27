
split_GO <- function(x, hit = "gene_ontology_blast"){
   y <- x[!is.na( get(hit) ), .( get(hit), gene_id, transcript_id, prot_id) ]

   # split multiple annotations in backtick-delimited list
   z <- strsplit(y$V1, "`" )
   n <- sapply(z, length)
   # and then split GO annotation into 3 columns

   z <- strsplit( unlist(z), "\\^" )
 
   x1 <- data.frame(  gene = rep(y$gene_id, n), 
                transcript = rep(y$transcript_id, n) ,  
                   protein = rep(gsub(".*\\|", "", y$prot_id), n),
                   go = sapply(z, "[", 1) , 
             ontology = sapply(z, "[", 2) , 
                 name = sapply(z, "[", 3) , 
           stringsAsFactors=FALSE )
    message(nrow(x1), " ", hit, " annotations")
    data.table(x1)
}

