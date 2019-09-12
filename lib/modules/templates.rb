module Templates

  def home_page_template
    %{
      <html lang="en-US">
        <head>
          <meta charset = "UTF-8">
          <title>Futbol Statistics</title>
          <link rel="stylesheet" href="stylesheet.css" />
        </head>

        <body>
          <h1>Futbol Statistics</h1>
          <hr>

          <h2>Site Index</h2>
          <ul>
            <h3><a href="game_stats.html">Game Statistics</a></h3>
            <h3><a href="league_stats.html">League Statistics</a></h3>
            <h3><a href="team_stats.html">Team Statistics</a></h3>
            <h3><a href="season_stats.html">Season Statistics</a></h3>
          </ul>
          <hr>

        </body>
      </html>
    }
  end

  def game_stats_template
    %{
      <html lang="en-US">
        <head>
          <meta charset = "UTF-8">
          <title>Futbol Statistics</title>
          <link rel="stylesheet" href="stylesheet.css" />
        </head>

        <body>
          <h1>Futbol Statistics</h1>
          <hr>

          <h2>Site Index</h2>
          <ul>
            <h3><a href="game_stats.html">Game Statistics</a></h3>
            <h3><a href="league_stats.html">League Statistics</a></h3>
            <h3><a href="team_stats.html">Team Statistics</a></h3>
            <h3><a href="season_stats.html">Season Statistics</a></h3>
          </ul>
          <hr>

          <h3>Game Statistics</h3>
          <h4>Highest Total Score:</h4>
          <h5>Highest sum of the winning and losing teams’ scores</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Lowest Total Score:</h4>
          <h5>Lowest sum of the winning and losing teams’ scores</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Biggest Blowout:</h4>
          <h5>	Highest difference between winner and loser</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Percentage Home Wins:</h4>
          <h5>Percentage of games that a home team has won (rounded to the nearest 100th)</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Percentage Visitor Wins:</h4>
          <h5>Percentage of games that a visitor has won (rounded to the nearest 100th)</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Percentage Ties:</h4>
          <h5>Percentage of games that has resulted in a tie (rounded to the nearest 100th)</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Count Of Games By Season:</h4>
          <h5>A hash with season names (e.g. 20122013) as keys and counts of games as values</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Average Goals Per Game:</h4>
          <h5>Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)</h5>
          <table>
          <% @stat_tracker.average_goals_per_game.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <h4>Average Goals by Season:</h4>
          <h5>Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as a key (rounded to the nearest 100th)</h5>
          <table>
            <tr>
              <th>Season</th>
              <th>Average Goals</th>
            </tr>
            <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
              <tr>
                <td><%= season[0..3] + "-" + season[4..-1] %></td>
                <td><%= goals %></td>
              </tr>
            <% end %>
          </table>

        </body>
      </html>
    }
  end

  def league_stats_template
    %{
      <html lang="en-US">
        <head>
          <meta charset = "UTF-8">
          <title>Futbol Statistics</title>
          <link rel="stylesheet" href="stylesheet.css" />
        </head>

        <body>
          <h1>Futbol Statistics</h1>
          <hr>

          <h2>Site Index</h2>
          <ul>
            <h3><a href="game_stats.html">Game Statistics</a></h3>
            <h3><a href="league_stats.html">League Statistics</a></h3>
            <h3><a href="team_stats.html">Team Statistics</a></h3>
            <h3><a href="season_stats.html">Season Statistics</a></h3>
          </ul>
          <hr>

        </body>
      </html>
    }
  end

  def team_stats_template
    %{
      <html lang="en-US">
        <head>
          <meta charset = "UTF-8">
          <title>Futbol Statistics</title>
          <link rel="stylesheet" href="stylesheet.css" />
        </head>

        <body>
          <h1>Futbol Statistics</h1>
          <hr>

          <h2>Site Index</h2>
          <ul>
            <h3><a href="game_stats.html">Game Statistics</a></h3>
            <h3><a href="league_stats.html">League Statistics</a></h3>
            <h3><a href="team_stats.html">Team Statistics</a></h3>
            <h3><a href="season_stats.html">Season Statistics</a></h3>
          </ul>
          <hr>

        </body>
      </html>
    }
  end

  def season_stats_template
    %{
      <html lang="en-US">
        <head>
          <meta charset = "UTF-8">
          <title>Futbol Statistics</title>
          <link rel="stylesheet" href="stylesheet.css" />
        </head>

        <body>
          <h1>Futbol Statistics</h1>
          <hr>

          <h2>Site Index</h2>
          <ul>
            <h3><a href="game_stats.html">Game Statistics</a></h3>
            <h3><a href="league_stats.html">League Statistics</a></h3>
            <h3><a href="team_stats.html">Team Statistics</a></h3>
            <h3><a href="season_stats.html">Season Statistics</a></h3>
          </ul>

          <hr>
          <h3>Season Statistics</h3>
          <h4>Biggest Bust:</h4>
          <h5>The team that suffered the biggest decrease between their regular and post-season records</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_bust(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Biggest Surprise:</h4>
          <h5>The team that achieved the biggest increase between their regular and post-season records</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.biggest_surprise(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Winningest Coach:</h4>
          <h5>The coach with the most wins in the given season</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.winningest_coach(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Worst Coach:</h4>
          <h5>The coach with the fewest wins in the given season</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.worst_coach(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Most Accurate Team:</h4>
          <h5>The team with the best ratio of shots taken to goals made in the given season</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.most_accurate_team(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Least Accurate Team:</h4>
          <h5>The team with the worst ratio of shots taken to goals made in the given season</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.least_accurate_team(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Most Tackles:</h4>
          <h5>The team with the largest amount of tackles in the given season</h5>
          <table>
          <% @stat_tracker.average_goals_by_season.each do |season, goals| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.most_tackles(season) %></td>
            </tr>
          <% end %>
          </table>

          <hr>
          <h4>Fewest Tackles:</h4>
          <h5>The team with the lowest amount of tackles in the given season</h5>
          <table>
          <% @stat_tracker.seasons.each do |season| %>
            <tr>
              <td><%= season[0..3] + "-" + season[4..-1] %></td>
              <td><%= @stat_tracker.fewest_tackles(season) %></td>
            </tr>
          <% end %>
          </table>

        </body>
      </html>
    }
  end

end
