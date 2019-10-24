require "test_helper"
describe ProductsController do
  describe "index" do 
    before do 
      # Arrange
      hot_dog = Product.create(name: "Hot Dog", price: 25.00, stock: 12, description: "Fido will look good enough to eat in this weiner suit!", photo: nil, retire: false, merchant_id: 1)
      unicorn_horn = Product.create(name: "Unicorn Horn", price: 14.00, stock: 78, description: "Your cat or dog will look majestic in this delightful unicorn horn. (No unicorns were harmed to make this product.)", photo: nil, retire: false, merchant_id: 1)
    end
    it "shows all the products" do 
      # Act
      get products_path
      
      # Assert
      must_respond_with :success      
    end
  end # end describe index block
  
  
  describe "show" do 
    before do 
      # Arrange
      @merchant = Merchant.create(username: "mariya", email: "m@gmail.com" )
      @hot_dog = Product.create(name: "Hot Dog", price: 25.00, stock: 12, description: "Fido will look good enough to eat in this weiner suit!", photo: nil, retire: false, merchant_id: @merchant.id)
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
  
  describe "new" do 
    it "can get the new product page" do
      # Act
      get new_product_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do 
    it "can create a new product" do
      # Arrange
      start_count = Product.all.count
      product_hash = {
      product: {
      name: "tutu",
      price: 50.00,
      stock: 5,
      description: "pink",
      photo: nil,
      retire: false,
    }
  }      
  # Act
    post products_path, params: product_hash
  
    last = Product.last 
  # Assert
    expect(start_count).must_equal 1
    must_redirect_to root_path
    end
  end

end #end Products controller
