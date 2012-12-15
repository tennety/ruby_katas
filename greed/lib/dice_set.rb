module Greed
  class DiceSet
    attr_reader :size

    SPECIAL_THREES = { 1 => 1000,
                       5 => 500 }

    SPECIAL_ONES   = { 1 => 100,
                       5 => 50 }

    def initialize(size)
      @size = size
    end

    def roll
      (1..size).map{|i| rand(6) + 1}
    end

    def score
      counts_hash = roll.inject(Hash.new(0)){|hash, val| hash[val] += 1; hash}
      count_specials(counts_hash) + count_others(counts_hash)
    end

    private
    def count_specials(counts_hash)
      SPECIAL_THREES.collect do |val, points|
        count = counts_hash.delete(val) || 0
        if count >= 3
          points + (count - 3) * SPECIAL_ONES[val]
        else
          count * SPECIAL_ONES[val]
        end
      end.inject(:+)
    end

    def count_others(counts_hash)
      counts_hash.select{|val, count| count == 3}
      .inject(0){|sum, pair| sum + pair[0] * 100}
    end
  end
end
