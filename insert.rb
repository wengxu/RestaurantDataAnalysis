require 'pg'
require './call_history.rb'

conn = PG::Connection.open(:dbname => 'restaurant')
#res = conn.exec('SELECT 1 AS a, 2 AS b, NULL AS c')
#res = conn.exec('select * from call_history')
=begin
call_history = Call_history.new({})
call_history.call_type = 'Received'
call_history.name = 'WIRELESS CALLER'
call_history.num = '615-428-6129'
call_history.call_time = '1999-03-01'
call_history.length = '0:25'
=end 
call_history = Call_history.new({
  "Call Type"=>"Received", 
  "Name"=>"WIRELESS CALLER", 
  "Number"=>"615-428-6129", 
  "When"=>"06-02-17, 10:06 PM", 
  "Length"=>"0:25"
})


def insert_call_history(conn, call_history) 
  call_type = call_history.call_type
  name = call_history.name
  num = call_history.num 
  call_time = call_history.call_time
  length = call_history.length
  params = [call_type, name, num, call_time, length, num, call_time]
  query = "insert into call_history (call_type, name, num, call_time, length) 
  select $1, $2, $3, $4, $5
  where not exists (select 1 from call_history where num = $6 and call_time = $7);"
  conn.exec_params(query, params)
end 
#params = ['Received', 'WIRELESS CALLER', num, call_time, '0:25', num, call_time]

#res = conn.exec_params(query, params)
#puts insert_call_history(conn, call_history).cmd_tuples()

