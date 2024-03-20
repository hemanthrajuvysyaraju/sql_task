create or replace function i213_getminbalformnt(accid int,stdt date,endt date)
returns decimal(10,2)
language 'plpgsql'
as
$body$
declare
iter_curs cursor for select 
case 
when tr_type in('d','D') then amount
when tr_type in ('w','W') then -amount 
end 
from i213_transactions where accno=accid and tr_date between stdt and endt;
stbal decimal(10,2);
tranbal decimal(10,2);
minbal decimal(10,2);
begin
select i213_getblncfordt(accid,stdt) into stbal;
minbal:=stbal;
open iter_curs;
loop
fetch iter_curs into tranbal;
exit when not found;
stbal:=stbal+tranbal;
raise notice '%',minbal;
raise notice '%',stbal;
if(minbal>stbal)then
minbal:=stbal;
end if;
end loop;
return minbal;
end;
$body$