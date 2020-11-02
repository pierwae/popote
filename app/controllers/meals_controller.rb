class MealsController < ApplicationController
  def meal_details
    meal = Meal.find(params[:id])
    render json: meal.to_json
  end
end
