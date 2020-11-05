class BasketsController < ApplicationController
  def create
    basket = Basket.create
    render json: basket.to_json
  end
end
