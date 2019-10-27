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
    @product = Product.find(params[:product_id])
    if @product.stock < 1
      flash.now[:failure] = "Out of stock. Sorry!"
      render products_path
      return
    end
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end
    if Orderproduct.find_by(order_id: @order.id, product_id: @product.id) != nil
      cur_orderproduct = Orderproduct.find_by(order_id: @order.id, product_id: @product.id)
      cur_orderproduct.quantity += 1
    else
      cur_orderproduct = Orderproduct.new(order_id: @order.id, product_id: @product.id, quantity: 1)
    end
    if cur_orderproduct.save
      flash[:success] = "Item added to cart."
      redirect_to products_path
      return
    else flash[:failure] = "Item NOT added to cart."
      render products_path
      return
    end
  end

  def edit ; end

  def update
  end

  def destroy
    if @orderproduct.destroy
      flash[:success] = "Work successfully deleted!"
      redirect_to order_path(@orderproduct.order)
    end
  end

  private
  def orderproduct_params
    return params.require(:orderproduct).permit(:order_id, :product_id, :quantity)
  end

  def find_orderproduct
    @orderproduct = Orderproduct.find_by(id: params[:id])
  end

  def if_orderproduct_missing
    if @orderproduct.nil?
      flash[:error] = "Orderproduct with id #{params[:id]} was not found!"
      redirect_to order_path(:order_id)
      return
    end
  end
end
