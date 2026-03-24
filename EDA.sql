-- Explorating Data Analysis

USE world_layoffs;

SELECT *
FROM layoffs_archieved2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_archieved2;

-- Total Layoffs by Company
 SELECT company, SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP BY company
 ORDER BY 2 DESC;
 
 -- Total Layoffs by Industry
 SELECT industry, SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP BY industry
 ORDER BY 2 DESC;
 
 -- Total Layoffs by Country
 SELECT country, SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP BY country
 ORDER BY 2 DESC;
 
 -- Total Layoffs by Year
 SELECT YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP BY YEAR(`date`)
 ORDER BY 1 DESC;
 
 SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off)
 FROM layoffs_archieved2
 WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
 GROUP BY `Month`
 ORDER BY 1 ASC;
 
 WITH Rolling_total AS 
 (
 SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS total_off
 FROM layoffs_archieved2
 WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
 GROUP BY `Month`
 ORDER BY 1 ASC
 )
 (
 SELECT `Month`, total_off, SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
 FROM Rolling_total
 );
 
 SELECT company, SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP by company
 order by 2 DESC;
 
 
 -- Company Ranking by Layoffs (Year-wise)
 
 SELECT company, YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP by company, YEAR(`date`)
 order by 3 DESC;
 
 WITH company_year(company, years, total_laid_off) AS 
 (
 SELECT company, YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_archieved2
 GROUP by company, YEAR(`date`)
 order by 3 DESC
 ), Company_Year_Ranking AS 
 (
 SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
 FROM company_year
 WHERE years IS NOT NULL
 )
 SELECT *
 FROM Company_Year_Ranking
 WHERE Ranking <= 5;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 