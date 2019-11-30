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

