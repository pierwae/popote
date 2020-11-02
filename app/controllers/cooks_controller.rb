class CooksController < ApplicationController
  def index
    @cooks = Cook.all
  end

  def show
    @cook = Cook.find(params[:id])
    @meals = Meal.all
    @basket = Basket.last
    @orders = @basket.orders
  end
end
