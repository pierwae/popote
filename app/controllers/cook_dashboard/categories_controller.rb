class CookDashboard::CategoriesController < ApplicationController
  def index
    @user = current_user
    @cook = @user.cook
    @categories = @cook.categories.order(:rank)
  end

  def new
    @category = Category.new
    @cook = current_user.cook
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
  end

  def create
    category = Category.new
    category.rank = current_user.cook.categories.count + 1
    save_category_based_on_params(category)
  end

  def destroy
    category = Category.find(params[:id])
    cook = current_user.cook
    update_category_ranks(cook, # cook
                          category, # selected_category
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
    update_category_ranks(cook, # cook
                          category, # selected_category
                          required_params[:rank].to_i, # new_rank
                          category.rank) # old_rank
    redirect_to cook_dashboard_categories_path
  end

  def update_category_ranks(cook, selected_category, new_rank, old_rank)
    if new_rank > old_rank
      moving_categories = cook.categories.where(rank: (old_rank + 1..new_rank).to_a) # old_rank < rank <= new_rank
      moving_categories.each { |category| category.decrement!(:rank) }
    elsif new_rank < old_rank
      moving_categories = cook.categories.where(rank: (new_rank...old_rank).to_a) # new_rank <= rank < old_rank
      moving_categories.each { |category| category.increment!(:rank) }
    end
    selected_category.update(rank: new_rank)
    cook.check_category_ranks # check qu'il n'y ai pas deux categories avec un meme rang
  end
end
