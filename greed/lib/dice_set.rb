module Greed
  class DiceSet
    attr_reader :size
    def initialize(size)
      @size = size
    end

    def roll
      (1..size).map{|i| rand(6) + 1}
    end
  end
end
