require_relative 'test_helper'

module Greed
  describe Options do
    describe ".configure" do
      it "allows options to be set" do
        Options.configure do |config|
          config.foo = "bar"
        end
        Options.options.foo.must_equal "bar"
      end
    end
  end
end
