require 'minitest/autorun'
require 'pry'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/dice_set'
require_relative '../lib/score'

puts MiniTest::Unit::VERSION

module Greed
  describe Game do
    before do
      @game = Game.new(3)
    end

    it "starts with a given number of players" do
      @game.players.length.must_equal 3
      @game.players.all?{|p| p.must_be_instance_of Player }
    end
  end

  describe Player do
    before do
      @player = Player.new
    end

    it "starts with a set of dice" do
      @player.dice_set.must_be_instance_of DiceSet
    end


    describe "#take_turn" do
    end
  end

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

  describe Score do
    describe "#score" do
      it "is 1000 if three 1s are rolled" do
        Score.new([1, 1, 1]).score.must_equal 1000
      end
      it "is 600 if three 6s are rolled" do
        Score.new([6, 6, 6]).score.must_equal 600
      end
      it "is 500 if three 5s are rolled" do
        Score.new([5, 5, 5]).score.must_equal 500
      end
      it "is 400 if three 4s are rolled" do
        Score.new([4, 4, 4]).score.must_equal 400
      end
      it "is 300 if three 3s are rolled" do
        Score.new([3, 3, 3]).score.must_equal 300
      end
      it "is 200 if three 2s are rolled" do
        Score.new([2, 2, 2]).score.must_equal 200
      end
      it "is 100 if one 1 is rolled" do
        Score.new([1]).score.must_equal 100
      end
      it "is 50 if one 5 is rolled" do
        Score.new([5]).score.must_equal 50
      end
      it "is 250 for throw: 5 1 3 4 1" do
        Score.new([5, 1, 3, 4, 1]).score.must_equal 250
      end
      it "is 1100 for throw: 1 1 1 3 1" do
        Score.new([1, 1, 1, 3, 1]).score.must_equal 1100
      end
      it "is 450 for throw: 2 4 4 5 4" do
        Score.new([2, 4, 4, 5, 4]).score.must_equal 450
      end
    end

    describe "#non_scoring_dice" do
      it "is 2 for throw: 5 1 3 4 1" do
        Score.new([5, 1, 3, 4, 1]).non_scoring_dice.must_equal 2
      end
      it "is 1 for throw: 1 1 1 3 1" do
        Score.new([1, 1, 1, 3, 1]).non_scoring_dice.must_equal 1
      end
      it "is 1 for throw: 2 4 4 5 4" do
        Score.new([2, 4, 4, 5, 4]).non_scoring_dice.must_equal 1
      end
    end
  end
end
