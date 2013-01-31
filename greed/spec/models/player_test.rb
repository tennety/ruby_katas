require 'test_helper'

module Greed
  describe Player do
    before do
      @player = Player.new
    end

    it "starts with a set of dice" do
      @player.dice_set.must_be_kind_of DiceSet
    end

    it "starts with a total score of 0" do
      @player.total.must_equal 0
    end

    it "starts with an empty last roll" do
      @player.last_roll.must_equal []
    end

    it "starts as not in the game" do
      @player.in_the_game?.must_equal false
    end

    describe "#mark_as_in_the_game" do
      it "sets the player as in the game" do
        @player.mark_as_in_the_game
        @player.in_the_game?.must_equal true
      end
    end

    describe "#roll" do
      it "rolls the dice set" do
        @mock_dice = MiniTest::Mock.new
        @player.stub(:dice_set, @mock_dice) do
          @mock_dice.expect(:roll, [])
          @player.roll
          @mock_dice.verify
        end
      end

      it "removes the non-scoring dice from the dice set" do
        @player.dice_set.stub(:roll, [5, 1, 3, 4, 1]) do
          @player.roll
          @player.dice_set.size.must_equal 3
        end
      end
    end

    describe "#last_roll" do
      it "caches the last roll of the dice set" do
        @player.dice_set.stub(:roll, [5]) do
          @player.roll
          @player.last_roll.must_equal [5]
        end
      end
    end

    describe "#last_score" do
      it "scores the last roll" do
        @player.dice_set.stub(:roll, [5]) do
          @player.roll
          @player.last_score.must_equal 50
        end
      end
    end

    describe "#scorer" do
      it "returns a Scorer instance with the last roll" do
        @player.dice_set.stub(:roll, [5]) do
          @player.roll
          @player.scorer.roll.must_equal [5]
        end
      end
    end

    describe "#with_new_dice_set" do
      it "resets the player's dice set to the default" do
        @player.stub(:last_roll, [1,1,1,2,3]) do
          @player.roll
          @player.dice_set.size.must_equal 3
          @player.with_new_dice_set
          @player.dice_set.size.must_equal 5
        end
      end
    end
  end
end
