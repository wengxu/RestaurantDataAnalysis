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
vDays = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", 
    "Friday", "Saturday")

for (i in 0:6) {
  #sql_str = "select count(*) from call_history"
  sql_str = paste(readLines("get_hour.sql"), collapse="\n")
  # set day of week 
  new_dow = i
  sql_str = gsub(pattern='\\{\\{dow\\}\\}', replacement=new_dow, sql_str)
  rs <- dbSendQuery(conn, sql_str)
  result_df = fetch(rs,n=-1)
  hour_q_vector = result_df[['hour_q']]
  count_vector = result_df[['count']]

  main_title = 'Call Count vs Time' 
  if (new_dow >= 0 && new_dow <= 6) {
    main_title = paste( main_title, 'on', vDays[new_dow+1])
  }
  pdf_name = paste('results/',vDays[new_dow+1], '.pdf', sep='')
  pdf(pdf_name) 
  x_pos <- barplot(count_vector,names.arg = hour_q_vector,
    main=main_title,
    xlab='Time', ylab='Call Count',
    cex.names= 0.5, las=2, width =0.85)
  text(x=x_pos,y=(count_vector+1),label=hour_q_vector,srt=90,cex=0.6)
  #write.csv(result_df, 'cal_hour_q.csv')
  dev.off()

}