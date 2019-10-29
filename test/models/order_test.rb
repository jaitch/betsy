require "test_helper"

describe Order do
  describe 'validations' do
    it 'can be made with valid input' do
    end
  end

  describe 'relations' do
    it 'has products' do
      order = orders(:c)
      order.products.length.must_equal 2
    end

    it 'can set the products' do
      order = Order.new
      order.products << products(:magician)
      order.products.first.id.must_equal products(:magician).id
    end
  end
end
