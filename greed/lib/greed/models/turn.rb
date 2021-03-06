module Greed
  class Turn
    attr_reader :player, :position, :running_total

    def initialize(player, position = 1)
      @player = player
      @position = position
      @running_total = 0
    end

    def keep_going
      player.roll
      if player.last_score.zero?
        @running_total = 0
      else
        @running_total += player.last_score
      end
      if !player.in_the_game? && @running_total >= 300
        player.mark_as_in_the_game
      end
    end

    def over?
      (!player.starting? && player.last_score.zero?) || player.wants_to_stop?
    end

    def stop
      player.total += running_total if player.in_the_game?
    end
  end
end
