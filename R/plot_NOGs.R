
plot_NOGs<-function(x, by="gene_id"){

   if(by == "transcript_id"){
      y <- unique(x[!is.na(eggnog), .(transcript_id, eggnog)])
      xlabel <- "Number of transcripts"
   }else{
      y <- unique(x[!is.na(eggnog), .(gene_id, eggnog)])
      xlabel <- "Number of genes"
   }
   nogs <- gsub("(.*)\\^.*", "\\1", y$eggnog)
   n <- match(nogs, egg$nog)
   y <- table( unlist( strsplit(egg$class[n], "")) )
   y1 <-rev( y[ order( match(names(y) , cogs$code) ) ] )
   # optional -  drop function unknown if too many
   y1 <- y1[-1]
   n <- match(names(y1) , cogs$code)
   op <- par(mar=c(4,25, 1,1), mgp=c(2,.5,0) )
     barplot(y1, col= cogs$clrs[n], horiz=TRUE, names.arg=paste(cogs$code[n], cogs$name[n], sep=". "), las=1, xlab= xlabel)
   par(op)


}

