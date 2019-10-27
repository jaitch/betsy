class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def show ; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
#    @order.status = "pending"
    orderproduct = Orderproduct.new(order_id: @order.id, product_id: params[:product][:id], quantity: 1)
  end

  def edit ; end


  def update
    if @order.update(order_params)
      @order.status = "paid"
      @order.orderproducts.each do |orderproduct|
        orderproduct.product.stock -= orderproduct.quantity
      end
      session[:order_id] = nil
      flash[:success] = "Order placed!"
      redirect_to root_path
      return
    else
      flash.now[:failure] = "Order failed!"
      render :edit
      return
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = "Order successfully deleted!"
      redirect_to orders_path
      return
    end
  end


  private
  def order_params
    return params.require(:order, :status => "pending").permit(:name, :email, :mailing_address, :zip, :name_on_cc, :cc_number, :cc_cvc, :cc_exp, :quantity, product_ids: [])
  end

  def find_order
    @order = Order.find_by(id: params[:id])
  end

  def if_order_missing
    if @order.nil?
      flash[:error] = "Order with id #{params[:id]} was not found!"
      redirect_to works_path
      return
    end
  end
end
