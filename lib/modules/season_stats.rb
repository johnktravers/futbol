module SeasonStats

  def biggest_bust(season_id)
    bust_team_id = post_and_reg_percents(season_id).max_by do |team_id, percents|
      percents[:reg_percent] - percents[:post_percent]
    end[0]
    @teams[bust_team_id].team_name
  end

  def biggest_surprise(season_id)
    surprise_team_id = post_and_reg_percents(season_id).max_by do |team_id, percents|
      percents[:post_percent] - percents[:reg_percent]
    end[0]
    @teams[surprise_team_id].team_name
  end

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
