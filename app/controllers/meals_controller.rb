class MealsController < ApplicationController
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

  def update
    meal = Meal.find(params[:id])
    save_meal_based_on_params(meal)
    redirect_back(fallback_location: homepage_path)
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

  def destroy
    meal = Meal.find(params[:id])
    # meal.destroy
    meal.deleted = true
    meal.save
    redirect_to cook_dashboard_categories_path
  end

  private

  def save_meal_based_on_params(meal)
    meal_details = params.require(:meal).permit(:name, :information, :description, :price, :category_id)
    meal.name        = meal_details[:name]
    meal.information = meal_details[:information]
    meal.description = meal_details[:description]
    meal.price       = meal_details[:price].gsub(',', '.').to_f
    meal.category_id = meal_details[:category_id]

    meal.save

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
