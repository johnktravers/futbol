require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
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
    expected = ["Atlanta United", "New England Revolution", "Vancouver Whitecaps FC"]
    assert_equal expected, @stat_tracker.worst_fans.sort
    # assert_equal 3, @stat_tracker.worst_fans.length
    # assert_equal true, @stat_tracker.worst_fans.include?("New England Revolution")
    # assert_equal true, @stat_tracker.worst_fans.include?("Vancouver Whitecaps FC")
    # assert_equal true, @stat_tracker.worst_fans.include?("Atlanta United")
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
  end

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("3")
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
    assert_equal "FC Dallas", @stat_tracker.favorite_opponent("21")
    assert_equal "Orlando Pride", @stat_tracker.favorite_opponent("27")
  end

  def test_rival
    assert_equal "Orlando City SC", @stat_tracker.rival("2")
    assert_equal "Vancouver Whitecaps FC", @stat_tracker.rival("52")
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
    expected = {
      "20122013"=>{
        :postseason=>{:total_goals_scored=>8, :total_goals_against=>5, :win_percentage=>1.0, :average_goals_scored=>2.67, :average_goals_against=>1.67},
        :regular_season=>{:total_goals_scored=>0, :total_goals_against=>0, :win_percentage=>0, :average_goals_scored=>0, :average_goals_against=>0}
      },
      "20142015"=>{
        :postseason=>{:total_goals_scored=>0, :total_goals_against=>0, :win_percentage=>0, :average_goals_scored=>0, :average_goals_against=>0},
        :regular_season=>{:total_goals_scored=>2, :total_goals_against=>2, :win_percentage=>0.0, :average_goals_scored=>2.0, :average_goals_against=>2.0}
      },
      "20132014"=>{
        :postseason=>{:total_goals_scored=>0, :total_goals_against=>0, :win_percentage=>0, :average_goals_scored=>0, :average_goals_against=>0},
        :regular_season=>{:total_goals_scored=>2, :total_goals_against=>2, :win_percentage=>0.0, :average_goals_scored=>2.0, :average_goals_against=>2.0}
      }
    }
    assert_equal expected, @stat_tracker.seasonal_summary("6")
  end

