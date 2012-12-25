module Greed
  class Player
    attr_reader :dice_set, :last_roll
    attr_accessor :total

    def initialize
      @dice_set = DiceSet.new(5)
      @total = 0
      @last_roll = []
      @in_the_game = false
    end

    def roll
      @last_roll = dice_set.roll
      last_size = @dice_set.size
      @dice_set = DiceSet.new(last_size - scorer.non_scoring_dice)
    end

    def last_score
      scorer.score
    end

    def scorer
      Scorer.new(last_roll)
    end

    def in_the_game?
      @in_the_game
    end

    def mark_as_in_the_game
      @in_the_game = true
    end
  end
end
