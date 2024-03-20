create or replace procedure i213_dotransaction(accid int,trtyp char,amt decimal(10,2))
language 'plpgsql'
as
$body$
declare 
bal decimal(10,2);
begin
select balance into bal from i213_accounts;
if bal-amt>0 then
if trtype in('w','W') then
update i213_accounts set balance=bal-amt;
insert into i213_transactions values(accid,trtype,current_date,amt);
end if;
end if;
if trtype in ('d','D') then 
update i213_accounts set balance=bal+amt;
insert into i213_transactions values(accid,trtype,current_date,amt);
end if;
end;
$body$