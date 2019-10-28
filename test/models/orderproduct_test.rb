require "test_helper"

describe Orderproduct do
  describe 'validations' do
    before do
      @orderproduct = orderproducts(:op1)
    end
    it 'is valid when quantity is present and a positive integer' do
      expect(@orderproduct.valid?).must_equal true
    end
it 'is invalid when quantity is not present' do
  @orderproduct.quantity = nil
  expect(@orderproduct.valid?).must_equal false
  expect(@orderproduct.errors.messages).must_include :quantity
end
it 'is invalid when quantity is not positive' do
end

    it 'can set the products' do
      order = Order.new
      order.products << products(:magician)
      order.products.first.id.must_equal products(:magician).id
    end
  end