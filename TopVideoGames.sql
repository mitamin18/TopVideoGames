/* Query that outputs the 10 best-selling games/
SELECT DENSE_RANK() OVER(ORDER BY public.game_sales.games_sold DESC), *
FROM game_sales

/*Alternatively can use this code as well*/
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10 


/* Query that outputs top 10 years with highest average critic score where at least 4 games were released (ensuring good sample size)*/
SELECT g.year, ROUND(AVG(r.critic_score),2) AS avg_critic_score, COUNT(g.name) AS num_games
FROM public.game_sales AS g
INNER JOIN public.reviews AS r
	ON g.name = r.name
GROUP BY 1
HAVING COUNT(g.name) >= 4
ORDER BY avg_critic_score DESC

/* Query that outputs the years where critics & gamers agreed upon the rating of games released for that year. This query only focuses on years where critics or gamers had rated the game over 9*/

SELECT u.year, u.num_games, u.avg_user_score, c.avg_critic_score, 
ABS(u.avg_user_score - c.avg_critic_score) AS diff
FROM public.users_avg_year_rating AS u
INNER JOIN 
public.critics_avg_year_rating AS c
	ON u.year = c.year
WHERE u.avg_user_score > 9 OR c.avg_critic_score > 9 
ORDER BY diff ASC