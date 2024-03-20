create or replace procedure i213_clcintrest()
language 'plpgsql'
as 
$body$
declare
curs_acc cursor for select accno,opdate from i213_accounts;
accid int;
opdt date;
intre decimal(10,2);
minbal decimal(10,2);
stdt date:=date(current_date-interval '6months');
endt date=date(current_date)
begin
open curs_acc;
loop
fetch curs_acc into accid,opdt;
exit when not found;
for i in  1.. 6 loop
select i213_getminbalformnt(accid,stdt+interval i-1||'months',stdt+interval i||'months') into minbal;
cal

end loop;

end;
$body$
