
# source("~/plague/genome/plants/trinotateR/R/top_table.R")

# y <- strsplit(x$gene_ontology_blast, "`")
# y <- strsplit(y, "\\^" )

top_table <- function(x, column, by,  n=10, position, pattern, replace, split1="`", split2="\\^" ){

  if(!missing(by)){
      x <- unique( x[!is.na( get(column)), c(column, by), with=FALSE ] )
      y <- x[,get(column)]    # in case column is a number...
   }else{
      y <-x[!is.na( get(column)), get(column)]
   }
   # skip splitting eggnog and blast with only 1 entry
   if( any(grepl("`", y))){
      y <- strsplit(y, split1 )
      y <- unlist(y)
   }

  if(!missing(position)){
      y <- strsplit(y, split2 )
      y <- sapply(y, "[", position) # will return NA is missing and "[[" returns error
  }
  if(!missing(pattern)) y <- y[grepl(pattern, y)]
  if(!missing(replace)) y <- gsub( replace, "", y)
 

  data.frame(total= sort(table( y ), decreasing=TRUE)[1:n])
}
