class CooksController < ApplicationController
  def index
    @cooks = Cook.all
  end

  def show
    @cook = Cook.find(params[:id])
    @categories = @cook.categories
    @basket = Basket.find(params[:basket_id])
    @suborders = @basket.basket_suborders
  end
end
