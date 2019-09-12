require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/dummy_games.csv',
      teams: './data/dummy_teams.csv',
      game_teams: './data/dummy_game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_initialize
    assert_instance_of Team, @stat_tracker.teams["19"]
    assert_equal 20, @stat_tracker.teams.length

    assert_instance_of Game, @stat_tracker.games["2012030221"]
    assert_equal 31, @stat_tracker.games.length

    assert_instance_of GameTeam, @stat_tracker.game_teams["2012030221"][0]
    assert_equal 2, @stat_tracker.game_teams["2012030221"].length
    assert_equal 31, @stat_tracker.game_teams.length

    assert_equal ["20122013", "20132014", "20142015", "20152016", "20162017", "20172018"], @stat_tracker.seasons
  end



  ##### Game Statistics Tests #####

  def test_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.61, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.23, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.16, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 7,
      "20132014" => 7,
      "20142015" => 5,
      "20152016" => 5,
      "20162017" => 6,
      "20172018" => 1,
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.19, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013" => 4.86,
      "20132014" => 4.29,
      "20142015" => 2.8,
      "20152016" => 3.4,
      "20162017" => 4.83,
      "20172018" => 6.0
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end



  ##### League Statistics Tests #####

  def test_count_of_teams
    assert_equal 20, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Portland Timbers", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Portland Thorns FC", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Atlanta United", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "San Jose Earthquakes", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Portland Timbers", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Orlando City SC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "North Carolina Courage", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Orlando Pride", @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_team
    assert_equal "New England Revolution", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Orlando City SC", @stat_tracker.best_fans
  end

  def test_worst_fans
    expected = ["New England Revolution", "Vancouver Whitecaps FC", "Atlanta United"]
    assert_equal expected, @stat_tracker.worst_fans
  end



  ##### Team Statistics Tests #####

  def test_team_info
    expected = {
      "team_id" => "21",
      "franchise_id" => "27",
      "team_name" => "Vancouver Whitecaps FC",
      "abbreviation" => "VAN",
      "link" => "/api/v1/teams/21"
    }
    assert_equal expected, @stat_tracker.team_info("21")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("3")
    assert_equal "20152016", @stat_tracker.best_season("21")
  end

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("3")
    assert_equal "20142015", @stat_tracker.worst_season("21")
  end

  def test_average_win_percentage
    assert_equal 0.33, @stat_tracker.average_win_percentage("3")
  end

  def test_most_goals_scored
    assert_equal 3, @stat_tracker.most_goals_scored("12")
  end

  def test_fewest_goals_scored
    assert_equal 2, @stat_tracker.fewest_goals_scored("6")
  end

  def test_favorite_opponent
    stub_opponent_stats

    assert_equal "Houston Dash", @stat_tracker.favorite_opponent("21")
  end

  def test_rival
    stub_opponent_stats

    assert_equal "Orlando Pride", @stat_tracker.rival("2")
  end

  def test_biggest_team_blowout
    assert_equal 1, @stat_tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 1, @stat_tracker.worst_loss("3")
  end

  def test_head_to_head
    expected = {
      "Houston Dynamo" => 1.0,
      "Vancouver Whitecaps FC" => 0.0,
      "North Carolina Courage" => 1.0,
      "Atlanta United" => 0.0
    }
    assert_equal expected, @stat_tracker.head_to_head("6")
  end

  def test_seasonal_summary
    stub_team_stats_by_season

    expected = {
      "20122013"=>{
        :postseason=>{:total_goals_scored=>8, :total_goals_against=>5, :win_percentage=>1.0, :average_goals_scored=>2.67, :average_goals_against=>1.67},
        :regular_season=>{:total_goals_scored=>0, :total_goals_against=>0, :win_percentage=>0, :average_goals_scored=>0, :average_goals_against=>0}
      },
      "20132014"=>{
        :regular_season=>{:total_goals_scored=>2, :total_goals_against=>2, :win_percentage=>0.0, :average_goals_scored=>2.0, :average_goals_against=>2.0},
        :postseason=>{:total_goals_scored=>0, :total_goals_against=>0, :win_percentage=>0, :average_goals_scored=>0, :average_goals_against=>0}
      },
      "20142015"=>{
        :regular_season=>{:total_goals_scored=>2, :total_goals_against=>2, :win_percentage=>0.0, :average_goals_scored=>2.0, :average_goals_against=>2.0},
        :postseason=>{:total_goals_scored=>0, :total_goals_against=>0, :win_percentage=>0, :average_goals_scored=>0, :average_goals_against=>0}
      }
    }
    assert_equal expected, @stat_tracker.seasonal_summary("6")
  end



