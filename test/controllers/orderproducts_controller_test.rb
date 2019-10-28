require "test_helper"

describe OrderproductsController do
  # describe 'index' do
  #   it "responds with success when there are many orderproducts saved" do
  #     op1 = orderproducts(:op1)
  #     op2 = orderproducts(:op2)
  #     op3 = orderproducts(:op3)
  #     get orderproducts_path
  #     must_respond_with :success
  #   end
  #   it "responds with success when there are no orderproducts saved" do
  #     orderproduct = orderproducts(:op1)
  #     delete orderproduct_path(orderproduct)
  #     get orderproduct_path(orderproduct.id)
  #     get orderproducts_path
  #     must_respond_with :success
  #   end
  # end
  # describe 'show' do
  #   it 'responds with success when showing an existing valid orderproduct' do
  #     op = orderproducts(:op1)
  #     if Orderproduct.count != 1
  #       puts "No orderproduct saved."
  #     end
  #     get orderproduct_path(op.id)
  #     must_respond_with :success
  #   end
  #   it 'responds with 404 when given an invalid orderproduct id' do
  #   end
  # end

  describe 'create' do
    it 'can create a new orderproduct with valid information' do
    end

    it 'does not create an orderproduct if the product is out of stock' do
    end

    it 'uses the session order id for the orderproduct order id if the is in an existing order' do
    end

    it 'does not let buyer add product to the cart of cart contains full stock of a product' do
    end

    it 'can add product to cart that already contains that item if not yet maxed out, and increases quantity by one' do
    end

    it 'can add a product to an order that does not yet contain it, and creates a new orderproduct in the process' do
    end
    

    it ''
  end
end
