class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(game_team_info)
    @game_id = game_team_info[0]
    @team_id = game_team_info[1]
    @hoa = game_team_info[2]
    @result = game_team_info[3]
    @head_coach = game_team_info[5]
    @goals = game_team_info[6].to_i
    @shots = game_team_info[7].to_i
    @tackles = game_team_info[8].to_i
  end

end