##### Season Statistics Tests #####

  def test_biggest_bust
    assert_equal "Seattle Sounders FC", @stat_tracker.biggest_bust("20122013")
  end

  def test_biggest_surprise
    assert_equal "Philadelphia Union", @stat_tracker.biggest_surprise("20142015")
  end

  def test_winningest_coach
    assert_equal "Adam Oates", @stat_tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Claude Julien", @stat_tracker.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal "Atlanta United", @stat_tracker.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    assert_equal "San Jose Earthquakes", @stat_tracker.least_accurate_team("20132014")
  end

  def test_most_tackles
    assert_equal "Philadelphia Union", @stat_tracker.most_tackles("20132014")
  end

  def test_fewest_tackles
    assert_equal "Seattle Sounders FC", @stat_tracker.fewest_tackles("20132014")
  end



##### Helper Method Tests #####

  def test_home_team?
    assert_equal true, @stat_tracker.home_team?("19", @stat_tracker.games["2013030161"])
    assert_equal false, @stat_tracker.home_team?("19", @stat_tracker.games["2014030153"])
  end

  def test_away_team?
    assert_equal true, @stat_tracker.away_team?("52", @stat_tracker.games["2015020849"])
    assert_equal false, @stat_tracker.away_team?("52", @stat_tracker.games["2015020314"])
  end

  def test_home_win?
    assert_equal true, @stat_tracker.home_win?("4", @stat_tracker.games["2016020070"])
    assert_equal false, @stat_tracker.home_win?("4", @stat_tracker.games["2015020797"])
  end

  def test_home_loss?
    assert_equal false, @stat_tracker.home_loss?("4", @stat_tracker.games["2016020070"])
    assert_equal true, @stat_tracker.home_loss?("4", @stat_tracker.games["2015020797"])
  end

  def test_away_win?
    assert_equal true, @stat_tracker.away_win?("21", @stat_tracker.games["2015020314"])
    assert_equal false, @stat_tracker.away_win?("13", @stat_tracker.games["2013020333"])
  end

  def test_away_loss?
    assert_equal false, @stat_tracker.away_loss?("21", @stat_tracker.games["2015020314"])
    assert_equal true, @stat_tracker.away_loss?("13", @stat_tracker.games["2013020333"])
  end

  def test_team_result_count
    expected = {
      "3" =>{:games=>3, :total_goals=>6, :goals_allowed=>7, :away_goals=>4, :away_games=>2, :home_goals=>2, :home_games=>1, :home_wins=>1},
      "6" =>{:games=>5, :total_goals=>12, :goals_allowed=>9, :home_goals=>8, :home_games=>3, :home_wins=>3, :away_goals=>4, :away_games=>2},
      "13"=>{:games=>4, :total_goals=>7, :goals_allowed=>10, :away_goals=>4, :away_games=>3, :home_goals=>3, :home_games=>1, :home_wins=>1},
      "2" =>{:games=>4, :total_goals=>11, :goals_allowed=>9, :home_goals=>9, :home_games=>3, :home_wins=>2, :away_goals=>2, :away_games=>1},
      "19"=>{:games=>5, :total_goals=>8, :goals_allowed=>13, :away_goals=>2, :away_games=>2, :home_goals=>6, :home_games=>3, :home_wins=>1},
      "28"=>{:games=>2, :total_goals=>5, :goals_allowed=>4, :home_goals=>3, :home_games=>1, :home_wins=>1, :away_goals=>2, :away_games=>1},
      "16"=>{:games=>3, :total_goals=>8, :goals_allowed=>4, :away_goals=>6, :away_games=>2, :away_wins=>2, :home_goals=>2, :home_games=>1, :home_wins=>1},
      "27"=>{:games=>2, :total_goals=>4, :goals_allowed=>7, :away_goals=>1, :away_games=>1, :home_goals=>3, :home_games=>1},
      "22"=>{:games=>2, :total_goals=>4, :goals_allowed=>4, :away_goals=>2, :away_games=>1, :home_goals=>2, :home_games=>1, :home_wins=>1},
      "30"=>{:games=>4, :total_goals=>11, :goals_allowed=>5, :away_goals=>1, :away_games=>1, :home_goals=>10, :home_games=>3, :home_wins=>3},
      "21"=>{:games=>2, :total_goals=>4, :goals_allowed=>3, :home_goals=>2, :home_games=>1, :away_goals=>2, :away_games=>1, :away_wins=>1},
      "1" =>{:games=>2, :total_goals=>4, :goals_allowed=>2, :away_goals=>2, :away_games=>1, :away_wins=>1, :home_goals=>2, :home_games=>1},
      "29"=>{:games=>3, :total_goals=>5, :goals_allowed=>7, :home_goals=>0, :home_games=>1, :away_goals=>5, :away_games=>2},
      "4" =>{:games=>5, :total_goals=>8, :goals_allowed=>13, :away_goals=>2, :away_games=>2, :home_goals=>6, :home_games=>3, :home_wins=>1},
      "15"=>{:games=>2, :total_goals=>6, :goals_allowed=>2, :home_goals=>2, :home_games=>1, :home_wins=>1, :away_goals=>4, :away_games=>1, :away_wins=>1},
      "52"=>{:games=>2, :total_goals=>2, :goals_allowed=>4, :home_goals=>1, :home_games=>1, :away_goals=>1, :away_games=>1},
      "12"=>{:games=>2, :total_goals=>5, :goals_allowed=>5, :home_goals=>2, :home_games=>1, :home_wins=>1, :away_goals=>3, :away_games=>1},
      "20"=>{:games=>3, :total_goals=>6, :goals_allowed=>9, :away_goals=>4, :away_games=>2, :home_goals=>2, :home_games=>1},
      "24"=>{:games=>4, :total_goals=>11, :goals_allowed=>7, :home_goals=>6, :home_games=>2, :home_wins=>2, :away_goals=>5, :away_games=>2, :away_wins=>2},
      "10"=>{:games=>3, :total_goals=>3, :goals_allowed=>6, :home_goals=>2, :home_games=>1, :away_goals=>1, :away_games=>2}
    }
    assert_equal expected, @stat_tracker.team_result_count
  end

  def test_opponent_stats
    expected = {
      "13"=>{:games=>1, :losses=>1},
      "27"=>{:games=>1, :losses=>1},
      "30"=>{:games=>1, :wins=>1},
      "29"=>{:games=>1}
    }
    assert_equal expected, @stat_tracker.opponent_stats("2")
  end

  def test_team_stats_by_season
    expected = {
      "20122013"=>{
        :postseason=>{:games=>3, :wins=>3, :goals_scored=>8, :goals_against=>5},
        :regular_season=>{}
      },
      "20132014"=>{
        :regular_season=>{:games=>1, :goals_scored=>2, :goals_against=>2},
        :postseason=>{}
      },
      "20142015"=>{
        :regular_season=>{:games=>1, :goals_scored=>2, :goals_against=>2},
        :postseason=>{}
      },
      "20152016"=>{
        :regular_season=>{},
        :postseason=>{}
      },
      "20162017"=>{
        :regular_season=>{},
        :postseason=>{}
      },
      "20172018"=>{
        :regular_season=>{},
        :postseason=>{}
      }
    }
    assert_equal expected, @stat_tracker.team_stats_by_season("6")
  end

  def test_coach_win_count
    expected = {
      "20122013"=>{
        "John Tortorella"=>{:games=>2},
        "Claude Julien"=>{:games=>3, :wins=>3},
        "Kevin Dineen"=>{:games=>1},
        "Jack Capuano"=>{:games=>1, :wins=>1},
        "Ken Hitchcock"=>{:games=>1},
        "Todd McLellan"=>{:games=>1, :wins=>1},
        "Randy Carlyle"=>{:games=>1},
        "Todd Richards"=>{:games=>1},
        "Dave Tippett"=>{:games=>1},
        "Bruce Boudreau"=>{:games=>1, :wins=>1},
        "Bob Hartley"=>{:games=>1}},
       "20132014"=>{
        "Joel Quenneville"=>{:games=>2, :wins=>2},
        "Ken Hitchcock"=>{:games=>2},
        "Dave Tippett"=>{:games=>1},
        "Jack Capuano"=>{:games=>1, :wins=>1},
        "Dallas Eakins"=>{:games=>2, :wins=>1},
        "Kevin Dineen"=>{:games=>1, :wins=>1},
        "Craig Berube"=>{:games=>1},
        "Alain Vigneault"=>{:games=>1, :wins=>1},
        "Peter Horachek"=>{:games=>1},
        "Claude Julien"=>{:games=>1},
        "Peter DeBoer"=>{:games=>1}},
      "20142015"=>{
        "Mike Yeo"=>{:games=>2, :wins=>1},
        "Ken Hitchcock"=>{:games=>2, :wins=>1},
        "Claude Julien"=>{:games=>1},
        "Patrick Roy"=>{:games=>1},
        "Adam Oates"=>{:games=>1, :wins=>1},
        "Todd Richards"=>{:games=>1},
        "Randy Carlyle"=>{:games=>1},
        "Joel Quenneville"=>{:games=>1, :wins=>1}},
      "20152016"=>{
        "Dave Hakstol"=>{:games=>3},
        "Barry Trotz"=>{:games=>2, :wins=>2},
        "Patrick Roy"=>{:games=>1, :wins=>1},
        "Paul Maurice"=>{:games=>2},
        "Bill Peters"=>{:games=>1, :wins=>1},
        "Bruce Boudreau"=>{:games=>1, :wins=>1}},
      "20162017"=>{
        "Glen Gulutzan"=>{:games=>2},
        "Randy Carlyle"=>{:games=>2, :wins=>2},
        "Tom Rowe"=>{:games=>1},
        "Bruce Boudreau"=>{:games=>1, :wins=>1},
        "Peter DeBoer"=>{:games=>1},
        "Mike Babcock"=>{:games=>1},
        "John Tortorella"=>{:games=>1},
        "Doug Weight"=>{:games=>1},
        "Bill Peters"=>{:games=>1},
        "Dave Hakstol"=>{:games=>1, :wins=>1}},
      "20172018"=>{
        "Doug Weight"=>{:games=>1},
        "Bruce Boudreau"=>{:games=>1, :wins=>1}
      }
    }
    assert_equal expected, @stat_tracker.coach_win_count
  end


  def test_team_tackles_and_shots
    expected = {
      "20122013"=>{
        "3"=>{:tackles=>77, :shots=>17, :goals=>4},
        "6"=>{:tackles=>117, :shots=>30, :goals=>8},
        "13"=>{:tackles=>22, :shots=>7, :goals=>2},
        "2"=>{:tackles=>15, :shots=>7, :goals=>3},
        "19"=>{:tackles=>22, :shots=>8, :goals=>2},
        "28"=>{:tackles=>30, :shots=>6, :goals=>3},
        "10"=>{:tackles=>37, :shots=>5, :goals=>1},
        "29"=>{:tackles=>36, :shots=>5, :goals=>3},
        "27"=>{:tackles=>35, :shots=>8, :goals=>3},
        "24"=>{:tackles=>17, :shots=>6, :goals=>3},
        "20"=>{:tackles=>17, :shots=>6, :goals=>2}},
      "20132014"=>{
        "16"=>{:tackles=>45, :shots=>17, :goals=>6},
        "19"=>{:tackles=>68, :shots=>20, :goals=>4},
        "27"=>{:tackles=>34, :shots=>8, :goals=>1},
        "2"=>{:tackles=>15, :shots=>7, :goals=>4},
        "22"=>{:tackles=>62, :shots=>14, :goals=>4},
        "13"=>{:tackles=>58, :shots=>11, :goals=>4},
        "4"=>{:tackles=>37, :shots=>3, :goals=>1},
        "3"=>{:tackles=>32, :shots=>9, :goals=>2},
        "6"=>{:tackles=>20, :shots=>7, :goals=>2},
        "1"=>{:tackles=>22, :shots=>6, :goals=>2}},
      "20142015"=>{
        "30"=>{:tackles=>64, :shots=>12, :goals=>4},
        "19"=>{:tackles=>62, :shots=>10, :goals=>2},
        "6"=>{:tackles=>27, :shots=>6, :goals=>2},
        "21"=>{:tackles=>26, :shots=>9, :goals=>2},
        "1"=>{:tackles=>25, :shots=>4, :goals=>2},
        "29"=>{:tackles=>29, :shots=>8, :goals=>0},
        "10"=>{:tackles=>34, :shots=>7, :goals=>0},
        "16"=>{:tackles=>22, :shots=>8, :goals=>2}},
      "20152016"=>{
        "4"=>{:tackles=>114, :shots=>25, :goals=>3},
        "15"=>{:tackles=>64, :shots=>11, :goals=>6},
        "21"=>{:tackles=>17, :shots=>7, :goals=>2},
        "52"=>{:tackles=>43, :shots=>10, :goals=>2},
        "12"=>{:tackles=>16, :shots=>7, :goals=>2},
        "24"=>{:tackles=>26, :shots=>6, :goals=>2}},
      "20162017"=>{
        "20"=>{:tackles=>67, :shots=>17, :goals=>4},
        "24"=>{:tackles=>68, :shots=>17, :goals=>6},
        "13"=>{:tackles=>16, :shots=>7, :goals=>1},
        "30"=>{:tackles=>13, :shots=>5, :goals=>3},
        "28"=>{:tackles=>23, :shots=>10, :goals=>2},
        "10"=>{:tackles=>20, :shots=>7, :goals=>2},
        "29"=>{:tackles=>24, :shots=>5, :goals=>2},
        "2"=>{:tackles=>23, :shots=>7, :goals=>2},
        "12"=>{:tackles=>19, :shots=>7, :goals=>3},
        "4"=>{:tackles=>13, :shots=>6, :goals=>4}},
      "20172018"=>{
        "2"=>{:tackles=>10, :shots=>8, :goals=>2},
        "30"=>{:tackles=>11, :shots=>8, :goals=>4}
      }
    }
    assert_equal expected, @stat_tracker.team_tack_shots
  end

  def test_season_counts
    expected = {
      "24"=>{:postseason=>{:games=>2, :wins=>2}},
      "20"=>{:postseason=>{:games=>2}},
      "30"=>{:regular_season=>{:games=>1, :wins=>1}},
      "13"=>{:regular_season=>{:games=>1}},
      "10"=>{:regular_season=>{:games=>1}},
      "28"=>{:regular_season=>{:games=>1}},
      "2"=>{:regular_season=>{:games=>1}},
      "29"=>{:regular_season=>{:games=>1}},
      "4"=>{:regular_season=>{:games=>1, :wins=>1}},
      "12"=>{:regular_season=>{:games=>1}}
    }
    assert_equal expected, @stat_tracker.season_counts("20162017")
  end

  def test_post_and_reg_percents
    expected = {
      "19"=>{:reg_percent=>0, :post_percent=>0.5},
      "30"=>{:reg_percent=>0, :post_percent=>0.5},
      "21"=>{:reg_percent=>0.0, :post_percent=>0},
      "6"=>{:reg_percent=>0.0, :post_percent=>0},
      "29"=>{:reg_percent=>0.0, :post_percent=>0},
      "1"=>{:reg_percent=>1.0, :post_percent=>0},
      "16"=>{:reg_percent=>1.0, :post_percent=>0},
      "10"=>{:reg_percent=>0.0, :post_percent=>0}
    }
    assert_equal expected, @stat_tracker.post_and_reg_percents("20142015")
  end

  ###### Test Helper Methods #####
  def stub_opponent_stats
    output = {
      "13"=>{:games=>4, :wins=>1, :losses=>3},
      "27"=>{:games=>4, :wins=>2, :losses=>2},
      "30"=>{:games=>4, :wins=>3, :losses=>1},
      "29"=>{:games=>4, :wins=>4, :losses=>0}
    }
    @stat_tracker.expects(:opponent_stats).returns(output)
  end

  def stub_team_stats_by_season
    output = {
      "20122013"=>{
        :postseason=>{:games=>3, :wins=>3, :goals_scored=>8, :goals_against=>5},
        :regular_season=>{:games=>0, :wins=>0, :goals_scored=>0, :goals_against=>0}
      },
      "20132014"=>{
        :regular_season=>{:games=>1, :wins=>0, :goals_scored=>2, :goals_against=>2},
        :postseason=>{:games=>0, :wins=>0, :goals_scored=>0, :goals_against=>0}
      },
      "20142015"=>{
        :regular_season=>{:games=>1, :wins=>0, :goals_scored=>2, :goals_against=>2},
        :postseason=>{:games=>0, :wins=>0, :goals_scored=>0, :goals_against=>0}
      }
    }
    @stat_tracker.expects(:team_stats_by_season).returns(output)
  end
end
