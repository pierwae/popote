class CooksController < ApplicationController
  def index
    @cooks = Cook.all
  end

  def show
    @cook = Cook.find(params[:id])
    @categories = @cook.categories
    @basket = Basket.last
    @suborders = @basket.suborders
  end
end
