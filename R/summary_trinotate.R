
# source("~/plague/genome/plants/trinotateR/R/summary_trinotate.R")

summary_trinotate <- function(x){
   #UNIQUE
   x1 <- x[,lapply(.SD, function(x) uniqueN(na.omit(x)) ),]
   # total
   x4 <- x[,lapply(.SD, function(x) sum(!is.na(x))) ]
  y <- data.frame(t( rbind(x1, x4)) )   
   names(y) <- c("unique", "total")

   y <- subset(y, total > 0)
   y <- y[order(y$total, decreasing=TRUE),]
   y
}
