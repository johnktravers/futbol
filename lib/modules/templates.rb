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

        </body>
      </html>
    }
  end

end
