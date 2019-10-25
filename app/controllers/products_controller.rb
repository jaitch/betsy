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
    if session[:merchant_id].nil?
      flash[:error] = "You must be logged in as a merchant to add a product."
      redirect_back(fallback_location: root_path)
      return
    end
    
    @product = Product.new
  end
  
  def create
    
    @product = Product.new(product_params.merge(merchant_id: session[:merchant_id])) # merge product params with session based ones
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
  
  private 
  
  def product_params
    params.require(:product).permit(:name, :price, :stock, :description, :photo, :retire, category_ids: [])
  end
end
