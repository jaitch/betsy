require "test_helper"

describe MerchantsController do
  before do
    @merchant = merchants(:gyjin)
  end
  
  describe "as a guest user" do
    describe "index" do
      it "can get the index path" do
        get merchants_path
        
        must_respond_with :success
      end
    end
    
    describe "show" do
      it "can get a valid merchant" do
        get merchant_path(@merchant.id)
        
        must_respond_with :success
      end
      
      it "will redirect for an invalid merchant" do
        get merchant_path(-1)
        
        must_respond_with :not_found
      end
    end
    
    describe "create" do
      it "can create an account for a new user and redirects to root route" do
        start_count = Merchant.count
        merchant = Merchant.new(provider: "github", uid: 1789, username: "test_user", email: "test@user.com")
        
        perform_login(merchant)
        
        must_redirect_to root_path
        _(Merchant.count).must_equal start_count + 1
        _(session[:merchant_id]).must_equal Merchant.last.id
        flash[:success].wont_be_nil
      end
      
      it "can log in an existing user and redirects to the root route" do
        start_count = Merchant.count
        merchant = merchants(:mariya)
        
        perform_login(merchant)
        
        must_redirect_to root_path
        _(session[:merchant_id]).must_equal merchant.id
        _(Merchant.count).must_equal start_count
        flash[:success].wont_be_nil
      end
      
      it "redirects to the login route if given invalid user data" do
        start_count = Merchant.count
        merchant = Merchant.new(provider: "github", uid: nil, username: "test_user", email: "test@user.com")
        
        perform_login(merchant)
        
        must_redirect_to root_path
        _(Merchant.count).must_equal start_count
        _(session[:merchant_id]).must_equal nil
        flash[:error].wont_be_nil
      end
    end
    
    describe "destroy" do
      it "cannot logout because guest user is not logged in" do
        start_count = Merchant.count
        delete logout_path
        _(Merchant.count).must_equal start_count
        _(session[:merchant_id]).must_equal nil
        flash[:error].wont_be_nil
      end
    end
    
    describe "fulfillment" do
      it "cannot show fulfillments because guest user is not logged in" do
        @merchant.fulfillment
        _(session[:merchant_id]).must_equal nil
        flash[:error].wont_be_nil
      end
    end
  end
end

# need tests for when merchant is signed in and can't sign in again
# destroy, successfully log out
# fulfillment, correct number of orderproducts for a merchant
