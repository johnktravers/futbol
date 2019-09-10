require_relative './team'
require_relative './game'
require_relative './game_team'
require_relative './helper_methods'
#thought you called modules directly, ask on monday
require_relative './game_stats'
require_relative './league_stats'
require_relative './team_stats'
require 'csv'
require 'pry'

class StatTracker
  include GameStats
  include LeagueStats
  include TeamStats
  include HelperMethods
  include ERB::Util

  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
    @seasons = count_of_games_by_season.keys
    @team_result_count = team_result_count
  end

  def self.from_csv(locations)
    teams = Hash.new
    CSV.foreach(locations[:teams], :headers => true) do |line|
      teams[line["team_id"]] = Team.new(line)
    end

    games = Hash.new
    CSV.foreach(locations[:games], :headers => true) do |line|
      games[line["game_id"]] = Game.new(line)
    end

    game_teams = Hash.new { |h,k| h[k] = Array.new }
    CSV.foreach(locations[:game_teams], :headers => true) do |line|
      game_teams[line["game_id"]].push(GameTeam.new(line))
    end

    StatTracker.new(teams, games, game_teams)
  end

end
