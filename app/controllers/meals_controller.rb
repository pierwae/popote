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
end
