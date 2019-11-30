# Futbol

This module 1 group project imports functional soccer league data from CSV files and manipulates it using various methods to display certain statistics. The statistics can be broken down into four types (`game`, `league`, `team`, and `season`), each of which is explained below.

## Setup Instructions

All of the statistics can be viewed in a static website on your own  machine by navigating to your desired directory and executing these commands:

```
git clone git@github.com:johnktravers/futbol.git
cd futbol
ruby page_generator.rb
open site/index.html
```

## Statistics

### Game Statistics

- **Highest Total Score**: highest total for home and away goals in a single game

- **Lowest Total Score**: lowest total for home and away goals in a single game

- **Biggest Blowout**: largest difference in goals between two teams in a single game

- **Overall Home Win Percentage**: percentage of games in which the home team won

- **Overall Visitor Win Percentage**: percentage of games in which the visiting team won

- **Overall Tie Percentage**: percentage of games which ended in a tie

- **Average Goals per Game**: the average number of total goals scored in a game

- **Average Goals by Season**: the average number of goals scored per game for each season in the league

- **Count of Games by Season**: the total number of games played during each season in the league

### League Statistics

- **Best Offense**: team with the highest average number of goals scored per game across all seasons

- **Worst Offense**: team with the lowest average number of goals scored per game across all seasons

- **Best Defense**: team with the lowest average number of goals allowed per game across all seasons

- **Worst Defense**: team with the highest average number of goals allowed per game across all seasons

- **Highest Scoring Visitor**: team with the highest average score per game across all seasons when they are away

- **Highest Scoring Home Team**: team with the highest average score per game across all seasons when they are home

- **Lowest Scoring Visitor**: team with the lowest average score per game across all seasons when they are a visitor

- **Lowest Scoring Home Team**: team with the lowest average score per game across all seasons when they are at home

- **Winningest Team**: team with the highest win percentage across all seasons

- **Best Fans**: team with biggest difference between home and away win percentages

- **Worst Fans**: list of names of all teams with better away records than home records

### Team Statistics

These statistics are available for every team in the league. You can select a team by using the drop-down menu on the static website.

- **Team Info**: A list of the team's team ID, franchise ID, team name, abbreviation, and API link

- **Best Season**: Season with the highest win percentage for a team

- **Worst Season**: Season with the lowest win percentage for a team

- **Average Win Percentage**: Average win percentage of all games for a team

- **Most Goals Scored**: Highest number of goals a particular team has scored in a single game

- **Fewest Goals Scored**: Lowest number of goals a particular team has scored in a single game

- **Favorite Opponent**: Name of the opponent that has the lowest win percentage against the given team

- **Rival**: Name of the opponent that has the highest win percentage against the given team

- **Biggest Team Blowout**: Biggest difference between team goals and opponent goals for a win for the given team

- **Worst Loss**: Biggest difference between team goals and opponent goals for a loss for the given team

- **Head to Head**: A list of opponents that the team has played and their win percentage against that opponent

- **Seasonal Summary**: A seasonal breakdown that includes the game type (regular season or postseason), win percentage, total goals scored, total goals against, average goals scored, and average goals against for every season

### Season Statistics

Each of these statistics is available for every season on record, from `2012-2013` to `2017-2018`.

- **Biggest Bust**: team that suffered the biggest decrease between their regular and post-season records

- **Biggest Surprise**: team that achieved the biggest increase between their regular and post-season records

- **Winningest Coach**: coach with the most wins in the given season

- **Worst Coach**: coach with the fewest wins in the given season

- **Most Accurate Team**: team with the best ratio of shots taken to goals made in the given season

- **Least Accurate Team**: team with the worst ratio of shots taken to goals made in the given season

- **Most Tackles**: team with the largest amount of tackles in the given season

- **Fewest Tackles**: team with the lowest amount of tackles in the given season
