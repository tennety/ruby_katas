require 'test_helper'

module Greed
  describe CliController do
    before do
      @controller = CliController.new
    end

    describe "#start_game" do
      it "creates a game" do
        @controller.start_game(3)
        @controller.game.wont_be :nil?
      end
    end
  end
end
