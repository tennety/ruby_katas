class Game
  attr_reader :players

  def initialize(no_of_players)
    @players = Array.new(no_of_players, Player.new)
  end
end

class Player
end

require 'minitest/autorun'

describe Game do
  before do
    @game = Game.new(3)
  end

  it "starts with a given number of players" do
    @game.players.length.must_equal 3
    @game.players.all?{|p| p.must_be_instance_of Player }
  end
end
