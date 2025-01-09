-- create database CovidDataAnalysis
-- import Excel data into database



-- Select Data that we are going to be starting with
select * 
from CovidDeaths

-- while i am expolring the data i discovered that
-- location field which should represent a country have a grouping field for world, africa, asia and other unions
-- so i will exclude it by ensuring the continent is no null


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
 select location, date, total_cases, new_cases
 from CovidDeaths
 order by 3,4 desc



-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

 select location, date,total_cases, total_deaths ,(total_cases/population)*100 as infected_percented 
 from CovidDeaths
 order by 1,2


-- Countries with Highest Infection Rate compared to Population
 select location, population, max(total_cases) as infected_percented,
 max(total_cases/population) *100 as percentage_of_population
 from CovidDeaths
 where continent is not null
 group by location, population
 order by percentage_of_population desc



-- Countries with Highest Death Count per Population
select location, population, max(cast(total_deaths as int)) as total_death
from CovidDeaths
where continent is not null
group by location, population
order by total_death desc



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population
select continent, sum(new_cases) as total_infected
from CovidDeaths
where continent is not null
group by continent
order by total_infected desc



-- GLOBAL NUMBERS
select sum(new_cases) as totsal_cases, sum(new_deaths) as total_death, ( sum(new_deaths)/sum(new_cases)) *100 as Dath_percentage
from CovidDeaths
where continent is not null




-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
select  location, date, cast(new_vaccinations as int)/population as vacinated_perc
,  SUM(CONVERT(int,new_vaccinations)) OVER (Partition by Location Order by location, Date) as RollingPeopleVaccinated
from CovidDeaths
where continent is not null

order by location, vacinated_perc desc


-- Using CTE to perform Calculation on Partition By in previous query




-- Using Temp Table to perform Calculation on Partition By in previous query





-- Creating View to store data for later visualizations


