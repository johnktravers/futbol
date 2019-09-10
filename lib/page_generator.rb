require_relative './stat_tracker'
require 'erb'

def get_items
  ['bread', 'milk', 'eggs', 'spam']
end

def get_template
  %{
    <head>
      <title>Futbol Statistics</title>
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body>
      <h1>Futbol Statistics</h1>
      <hr>

      <h3>Game Statistics</h3>

      <ul>
        <% for @team in @stat_tracker.teams %>
          <li><%= @team %></li>
        <% end %>
      </ul>
    </body>
  }
end

class ShoppingList
  include ERB::Util
  # include Template

  def initialize(locations)
    @stat_tracker = StatTracker.from_csv(locations)
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

stat_tracker = StatTracker.from_csv(locations)

File.open('./site/index.html', 'w') { |file| file.write(stat_tracker.render) }
