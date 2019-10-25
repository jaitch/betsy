class CategoriesController < ApplicationController

  def show
    category_id = params[:id]
    @category = Category.find_by(id: category_id)

    if @category.nil?
      redirect_to root_path
    end
  end
end
