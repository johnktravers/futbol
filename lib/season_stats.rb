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

  def biggest_surprise
    #
  end

  def winningest_coach(season)
    coach_win_count[season].max_by do |coach, counts|
      counts[:wins] / counts[:games].to_f
    end[0]
  end

  def worst_coach(season)
    coach_win_count[season].min_by do |coach, counts|
      counts[:wins] / counts[:games].to_f
    end[0]
  end
end
