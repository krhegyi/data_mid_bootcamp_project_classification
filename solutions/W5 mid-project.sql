select * from credit_card_classification.credit_card_data;


ALTER TABLE credit_card_classification.credit_card_data	
RENAME COLUMN col_1 TO customer_number,
RENAME COLUMN col_2 TO offer_accepted,
RENAME COLUMN col_3 TO reward,
RENAME COLUMN col_4 TO mailer_type,
RENAME COLUMN col_5 TO income_level,
RENAME COLUMN col_6 TO bank_accounts_open,
RENAME COLUMN col_7 TO overdraft_protection,
RENAME COLUMN col_8 TO credit_rating,
RENAME COLUMN col_9 TO credit_cards_held,
RENAME COLUMN col_10 TO homes_owned,
RENAME COLUMN col_11 TO household_size,
RENAME COLUMN col_12 TO own_your_home,
RENAME COLUMN col_13 TO avg_balance,
RENAME COLUMN col_14 TO balance_q1,
RENAME COLUMN col_15 TO balance_q2,
RENAME COLUMN col_16 TO balance_q3,
RENAME COLUMN col_17 TO balance_q4;

ALTER TABLE credit_card_classification.credit_card_data DROP COLUMN balance_q4;

#set all 0s to NULL then change avg_balance type to INT
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM credit_card_classification.credit_card_data WHERE avg_balance IS NULL OR avg_balance = '';
UPDATE credit_card_classification.credit_card_data
SET avg_balance = NULL WHERE avg_balance = '';
SELECT * FROM credit_card_classification.credit_card_data WHERE avg_balance IS NULL OR avg_balance = '';
ALTER TABLE credit_card_classification.credit_card_data MODIFY COLUMN avg_balance INT;


select * from credit_card_classification.credit_card_data
limit 10;

select count(*) from credit_card_classification.credit_card_data;

select distinct offer_accepted from credit_card_classification.credit_card_data;
select distinct reward from credit_card_classification.credit_card_data;
select distinct mailer_type from credit_card_classification.credit_card_data;
select distinct credit_cards_held from credit_card_classification.credit_card_data order by credit_cards_held;
select distinct household_size from credit_card_classification.credit_card_data order by household_size;

select customer_number, avg_balance
from credit_card_classification.credit_card_data
order by avg_balance DESC
limit 10;

select round(avg(avg_balance),2) as average_customer_balance
from credit_card_classification.credit_card_data;

select round(avg(avg_balance),2) as average_balance, income_level
from credit_card_classification.credit_card_data
group by income_level
order by income_level;

select bank_accounts_open as number_of_bankaccounts, round(avg(avg_balance),2) as average_balance
from credit_card_classification.credit_card_data
group by bank_accounts_open
order by bank_accounts_open;

select credit_rating, avg(credit_cards_held) as average_number_of_credit_card
from credit_card_classification.credit_card_data
group by credit_rating;

select credit_cards_held, sum(bank_accounts_open) as number_of_bank_accounts
from credit_card_classification.credit_card_data
group by credit_cards_held
order by credit_cards_held; #no correlation between credit_cards_held and number_of_bank_accounts

select avg(credit_cards_held) average_creditcards_held, bank_accounts_open
from credit_card_classification.credit_card_data
group by bank_accounts_open
order by bank_accounts_open; #no correlation between credit_cards_held and number_of_bank_accounts

select *
from credit_card_classification.credit_card_data
where credit_rating != 'low' 
	AND credit_cards_held <= 2
    AND own_your_home = 'Yes'
    AND household_size >= 3
    AND offer_accepted = "Yes"
order by customer_number;


create view customers_under_average AS
select customer_number, avg_balance
from credit_card_classification.credit_card_data
where avg_balance < 
	(
	select avg(avg_balance)
	from credit_card_classification.credit_card_data
    )
order by avg_balance DESC;

select offer_accepted, count(customer_number) number_of_customers
from credit_card_classification.credit_card_data
group by offer_accepted;

select avg(avg_balance), credit_rating
from credit_card_classification.credit_card_data
#where credit_rating = 'High' OR credit_rating = 'Low'
where credit_rating IN ('High', 'Low')
group by credit_rating;

select mailer_type, count(customer_number) as number_of_customers
from credit_card_classification.credit_card_data
group by mailer_type;


select *
from (
	select *
	from credit_card_classification.credit_card_data
    where balance_q1 > 0
	order by balance_q1
	limit 11
	) as t
order by balance_q1 DESC
limit 1;



