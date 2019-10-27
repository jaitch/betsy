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
    @orderproduct = Orderproduct.new(orderproduct_params, quantity: 1)
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
