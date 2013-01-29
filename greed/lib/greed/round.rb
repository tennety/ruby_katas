module Greed
  class Round

    def initialize(players)
      @players = players.each(&:with_new_dice_set)
    end

    def play
      turns = create_turns
      turns.each do |turn|
        ui.write "\nPlayer #{turn.position}'s turn:"
        until turn.over?
          turn.keep_going
        end
        turn.stop
      end
    end

    private
    def ui
      Options.ui
    end

    def create_turns
      @players.map.with_index do |player, i|
        Turn.new(player, i)
      end
    end
  end
end