##### Season Statistics Tests #####

  def test_winningest_coach
    assert_equal "Adam Oates", @stat_tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Claude Julien", @stat_tracker.worst_coach("20142015")
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

  def test_away_win?
    assert_equal true, @stat_tracker.away_win?("21", @stat_tracker.games["2015020314"])
    assert_equal false, @stat_tracker.away_win?("13", @stat_tracker.games["2013020333"])
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
        :post_games=>3,
        :post_wins=>3,
        :post_goals_scored=>8,
        :post_goals_against=>5
      },
      "20142015"=>{
        :reg_games=>1,
        :reg_goals_scored=>2,
        :reg_goals_against=>2
      },
      "20132014"=>{
        :reg_games=>1,
        :reg_goals_scored=>2,
        :reg_goals_against=>2
      }
    }
    assert_equal expected, @stat_tracker.team_stats_by_season("6")
  end

  def test_coach_win_count
    expected = {"20122013"=>{"John Tortorella"=>{:games=>2}, "Claude Julien"=>{:games=>3, :wins=>3}, "Kevin Dineen"=>{:games=>1}, "Jack Capuano"=>{:games=>1, :wins=>1}, "Ken Hitchcock"=>{:games=>1}, "Todd McLellan"=>{:games=>1, :wins=>1}, "Randy Carlyle"=>{:games=>1}, "Todd Richards"=>{:games=>1}, "Dave Tippett"=>{:games=>1}, "Bruce Boudreau"=>{:games=>1, :wins=>1}, "Bob Hartley"=>{:games=>1}}, "20132014"=>{"Joel Quenneville"=>{:games=>2, :wins=>2}, "Ken Hitchcock"=>{:games=>2}, "Dave Tippett"=>{:games=>1}, "Jack Capuano"=>{:games=>1, :wins=>1}, "Dallas Eakins"=>{:games=>2, :wins=>1}, "Kevin Dineen"=>{:games=>1, :wins=>1}, "Craig Berube"=>{:games=>1}, "Alain Vigneault"=>{:games=>1, :wins=>1}, "Peter Horachek"=>{:games=>1}, "Claude Julien"=>{:games=>1}, "Peter DeBoer"=>{:games=>1}}, "20142015"=>{"Mike Yeo"=>{:games=>2, :wins=>1}, "Ken Hitchcock"=>{:games=>2, :wins=>1}, "Claude Julien"=>{:games=>1}, "Patrick Roy"=>{:games=>1}, "Adam Oates"=>{:games=>1, :wins=>1}, "Todd Richards"=>{:games=>1}, "Randy Carlyle"=>{:games=>1}, "Joel Quenneville"=>{:games=>1, :wins=>1}}, "20152016"=>{"Dave Hakstol"=>{:games=>3}, "Barry Trotz"=>{:games=>2, :wins=>2}, "Patrick Roy"=>{:games=>1, :wins=>1}, "Paul Maurice"=>{:games=>2}, "Bill Peters"=>{:games=>1, :wins=>1}, "Bruce Boudreau"=>{:games=>1, :wins=>1}}, "20162017"=>{"Glen Gulutzan"=>{:games=>2}, "Randy Carlyle"=>{:games=>2, :wins=>2}, "Tom Rowe"=>{:games=>1}, "Bruce Boudreau"=>{:games=>1, :wins=>1}, "Peter DeBoer"=>{:games=>1}, "Mike Babcock"=>{:games=>1}, "John Tortorella"=>{:games=>1}, "Doug Weight"=>{:games=>1}, "Bill Peters"=>{:games=>1}, "Dave Hakstol"=>{:games=>1, :wins=>1}}, "20172018"=>{"Doug Weight"=>{:games=>1}, "Bruce Boudreau"=>{:games=>1, :wins=>1}}}
    assert_equal expected, @stat_tracker.coach_win_count
  end

end

