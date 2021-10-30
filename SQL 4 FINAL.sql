use bank;

#Query 1
select client_id, district_id from client
where district_id = '1'
limit 5;

#Query 2
select client_id, district_id from client
where district_id = '72'
order by client_id desc
limit 1;

#Query 3
select (amount) from loan
order by amount asc
limit 3;

#Query 4
select distinct(status) from loan
order by status asc;

#Query 5
select loan_id, payments from loan
where status = 'A'
order by payments desc;

#Query 6
select amount, account_id from loan
order by account_id asc
limit 5;

#Query 7
select account_id from loan
where duration = '60'
order by amount asc;

#Query 8
select distinct(k_symbol) from bank.order;

#Query 9
select order_id from bank.order
where account_id ='34';

#Query 10
select distinct(account_id) from bank.order
where order_id between '29540' and '29560';

#Query 11
select sum(amount) from bank.order
where account_to = '30067122';

#Query 12
select trans_id, date, type, amount from trans
where account_id = '793'
order by date desc
limit 10;

#Query 13
select district_id, count(client_id) as client_nb from client
where district_id < '10'
group by district_id
order by district_id asc;

#Query 14
SELECT DISTINCT type, count(*) AS counter
FROM card
GROUP BY type;

#Query 15
SELECT account_id, sum(amount)
FROM loan
GROUP BY account_id
order by sum(amount) desc;

#Query 16
select count(loan_id) from loan
where loan_id < '930907'
group by date
order by date desc;

#Query 17
select date, duration, count(loan_id) AS counter
from loan
where date like '%9712%'
group by date, duration
order by date asc, duration asc;

#Query 18

select account_id, type, sum(amount)
from trans
where account_id ='396'
group by type;


#Query 19
select account_id,
(case
	when type = 'PRIJEM' then 'Incoming'
	when type = 'VYDAJ' then 'Outgoing'
    else 'NA'
    end) as type,
round(sum(amount)) as sum_amount
from trans
where account_id ='396'
group by
case
	when type = 'PRIJEM' then 'Incoming'
	when type = 'VYDAJ' then 'Outgoing'
    else 'NA'
    end;

#Query 20

select account_id,
round(sum(case when type = 'VYDAJ' then amount else 0 end)) as 'outgoing',
round(sum(case when type = 'PRIJEM' then amount else 0 end)) as 'incoming',
round(sum(case when type = 'VIDAJ' then amount else 0 end) - sum(case when type = 'PRIJEM' then amount else 0 end)) as 'Balance'
from trans
where account_id ='396';

#Query 21

select account_id,
round(sum(case when type = 'VIDAJ' then amount else 0 end) - sum(case when type = 'PRIJEM' then amount else 0 end)) as 'Balance', 
rank () over(order by round(sum(case when type = 'VIDAJ' then amount else 0 end) - sum(case when type = 'PRIJEM' then amount else 0 end)) desc) as ranking
from trans
group by account_id
limit 10;

