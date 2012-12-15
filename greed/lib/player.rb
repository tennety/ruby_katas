module Greed
  class Player
    attr_reader :dice_set

    def initialize
      @dice_set = DiceSet.new(5)
    end
  end
end
