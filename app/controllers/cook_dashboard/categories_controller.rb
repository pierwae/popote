class CookDashboard::CategoriesController < ApplicationController
  def index
    @user = current_user
    @cook = Cook.last
    @meal = Cook.last.categories.last.meals.last
    @ingredients = @meal.ingredients
  end
end
