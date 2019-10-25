class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit] #, :update, :destroy]
  before_action :missing_merchant, only: [:show, :edit]
  
  def index
    @all_merchants = Merchant.all
  end
  
  def show ; end
  
  # def login_form
  #   @merchant = Merchant.new
  # end
  
  # def login
  #   merchantname = params[:merchant][:merchantname]
  #   email = params[:merchant][:email]
  #   merchant = Merchant.find_by(merchantname: merchantname)
  #   if merchant
  #     session[:merchant_id] = merchant.id
  #     flash[:success] = "Successfully logged in as returning merchant #{merchantname}"
  #     redirect_to root_path
  #     return
  #   else
  #     merchant = Merchant.new(merchantname: merchantname, email: email)
  #     if merchant.save
  #       session[:merchant_id] = merchant.id
  #       flash[:success] = "Successfully logged in as new merchant #{merchantname}"
  #       redirect_to root_path
  #       return
  #     else
  #       flash[:failure] = "Could not create new merchant"
  #       redirect_to login_path
  #       return
  #     end
  #   end
  # end
  
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
      redirect_to root_path
    end
    # return @current_merchant
  end
  
  # def logout
  #   session[:merchant_id] = nil
  #   flash[:success] = "You have been sucessfully logged out"
  #   redirect_to root_path
  # end
  
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
