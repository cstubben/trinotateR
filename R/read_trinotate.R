read_trinotate <- function(file, ...){
   ## suppress fread warning messages like Bumped column 5 to type character 
   x <- suppressWarnings( fread(file, sep="\t", na.strings=".", ...) )
   # message("Read ", nrow(x), " rows")
   # replace "#gene_id"  since names in row 1 start with # 
   names(x)[1] <- "gene_id"
   setkeyv(x, c("gene_id", "transcript_id") )
   x
}


