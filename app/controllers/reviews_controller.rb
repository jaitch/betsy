class ReviewsController < ApplicationController
  def index 
    @reviews = Review.all
  end
  
  def show 
    review_id = params[:id]
    @review = Review.find_by(id: review_id)
    
    if @review.nil?
      redirect_to root_path
      # redirect to product page?
    end
  end
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new
    if @review.save 
      flash[:success] = "Your review has been saved."
      redirect_to root_path
      return
    else 
      flash.now[:warning] = "Your review could not be saved because #{@review.errors.full_messages}"
      render :new
      return
    end
  end

  private 

  def review_params
    params.require(:review).permit(:rating, :text)
  end

end
