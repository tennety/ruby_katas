require 'test_helper'

module Greed
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
          turn.expect(:position, 1)

          turn.expect(:over?, true)
          turn.expect(:stop, nil)

          @round.stub(:create_turns, [turn]) do
            @round.play
            turn.verify
          end
        end
      end

      describe "when the turn is not over" do
        it "keeps the turn going" do
          turn = MiniTest::Mock.new
          turn.expect(:position, 1)

          #first "until" call
          turn.expect(:over?, false)
          turn.expect(:keep_going, nil)

          #next "until" call
          turn.expect(:over?, true)
          turn.expect(:stop, nil)

          @round.stub(:create_turns, [turn]) do
            @round.play
            turn.verify
          end
        end
      end
    end
  end
end
