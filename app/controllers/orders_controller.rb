class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  def delete
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
      redirect_to works_path
      return
    end
  end
end
