module Greed
  class Game
    attr_reader :players

    def initialize(no_of_players)
      @players = Array.new(no_of_players, Player.new)
    end
  end
end
