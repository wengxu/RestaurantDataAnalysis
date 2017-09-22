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
hour_q_vector = result_df[['hour_q']]
count_vector = result_df[['count']]

x_pos <- barplot(count_vector,names.arg = hour_q_vector, 
  xlab='Time', ylab='Call Count',
  cex.names= 0.5, las=2, width =0.85)
text(x=x_pos,y=(count_vector+7),label=hour_q_vector,srt=90,cex=0.6)
#write.csv(result_df, 'cal_hour_q.csv')

