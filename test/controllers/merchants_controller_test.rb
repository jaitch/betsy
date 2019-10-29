require "test_helper"

describe MerchantsController do
  # before do
  #   merchant = Merchant.new(username: "gyj", email: "email")
  #   merchant.save
  # product = Product.new(name: "new product", stock: 10, price: 12.00, merchant_id: merchant.id)
  # product.save
  # end
  # need tests for
  describe "index" do
    it "can get the index path" do
      get merchants_path
      
      must_respond_with :success
    end
  end
  # show
  # login_form
  # login
  # current
  # describe "current" do
  #   it "returns 200 OK for a logged-in merchant" do
  #     merchant = Merchant.first 
  #     login_data = {
  #       merchant: {
  #         username: merchant.username,
  #         email: merchant.email
  #       }
  #     }
  #     post login_path, params: login_data
  
  #     expect(session[:merchant_id]).must_equal merchant.id
  
  #     get current_merchant_path
  
  #     must_respond_with :success
  #   end
  # end
  # logout
  # find in testing session lecture 
  
  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do
      start_count = Merchant.count
      merchant = merchants(:mariya)
      
      perform_login(merchant)
      
      must_redirect_to root_path
      _(session[:merchant_id]).must_equal merchant.id
      _(Merchant.count).must_equal start_count
      # flash[:error].wont_be_nil, test for flash messages?
    end
    
    it "creates an account for a new user and redirects to the root route" do
      start_count = Merchant.count
      merchant = Merchant.new(provider: "github", uid: 1789, username: "test_user", email: "test@user.com")
      
      perform_login(merchant)
      
      must_redirect_to root_path
      _(Merchant.count).must_equal start_count + 1
      _(session[:merchant_id]).must_equal Merchant.last.id
    end
    
    it "redirects to the login route if given invalid user data" do
      start_count = Merchant.count
      merchant = Merchant.new(provider: "github", uid: nil, username: "test_user", email: "test@user.com")
      
      perform_login(merchant)
      
      must_redirect_to root_path
      _(Merchant.count).must_equal start_count
      _(session[:merchant_id]).must_equal nil
    end
  end
end
