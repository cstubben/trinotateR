# source("~/plague/genome/plants/trinotateR/R/split_blast.R")

split_blast <- function(x, hit = "TrEMBL_Top_BLASTX_hit"){
   y <- x[!is.na( get(hit) ), .( get(hit), gene_id, transcript_id, prot_id) ]

   # split multiple annotations in backtick-delimited list
   z <- strsplit(y$V1, "`" )
   n <- sapply(z, length)
   # and then split BLAST annotation into 7 columns

   z <- strsplit( unlist(z), "\\^" )
  # first two columns are identical 
  if(  any(sapply(z, "[", 1) != sapply(z, "[", 2)  ) ) print("WARNING: check different values in columns 1 and 2")

      NAME <- gsub("^RecName: Full=", "", sapply(z, "[", 6) )
      NAME <- gsub("SubName: Full=", "", NAME )
      NAME <- gsub(";$", "", NAME )
   #   drop {ECO:0000256|RuleBase:RU361189} from names
     NAME <- gsub(" \\{[^}]+}", "", NAME)

   x1 <- data.frame(  gene = rep(y$gene_id, n), 
                transcript = rep(y$transcript_id, n) ,  
                   protein = rep(gsub(".*\\|", "", y$prot_id), n),
                   uniprot = sapply(z, "[", 1) , 
                     align = sapply(z, "[", 3) , 
                   identity = as.numeric( gsub( "%ID", "", sapply(z, "[", 4))) , 
                    evalue = as.numeric(gsub("E:", "", sapply(z, "[", 5) )), 
                      name = NAME, 
                  lineage = sapply(z, "[", 7) , 
                   domain = gsub( "; .*", "", sapply(z, "[", 7) ) , 
                    genus = gsub( ".*; ", "", sapply(z, "[", 7) ) , 
           stringsAsFactors=FALSE )
    message(nrow(x1), " ", hit, " annotations")
    data.table(x1)
}

