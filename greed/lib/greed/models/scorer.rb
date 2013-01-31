module Greed
  class Scorer
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
      occurrences_by_number.reject do |face_val, cnt|
        has_special_scoring?(face_val) || cnt == 3
      end.length
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
        !has_special_scoring?(val) && count == 3
      end.collect{|val, count| val * 100}.inject(:+).to_i
    end

    private
    def has_special_scoring?(value)
      SPECIAL_ONES.keys.include?(value)
    end
  end
end
