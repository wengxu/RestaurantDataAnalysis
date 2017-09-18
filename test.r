# get hourly call bar chart from call data 
#library(RPosgreSQL)
library(RPostgreSQL)
"h <- c(1,1,3,4,5,6, 7, 8, 9, 10)
counts <- table(h)
print(counts)
barplot(counts)
"

print('hello')

#print(available.packages())
drv <- dbDriver("PostgreSQL")
conn <- dbConnect(drv, dbname="restaurant", host="/tmp")
rs <- dbSendQuery(conn, "select count(*) from call_history")
typeof(fetch(rs,n=-1))