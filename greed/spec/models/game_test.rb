require 'test_helper'

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
end
