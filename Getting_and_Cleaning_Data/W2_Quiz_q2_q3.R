#Week 2 Quiz q2_q3

acs <- read.csv("delete_download.csv")

# sqldf("select * from acs where AGEP < 50")
# sqldf("select pwftp1 from acs")
# sqldf("select * from acs")
sqldf("select pwgtp1 from acs where AGEP < 50")

#q3 

# unique(acs$AGEP) == sqldf("select AGEP where unique from acs")
# unique(acs$AGEP) == sqldf("select unique * from acs")
# unique(acs$AGEP) == sqldf("select distinct pwgtp1 from acs")
unique(acs$AGEP) == sqldf("select distinct AGEP from acs")
                          
