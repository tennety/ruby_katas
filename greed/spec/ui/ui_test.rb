require_relative '../test_helper'

module Greed
  module UI
    shared_examples_for "UI" do
      describe "UI interactions" do
        it "can write" do
          @ui.must_respond_to :write
        end

        it "can ask" do
          @ui.must_respond_to :ask
        end

        it "can notify" do
          @ui.must_respond_to :notify
        end
      end
    end
  end
end
