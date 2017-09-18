
-- select for join with get_all_hour_q table 
select case when count is null then 0 else count end as count, 
  all_hour_q.hour_q, hour_num from 
(
-- aggregate call_time to count 
select count(*) as count, hour_q
  --, dow  
from 
(
select hour_12 || quarter_of_hour as hour_q, 
  --dow, 
  call_time

from (

  select 
    hour, 
    case 
      when hour > 12 then (hour - 12) || ' PM '
      else hour || ' AM '
      end as hour_12,
    minute, 
    case 
      when minute >= 0 and minute < 15 then 'Q1'
      when minute >= 15 and minute < 30 then 'Q2'
      when minute >= 30 and minute < 45 then 'Q3'
      when minute >= 45 and minute < 60 then 'Q4'
      else 'QQ'
      end as quarter_of_hour,
    --dow, 
    call_time

  from 

  (
    select 
      date_part('hour', call_time) as hour, 
      date_part('minute', call_time) as minute, 
      date_part('dow', call_time) as dow, 
      call_time  from call_history
      where call_time > '2016-07-01'
  ) as call_time_tbl

) as call_time_tbl2
) as call_time_tbl3
group by hour_q --, dow
order by hour_q
) as call_time_result 
-- join all_hour_q table 
right join 
(
  select hour_table.hour || ' ' || quarter_table.quarter as hour_q, hour_table.hour_num from 
  (
    select case when hour <= 12 then hour || ' AM' else hour - 12 || ' PM' end as hour, hour as hour_num from 
    (
      select * from generate_series(10,22) hour
    ) as hour_num_table
  ) as hour_table 
  left join 
  (select 'Q' || q_num as quarter from generate_series(1,4) q_num)
  as quarter_table
  on 1 = 1
) as all_hour_q
on call_time_result.hour_q = all_hour_q.hour_q
order by hour_num, hour_q