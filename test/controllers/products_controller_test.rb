require "test_helper"

describe ProductsController do
  describe "index" do 
    before do 
      # Arrange
      hot_dog = Product.create(name: "Hot Dog", price: 25.00, stock: 12, description: "Fido will look good enough to eat in this weiner suit!", photo: nil, retire?: false)
      unicorn_horn = Product.create(name: "Unicorn Horn", price: 14.00, stock: 78, description: "Your cat or dog will look majestic in this delightful unicorn horn. (No unicorns were harmed to make this product.)", photo: nil, retire?: false)
    end
    it "shows all the products" do 
      # Act
      get root_path
      
      # Assert
      must_respond_with :success      
    end
  end # end describe index block
  
  
  describe "show" do 
    before do 
      # Arrange
      @merchant = Merchant.create(username: "mariya", email: "m@gmail.com" )
      @hot_dog = Product.create(name: "Hot Dog", price: 25.00, stock: 12, description: "Fido will look good enough to eat in this weiner suit!", photo: nil, retire?: false, merchant_id: @merchant.id)
      @unicorn_horn = Product.create(name: "Unicorn Horn", price: 14.00, stock: 78, description: "Your cat or dog will look majestic in this delightful unicorn horn. (No unicorns were harmed to make this product.)", photo: nil, retire?: false, merchant: @merchant)
    end
    
    it "succeeds for an existing product_id" do 
      # Act
      get product_path(@hot_dog.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "redirects for invalid id" do 
      # Act
      get product_path(246273452735)
      
      # Assert
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end #describe show block
  
end #end Products controller
