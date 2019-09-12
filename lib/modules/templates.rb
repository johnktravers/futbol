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

          <h3>Average Goals by Season:</h3>
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

          <h2>League Statistics</h2>
          <table>
            <tr>
              <td>Count of Teams</td>
              <td><%= @stat_tracker.count_of_teams %></td>
            </tr>
            <tr>
              <td>Best Offense</td>
              <td><%= @stat_tracker.best_offense %></td>
            </tr>
            <tr>
              <td>Worst Offense</td>
              <td><%= @stat_tracker.worst_offense %></td>
            </tr>
            <tr>
              <td>Best Defense</td>
              <td><%= @stat_tracker.best_defense %></td>
            </tr>
            <tr>
              <td>Worst Defense</td>
              <td><%= @stat_tracker.worst_defense %></td>
            </tr>
            <tr>
              <td>Highest Scoring Visitor</td>
              <td><%= @stat_tracker.highest_scoring_visitor %></td>
            </tr>
            <tr>
              <td>Highest Scoring Home Team</td>
              <td><%= @stat_tracker.highest_scoring_home_team %></td>
            </tr>
            <tr>
              <td>Lowest Scoring Visitor</td>
              <td><%= @stat_tracker.lowest_scoring_visitor %></td>
            </tr>
            <tr>
              <td>Lowest Scoring Home Team</td>
              <td><%= @stat_tracker.lowest_scoring_home_team %></td>
            </tr>
            <tr>
              <td>Winningest Team</td>
              <td><%= @stat_tracker.winningest_team %></td>
            </tr>
            <tr>
              <td>Best Fans</td>
              <td><%= @stat_tracker.best_fans %></td>
            </tr>
            <tr>
              <td>Worst Fans</td>
              <td>
                <%= @stat_tracker.worst_fans[0] %>
                <br>
                <%= @stat_tracker.worst_fans[1] %>
              </td>
            </tr>
          </table>

          <br>

          <h4>Best Offense</h4>
          <p>Team with the highest average number of goals scored per game across all seasons</p>
          <h4>Worst Offense</h4>
          <p>Team with the lowest average number of goals scored per game across all seasons</p>
          <h4>Best Defense</h4>
          <p>Team with the lowest average number of goals allowed per game across all seasons</p>
          <h4>Worst Defense</h4>
          <p>Team with the highest average number of goals allowed per game across all seasons</p>
          <h4>Highest Scoring Visitor</h4>
          <p>Team with the highest average score per game across all seasons when they are away</p>
          <h4>Highest Scoring Home Team</h4>
          <p>Team with the highest average score per game across all seasons when they are home</p>
          <h4>Lowest Scoring Visitor</h4>
          <p>Team with the lowest average score per game across all seasons when they are a visitor</p>
          <h4>Lowest Scoring Home Team</h4>
          <p>Team with the lowest average score per game across all seasons when they are at home</p>
          <h4>Winningest Team</h4>
          <p>	Team with the highest win percentage across all seasons</p>
          <h4>Best Fans</h4>
          <p>	Team with biggest difference between home and away win percentages</p>
          <h4>Worst Fans</h4>
          <p>	List of names of all teams with better away records than home records</p>

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
          <h2>Season Statistics</h2>
          <h3>Biggest Bust:</h3>
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
          <h3>Biggest Surprise:</h3>
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
          <h3>Winningest Coach:</h3>
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
          <h3>Worst Coach:</h3>
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
          <h3>Most Accurate Team:</h3>
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
          <h3>Least Accurate Team:</h3>
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
          <h3>Most Tackles:</h3>
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
          <h3>Fewest Tackles:</h3>
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
