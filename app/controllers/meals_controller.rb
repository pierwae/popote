class MealsController < ApplicationController
  def details
    meal = Meal.find(params[:id])
    render json: meal.to_json
  end
end
