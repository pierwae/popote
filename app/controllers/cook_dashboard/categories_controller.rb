class CookDashboard::CategoriesController < ApplicationController
  def index
    @user = current_user
    @cook = @user.cook
    @categories = @cook.categories
    # @meal = Cook.last.categories.last.meals.last
    # @ingredients = @meal.ingredients
  end


end
