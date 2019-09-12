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

          <h2>Game Statistics</h2>

          <h4>Average Goals by Season:</h4>
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

          <h2>Team Statistics</h2>

          <p>Please select a team name:</p>
          <select id="team_id">
            <% @stat_tracker.teams.each do |team_id, team| %>
              <option value = <%= team_id %>><%= team.team_name %></option>
            <% end %>
          </select>

          <br>
          <br>

          <h3>Team Information</h3>
          <table>
            <tr>
              <td>Team Name</td>
              <td><%= @stat_tracker.team_info("3")["team_name"] %></td>
            </tr>
            <tr>
              <td>Team ID</td>
              <td><%= @stat_tracker.team_info("3")["team_id"] %></td>
            </tr>
            <tr>
              <td>Franchise ID</td>
              <td><%= @stat_tracker.team_info("3")["franchise_id"] %></td>
            </tr>
            <tr>
              <td>Abbreviation</td>
              <td><%= @stat_tracker.team_info("3")["abbreviation"] %></td>
            </tr>
            <tr>
              <td>Link</td>
              <td><%= @stat_tracker.team_info("3")["link"] %></td>
            </tr>
          </table>

          <br>

          <h3>Team Statistics</h3>
          <table>
            <tr>
              <td>Best Season</td>
              <td><%= @stat_tracker.best_season("3")[0..3] + "-" + @stat_tracker.best_season("3")[4..7] %></td>
            </tr>
            <tr>
              <td>Worst Season</td>
              <td><%= @stat_tracker.worst_season("3")[0..3] + "-" + @stat_tracker.worst_season("3")[4..7] %></td>
            </tr>
            <tr>
              <td>Average Win Percentage</td>
              <td><%= @stat_tracker.average_win_percentage("3") %></td>
            </tr>
            <tr>
              <td>Most Goals Scored</td>
              <td><%= @stat_tracker.most_goals_scored("3") %></td>
            </tr>
            <tr>
              <td>Fewest Goals Scored</td>
              <td><%= @stat_tracker.fewest_goals_scored("3") %></td>
            </tr>
            <tr>
              <td>Favorite Opponent</td>
              <td><%= @stat_tracker.favorite_opponent("3") %></td>
            </tr>
            <tr>
              <td>Rival</td>
              <td><%= @stat_tracker.rival("3") %></td>
            </tr>
            <tr>
              <td>Biggest Blowout</td>
              <td><%= @stat_tracker.biggest_team_blowout("3") %></td>
            </tr>
            <tr>
              <td>Worst Loss</td>
              <td><%= @stat_tracker.worst_loss("3") %></td>
            </tr>
          </table>

          <br>

          <h3>Head to Head Summary</h3>
          <table>
            <tr>
              <th>Name of Opponent Team</td>
              <th>Win Percentage Against Opponent</td>
            </tr>
            <% @stat_tracker.head_to_head("3").each do |team_name, win_perc| %>
              <tr>
                <td><%= team_name %></td>
                <td><%= win_perc %></td>
              </tr>
            <% end %>
          </table>

          <br>

          <h3>Seasonal Summary</h3>
          <table>
            <tr>
              <th>Season</th>
              <th>Game Type</th>
              <th>Win Percentage</th>
              <th>Total Goals Scored</th>
              <th>Total Goals Against</th>
              <th>Average Goals Scored</th>
              <th>Average Goals Against</th>
            </tr>
            <% @stat_tracker.seasonal_summary("3").each do |season, counts| %>
              <tr>
                <td><%= season[0..3] + "-" + season[4..7] %></td>
                <td>Regular Season</td>
                <td><%= counts[:regular_season][:win_percentage] %></td>
                <td><%= counts[:regular_season][:total_goals_scored] %></td>
                <td><%= counts[:regular_season][:total_goals_against] %></td>
                <td><%= counts[:regular_season][:average_goals_scored] %></td>
                <td><%= counts[:regular_season][:average_goals_against] %></td>
              </tr>
              <tr>
                <td><%= season[0..3] + "-" + season[4..7] %></td>
                <td>Postseason</td>
                <td><%= counts[:postseason][:win_percentage] %></td>
                <td><%= counts[:postseason][:total_goals_scored] %></td>
                <td><%= counts[:postseason][:total_goals_against] %></td>
                <td><%= counts[:postseason][:average_goals_scored] %></td>
                <td><%= counts[:postseason][:average_goals_against] %></td>
              </tr>
            <% end %>
          </table>

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
