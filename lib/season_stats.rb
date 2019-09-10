module SeasonStats
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
