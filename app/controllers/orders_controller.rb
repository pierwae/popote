class OrdersController < ApplicationController
  def index
    @user = current_user
    @order = Order.last

  end

  def create
    order_details = params.require(:order).permit(:instructions, :cgu_validation)
    basket = Basket.find(params[:basket_id])
    cook = basket.meals.first.category.cook
    order = Order.new(cook: cook,
                      customer_id: current_user.id,
                      instructions: order_details[:instructions],
                      cgu_validation: order_details[:cgu_validation],
                      status: 'En attente de validation...')

    redirect_to homepage_path unless order.save

    basket.meals.each do |meal|
      suborder = Suborder.new(meal: meal, order: order)
      redirect_to homepage_path unless suborder.save
    end

    redirect_to user_orders_path(current_user)
  end
end
