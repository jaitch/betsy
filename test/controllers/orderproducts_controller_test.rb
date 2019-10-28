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
    it 'does not create an orderproduct if the product is out of stock' do
    end

    it 'uses the session order id for the orderproduct order id' do
    end

    it ''
  end
end
