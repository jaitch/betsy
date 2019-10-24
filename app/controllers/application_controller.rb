class ApplicationController < ActionController::Base

  def add_to_cart
    if session[:order_id]
      order = Order.find(session:[:order_id])
    else
      order = Order.create
    end
    product_to_add = Orderproduct.create(product_id: params[:product_id], order_id: order.id)
    if product_to_add
      flash[:success] = "Successfully added item to your cart."
      redirect_to products_path
    else
      flash[:failure] = "Problem adding item to your cart."
      redirect_to products_path
    end
  end
end