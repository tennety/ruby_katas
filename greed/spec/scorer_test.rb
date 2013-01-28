require_relative 'test_helper'

module Greed
  describe Scorer do
    describe "#score" do
      it "is 1000 if three 1s are rolled" do
        Scorer.new([1, 1, 1]).score.must_equal 1000
      end
      it "is 600 if three 6s are rolled" do
        Scorer.new([6, 6, 6]).score.must_equal 600
      end
      it "is 500 if three 5s are rolled" do
        Scorer.new([5, 5, 5]).score.must_equal 500
      end
      it "is 400 if three 4s are rolled" do
        Scorer.new([4, 4, 4]).score.must_equal 400
      end
      it "is 300 if three 3s are rolled" do
        Scorer.new([3, 3, 3]).score.must_equal 300
      end
      it "is 200 if three 2s are rolled" do
        Scorer.new([2, 2, 2]).score.must_equal 200
      end
      it "is 100 if one 1 is rolled" do
        Scorer.new([1]).score.must_equal 100
      end
      it "is 50 if one 5 is rolled" do
        Scorer.new([5]).score.must_equal 50
      end
      it "is 250 for throw: 5 1 3 4 1" do
        Scorer.new([5, 1, 3, 4, 1]).score.must_equal 250
      end
      it "is 1100 for throw: 1 1 1 3 1" do
        Scorer.new([1, 1, 1, 3, 1]).score.must_equal 1100
      end
      it "is 450 for throw: 2 4 4 5 4" do
        Scorer.new([2, 4, 4, 5, 4]).score.must_equal 450
      end
    end

    describe "#non_scoring_dice" do
      it "is 2 for throw: 5 1 3 4 1" do
        Scorer.new([5, 1, 3, 4, 1]).non_scoring_dice.must_equal 2
      end
      it "is 1 for throw: 1 1 1 3 1" do
        Scorer.new([1, 1, 1, 3, 1]).non_scoring_dice.must_equal 1
      end
      it "is 1 for throw: 2 4 4 5 4" do
        Scorer.new([2, 4, 4, 5, 4]).non_scoring_dice.must_equal 1
      end
    end
  end
end
