require 'test_helper'

module Greed
  describe Game do
    before do
      ui = Class.new do
        def write(msg)  ; end
        def ask(msg)    ; end
        def notify(msg) ; end
      end.new

      Options.configure do |config|
        config.ui = ui
      end

      @game = Game.new(3)
    end

    it "starts with a given number of players" do
      @game.players.length.must_equal 3
      @game.players.all?{|p| p.must_be_kind_of Player }
    end

    it "starts by writing a start message to the UI" do
      ui = MiniTest::Mock.new
      ui.expect(:write, nil, [String])

      Options.configure do |config|
        config.ui = ui
      end

      game = Game.new(3)
      ui.verify
    end

    describe "#create_round" do
      it "creates a round" do
        @game.create_round.must_be_kind_of Round
      end
    end
  end
end
