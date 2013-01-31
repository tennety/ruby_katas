require 'test_helper'

module Greed
  describe Turn do
    before do
      @turn = Turn.new(Player.new)
    end
    it "starts with a player" do
      @turn.player.must_be_kind_of Player
    end

    it "remembers the position of the player" do
      @turn.position.must_equal 1
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
end
