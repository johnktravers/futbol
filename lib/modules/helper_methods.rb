module HelperMethods

  def home_team?(team_id, game)
    game.home_team_id == team_id
  end

  def away_team?(team_id, game)
    game.away_team_id == team_id
  end

  def home_win?(team_id, game)
    home_team?(team_id, game) && game.home_goals > game.away_goals
  end

  def home_loss?(team_id, game)
    home_team?(team_id, game) && game.home_goals < game.away_goals
  end

  def away_win?(team_id, game)
    away_team?(team_id, game) && game.away_goals > game.home_goals
  end

  def away_loss?(team_id, game)
    away_team?(team_id, game) && game.away_goals < game.home_goals
  end

  def team_result_count
    team_result_count = Hash.new { |h,k| h[k] = Hash.new(0) }

    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        team_count = team_result_count[game_team.team_id]

        team_count[:games] += 1
        team_count[:total_goals] += game_team.goals

        team_count[(game_team.hoa + "_goals").to_sym] += game_team.goals
        team_count[(game_team.hoa + "_games").to_sym] += 1
        team_count[(game_team.hoa + "_wins").to_sym] += 1 if game_team.result == "WIN"

        if game_team.hoa == "away"
          team_count[:goals_allowed] += @games[game_team.game_id].home_goals

        elsif game_team.hoa == "home"
          team_count[:goals_allowed] += @games[game_team.game_id].away_goals
        end
      end
    end
    team_result_count
  end

  def opponent_stats(team_id)
    opponent_count = Hash.new { |h,k| h[k] = Hash.new(0) }

    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id

          if game_team.hoa == "away"
            opponent_id = @games[game_id].home_team_id
          elsif game_team.hoa == "home"
            opponent_id = @games[game_id].away_team_id
          end

          opponent_count[opponent_id][:games] += 1
          opponent_count[opponent_id][:wins] += 1 if game_team.result == "LOSS"
          opponent_count[opponent_id][:losses] += 1 if game_team.result == "WIN"
        end
      end
    end
    opponent_count
  end

  def team_stats_by_season(team_id)
    season_stats = Hash.new { |h1,k1| h1[k1] = Hash.new { |h2,k2| h2[k2] = Hash.new(0) } }

    @games.each do |game_id, game|
      if home_team?(team_id, game) || away_team?(team_id, game)
        type = game.type.gsub(/ /, "_").downcase.to_sym

        season_stats[game.season][type][:games] += 1

        season_stats[game.season][type][:wins] += 1 if home_win?(team_id, game)
        season_stats[game.season][type][:wins] += 1 if away_win?(team_id, game)

        season_stats[game.season][type][:goals_scored] += game.home_goals if home_team?(team_id, game)
        season_stats[game.season][type][:goals_scored] += game.away_goals if away_team?(team_id, game)

        season_stats[game.season][type][:goals_against] += game.home_goals if away_team?(team_id, game)
        season_stats[game.season][type][:goals_against] += game.away_goals if home_team?(team_id, game)
      end

      if !season_stats[game.season][:regular_season][:games]
        season_stats[game.season][:regular_season][:games] = 0
      elsif !season_stats[game.season][:postseason][:games]
        season_stats[game.season][:postseason][:games] = 0
      end
    end
    season_stats
  end

  def coach_win_count
    coach_wins = Hash.new { |h1, k1| h1[k1] = Hash.new { |h2, k2| h2[k2] = Hash.new(0) } }
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        season = @games[game_id].season
        coach_wins[season][game_team.head_coach][:games] += 1
        coach_wins[season][game_team.head_coach][:wins] += 1 if game_team.result == "WIN"
      end
    end
    coach_wins
  end

  def team_tack_shots
    tack_shots = Hash.new { |h1, k1| h1[k1] = Hash.new { |h2, k2| h2[k2] = Hash.new(0) } }
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        season = @games[game_id].season
        tack_shots[season][game_team.team_id][:tackles] += game_team.tackles
        tack_shots[season][game_team.team_id][:shots] += game_team.shots
        tack_shots[season][game_team.team_id][:goals] += game_team.goals
      end
    end
    tack_shots
  end

  def season_counts(season_id)
    season_count = Hash.new{ |h1,k1| h1[k1] = Hash.new { |h2,k2| h2[k2] = Hash.new(0) } }
    @games.each do |game_id, game|
      type = game.type.gsub(/ /, "_").downcase.to_sym

      if game.season == season_id
        season_count[game.home_team_id][type][:games] += 1
        season_count[game.away_team_id][type][:games] += 1

        if game.home_goals > game.away_goals
          season_count[game.home_team_id][type][:wins] += 1
        elsif game.away_goals > game.home_goals
          season_count[game.away_team_id][type][:wins] += 1
        end
      end
    end
    season_count
  end
end
