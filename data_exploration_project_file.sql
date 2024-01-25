select * from PortfolioProject..CovidDeaths
order by 3,4

select * from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4;

--select * from PortfolioProject..CovidVaccinations
--order by 3,4


-- selecting the data that we are going to work with

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2


-- looking at total cases vs total deaths  in percentage

select location, date, total_cases, total_deaths, convert(float, total_deaths)/convert(float, total_cases)* 100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2


-- shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, convert(float, total_deaths)/convert(float, total_cases)* 100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%australia%' and continent is not null
order by 1,2

-- looking at the total cases vs population


select location, date, total_cases, population, convert(float, total_cases)/convert(float, population) * 100 as new_case_percent
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2


-- shows what percentage of population got covid in your country

select location, date, total_cases, population, convert(float, total_cases)/convert(float, population) * 100 as new_case_percent
from PortfolioProject..CovidDeaths
--where location like '%australia%'
where continent is not null
order by 1,2


-- looking at countries with highest infection rate compared to population

select location, population, max(total_cases)as max_total_cases, max(convert(float, total_cases)/convert(float, population) * 100) as PercentPopulaltionInfected
from PortfolioProject..CovidDeaths
where continent is not null
group by location, population
order by PercentPopulaltionInfected desc ;


-- showing the countries with the highest death count per population with out the filtering of null continent

select location,  Max(convert (float, total_deaths)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where continent is not null
group by location
order by TotalDeathCount desc;

-- showing the countries with the highest death count per population with the filter not including the continents with null value

select location,  Max(convert (float, total_deaths)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc;

-- let's break things down by continent 

select continent,  Max(convert (float, total_deaths)) as TotalDeathCount
from PortfolioProject..CovidDeaths
group by continent
having continent is not null
order by TotalDeathCount desc;


select continent,  Max(convert (float, total_deaths)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
--having continent is not null
order by TotalDeathCount desc;

-- the above one is not giving the right calculation for total death in north america so we are doing it again 
-- a different way


select location,  Max(convert (float, total_deaths)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is  null
group by location
order by TotalDeathCount desc;

-- you can go back up and remove the continent is not null if you want but  not necessarily




-- showing continents with the highest death count per population

select  continent, max ( cast(total_deaths as float)/ cast (population as float)) * 100 as DeathPopulationPercent
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by DeathPopulationPercent desc;

-- GLOBAL NUMBERS (we want to calculate everything for the across the entire world)

-- calculating death per population percentage accross the world on each date from start to end

-- the below query only calculate the death percentage
-- there are same dates with multiple total_deaths, this query pic the max total_deaths amoung those same dates and do the calculation, which isn't what we meant to do, 
-- we meant to find the total cases that happend in that particular death which can be achieved only if we add all the new cases around the world on that specific date. 
-- look at the below's 3rd query for the correct answer

select date, Max(total_cases) as max_cases, Max(cast (total_deaths as int)) as max_deaths,   Max(cast (total_deaths as int)) / Max(total_cases) * 100 as DeathPerPopulationPercentage
from PortfolioProject..CovidDeaths
group by date
order by date ;


select  Max(total_cases) as max_cases, Max(cast (total_deaths as int)) as max_deaths,   Max(cast (total_deaths as int)) / Max(total_cases) * 100 as DeathPerPopulationPercentage
from PortfolioProject..CovidDeaths ;

-- this calculate the total cases and total deaths occured on that specific date accross the world irrespective of the location and then calculate the deaths per cases on that specific death accross the world,
-- thats why we can't just take the max total_caes and max total_death to calculate the death on a specific day we use those only when we are doing calculation for the specific location. 



select date, sum(new_cases) as total_cases, sum(cast (new_deaths as int)) as total_deaths,   sum(cast (new_deaths as int)) / sum(new_cases) * 100 as DeathPerPopulationPercentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by date;


-- overall across the world the total deaths per percentage irrespective of death or any specific locatin

select  sum(new_cases) as total_cases, sum(cast (new_deaths as int)) as total_deaths,   sum(cast (new_deaths as int)) / sum(new_cases) * 100 as DeathPerPopulationPercentage
from PortfolioProject..CovidDeaths
where continent is not null
--group by date
order by 1,2;


-- using the covid vaccination table

-- looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null
order by 2,3;


-- looking at the total vaccinatin with use of new vaccinatin data
-- looking at total population vs vaccinations


select dea.continent, dea.location, dea.date, dea.population, sum(cast (vac.new_vaccinations as int)) over (partition by dea.continent) as total_vaccination_per_continent
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null
order by 2,3;


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location) as total_vaccination_per_location
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null
order by 2,3;

-- order by location and date within the partition by in the below query to see the real time addtion of total vaccination as the new_vacination keep going up
-- I haven't been able to understand how it worked


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null 
order by 2,3;


-- more practice myself - below is the changes made by the above query made with the use of order by with in partition by clause

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null 
and dea.location like '%albania%' and vac.new_vaccinations is not null
order by 2,3;

--  i think i under stnad this a bit  (look at the part 3 data exploration note)
-- 59:00

-- 

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated / population) * 100  -- to know how many people in that country is vaccinated
 -- we can't use a column that you just created to use as the next one, so what we need to do is create either a CTE or a temp table.
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null 
order by 2,3;


-- you can either creat a cte or temp table

-- USE CTE

with PopvsVac (continent, Location, Date, population, new_vaccinations, RollingPeopleVaccinated)
as (  
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	on dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3

)

select *, (RollingPeopleVaccinated/population) * 100  
from PopvsVac


--select *, (RollingPeopleVaccinated/population) * 100  as percentageV
--from PopvsVac
--where location like '%albania%'  and new_vaccinations is not null;


-- TEMP TABLE CREATION

Drop Table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar (255),
location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
--where dea.continent is not null 
order by 2,3;


select *, (RollingPeopleVaccinated/population) * 100  
from #PercentPopulationVaccinated

-- Creating view to store dat a for later visualizations


create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast (vac.new_vaccinations as int)) over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
on dea.location = vac.location  and dea.date = vac.date
where dea.continent is not null 
--order by 2,3;







--select continent,  Max(convert (float, total_deaths)) as TotalDeathCount
--from PortfolioProject..CovidDeaths
--where continent is not null
--group by continent
----having continent is not null
--order by TotalDeathCount desc;





