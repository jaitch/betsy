require "test_helper"

describe Merchant do
  before do
    merchant = Merchant.new(username: "gyj", email: "email")
    merchant.save
    product = Product.new(name: "new product", stock: 10, price: 12.00, merchant_id: merchant.id)
    product.save
  end
  # can get rid of this before do when fixtures are added
  
  describe "instantiation" do
    it "can be instantiated" do
      new_merchant = Merchant.new(
      username: "Peter",
      email: "peter@gmail.com"
      )
      expect(new_merchant.valid?).must_equal true
    end
    
    it "will have the required fields" do
      merchant = Merchant.first
      expect(merchant).must_respond_to :username
      expect(merchant).must_respond_to :email
    end
  end
  
  describe "relationships" do
    it "can have many products" do
      merchant = Merchant.first
      
      expect(Merchant.products.count).must_be :>=, 0
      Merchant.products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end
  end
  
  describe "validations" do
    before do
      @merchant = Merchant.first
    end
    
    it "must have a username" do
      @merchant.username = nil
      expect(@merchant.valid?).must_equal false
      expect(@merchant.errors.messages).must_include :username
      expect(@merchant.errors.messages[:username]).must_equal ["can't be blank"]
    end
    
    it "must have an email" do
      @merchant.email = nil
      expect(@merchant.valid?).must_equal false
      expect(@merchant.errors.messages).must_include :email
      expect(@merchant.errors.messages[:email]).must_equal ["can't be blank"]
    end
  end
end

# needs tests for building from github
# fulfillments method