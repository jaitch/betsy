class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :fulfillment] #, :update, :destroy]
  before_action :missing_merchant, only: [:show, :edit]
  
  def index
    @all_merchants = Merchant.all
  end
  
  def show ; end
  
  def create
    auth_hash = request.env["omniauth.auth"]
    
    merchant = Merchant.find_by(uid: auth_hash[:uid], provider: "github")
    if merchant
      flash[:success] = "Logged in as returning merchant #{merchant.username}"
    else
      merchant = Merchant.build_from_github(auth_hash)
      if merchant.save
        flash[:success] = "Logged in as new merchant #{merchant.username}"
      else
        flash[:error] = "Could not create new merchant account: #{merchant.errors.messages}"
        return redirect_to root_path
      end
    end
    
    session[:merchant_id] = merchant.id
    return redirect_to root_path
  end
  
  def destroy
    session[:merchant_id] = nil
    flash[:success] = "Successfully logged out!"
    
    redirect_to root_path
  end
  
  def current
    @current_merchant = Merchant.find_by(id: session[:merchant_id])
    unless @current_merchant
      
      flash[:error] = "You must be logged in to do that"
        redirect_back(fallback_location: root_path)
        
      end
      # return @current_merchant
    end
    
    def fulfillment
      @ordered_products = @merchant.fulfillments
      return @ordered_products
    end
    
    private
    
    def merchant_params
      return params.require(:merchant).permit(:username, :email, :provider, :uid)
    end
    
    def find_merchant
      @merchant = Merchant.find_by_id(params[:id])
    end
    
    def missing_merchant
      if @merchant.nil?
        head :not_found
        return
      end
    end
    
  end
  