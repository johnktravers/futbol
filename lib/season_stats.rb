module SeasonStats
  def winningest_coach(season)
    @coach_win_count[season].max_by do |coach, counts|
      counts[:wins] / counts[:games].to_f
    end[0]
  end

  def worst_coach(season)
    @coach_win_count[season].min_by do |coach, counts|
      counts[:wins] / counts[:games].to_f
    end[0]
  end

  def most_accurate_team(season)
    max_team_id = @team_tack_shots[season].max_by do |team_id, counts|
      counts[:goals] / counts[:shots].to_f
    end[0]
    @teams[max_team_id].team_name
  end

  def least_accurate_team(season)
    min_team_id = @team_tack_shots[season].min_by do |team_id, counts|
      counts[:goals] / counts[:shots].to_f
    end[0]
    @teams[min_team_id].team_name
  end

  def most_tackles(season)
    max_tackles = @team_tack_shots[season].max_by do |team_id, counts|
      counts[:tackles]
    end[0]
    @teams[max_tackles].team_name
  end

  def fewest_tackles(season)
    min_tackles = @team_tack_shots[season].min_by do |team_id, counts|
      counts[:tackles]
    end[0]
    @teams[min_tackles].team_name
  end
end
