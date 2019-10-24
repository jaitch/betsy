class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit] #, :update, :destroy]
  before_action :missing_merchant, only: [:show, :edit]
  
  def index
    @all_merchants = Merchant.all
  end
  
  def show ; end
  
  def login_form
    @merchant = Merchant.new
  end
  
  def login
    username = params[:merchant][:username]
    email = params[:merchant][:email]
    merchant = Merchant.find_by(username: username)
    if merchant
      session[:merchant_id] = merchant.id
      flash[:success] = "Successfully logged in as returning merchant #{username}"
      redirect_to root_path
      return
    else
      merchant = Merchant.new(username: username, email: email)
      if merchant.save
        session[:merchant_id] = merchant.id
        flash[:success] = "Successfully logged in as new merchant #{username}"
        redirect_to root_path
        return
      else
        flash[:failure] = "Could not create new merchant"
        redirect_to login_path
        return
      end
    end
  end
  
  def current
    @current_merchant = Merchant.find_by(id: session[:merchant_id])
    unless @current_merchant
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    end
  end
  
  def logout
    session[:merchant_id] = nil
    flash[:success] = "You have been sucessfully logged out"
    redirect_to root_path
  end
  
  private
  
  def merchant_params
    return params.require(:merchant).permit(:username, :email)
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
