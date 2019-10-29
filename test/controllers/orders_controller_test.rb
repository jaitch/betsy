require "test_helper"

describe OrdersController do
  describe 'show' do
    it 'responds with success when showing a valid order (cart)' do
      valid_order = Order.first
      get order_path(valid_order.id)
      must_respond_with :success
    end
    it 'responds with failure when asked to show an invalid order (cart)' do
      get order_path(-42)
      must_redirect_to products_path
    end
  end

  describe 'new action' do
    it 'creates a new order when a guest adds a product to the cart' do
      product_id = products(:clown).id
      expect { post product_orderproducts_path(product_id) }.must_differ 'Order.count', 1
    end
  end

end
