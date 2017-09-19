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
#sql_str = "select count(*) from call_history"
sql_str = paste(readLines("get_hour.sql"), collapse="\n")
rs <- dbSendQuery(conn, sql_str)
result_df = fetch(rs,n=-1)

write.csv(result_df, 'cal_hour_q.csv')