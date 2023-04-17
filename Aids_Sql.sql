##-- Selecting data relevant for the project 
select * 
	from development_aid; 
    
    #or 
 
 select recipient_country, Donor, item, year, unit,value
	from 
    development_aid;
    

-----#Viewing all donors IN OUR project
select distinct 
	donor 
	from 	
    development_aid;
    
-----#Viewing all recipients in our project
select distinct 
	recipient_country
    from
    development_aid;
    
-----#Viewing all purpose of donations
select distinct 
	purpose
	from 
    development_aid;

-----#Show total commitment by Donors in 2019
Select donor, round(sum(Value),2) as Commitments,
	year 
	from development_aid 
    where year = '2019' 
    and 
    item = 'Commitment'
    group by donor
    order by sum(Value) desc;
#United states commited to make the highest donations in 2019

-----#Show total commitment by Donors in 2020 
select donor, round(sum(Value),2) as Commitments,
	year 
	from development_aid 
    where year = '2020'
    and 
    item = 'Commitment'
    group by donor
    order by sum(Value) desc;
#United states commited to make the highest donations in 2020

-----#Show total disbursements by Donors in 2019
Select donor, round(sum(Value),2) as Donations,
	year 
	from development_aid 
    where year = '2019'
    and 
    item = 'Disbursement'
    group by donor
    order by sum(Value) desc;
#United states made the highest donation in 2019

-----#Examine donations of the United states by purpose IN 2019
select purpose, round(sum(Value),2) as Donations,
	year
    from development_aid
    where year = '2019'
    and
    item = 'Disbursement'
    and 
    Donor = 'United states of America'
    group by purpose
    ;
#Over 75% of donations were made to food and nutrition assistance programs 

-----#Show the biggest recipient of aids from the USA in 2019
select recipient_country, round(sum(Value),2) as Aids, year
	from development_aid 
    where year = '2019'
    and 
    donor = 'United states of America'
    group by recipient_country
    order by sum(value) desc;
#Ethiopia received the highest Aids from the USA in 2019
	
-----#Show total disbursements by Donors in 2020
Select donor, round(sum(Value),2) as Donations,
	year 
	from development_aid 
    where year = '2020'
    and 
    Item = 'Disbursement'
    group by donor
    order by sum(Value) desc;
#United made the highest contribution again in 2020

-----#Examine donations of the United states by purpose IN 2020
select purpose, round(sum(Value),2) as Donations,
	year
    from development_aid
    where year = '2020'
    and
    item = 'Disbursement'
    and 
    Donor = 'United states of America'
    group by purpose
    ;
#Majority was donated to food and nutrition assistance

-----#Show the biggest recipient of aids from the USA in 2020
select recipient_country, round(sum(Value),2) as Aids, year
	from development_aid 
    where year = '2020'
    and 
    donor = 'United states of America'
    group by recipient_country
    order by sum(value) desc;
##Yemen received the highest donation in 2020 from the united states

-----#Show the Value of Aids received by recipient countries from donors 2019
Select recipient_country,round(sum(Value),2) as Aids_received, year
	from Development_aid
    where year = '2019'
    and item = 'Disbursement'
    group by recipient_country
    order by sum(Value) desc;
##In 2019, the largest aids(Donation was granted to Ethiopia)

-----#Examine donations made to Ethiopia by Purpose    
select purpose,year, round(sum(Value),2) as Aids
	from development_aid
    where year = '2019'
    and recipient_country = 'Ethiopia'
    group by purpose;

-----#Examine donations to Ethiopia by individual donors
Select donor, recipient_country, round(sum(Value),2),year 
	from Development_aid
    where year = '2019'
    and recipient_country = 'Ethiopia'
    group by donor
    order by sum(Value) desc;
#Ethiopia received their highest donation from the united states
    
-----#Show the Value of Aids received by recipient countries from donors 2020    
Select recipient_country,round(sum(Value),2) as Aids_received, year
	from Development_aid
    where year = '2020'
    and item = 'Disbursement'
    group by recipient_country
    order by sum(Value) desc;
##Syria received the highest donations in 2020
    
-----#Examine donations made to Syria by Purpose    
select purpose,year, round(sum(Value),2) as Aids
	from development_aid
    where year = '2020'
    and recipient_country = 'Syrian Arab Republic'
    group by purpose;

-----#Examine donations to Syria by individual donors
Select donor, recipient_country, round(sum(Value),2),year 
	from Development_aid
    where year = '2020'
    and recipient_country = 'Syrian Arab Republic'
    group by donor
    order by sum(Value) desc;
#Turkey contributed the highest to Syria

Create view Top_recipients as 
Select recipient_country,round(sum(Value),2) as Aids_received,
 Rank() over (order by sum(Value) desc) as Ranking
	from Development_aid
    where
    item = 'Disbursement'
    group by recipient_country
    Limit 5;

Create view Top_Donors as 
Select donor,round(sum(Value),2) as Donations,
 Rank() over (order by sum(Value) desc) as Ranking
	from Development_aid
    where
    item = 'Disbursement'
    group by donor
    Limit 5;

###Key summaries 
--##The united states is the biggest donor for Agricultural relaed Aids in the world
--##In comparison with 2019, Aids from the United states in 2020 declined
--##Largest donations from the United states of America were made for the purpose of improving food and Nutrition
--##In 2019, the biggest recipient of aid is Ethiopia
--##The biggest contribution to Ethiopia was geared towards improving food and nutrition
    
-----#Show total commitment 2019
Select donor, round(sum(amount),2) as Commitments,
	year 
	from development 
    where item= 'commitment' 
    and year = '2019'
    group by donor
    order by sum(amount) desc;

-----#Show total commitment 2020
Select donor, round(sum(amount),2) as Commitments,
	year 
	from development 
    where item= 'commitment' 
    and year = '2020'
    group by donor
    order by sum(amount) desc;
    
-----#Show total disburbusment from donors, top 5
Select donor, round(sum(amount),2) as Donations,
	rank()
    over(order by sum(amount) desc) Ranking
    from development 
    where item= 'disbursement' 
    group by donor
    limit 5;

-----#Show total disbursements ODA from donors, top 5
Select donor, round(sum(amount),2) as Donations,
	rank()
    over(order by sum(amount) desc) Ranking
    from development 
    where item= 'disbursement oda' 
    group by donor
    limit 5;

-----#Show total disbursements O0f from donors, top 5
Select donor, round(sum(amount),2) as Donations,
	rank()
    over(order by sum(amount) desc) Ranking
    from development 
    where item= 'disbursement PRIVATE GRANT' 
    group by donor
    limit 5;
    
-----#Show biggest receipients of Aids top 5
Select round(sum(amount),2) as donations,
	recipient_country,
	rank() over (order by sum(amount) desc) Ranking
    from development 
    where item = 'Disbursement'
    group by recipient_country
    limit 20;
    
