module Greed
  class Game
    attr_reader :players

    def initialize(no_of_players)
      @players = (1..no_of_players).collect{ |i| Player.new }
    end

    def create_round
      Round.new(players)
    end
  end
end
