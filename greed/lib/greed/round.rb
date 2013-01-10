module Greed
  class Round

    def initialize(players)
      @players = players.each(&:with_new_dice_set)
    end

    def play
      turns = @players.collect do |player|
        Turn.new(player)
      end
      turns.each do |turn|
        until turn.over?
          turn.keep_going
        end
        turn.stop
      end
    end
  end
end
