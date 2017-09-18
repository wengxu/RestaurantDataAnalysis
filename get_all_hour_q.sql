--select * from crosstab('select 1,2,3') --as ct(col1, TEXT);
--select m from generate_series('a','b') m
--select * from crosstab(1,2,3) as (col1, NUMBER);

-- create hours 

-- create hour in am and pm 
/*
select case when hour <= 12 then hour || ' AM' else hour - 12 || ' PM' end from (
select * from generate_series(1,24) hour
) as hour_num_table; 
*/
-- tmp for example 
/*
select hour from (
select * from generate_series(1,5) hour
) as hour_table; 
*/

-- create quarter table 
/*
select 'Q' || quarter from generate_series(1,4) quarter;
*/
-- select quarter for each hour 

select hour_table.hour || ' ' || quarter_table.quarter from (
  select case when hour <= 12 then hour || ' AM' else hour - 12 || ' PM' end as hour from 
  (
    select * from generate_series(10,22) hour
  ) as hour_num_table
) as hour_table 
  left join 
  (select 'Q' || q_num as quarter from generate_series(1,4) q_num)
  as quarter_table
  on 1 = 1
  ; 

-- join with get_hour sql 
/*
SELECT * 
FROM crosstab( 'select student, subject, evaluation_result from evaluations 
                where extract (month from evaluation_day) = 7 order by 1,2',
                'select name from subject order by 1') 
     AS final_result(Student TEXT, Geography NUMERIC,History NUMERIC,Language NUMERIC,Maths NUMERIC,Music NUMERIC);

*/