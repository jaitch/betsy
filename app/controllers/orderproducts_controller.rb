class OrderproductsController < ApplicationController
  before_action :find_orderproduct, only: [:show, :edit, :update, :destroy]
  def index
    @orderproducts = Orderproduct.all
  end
  
  def show ; end
  
  def new
    @orderproduct = Orderproduct.new
  end
  
  def create
    @orderproduct = Orderproduct.new(order_id: @order.id, product_id: @product.id, quantity: 1)
  end
  
  
  def edit ; end
  
  
  def update
  end
  
  def destroy
    orderproduct.destroy
    redirect_to order_path
  end
  
  
  private
  def orderproduct_params
    return params.require(:orderproduct).permit(:order_id, :product_id)
  end
  
  def find_order
    orderproduct = Orderproduct.find_by(order_id: @order.id, product_id: @product.id)
  end
  
  def if_order_missing
    if @orderproduct.nil?
      flash[:error] = "Orderproduct with id #{params[:id]} was not found!"
      redirect_to orders_path
      return
    end
  end
end
