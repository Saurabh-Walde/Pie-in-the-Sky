# 1. Show the percentage of wins of each bidder in the order of highest to lowest percentage.

SELECT IPL_BIDDING_DETAILS.BIDDER_ID, COUNT(IPL_BIDDING_DETAILS.BID_STATUS) , NO_OF_BIDS,
(COUNT(IPL_BIDDING_DETAILS.BID_STATUS)/NO_OF_BIDS)*100 AS PERCENTAGE_WIN
FROM IPL_BIDDING_DETAILS  
INNER JOIN IPL_BIDDER_POINTS 
ON IPL_BIDDING_DETAILS.BIDDER_ID = IPL_BIDDER_POINTS.BIDDER_ID
AND  IPL_BIDDING_DETAILS.BID_STATUS ='Won'
GROUP BY IPL_BIDDING_DETAILS.BIDDER_ID, NO_OF_BIDS
ORDER BY PERCENTAGE_WIN DESC;


# 2. Display the number of matches conducted at each stadium with stadium name, city from the database.

SELECT  IPL_STADIUM.STADIUM_ID, STADIUM_NAME,CITY , COUNT(IPL_STADIUM.STADIUM_ID) AS TOTAL_MATCHES
FROM IPL_STADIUM
INNER JOIN IPL_MATCH_SCHEDULE
ON IPL_STADIUM.STADIUM_ID = IPL_MATCH_SCHEDULE.STADIUM_ID
GROUP BY IPL_STADIUM.STADIUM_ID,STADIUM_NAME
ORDER BY TOTAL_MATCHES;


# 3. In a given stadium, what is the percentage of wins by a team which has won the toss?

SELECT S.STADIUM_NAME,
(SUM(CASE WHEN M.TOSS_WINNER = M.MATCH_WINNER THEN 1 ELSE 0 END) / COUNT(M.MATCH_ID)) * 100 AS WIN_PERCENTAGE
FROM IPL_STADIUM AS S
JOIN IPL_MATCH_SCHEDULE AS MS 
ON S.STADIUM_ID = MS.STADIUM_ID
JOIN IPL_MATCH AS M 
ON MS.MATCH_ID = M.MATCH_ID
GROUP BY S.STADIUM_NAME;



# 4. Show the total bids along with bid team and team name.

SELECT IPL_BIDDING_DETAILS.BID_TEAM, IPL_TEAM.TEAM_NAME,
COUNT(IPL_BIDDING_DETAILS.BIDDER_ID) AS TOTAL_BIDS
FROM IPL_BIDDING_DETAILS
JOIN IPL_TEAM 
ON IPL_BIDDING_DETAILS.BID_TEAM = IPL_TEAM.TEAM_ID
GROUP BY IPL_BIDDING_DETAILS.BID_TEAM, IPL_TEAM.TEAM_NAME;


# 5. Show the team id who won the match as per the win details.

SELECT IPL_MATCH.MATCH_ID, IPL_MATCH.MATCH_WINNER AS TEAM_ID, IPL_MATCH.WIN_DETAILS
FROM IPL_TEAM
INNER JOIN IPL_MATCH 
ON IPL_TEAM.TEAM_ID = IPL_MATCH.MATCH_WINNER;


# 6.	Display total matches played, total matches won and total matches lost by team along with its team name.

SELECT IPL_TEAM_STANDINGS.TEAM_ID,IPL_TEAM.TEAM_NAME,
SUM(IPL_TEAM_STANDINGS.MATCHES_PLAYED) AS TOTAL_MATCH_PLAYED,
SUM(IPL_TEAM_STANDINGS.MATCHES_WON) AS WON_MATCHES,
SUM(IPL_TEAM_STANDINGS.MATCHES_LOST) AS LOST_MATCHES
FROM IPL_TEAM_STANDINGS  
INNER JOIN IPL_TEAM 
ON IPL_TEAM_STANDINGS.TEAM_ID=IPL_TEAM.TEAM_ID
GROUP BY IPL_TEAM_STANDINGS.TEAM_ID;


# 7.Display the bowlers for Mumbai Indians team.

SELECT IPL_TEAM_PLAYERS.PLAYER_ID,TEAM_NAME,IPL_TEAM_PLAYERS.REMARKS,PLAYER_ROLE, PLAYER_NAME
FROM IPL_TEAM 
RIGHT OUTER JOIN IPL_TEAM_PLAYERS     
ON SUBSTR(IPL_TEAM.REMARKS,-2) = SUBSTR(IPL_TEAM_PLAYERS.REMARKS,-2)
INNER JOIN IPL_PLAYER
ON IPL_TEAM_PLAYERS.PLAYER_ID = IPL_PLAYER.PLAYER_ID 
WHERE TEAM_NAME LIKE 'Mumbai Indians' 
AND PLAYER_ROLE LIKE 'Bowler'
ORDER BY PLAYER_ID;


#8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order

SELECT TEAM_NAME, PLAYER_ROLE, COUNT(PLAYER_ROLE) AS TOTAL
FROM IPL_TEAM 
INNER JOIN IPL_TEAM_PLAYERS 
ON SUBSTR(IPL_TEAM.REMARKS,-2) = SUBSTR(IPL_TEAM_PLAYERS.REMARKS,-2)
GROUP BY PLAYER_ROLE, TEAM_NAME
HAVING PLAYER_ROLE LIKE 'All-Rounder' AND COUNT(PLAYER_ROLE) > 4 
ORDER BY COUNT(PLAYER_ROLE) DESC;



