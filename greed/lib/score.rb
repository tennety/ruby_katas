module Greed
  class Score
    attr_reader :roll, :occurrences_by_number

    SPECIAL_THREES = { 1 => 1000,
                       5 => 500 }

    SPECIAL_ONES   = { 1 => 100,
                       5 => 50 }

    def initialize(roll)
      @roll = roll
      @occurrences_by_number = roll.inject(Hash.new(0)){|hash, val| hash[val] += 1; hash}
    end

    def score
      count_specials + count_others
    end

    def non_scoring_dice
      @occurrences_by_number.dup.delete_if do |face_val, cnt|
        SPECIAL_ONES.keys.include?(face_val) || cnt == 3
      end.keys.length
    end

    def count_specials
      SPECIAL_THREES.collect do |val, points|
        count = occurrences_by_number[val] || 0
        if count >= 3
          points + (count - 3) * SPECIAL_ONES[val]
        else
          count * SPECIAL_ONES[val]
        end
      end.inject(:+)
    end

    def count_others
      occurrences_by_number.select do |val, count|
        !SPECIAL_ONES.keys.include?(val) && count == 3
      end.inject(0){|sum, pair| sum + pair[0] * 100}
    end
  end
end
