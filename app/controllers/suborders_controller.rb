class SubordersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    body = JSON.parse(request.body.read)
    suborder = Suborder.create(meal_id: body['meal_id'],
                               basket_id: body['basket_id'],
                               quantity: body['quantity'])

    render json: { suborder_id: suborder.id,
                   quantity: suborder.quantity,
                   meal_name: suborder.meal.name,
                   price: suborder.meal.price }.to_json
  end

  def update
    body = JSON.parse(request.body.read)
    suborder = Suborder.find(params[:id])
    suborder.quantity += Integer(body['quantity'])
    success = suborder.save
    render json: { success: success,
                   suborder_id: suborder.id,
                   price: suborder.meal.price,
                   quantity: suborder.quantity }.to_json
  end
end
