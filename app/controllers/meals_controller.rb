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
    @meal = Meal.find(params[:id])
    meal_details = params.require(:meal).permit(:name, :information, :price, :category_id)
    @meal.update(name: meal_details[:name],
                 information: meal_details[:information],
                 price: meal_details[:price].gsub(',', '.').to_f,
                 category_id: meal_details[:category_id])
    @meal.save

    @ingredients = params.require(:meal).require(:ingredients).permit!
    @meal.ingredients.delete_all
    @ingredients.values.each do |value|
      puts value
    end

    raise
  end
end
