require 'ostruct'

module Greed
  module Options
    @options ||= OpenStruct.new

    def self.configure
      yield @options
    end

    def self.options
      @options
    end
  end
end

