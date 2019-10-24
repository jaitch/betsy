class OrdersController < ApplicationController
  
  def show; end
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    
    if @order.save
      flash[:success] = "Item added to your shopping cart."
      redirect_to products_path
      return
    else
      flash.now[:failure] = "Item not added!"
      render :new
      return
    end
  end
  
  def edit ; end
  
  def update
    if @order.update(order_params)
      flash[:success] = "Item added to your shopping cart."
      redirect_to products_path
    else
      flash.now[:failure] = "Item not added!"
      render :edit
      return
    end
  end
  
  def delete
  end
  
  def checkout
  end
  
  
  private
  def order_params
    return params.require(:order).permit(:name, :email, :mailing_address, :zip, :name_on_cc, :cc_number, :cc_cvc, :cc_exp)
  end
  
  def find_order
    @order = Order.find_by(id: params[:id])
  end
  
  def if_order_missing
    if @order.nil?
      flash[:error] = "Order with id #{params[:id]} was not found!"
      redirect_to products_path
      return
    end
  end
end
