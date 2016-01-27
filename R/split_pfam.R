
split_pfam <- function(x){

   y <- x[!is.na(Pfam), .(Pfam, gene_id, transcript_id, prot_id) ]
  # split multiple annotations in backtick-delimited list
   z <- strsplit(y$Pfam, "`" )
   n <- sapply(z, length)
   # and then split annotation into 5 columns
   z <- strsplit( unlist(z), "\\^" )

   # drop transcript from protein?  GG10000|c0_g1_i1|m.81222  = m.81222
   # drop suffix from pfam?  PF02586.9 = PF02586

   x1 <- data.frame(  gene = rep(y$gene_id, n), 
                transcript = rep(y$transcript_id, n) ,  
                   protein = rep(gsub(".*\\|", "", y$prot_id), n),
                      pfam = gsub("\\.[0-9]*", "", sapply(z, "[", 1)) , 
                    symbol = sapply(z, "[", 2) , 
                      name = sapply(z, "[", 3) , 
                     align = sapply(z, "[", 4) , 
                    evalue = as.numeric(gsub("E:", "", sapply(z, "[", 5) )), 
           stringsAsFactors=FALSE )
    message(nrow(x1), " Pfam annotations")
    data.table(x1)
}
