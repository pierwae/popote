class BasketsController < ApplicationController
  before_action :authenticate_user!, except: %I[create the_meal_in_the_basket? total_price]

  def show
    @basket = Basket.find(params[:id])
    @user   = current_user
    @cook   = @basket.meals.first.category.cook
    @order  = Order.new
  end

  def create
    basket = Basket.create
    render json: basket.to_json
  end

  def the_meal_in_the_basket?
    basket = Basket.find(params[:id])
    meal   = Meal.find(params[:meals_id])
    if basket.meals.include?(meal)
      render json: BasketSuborder.where(meal: meal, basket: basket).first.id.to_json
    else
      render json: 0.to_json
    end
  end

  def total_price
    total_price = Basket.find(params[:id]).formatted_total_price
    render json: total_price.to_json
  end
end
