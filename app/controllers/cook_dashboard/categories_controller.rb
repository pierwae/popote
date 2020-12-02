class CookDashboard::CategoriesController < ApplicationController
  def index
    @user = current_user
    @cook = @user.cook
    @categories = @cook.categories.order(created_at: :desc)
  end

  def update
    category = Category.find(params[:id])
    category_details = params.require(:category).permit(:name)
    category.name = category_details[:name]
    category.save
    redirect_back(fallback_location: homepage_path)
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to cook_dashboard_categories_path
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new
    category_details = params.require(:category).permit(:name)
    category.name = category_details[:name]
    category.cook = current_user.cook
    category.save
    redirect_to cook_dashboard_categories_path
  end
end
