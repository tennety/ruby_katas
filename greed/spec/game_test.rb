require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/dice_set'

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
  end

  describe DiceSet do
    before do
      @dice_set = DiceSet.new(5)
    end

    it "starts with a given number of dice" do
      @dice_set.size.must_equal 5
    end

    describe "#roll" do
      it "consists of 5 die scores" do
        roll = @dice_set.roll
        roll.length.must_equal 5
        roll.all?{|i| (1..6).must_include i}
      end
    end
  end
end
