class ReviewsController < ApplicationController
  def index 
    @reviews = Review.all
  end
  
  def show 
    review_id = params[:id]
    @review = Review.find_by(id: review_id)
    
    if @review.nil?
      redirect_to root_path
    end
  end
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(rating: params[:review][:rating], product_id: params[:product_id], text: params[:review][:text])
    if @review.save 
      flash[:success] = "Your review has been saved."
      redirect_to product_path(params[:product_id])
      return
    else 
      render :new
      return
    end
  end

  private 

  def review_params
    params.require(:review).permit(:rating, :text, :product_id)
  end

end
