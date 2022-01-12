SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVacinations
--ORDER BY 3,4

--Select Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
and continent is not null
ORDER BY 1,2


-- Looking at Total Cases vs Polulation
-- Shows what percentage of population got Covid
SELECT Location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected 
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
ORDER BY 1,2



--Looking at Countries with Hightest Infection Rate compared to Population

SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
GROUP BY Location, population
ORDER BY PercentPopulationInfected desc


--Showing Countries with Highest Death Count per Population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc



-- LET'S BREAK THINGS DOWN BY CONTINENT

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc



-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc



-- GLOBAL NUMBERS

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2




-- Looking at Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVacinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3