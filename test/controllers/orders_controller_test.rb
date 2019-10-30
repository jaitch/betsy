require "test_helper"
require 'pry'

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

  describe 'new/create action' do
    it 'creates a new order when a guest adds a product to the cart' do
      product_id = products(:clown).id
      expect { post product_orderproducts_path(product_id) }.must_differ 'Order.count', 1
    end
  end

  describe 'update action' do
    it 'enables buyer to check out' do
      product_id = products(:clown).id
      post product_orderproducts_path(product_id)
      order = Order.last
      checkout_hash = {
      order: {
      name: "Tummy",
      email: "tummy@petsy.com",
      mailing_address: "123 Pine St.",
      zip: 12345,
      name_on_cc: "Tummy B. Button",
      cc_number: "252024045",
      cc_exp: "11/9/19"
      }}
      expect{ patch order_path(order.id), params: checkout_hash }.wont_change Order.count
      must_respond_with :success
      # tried to check redirect to confirmation page, but it's hitting the success reponse first
    end

    it 'decreases quantity purchased from product stock' do
      valid_product = Product.last
      valid_product.stock = 5
      cur_id = valid_product.id
      post product_orderproducts_path(cur_id)
      order = Order.last
      checkout_hash = {
      order: {
      name: "Tummy",
      email: "tummy@petsy.com",
      mailing_address: "123 Pine St.",
      zip: 12345,
      name_on_cc: "Tummy B. Button",
      cc_number: "252024045",
      cc_exp: "11/19"
      }}
      patch order_path(order.id), params: checkout_hash
      updated_valid_product = Product.find_by(id: cur_id)
      expect(updated_valid_product.stock).must_equal 4
    end
    # Was going to test that status changed from 'pending' to 'paid' but that happens with a hidden field in the form, so not appropriate to test?
  end
end
