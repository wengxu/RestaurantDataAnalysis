create or replace view spam 
  as select num, count(*) 
    from call_history 
    where name = 'SUPPORT INT' 
      or num = '614-907-7296'
    group by num 
    order by count(*) desc;