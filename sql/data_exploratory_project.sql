--data exploration
select * 
from world_layoffs.layoffs_staging2;

--initially columns in table are in varchar datatype so i converted
--them into other datatypes which they logically belong to

ALTER TABLE world_layoffs.layoffs_staging2
ALTER COLUMN total_laid_off INT;

ALTER TABLE world_layoffs.layoffs_staging2
ALTER COLUMN percentage_laid_off float;

ALTER TABLE world_layoffs.layoffs_staging2
ALTER COLUMN funds_raised_millions float;

ALTER TABLE world_layoffs.layoffs_staging2
ALTER COLUMN date date;

update world_layoffs.layoffs_staging2
set total_laid_off=null, percentage_laid_off = null
where total_laid_off='NULL' or percentage_laid_off='NULL';

update world_layoffs.layoffs_staging2
set funds_raised_millions= null
where funds_raised_millions='NULL';

--data exploration starts here

-- maximum of total_laid_off and percentage_laid_off

select max(total_laid_off) as maximum,max(percentage_laid_off)as maximum
from world_layoffs.layoffs_staging2;

--campany wise total_laid_off & percentage_laid_off
select company,total_laid_off,percentage_laid_off
from world_layoffs.layoffs_staging2;

--total no of total_laid_off & percentage_laid_off
select sum(total_laid_off) as total_laid_off,
sum(percentage_laid_off) as percentage_laid_off
from world_layoffs.layoffs_staging2;

--year wise layoffs
select year(date) as date ,sum(total_laid_off) as total_laid_off,
sum(percentage_laid_off)as percentage_laid_off
from world_layoffs.layoffs_staging2
group by year(date)
order by 2 desc;

--month wise layoffs
select month(date) as date ,sum(total_laid_off) as total_laid_off,
sum(percentage_laid_off)as percentage_laid_off
from world_layoffs.layoffs_staging2
group by month(date)
order by 1 desc;

--industry wise layoffs
select industry,sum(total_laid_off) as total_laid_off,
sum(percentage_laid_off)as percentage_laid_off
from world_layoffs.layoffs_staging2
group by industry
order by industry;

--stage wise layoffs
select stage,sum(total_laid_off) as total_laid_off,
sum(percentage_laid_off)as percentage_laid_off
from world_layoffs.layoffs_staging2
group by stage
order by stage;

--total_laid_off campany wise every year
select company,year(date) as year,sum(total_laid_off) as total_laid_off
from world_layoffs.layoffs_staging2
group by company,year(date)
order by total_laid_off desc;

--layoffs by countrywise
select country,sum(total_laid_off) as total_laid_off
from world_layoffs.layoffs_staging2
group by country
order by total_laid_off desc;

--finding which company are on top5 layoffs year wise
WITH company_year AS (
    SELECT 
        company,
        YEAR(date) AS year,
        SUM(total_laid_off) AS total_laid_off,
        DENSE_RANK() OVER (
            PARTITION BY YEAR(date)
            ORDER BY SUM(total_laid_off) DESC
        ) AS ranking
    FROM world_layoffs.layoffs_staging2
    GROUP BY company, YEAR(date)

)
SELECT *
FROM company_year
where year is not null and ranking<=5
ORDER BY year;