{"20122013"=>{"John Tortorella"=>{:games=>60, :wins=>22}, "Claude Julien"=>{:games=>69, :wins=>38}, "Dan Bylsma"=>{:games=>63, :wins=>33}, "Mike Babcock"=>{:games=>62, :wins=>29}, "Joel Quenneville"=>{:games=>71, :wins=>38}, "Paul MacLean"=>{:games=>58, :wins=>21}, "Michel Therrien"=>{:games=>53, :wins=>22}, "Mike Yeo"=>{:games=>53, :wins=>14}, "Darryl Sutter"=>{:games=>66, :wins=>30}, "Ken Hitchcock"=>{:games=>54, :wins=>22}, "Bruce Boudreau"=>{:games=>55, :wins=>24}, "Jack Capuano"=>{:games=>54, :wins=>17}, "Adam Oates"=>{:games=>55, :wins=>22}, "Todd Richards"=>{:games=>48, :wins=>17}, "Kirk Muller"=>{:games=>48, :wins=>18}, "Peter DeBoer"=>{:games=>48, :wins=>16}, "Dave Tippett"=>{:games=>48, :wins=>16}, "Ron Rolston"=>{:games=>31, :wins=>9}, "Bob Hartley"=>{:games=>48, :wins=>17}, "Joe Sacco"=>{:games=>48, :wins=>14}, "Ralph Krueger"=>{:games=>48, :wins=>18}, "Randy Carlyle"=>{:games=>55, :wins=>24}, "Kevin Dineen"=>{:games=>48, :wins=>12}, "Todd McLellan"=>{:games=>59, :wins=>22}, "Barry Trotz"=>{:games=>48, :wins=>12}, "Lindy Ruff"=>{:games=>17, :wins=>8}, "Claude Noel"=>{:games=>48, :wins=>17}, "Peter Laviolette"=>{:games=>48, :wins=>15}, "Glen Gulutzan"=>{:games=>48, :wins=>21}, "Alain Vigneault"=>{:games=>52, :wins=>23}, "Guy Boucher"=>{:games=>31, :wins=>15}, "Jon Cooper"=>{:games=>15, :wins=>3}, "Martin Raymond"=>{:games=>1}, "Dan Lacroix"=>{:games=>1, :wins=>1}}, "20162017"=>{"Glen Gulutzan"=>{:games=>86, :wins=>38}, "Randy Carlyle"=>{:games=>99, :wins=>45}, "Peter Laviolette"=>{:games=>104, :wins=>44}, "Mike Yeo"=>{:games=>43, :wins=>22}, "Mike Babcock"=>{:games=>88, :wins=>28}, "Barry Trotz"=>{:games=>95, :wins=>50}, "John Tortorella"=>{:games=>87, :wins=>45}, "Mike Sullivan"=>{:games=>107, :wins=>53}, "Bruce Boudreau"=>{:games=>87, :wins=>43}, "Dave Hakstol"=>{:games=>82, :wins=>24}, "Joel Quenneville"=>{:games=>86, :wins=>33}, "Michel Therrien"=>{:games=>58, :wins=>31}, "Jack Capuano"=>{:games=>42, :wins=>12}, "Darryl Sutter"=>{:games=>82, :wins=>32}, "Paul Maurice"=>{:games=>82, :wins=>35}, "Dave Tippett"=>{:games=>82, :wins=>18}, "John Hynes"=>{:games=>82, :wins=>26}, "Doug Weight"=>{:games=>40, :wins=>17}, "Peter DeBoer"=>{:games=>88, :wins=>41}, "Guy Boucher"=>{:games=>101, :wins=>41}, "Jared Bednar"=>{:games=>82, :wins=>20}, "Bill Peters"=>{:games=>82, :wins=>32}, "Lindy Ruff"=>{:games=>82, :wins=>33}, "Claude Julien"=>{:games=>85, :wins=>38}, "Jeff Blashill"=>{:games=>82, :wins=>26}, "Willie Desjardins"=>{:games=>82, :wins=>25}, "Tom Rowe"=>{:games=>60, :wins=>23}, "Ken Hitchcock"=>{:games=>50, :wins=>21}, "Todd McLellan"=>{:games=>95, :wins=>47}, "Jon Cooper"=>{:games=>82, :wins=>33}, "Alain Vigneault"=>{:games=>94, :wins=>44}, "Bruce Cassidy"=>{:games=>33, :wins=>21}, "Dan Bylsma"=>{:games=>82, :wins=>30}, "Gerard Gallant"=>{:games=>22, :wins=>7}},
"20142015"=>{
  "Joel Quenneville"=>{:games=>105, :wins=>44},
  "Jon Cooper"=>{:games=>108, :wins=>45},
  "Mike Johnston"=>{:games=>87, :wins=>37},
  "Alain Vigneault"=>{:games=>101, :wins=>52},
  "Mike Yeo"=>{:games=>92, :wins=>42},
  "Ken Hitchcock"=>{:games=>88, :wins=>38},
  "Dave Cameron"=>{:games=>61, :wins=>26},
  "Michel Therrien"=>{:games=>94, :wins=>46},
  "Barry Trotz"=>{:games=>96, :wins=>49},
  "Jack Capuano"=>{:games=>89, :wins=>40},
  "Paul Maurice"=>{:games=>86, :wins=>36},
  "Bruce Boudreau"=>{:games=>98, :wins=>48}, "Darryl Sutter"=>{:games=>82, :wins=>33}, "Todd Richards"=>{:games=>82, :wins=>26}, "Bill Peters"=>{:games=>82, :wins=>25}, "Dave Tippett"=>{:games=>82, :wins=>19}, "Dallas Eakins"=>{:games=>31, :wins=>9}, "Todd McLellan"=>{:games=>82, :wins=>31}, "Patrick Roy"=>{:games=>82, :wins=>29}, "Claude Julien"=>{:games=>82, :wins=>31}, "Craig Berube"=>{:games=>82, :wins=>27}, "Lindy Ruff"=>{:games=>82, :wins=>29}, "Gerard Gallant"=>{:games=>82, :wins=>24}, "Peter Horachek"=>{:games=>42, :wins=>9}, "Todd Nelson"=>{:games=>46, :wins=>10}, "Mike Babcock"=>{:games=>89, :wins=>37}, "Ted Nolan"=>{:games=>82, :wins=>15}, "Bob Hartley"=>{:games=>93, :wins=>35}, "Adam Oates"=>{:games=>46, :wins=>16}, "Willie Desjardins"=>{:games=>88, :wins=>42}, "Peter Laviolette"=>{:games=>88, :wins=>45}, "Peter DeBoer"=>{:games=>36, :wins=>12}, "Randy Carlyle"=>{:games=>40, :wins=>18}, "Paul MacLean"=>{:games=>27, :wins=>8}, "Craig MacTavish"=>{:games=>5, :wins=>1}}, "20152016"=>{"Alain Vigneault"=>{:games=>87, :wins=>39}, "Mike Sullivan"=>{:games=>78, :wins=>41}, "Peter DeBoer"=>{:games=>106, :wins=>52}, "Darryl Sutter"=>{:games=>87, :wins=>43}, "Dave Hakstol"=>{:games=>88, :wins=>29}, "Barry Trotz"=>{:games=>94, :wins=>53}, "John Torchetti"=>{:games=>33, :wins=>12}, "Lindy Ruff"=>{:games=>95, :wins=>39}, "Jack Capuano"=>{:games=>93, :wins=>35}, "Gerard Gallant"=>{:games=>88, :wins=>40}, "Joel Quenneville"=>{:games=>89, :wins=>43}, "Ken Hitchcock"=>{:games=>102, :wins=>48}, "Jon Cooper"=>{:games=>99, :wins=>45}, "Patrick Roy"=>{:games=>82, :wins=>35}, "Paul Maurice"=>{:games=>82, :wins=>32}, "Bill Peters"=>{:games=>82, :wins=>33}, "Mike Babcock"=>{:games=>82, :wins=>24}, "Todd McLellan"=>{:games=>82, :wins=>26}, "Mike Johnston"=>{:games=>28, :wins=>9}, "John Hynes"=>{:games=>82, :wins=>32}, "Bruce Boudreau"=>{:games=>89, :wins=>39}, "Peter Laviolette"=>{:games=>96, :wins=>42}, "Bob Hartley"=>{:games=>82, :wins=>29}, "Dan Bylsma"=>{:games=>82, :wins=>32}, "Willie Desjardins"=>{:games=>82, :wins=>23}, "Claude Julien"=>{:games=>81, :wins=>33}, "John Tortorella"=>{:games=>75, :wins=>27}, "Dave Cameron"=>{:games=>82, :wins=>29}, "Dave Tippett"=>{:games=>82, :wins=>29}, "Jeff Blashill"=>{:games=>87, :wins=>33}, "Mike Yeo"=>{:games=>55, :wins=>25}, "Michel Therrien"=>{:games=>82, :wins=>26}, "Todd Richards"=>{:games=>7}}, "20132014"=>{"Joel Quenneville"=>{:games=>101, :wins=>47}, "Ken Hitchcock"=>{:games=>88, :wins=>37}, "Mike Yeo"=>{:games=>95, :wins=>37}, "Patrick Roy"=>{:games=>89, :wins=>36}, "Darryl Sutter"=>{:games=>108, :wins=>53}, "Bruce Boudreau"=>{:games=>95, :wins=>49}, "Lindy Ruff"=>{:games=>88, :wins=>34}, "John Tortorella"=>{:games=>82, :wins=>33}, "Craig Berube"=>{:games=>86, :wins=>34}, "Mike Babcock"=>{:games=>87, :wins=>31}, "Todd Richards"=>{:games=>88, :wins=>38}, "Adam Oates"=>{:games=>82, :wins=>22}, "Bob Hartley"=>{:games=>82, :wins=>24}, "Barry Trotz"=>{:games=>82, :wins=>31}, "Claude Julien"=>{:games=>94, :wins=>54}, "Michel Therrien"=>{:games=>99, :wins=>44}, "Dan Bylsma"=>{:games=>95, :wins=>46}, "Jack Capuano"=>{:games=>82, :wins=>22}, "Claude Noel"=>{:games=>47, :wins=>13}, "Jon Cooper"=>{:games=>86, :wins=>29}, "Kevin Dineen"=>{:games=>16, :wins=>3}, "Todd McLellan"=>{:games=>89, :wins=>41}, "Ted Nolan"=>{:games=>62, :wins=>13}, "Randy Carlyle"=>{:games=>82, :wins=>22}, "Dave Tippett"=>{:games=>82, :wins=>28}, "Peter DeBoer"=>{:games=>82, :wins=>31}, "Peter Horachek"=>{:games=>66, :wins=>15}, "Paul Maurice"=>{:games=>35, :wins=>12}, "Paul MacLean"=>{:games=>82, :wins=>24}, "Dallas Eakins"=>{:games=>82, :wins=>19}, "Alain Vigneault"=>{:games=>107, :wins=>49}, "Kirk Muller"=>{:games=>82, :wins=>31}, "Ron Rolston"=>{:games=>20, :wins=>2}, "Peter Laviolette"=>{:games=>3}}, "20172018"=>{"Peter DeBoer"=>{:games=>92, :wins=>44}, "Gerard Gallant"=>{:games=>102, :wins=>51}, "Randy Carlyle"=>{:games=>86, :wins=>32}, "Barry Trotz"=>{:games=>106, :wins=>48}, "Jon Cooper"=>{:games=>99, :wins=>47}, "John Tortorella"=>{:games=>88, :wins=>37}, "Paul Maurice"=>{:games=>99, :wins=>48}, "Peter Laviolette"=>{:games=>95, :wins=>43}, "John Stevens"=>{:games=>86, :wins=>40}, "Bruce Cassidy"=>{:games=>94, :wins=>50}, "Dave Hakstol"=>{:games=>88, :wins=>31}, "Mike Sullivan"=>{:games=>94, :wins=>48}, "John Hynes"=>{:games=>87, :wins=>33}, "Mike Babcock"=>{:games=>89, :wins=>36}, "Jared Bednar"=>{:games=>88, :wins=>39}, "Bruce Boudreau"=>{:games=>87, :wins=>39}, "Phil Housley"=>{:games=>82, :wins=>20}, "Glen Gulutzan"=>{:games=>82, :wins=>30}, "Travis Green"=>{:games=>82, :wins=>26}, "Ken Hitchcock"=>{:games=>82, :wins=>31}, "Doug Weight"=>{:games=>82, :wins=>30}, "Rick Tocchet"=>{:games=>82, :wins=>28}, "Todd McLellan"=>{:games=>82, :wins=>27}, "Bill Peters"=>{:games=>82, :wins=>35}, "Claude Julien"=>{:games=>82, :wins=>25}, "Bob Boughner"=>{:games=>82, :wins=>38}, "Alain Vigneault"=>{:games=>82, :wins=>24}, "Guy Boucher"=>{:games=>82, :wins=>23}, "Mike Yeo"=>{:games=>82, :wins=>38}, "Joel Quenneville"=>{:games=>82, :wins=>31}, "Jeff Blashill"=>{:games=>82, :wins=>29}}}
