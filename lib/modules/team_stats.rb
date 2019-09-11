module TeamStats

  def team_info(team_id)
    {
      "team_id" => team_id,
      "franchise_id" => @teams[team_id].franchise_id,
      "team_name" => @teams[team_id].team_name,
      "abbreviation" => @teams[team_id].abbr,
      "link" => @teams[team_id].link,
    }
  end

  def best_season(team_id)
    team_games = @games.find_all {|game_id, game| game.home_team_id == team_id || game.away_team_id == team_id}
    season = Hash.new { |h,k| h[k] = Hash.new(0) }

    team_games.each do |game_id, game|
      season[game.season][:season_games] += 1
      if home_win?(team_id, game)
        season[game.season][:season_wins] += 1
      elsif away_win?(team_id, game)
        season[game.season][:season_wins] += 1
      end
    end
    season.max_by {|season_id, tallies| tallies[:season_wins] / tallies[:season_games].to_f}[0]
  end

  def worst_season(team_id)
    team_games = @games.find_all {|game_id, game| game.home_team_id == team_id || game.away_team_id == team_id}
    season = Hash.new { |h,k| h[k] = Hash.new(0) }

    team_games.each do |game_id, game|
      season[game.season][:season_games] += 1
      if home_win?(team_id, game)
        season[game.season][:season_wins] += 1
      elsif away_win?(team_id, game)
        season[game.season][:season_wins] += 1
      end
    end
    season.min_by {|season_id, tallies| tallies[:season_wins] / tallies[:season_games].to_f}[0]
  end

  def average_win_percentage(team_id)
    total_wins = @team_result_count[team_id][:away_wins] + @team_result_count[team_id][:home_wins]
    (total_wins.to_f / @team_result_count[team_id][:games]).round(2)
  end

  def most_goals_scored(team_id)
    most_goals = 0
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          most_goals = game_team.goals if game_team.goals > most_goals
        end
      end
    end
    most_goals
  end

  def fewest_goals_scored(team_id)
    fewest_goals = 50
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          fewest_goals = game_team.goals if game_team.goals < fewest_goals
        end
      end
    end
    fewest_goals
  end

  def favorite_opponent(team_id)
    opponent_id = opponent_stats(team_id).min_by do |tm_id, counts|
      counts[:wins] / counts[:games].to_f
    end[0]

    @teams[opponent_id].team_name
  end

  def rival(team_id)
    opponent_id = opponent_stats(team_id).min_by do |tm_id, counts|
      counts[:losses] / counts[:games].to_f
    end[0]

    @teams[opponent_id].team_name
  end

  def biggest_team_blowout(team_id)
    greatest_difference = 0
    @games.each do |game_id, game|
      if home_win?(team_id, game) || away_win?(team_id, game)
        difference = (game.home_goals - game.away_goals).abs
        greatest_difference = difference if difference > greatest_difference
      end
    end
    greatest_difference
  end

  def worst_loss(team_id)
    greatest_difference = 0
    @games.each do |game_id, game|
      if home_loss?(team_id, game) || away_loss?(team_id, game)
        difference = (game.home_goals - game.away_goals).abs
        greatest_difference = difference if difference > greatest_difference
      end
    end
    greatest_difference
  end

  def head_to_head(team_id)
    record = Hash.new
    opponent_stats = opponent_stats(team_id)

    opponent_stats.each do |tm_id, counts|
      record[@teams[tm_id].team_name] = (counts[:losses] / counts[:games].to_f).round(2)
    end

    record
  end

  def seasonal_summary(team_id)
    season_summary = Hash.new { |h1,k1| h1[k1] = Hash.new { |h2,k2| h2[k2] = Hash.new(0) } }
    team_stats = team_stats_by_season(team_id)

    team_stats.each do |season, stats|
      stats.each do |game_type, counts|

        season_summary[season][game_type][:total_goals_scored] = counts[:goals_scored]
        season_summary[season][game_type][:total_goals_against] = counts[:goals_against]

        if counts[:games] > 0
          season_summary[season][game_type][:win_percentage] = (counts[:wins] / counts[:games].to_f).round(2)
          season_summary[season][game_type][:average_goals_scored] = (counts[:goals_scored] / counts[:games].to_f).round(2)
          season_summary[season][game_type][:average_goals_against] = (counts[:goals_against] / counts[:games].to_f).round(2)
        else
          season_summary[season][game_type][:win_percentage] = 0
          season_summary[season][game_type][:average_goals_scored] = 0
          season_summary[season][game_type][:average_goals_against] = 0
        end
      end
    end
    season_summary
  end

end
