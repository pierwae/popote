class BasketsController < ApplicationController
  def create
    basket = Basket.create
    render json: basket.to_json
  end

  def the_meal_in_the_basket?
    basket = Basket.find(params[:id])
    meal   = Meal.find(params[:meals_id])
    if basket.meals.include?(meal)
      render json: Suborder.where(meal: meal, basket: basket).first.id.to_json
    else
      render json: 0.to_json
    end
  end
end
