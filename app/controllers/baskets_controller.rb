class BasketsController < ApplicationController
  def create
    basket = Basket.create
    render json: basket.to_json
  end

  # def create_or_update_suborder
  #   basket = Basket.find(params[:basket_id])
  #   # Si suborder existe : update suborder avec une autre qtt
  #   # si suborder n'existe pas : le créer avec les infos
  # end
end
