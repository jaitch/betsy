require "test_helper"

describe Orderproduct do
  it 'can set the products' do
    order = Order.new
    order.products << products(:magician)
    order.products.first.id.must_equal products(:magician).id
  end
end