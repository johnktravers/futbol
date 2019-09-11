module SeasonStats

  def biggest_bust(season_id)
   season_count = season_counts(season_id)
   bust_team = ""
   bust_percent = 0
   season_count.each do |team_id, counts|
    # if counts[:post_games] != 0
     reg_percent = counts[:reg_wins] / counts[:reg_games].to_f
     post_percent = counts[:post_wins] / counts[:post_games].to_f if counts[:post_games] > 0
     post_percent = 0 if counts[:post_games] == 0
     if (reg_percent - post_percent) > bust_percent
      bust_team = @teams[team_id].team_name
      bust_percent = reg_percent - post_percent
     end
    # end
   end
   bust_team
    # require 'pry'; binding.pry
  end
  
  def biggest_surprise(season_id)
   season_count = season_counts(season_id)
   surprise_team = ""
   biggest_percent = 0
   season_count.each do |team_id, counts|
    reg_percent = counts[:reg_wins] / counts[:reg_games].to_f
    post_percent = counts[:post_wins] / counts[:post_games].to_f
    if (post_percent - reg_percent) > biggest_percent
     surprise_team = @teams[team_id].team_name
     biggest_percent = post_percent - reg_percent
    end
   end
   surprise_team
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
