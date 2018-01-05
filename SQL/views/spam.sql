create or replace view spam 
  as select num, count(*) 
    from call_history 
    where name = 'SUPPORT INT' 
    group by num 
    order by count(*) desc;