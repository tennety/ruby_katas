require 'test_helper'

module Greed
  describe DiceSet do
    before do
      @dice_set = DiceSet.new(5)
    end

    it "starts with a given number of dice" do
      @dice_set.size.must_equal 5
    end

    describe "#roll" do
      it "consists of all the die scores" do
        roll = @dice_set.roll
        roll.length.must_equal @dice_set.size
        roll.all?{|i| (1..6).must_include i}
      end
    end
  end
end
