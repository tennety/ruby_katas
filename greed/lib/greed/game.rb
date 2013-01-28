module Greed
  class Game
    attr_reader :players

    def initialize(no_of_players)
      @players = (1..no_of_players).collect{ |i| Player.new }
      ui.write "Starting a game of Greed with #{no_of_players} players..."
    end

    def create_round
      Round.new(players)
    end

    private
    def ui
      Options.options.ui
    end
  end
end
