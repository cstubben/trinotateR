\name{cogs}
\alias{cogs}
\docType{data}
\title{ COG classes and colors }
\description{ COG function classes and color scheme  }
\usage{data("cogs")}
\format{
  A data frame with 26 observations on the following 3 variables.
  \describe{
    \item{\code{code}}{code}
    \item{\code{name}}{function}
    \item{\code{clrs}}{color}
  }
}
%%\details{ }
\source{ COG function names at \url{ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/data/fun2003-2014.tab} and colors at 
\url{ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/static/lists/homeCOGs.html}

}
%%\references{ }
\examples{
data(cogs)

\dontrun{
## Code to create this table
cogs <- read.delim("ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/data/fun2003-2014.tab", stringsAsFactors = FALSE, comment="")
names(cogs) <- c("code", "name")
library(XML)
doc <- htmlParse(readLines("ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/static/lists/homeCOGs.html", n=44))
cogs$clrs <- xpathSApply(doc, "//table[@border='0']/tr/td", xmlGetAttr, "bgcolor")
}

}
\keyword{datasets}
