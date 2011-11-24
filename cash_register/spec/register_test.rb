class CashRegister
  def initialize
    @items = []
  end

  def total
    @items.inject(0, &:+)
  end

  def scan(price)
    @items << price
  end

  def clear
    @items = []
  end
end

require 'minitest/autorun'

describe CashRegister do
  before do
    @register = CashRegister.new
  end

  describe '#total' do
    it 'default is zero' do
      @register.total.must_equal 0
    end

    it 'shows the total of the items scanned' do
      num_items = rand(20) + 1
      num_items.times { @register.scan 5.0 }
      @register.total.must_equal num_items*5.0
    end
  end

  describe '#scan' do
    it 'takes a price' do
      ->{ @register.scan }.must_raise ArgumentError
    end

    it 'adds the price to the total' do
      price = rand(10) + 1
      @register.total.must_equal 0

      @register.scan price
      @register.total.must_equal price
    end
  end

  describe '#clear' do
    it 'resets the total to 0' do
      2.times { @register.scan(2) }
      @register.total.must_equal 4

      @register.clear
      @register.total.must_equal 0
    end
  end
end
