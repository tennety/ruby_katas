module Greed
  class CliController
    attr_reader :game
    def start_game(num_players)
      @game = Game.new(num_players)
    end
  end
end
