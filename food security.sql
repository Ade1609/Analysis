USE fOOD_SECURITY1;

select * from labor;

select * from labor where hh_e03 = '';
select * from education where hh_c03 = '';

-----##dropping columns not relevant from Education Table

Alter table Education
drop column hh_c05a,drop column hh_c05b,drop column hh_c07a,
drop column hh_c07b,drop column hh_c07_oth,drop column hh_c08,
drop column hh_c10,drop column hh_c11,drop column hh_c12,
drop column hh_c13,drop column hh_c14,drop column hh_c14_oth,
drop column hh_c15,drop column hh_c16,drop column hh_c17,
drop column hh_c18,drop column hh_c18_oth,drop column hh_c19a,
drop column hh_c19b,drop column hh_c20,drop column hh_c21,
drop column hh_c21_oth,drop column hh_c22a,drop column hh_c22b,
drop column hh_c22c,drop column hh_c22d,drop column hh_c22e,
drop column hh_c22f,drop column hh_c22g,drop column hh_c22h,
drop column hh_c22i;

alter table education;
drop column hh_c04;

Alter table education
drop column highest_edu;

---##deleting missing items 
update education
	set 
    hh_c22j = '0'
    where 
    hh_c22j = '';
    
delete from education where hh_c03 = '';

delete from education where hh_c09 = '';

---## renaming the columns

alter table education 
rename column hh_c22j to edu_expenses;

alter table education 
rename column hh_c09 to highest_edu;

Alter table education 
rename column hh_c06 to educated;

alter table education
rename column hh_c03 to representative;

Select * from health;
Alter table health
drop column Pid,drop column hh_d02, drop column hh_d03,
drop column hh_d05a,drop column hh_d05b,drop column hh_d05_oth,
drop column hh_d06a,drop column hh_d06b,drop column hh_d06b_oth,
drop column hh_d07a,drop column hh_d07a_oth,drop column hh_d07b,
drop column hh_d07b_oth,drop column hh_d08,drop column hh_d09;


alter table health
drop column hh_d06a_oth,drop column hh_d17,drop column hh_d18,
drop column hh_d33,drop column hh_d34_oth,drop column hh_d34a,
drop column hh_d34b,drop column hh_d35a,drop column hh_d35b,
drop column hh_d36a,drop column hh_d36a_oth,drop column hh_d38,
drop column hh_d38_oth,drop column hh_d45,drop column hh_d45_oth,
drop column hh_d46,drop column hh_d46_oth;

alter table health
drop column hh_d13;

alter table health
drop column hh_d36b_oth,drop column hh_d36b,drop column hh_d22;

---##Generate total health expense
select case_id, HHID,HH_D04,hh_d10 + hh_d11+hh_d12+hh_d14+hh_d15+hh_d16+hh_d19+hh_d20+hh_d21
	 as 
     medical_expenses 
     from health
;
  
CREATE TABLE HEALTHS(
	case_id varchar(255),
    HHID VARCHAR(255),
    hh_d04 INT,
    Medical_expenses int);

insert into healths
select case_id, HHID,HH_D04,hh_d10 + hh_d11+hh_d12+hh_d14+hh_d15+hh_d16+hh_d19+hh_d20+hh_d21 as medical_expenses
	from health;
    
select * from healths;
drop table health;


select case_id, HHID,
case when hh_d04 = 1 then 'Yes'
	when hh_d04 = 2 then 'No' 
    end as Illness
from healths;