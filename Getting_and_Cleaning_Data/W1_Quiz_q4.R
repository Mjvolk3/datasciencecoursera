#W1 Quiz q4

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
fileCurl <- getURL(fileUrl)
doc <- xmlTreeParse(fileCurl, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
sum(xpathSApply(rootNode,"//zipcode",xmlValue) == 21231)