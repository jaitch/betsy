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
end