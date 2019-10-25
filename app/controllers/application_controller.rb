class ApplicationController < ActionController::Base

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end
  end
  def add_item
    order = current_order
    product = Product.find(params[:product_id])
    if product.stock < 1
      flash.now[:failure] = "Out of stock. Sorry!"
      render products_path
    else
      cur_orderproduct = Orderproduct.new(order_id: session[:order_id], product_id: product.id, quantity: 1)
      # check for existing item here and do += ? or add all like items at checkout?
      product.stock -= 1
    end
    if cur_orderproduct.save
      flash[:success] = "Item added to cart."
      redirect_to products_path
    end
  end
end