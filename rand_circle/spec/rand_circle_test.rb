class RandCircle
  attr_reader :radius
  def initialize(radius)
    @radius = radius
  end
end

require 'minitest/autorun'

describe RandCircle do
  it "takes a radius" do
    r = RandCircle.new(5)
    r.radius.wont_be :nil?
  end
end
