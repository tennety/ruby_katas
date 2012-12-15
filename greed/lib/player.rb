module Greed
  class Player
    attr_reader :dice_set, :total

    def initialize
      @dice_set = DiceSet.new(5)
      @total = 0
    end
  end
end
