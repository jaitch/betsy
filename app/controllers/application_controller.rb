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
      if Orderproduct.find_by(order_id: session[:order_id], product_id: product.id) != nil
        cur_orderproduct = Orderproduct.find_by(order_id: session[:order_id], product_id: product.id)
        cur_orderproduct.quantity += 1
      else
      cur_orderproduct = Orderproduct.new(order_id: session[:order_id], product_id: product.id, quantity: 1)
      end
    end
    if cur_orderproduct.save
      product.stock -= 1
      flash[:success] = "Item added to cart."
      redirect_to products_path
    end
  end
end