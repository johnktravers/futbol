require './lib/stat_tracker'
require 'erb'

def get_template
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

        <h3>Game Statistics</h3>

        <!--
        <ul>
          <% for @team in @stat_tracker.teams.keys %>
            <li><%= @stat_tracker.team_info(@team) %></li>
          <% end %>
        </ul> -->

        <h4>Average Goals by Season:</h4>
        <table>
          <tr>
            <th>Season</th>
            <th>Average Goals</th>
          </tr>
          <tr>
            <td>Jill</td>
            <td>Smith</td>
          </tr>
          <tr>
            <td>Eve</td>
            <td>Jackson</td>
          </tr>
        </table>

      </body>
    </html>
  }
end

class PageGenerator
  include ERB::Util

  def initialize(locations)
    @stat_tracker = StatTracker.from_csv(locations)
    @template = get_template
  end

  def render
    ERB.new(@template).result(binding)
  end

end

locations = {
  games: './data/dummy_games.csv',
  teams: './data/dummy_teams.csv',
  game_teams: './data/dummy_game_teams.csv'
}

page_generator = PageGenerator.new(locations)

File.open('./site/index.html', 'w') { |file| file.write(page_generator.render) }
