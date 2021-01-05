class CookDashboard::CategoriesController < ApplicationController
  include UpdateRanksConcern

  def index
    @user = current_user
    @cook = @user.cook
    @categories = @cook.categories.order(:rank)
  end

  def new
    @category = Category.new
    @cook = current_user.cook
  end

  def create
    category = Category.new
    category.rank = current_user.cook.categories.count + 1
    save_category_based_on_params(category)
  end

  def update
    category = Category.find(params[:id])
    save_category_based_on_params(category)
  end

  def destroy
    category = Category.find(params[:id])
    cook = current_user.cook
    update_ranks(category, # selected_element
                 cook.categories.count, # new_rank
                 category.rank) # old_rank
    category.destroy
    redirect_to cook_dashboard_categories_path
  end

  private

  def save_category_based_on_params(category)
    cook = current_user.cook
    required_params = params.require(:category).permit(:name, :rank)
    category.update(name: required_params[:name], cook: cook)
    update_ranks(category, # selected_element
                 required_params[:rank].to_i, # new_rank
                 category.rank) # old_rank
    redirect_to cook_dashboard_categories_path
  end
end
