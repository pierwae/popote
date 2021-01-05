class MealsController < ApplicationController
  include UpdateRanksConcern

  def details
    meal = Meal.find(params[:meal_id])
    render json: meal.to_json
  end

  def presence_checking
    basket = Basket.find(params[:basket_id])
    meal   = Meal.find(params[:meal_id])
    if basket.meals.include?(meal)
      render json: BasketSuborder.where(meal: meal, basket: basket).first.id.to_json
    else
      render json: 0.to_json
    end
  end

  def new
    @meal = Meal.new
    @categories = current_user.cook.categories.order(created_at: :desc)
  end

  def create
    meal = Meal.new
    save_meal_based_on_params(meal)
    redirect_to cook_dashboard_categories_path
  end

  def update
    meal = Meal.find(params[:id])
    save_meal_based_on_params(meal)
    redirect_back(fallback_location: homepage_path)
  end

  def destroy
    meal = Meal.find(params[:id])
    update_ranks(meal, # selected_element
                 meal.category.meals.count, # new_rank
                 meal.rank) # old_rank
    if meal.suborders.empty? && meal.basket_suborders.empty?
      meal.destroy
    else
      meal.deleted = true
      meal.save
    end
    redirect_to cook_dashboard_categories_path
  end

  private

  def save_meal_based_on_params(meal)
    required_params = params.require(:meal).permit(:name, :information, :description, :price, :category_id, :rank)
    meal.name        = required_params[:name]
    meal.information = required_params[:information]
    meal.description = required_params[:description]
    meal.price       = required_params[:price].gsub(',', '.').to_f
    meal.category_id = required_params[:category_id]
    meal.cook        = current_user.cook

    unless required_params[:rank].nil?
      meal.rank = required_params[:rank]
    else
      meal.rank = Category.find(required_params[:category_id]).meals.count + 1
    end

    meal.save

    update_ranks(meal, # selected_element
                 required_params[:rank].to_i, # new_rank
                 meal.rank) # old_rank

    meal.ingredients.each { |ingredient| ingredient.destroy }

    if params[:meal].keys.include?('ingredients')
      ingredients = params.require(:meal).require(:ingredients).permit!
      ingredients = ingredients.to_h.sort_by { |_, value| value['rank'] }
      ingredients.each_with_index do |item, index|
        name = item[1]['name']
        unless name.empty?
          ingredient = Ingredient.new(meal: meal, rank: index + 1, name: name)
          ingredient.save
        end
      end
    end
  end
end
