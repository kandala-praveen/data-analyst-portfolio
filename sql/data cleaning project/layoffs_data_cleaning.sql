--sqlproject --data cleaning

SELECT *
FROM world_layoffs.layoffs;

--1.remove duplicates
--2.standardize the data
--3.null values or blank values
--4.remove columns or rows

--1.remove duplicates
select *
into world_layoffs.layoffs_staging
from world_layoffs.layoffs
where 1=0;

INSERT INTO world_layoffs.layoffs_staging
SELECT *
FROM world_layoffs.layoffs;

with duplicate_cte as(
		select * ,row_number()
				over(partition by company,location,industry,total_laid_off, 
				percentage_laid_off,date,stage,country,funds_raised_millions order by company ) as row_num
		from world_layoffs.layoffs_staging
)
select * 
from duplicate_cte
where row_num>1;

with duplicate_cte as(
		select * ,row_number()
				over(partition by company,location,industry,total_laid_off, 
				percentage_laid_off,date,stage,country,funds_raised_millions order by company ) as row_num
		from world_layoffs.layoffs_staging
)
delete
from duplicate_cte
where row_num>1;

select * 
from world_layoffs.layoffs_staging
order by company;

--2.standardizing
select *
into world_layoffs.layoffs_staging2
from world_layoffs.layoffs_staging
where 1=0;

select *
from world_layoffs.layoffs_staging2
order by company;

insert into world_layoffs.layoffs_staging2
SELECT *
FROM world_layoffs.layoffs_staging;

select * 
from world_layoffs.layoffs_staging2
where industry like 'cry%';

update world_layoffs.layoffs_staging2
set industry = 'Crypto'
where industry like 'crypto%';


select *
from world_layoffs.layoffs_staging2
order by company;

update world_layoffs.layoffs_staging2
set industry = 'Finance'
where industry like 'Fin-Tech%';

select distinct company
from world_layoffs.layoffs_staging2;

update world_layoffs.layoffs_staging2
set country = 'United States'
where country like 'United States.';

update world_layoffs.layoffs_staging2
set date=TRY_CONVERT(date, date, 103);

select *
from world_layoffs.layoffs_staging2
order by company;

--3.handle null values

select *
from world_layoffs.layoffs_staging2
where industry is NULL or industry='';

select *
from world_layoffs.layoffs_staging2
where company ='Airbnb';

select *
from world_layoffs.layoffs_staging2
where company ='Juul';

select *
from world_layoffs.layoffs_staging2
where company ='Carvana';

update t1
set t1.industry=t2.industry
from world_layoffs.layoffs_staging2 as t1
join world_layoffs.layoffs_staging2 as t2
	on t1.company=t2.company
	and t1.location=t2.location
where (t1.industry is NULL or t1.industry='')
and t2.industry is NOT NULL;

select * 
from world_layoffs.layoffs_staging2
where total_laid_off ='NULL';

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 'NULL' and total_laid_off ='NULL';

--the rows which have both percentage_laid_off and total_laid_off as null will deleted because they dont have layoffs
delete
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 'NULL' and total_laid_off ='NULL';

select *
from world_layoffs.layoffs_staging2
order by company;

--the nulls in total_laid_off, percentage_laid_off and funds_raised_millions will be calculated in EDA phase