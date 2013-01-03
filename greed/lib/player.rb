module Greed
  class Player
    attr_reader :dice_set, :last_roll
    attr_accessor :total

    def initialize
      with_new_dice_set
      @total = 0
      @last_roll = []
      @in_the_game = false

      #for exit condition
      @stop =  2
      @rolls = 0
    end

    def roll
      @last_roll = dice_set.roll
      @rolls += 1
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

    def winning?
      total >= 3000
    end

    def wants_to_stop?
      @rolls >= @stop
    end

    def has_rolled?
      @rolls > 0
    end

    def with_new_dice_set
      @dice_set = DiceSet.new(5)
      @rolls = 0
    end

    def starting?
      @rolls == 0
    end
  end
end
