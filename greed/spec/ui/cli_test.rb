require_relative '../test_helper'
require_relative 'ui_test'

module Greed
  module UI
    describe CLI do
      before do
        @ui = CLI.new
      end

      it_behaves_like 'UI'

      describe "#write" do
        it "takes a message argument" do
          lambda{ @ui.write }.must_raise ArgumentError
        end

        it "puts the message on STDOUT" do
          stdout = Object.const_get(:STDOUT)
          Object.const_set('STDOUT', MiniTest::Mock.new)

          STDOUT.expect(:puts, nil, ["Hi!"])
          @ui.write("Hi!")
          STDOUT.verify

          Module.const_set('STDOUT', stdout)
        end
      end
    end
  end
end
