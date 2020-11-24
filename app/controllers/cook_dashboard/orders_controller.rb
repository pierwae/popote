class CookDashboard::OrdersController < ApplicationController
  def index
    @user = current_user
    @order = Order.last
  end

  def update
    # something
    update_customer_validation(nil)
  end

  def accept
    update_cook_validation(true)
  end

  def decline
    update_cook_validation(false)
  end

  def cancel
    update_cook_validation(nil)
  end

  private

  def update_cook_validation(new_status)
    @order = Order.find(params[:order_id])
    @order.cook_validation = new_status
    @order.save
    redirect_to cook_dashboard_orders_path
  end

  def update_customer_validation(new_status)
    @order = Order.find(params[:order_id])
    @order.customer_validation = new_status
    @order.save
    redirect_to cook_dashboard_orders_path
  end
end
