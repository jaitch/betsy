require "test_helper"

describe HomepagesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  before do
    @products = Product.all
    @merchants = Merchant.all
    @categories = Category.all
  end
  
  describe "index" do
    it "can get the products path" do
      get products_path
      
      must_respond_with :success
    end
    
    it "can get the merchants path" do
      get merchants_path
      
      must_respond_with :success
    end
    
    it "can get the categories path" do
      get categories_path
      
      must_respond_with :success
    end
    
  end

end
  
  