class Game
  attr_reader :game_id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(game_info)
    @game_id = game_info[0]
    @season = game_info[1]
    @type = game_info[2]
    @away_team_id = game_info[4]
    @home_team_id = game_info[5]
    @away_goals = game_info[6].to_i
    @home_goals = game_info[7].to_i
  end

end
