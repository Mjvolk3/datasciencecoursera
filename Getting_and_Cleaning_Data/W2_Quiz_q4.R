#Week 2 Quiz q4
library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
# html <- htmlTreeParse(url, useInternalNodes = TRUE)
# rootNode <- xmlRoot(html)
html_lines <- readLines(url)
print(c(nchar(html_lines[10]), nchar(html_lines[20]), nchar(html_lines[30]), nchar(html_lines[100])))
