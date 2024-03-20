create or replace function i213_getblncfordt(accid int,dt date)
returns decimal(10,2)
language 'plpgsql'
as
$body$
declare 
availbal decimal(10,2);
totdep decimal(10,2);
totwith decimal(10,2);
begin 
select balance into availbal from i213_accounts where accno=accid;
select coalesce(sum(amount),0) into totdep from i213_transactions where accno=accid and tr_type in('d','D') and tr_date between dt and current_date;
select coalesce(sum(amount),0) into totwith from i213_transactions where accno=accid and tr_type in('w','W') and tr_date between dt and current_date;
return avilbal+totwith-totdep;
end;
$body$