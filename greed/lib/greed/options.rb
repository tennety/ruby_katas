require 'ostruct'

module Greed
  module Options
    @options ||= OpenStruct.new

    def self.configure
      yield @options
    end

    def self.method_missing(method, *args, &block)
      @options.send(method, *args, &block)
    end
  end
end

