require "test_helper"

describe Order do
  describe 'validations' do
    before do
      product = products(:wizard)
      post product_orderproducts_path(product_id)
      order = Order.last
      checkout_hash = {
      order: {
      status: "paid",
      name: "Jane Doe",
      email: "jane@petsy.com",
      mailing_address: "123 Main Street",
      zip: 98110,
      name_on_cc: "Jane X. Doe",
      cc_number: "1234567890123456",
      cc_exp: "12/31/56"}}
      patch order_path(order.id), params: checkout_hash
    end
    
    it 'can be made with valid input' do
      expect(order.valid?).must_equal true
    end
    it 'on update, is invalid without a name' do
    end
    it 'on update, is invalid without an email' do
    end
    it 'on update, is invalid without a mailing address' do
    end
    
    it 'on update, is invalid without a five-digit integer zip code' do
    end
    
    it 'on update, is invalid without a credit card name' do
    end
    
    it 'on update, is invalid without a sixteen-digit credit card number' do
    end
    
    it 'on update, is invalid without a three-digit integer credit card cvc' do
    end
    
    it 'on update, is invalid without a credit card expiration date' do
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
