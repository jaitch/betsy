class ProductsController < ApplicationController
  
  def index 
    @products = Product.all
  end
  
  def show 
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    
    if @product.nil?
      redirect_to root_path
    end
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(name: params[:product][:name], price: params[:product][:price], stock: params[:product][:stock], description: params[:product][:description], photo: params[:product][:photo], retire: params[:product][:retire], merchant_id: session[:merchant_id])
    if @product.save 
      flash[:success] = "Your product has been added."
      redirect_to root_path
      return
    else 
      flash.now[:warning] = "Your product could not be saved because #{@product.errors.full_messages}"
      render :new
      return
    end
  end
end
