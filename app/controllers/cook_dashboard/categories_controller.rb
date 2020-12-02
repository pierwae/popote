class CookDashboard::CategoriesController < ApplicationController
  def index
    @user = current_user
    @cook = @user.cook
    @categories = @cook.categories.order(:rank)
  end

  def meal_ranks_array
    meal_ranks = []
    (1..meals.count).each do |rank|
      meal_ranks << rank.to_s + '.'
    end
    meal_ranks
  end

  def update
    category = Category.find(params[:id])
    save_category_based_on_params(category)
    # cook.update_category_ranks
    redirect_to cook_dashboard_categories_path
  end

  def create
    category = Category.new
    cook = current_user.cook
    category.rank = cook.categories.count
    save_category_based_on_params(category)
    redirect_to cook_dashboard_categories_path
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to cook_dashboard_categories_path
  end

  def new
    @category = Category.new
    @cook = current_user.cook
  end

  private

  def params_content
    params.require(:category).permit(:name, :rank)
  end

  def save_category_based_on_params(category)
    cook = current_user.cook
    categories = cook.categories
    category_details = params.require(:category).permit(:name, :rank)

    category2 = categories.find_by(rank: category_details[:rank])
    unless category2.nil?
      category2.rank = category.rank
      category2.save
    end

    category.name = category_details[:name]
    category.rank = category_details[:rank]
    category.cook = cook
    category.save
  end
end
