module Greed
  class Player
    attr_reader :dice_set

    def initialize
      @dice_set = DiceSet.new(5)
    end

    def roll_score
      throw = @dice_set.roll
      counts_hash = throw.inject(Hash.new(0)){|hash, val| hash[val] += 1; hash}
      count_ones(counts_hash.delete(1) || 0) + count_fives(counts_hash.delete(5) || 0) + count_others(counts_hash)
    end

    def count_ones(count)
      if count >= 3
        1000 + (count - 3) * 100
      else count > 0
        count * 100
      end
    end

    def count_fives(count)
      if count >= 3
        500 + (count - 3) * 50
      else count > 0
        count * 50
      end
    end

    def count_others(counts_hash)
      counts_hash.select{|val, count| count == 3}
      .inject(0){|sum, pair| sum + pair[0] * 100}
    end
  end
end
