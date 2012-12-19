module Greed
  class Player
    attr_reader :dice_set, :total, :last_roll

    def initialize
      @dice_set = DiceSet.new(5)
      @total = 0
      @last_roll = []
    end

    def roll
      @last_roll = dice_set.roll
      @total += last_score
      last_size = @dice_set.size
      @dice_set = DiceSet.new(last_size - scorer.non_scoring_dice)
    end

    def last_score
      scorer.score
    end

    def scorer
      Scorer.new(last_roll)
    end
  end
end
