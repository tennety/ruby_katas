require 'minitest/autorun'
require 'pry'
require_relative '../greed'

module Greed
  describe Game do
    before do
      @game = Game.new(3)
    end

    it "starts with a given number of players" do
      @game.players.length.must_equal 3
      @game.players.all?{|p| p.must_be_kind_of Player }
    end

    describe "#create_round" do
      it "creates a round" do
        @game.create_round.must_be_kind_of Round
      end
    end
  end

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

  describe Turn do
    before do
      @turn = Turn.new(Player.new)
    end
    it "starts with a player" do
      @turn.player.must_be_kind_of Player
    end

    it "starts with a running total of zero" do
      @turn.running_total.must_equal 0
    end

    describe "#keep_going" do
      describe "with non-zero score" do
        it "adds the score to the running total" do
          @turn.running_total.must_equal 0
          @turn.player.stub(:last_score, 50) do
            @turn.keep_going
            @turn.running_total.must_equal 50
          end
        end
      end

      describe "with zero score" do
        it "zeroes the running total" do
          @turn.player.stub(:last_score, 50) do
            @turn.keep_going
            @turn.running_total.must_equal 50
          end
          @turn.player.stub(:last_score, 0) do
            @turn.keep_going
            @turn.running_total.must_equal 0
          end
        end
      end

      describe "when running total exceeds 300" do
        it "marks the player as in the game" do
          @turn.player.stub(:last_score, 1000) do
            @turn.keep_going
            @turn.player.in_the_game?.must_equal true
          end
        end
      end
    end

    describe "#over?" do
      describe "when the last roll is zero" do
        it "returns true" do
          @turn.player.stub(:last_score, 0) do
            @turn.keep_going
            @turn.over?.must_equal true
          end
        end
      end

      describe "when the last roll is non-zero" do
        describe "when the player does not want to stop" do
          it "returns false" do
            @turn.player.stub(:last_score, 50) do
              @turn.player.stub(:wants_to_stop?, false) do
                @turn.keep_going
                @turn.over?.must_equal false
              end
            end
          end
        end

        describe "when the player wants to stop" do
          it "returns true" do
            @turn.player.stub(:last_score, 50) do
              @turn.player.stub(:wants_to_stop?, true) do
                @turn.keep_going
                @turn.over?.must_equal true
              end
            end
          end
        end
      end
    end

    describe "#stop" do
      describe "when the player is in the game" do
        it "adds the running total to the player's total" do
          @turn.player.stub(:in_the_game?, true) do
            @turn.player.stub(:last_score, 100) do
              @turn.keep_going
              @turn.stop
              @turn.player.total.must_equal 100
            end
          end
        end
      end

      describe "when the player is not in the game" do
        it "does nothing" do
          @turn.player.stub(:in_the_game?, false) do
            @turn.player.stub(:last_score, 100) do
              @turn.keep_going
              @turn.stop
              @turn.player.total.must_equal 0
            end
          end
        end
      end
    end
  end

  describe Round do
    before do
      @players = Array.new(2, Player.new)
      @round = Round.new(@players)
    end

    describe "#play" do
      it "creates a turn for each player" do
        turns = @round.play
        turns.map(&:player).sort.must_equal @players.sort
      end

      describe "when the turn is over" do
        it "stops the turn" do
          turn = MiniTest::Mock.new
          turn.expect(:over?, true)
          turn.expect(:stop, nil)
          @players.stub(:collect, [turn]) do
            @round.play
            turn.verify
          end
        end
      end

      describe "when the turn is not over" do
        it "keeps the turn going" do
          turn = MiniTest::Mock.new

          #first "until" call
          turn.expect(:over?, false)
          turn.expect(:keep_going, nil)

          #next "until" call
          turn.expect(:over?, true)
          turn.expect(:stop, nil)

          @players.stub(:collect, [turn]) do
            @round.play
            turn.verify
          end
        end
      end
    end
  end
end
