require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @test_line = '2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7'.split(',')
    @game_team = GameTeam.new(@test_line)
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_initialize
    assert_equal "2012030221", @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal 'away', @game_team.hoa
    assert_equal 'LOSS', @game_team.result
    assert_equal 'John Tortorella', @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 44, @game_team.tackles
  end


end
