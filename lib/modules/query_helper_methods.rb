module QueryHelperMethods

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
  
end
